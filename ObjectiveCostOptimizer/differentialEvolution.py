from PyGMO.problem import base
from PyGMO import *
from ObjectiveCostOptimizer.directionsAPI import Routes
from gisModule import models

TIME_REQ_PER_PRODUCT = 90  # sec
TIME_REQ_PER_MARKET = 1800  # sec
FUEL_PRICE = 0  # TL/liter
FUEL_CONSUME = 0.08  # liter/km
TIME_MULTIPLIER = 20


def time_spent_on_shopping(x, y): return (x * TIME_REQ_PER_MARKET) + (
    y * TIME_REQ_PER_PRODUCT)  # x: Market Count, y: Product Count


# Checks if content of parameter list is equal
def equals(indivd1, indivd2):
    return set([int(i) for i in indivd1.cur_x]) == set([int(i) for i in indivd2.cur_x])


def total_cost(fitness_vector):
    return fitness_vector[0] + fitness_vector[2] * TIME_MULTIPLIER


def unique_population(population):
    decision_vectors = []
    fitness_vectors = []

    for indivd in population:
        fitness_vector = [i for i in indivd.cur_f]
        decision_vector = [int(i) for i in indivd.cur_x]

        if decision_vector not in decision_vectors:
            decision_vectors.append(decision_vector)
            fitness_vectors.append(fitness_vector)

    return decision_vectors, fitness_vectors


def convert_routes(decision_vectors, fitness_vectors, product_count, retailer_list, factors, routes, route_cache,
                   product_quantities):
    if not factors[2]:  # Add back time costs to fitness vector
        i = 0
        for fitness_vector in fitness_vectors:
            unique_list_of_retailers = list(set(list(map(int, decision_vectors[i]))))

            # Caching for direction results of different retailer combinations
            hash_key = hash(frozenset(tuple(unique_list_of_retailers)))
            if hash_key not in route_cache:
                dist_cost, time_cost = routes.calculate_legs(unique_list_of_retailers)  # metres, seconds
                route_cache[hash_key] = (dist_cost, time_cost)
            else:
                dist_cost, time_cost = route_cache[hash_key]  # metres, seconds
            # Caching for direction results of different retailers retailer combinations

            time_cost += time_spent_on_shopping(len(unique_list_of_retailers), len(retailer_list))  # seconds
            time_cost /= 3600  # to hours
            fitness_vector.append(time_cost)
            i += 1

    if not factors[1]:  # Add back dist costs to fitness vector
        i = 0
        for fitness_vector in fitness_vectors:
            unique_list_of_retailers = list(set(list(map(int, decision_vectors[i]))))

            # Caching for direction results of different retailer combinations
            hash_key = hash(frozenset(tuple(unique_list_of_retailers)))
            if hash_key not in route_cache:
                dist_cost, time_cost = routes.calculate_legs(unique_list_of_retailers)  # metres, seconds
                route_cache[hash_key] = (dist_cost, time_cost)
            else:
                dist_cost, time_cost = route_cache[hash_key]  # metres, seconds
            # Caching for direction results of different retailers retailer combinations

            dist_cost /= 1000  # to meters
            temp = fitness_vector.pop()
            fitness_vector.append(dist_cost)
            fitness_vector.append(temp)
            i += 1

    if not factors[0]:  # Add back money costs to fitness vector
        i = 0
        for fitness_vector in fitness_vectors:
            money_cost = 0
            prod_ind = 0
            unique_list_of_retailers = list(set(list(map(int, decision_vectors[i]))))

            # Caching for direction results of different retailer combinations
            hash_key = hash(frozenset(tuple(unique_list_of_retailers)))
            if hash_key not in route_cache:
                dist_cost, time_cost = routes.calculate_legs(unique_list_of_retailers)  # metres, seconds
                route_cache[hash_key] = (dist_cost, time_cost)
            else:
                dist_cost, time_cost = route_cache[hash_key]  # metres, seconds
            # Caching for direction results of different retailers retailer combinations

            for key, value in retailer_list.items():
                money_cost += list(retailer_list[key].values())[int(decision_vectors[i][prod_ind])] * \
                              product_quantities[
                                  prod_ind]
                prod_ind += 1

            time_cost /= 3600  # to hours
            dist_cost /= 1000  # to meters

            temp1 = fitness_vector.pop()
            temp2 = fitness_vector.pop()
            fitness_vector.append(money_cost + (dist_cost * FUEL_PRICE * FUEL_CONSUME))
            fitness_vector.append(temp2)
            fitness_vector.append(temp1)
            i += 1

    money_champ_ind = 0
    dist_champ_ind = 0
    time_champ_ind = 0
    reasonable_champ_ind = 0

    i = 0
    for fitness_vector in fitness_vectors:
        if fitness_vector[0] < fitness_vectors[money_champ_ind][0]:
            money_champ_ind = i
        if fitness_vector[1] < fitness_vectors[dist_champ_ind][1]:
            dist_champ_ind = i
        if fitness_vector[2] < fitness_vectors[time_champ_ind][2]:
            time_champ_ind = i
        if total_cost(fitness_vector) < total_cost(fitness_vectors[reasonable_champ_ind]):
            reasonable_champ_ind = i
        i += 1

    routes = []
    for j in range(0, len(decision_vectors)):
        retailers = []
        products = []
        for i in range(0, product_count):
            retailers.append(models.Retailer.objects.get(
                id=list(list(retailer_list.values())[0].keys())[int(decision_vectors[j][i])]))
            products.append(models.ShoppingListItem.objects.get(id=list(retailer_list.keys())[i]).product)
        routes.append({'retailers': retailers, 'products': products})

    i = 0
    for fitness_vector in fitness_vectors:
        routes[i]['money_diff'] = fitness_vector[0] - fitness_vectors[money_champ_ind][0]
        routes[i]['dist_diff'] = fitness_vector[1] - fitness_vectors[dist_champ_ind][1]
        routes[i]['time_diff'] = fitness_vector[2] - fitness_vectors[time_champ_ind][2]
        routes[i]['costs'] = fitness_vector  # [money, distance, time] costs in order
        i += 1

    return routes, [money_champ_ind, dist_champ_ind, time_champ_ind, reasonable_champ_ind]


class CostOptimization(base):
    flag = False
    products_in_markets = {}
    product_quantities = []
    routes = None
    factors = [True, True, True]
    route_cache = {}

    def __init__(self, product_count=5, market_count=0, products_in_markets={}, product_quantities=[], routes=None,
                 facts=[True, True, True]):
        # We call the base constructor as 'dim' dimensional problem, with 0 integer parts and 1 objectives.
        super(CostOptimization, self).__init__(product_count, 0, facts.count(True))  # Dynamic objective count
        self.factors = facts
        self.routes = routes
        self.products_in_markets = products_in_markets
        self.product_quantities = product_quantities
        self.set_bounds(0, market_count)

    def _objfun_impl(self, x, **kwargs):
        money_cost = 0
        prod_ind = 0
        unique_list_of_retailers = list(set(list(map(int, x))))

        # Caching for direction results of different retailer combinations
        hash_key = hash(frozenset(tuple(unique_list_of_retailers)))

        if hash_key not in self.route_cache:
            dist_cost, time_cost = self.routes.calculate_legs(unique_list_of_retailers)  # metres, seconds
            self.route_cache[hash_key] = (dist_cost, time_cost)
        else:
            dist_cost, time_cost = self.route_cache[hash_key]  # metres, seconds
        # Caching for direction results of different retailers retailer combinations
        time_cost += time_spent_on_shopping(len(unique_list_of_retailers), len(self.products_in_markets))  # seconds

        for key, value in self.products_in_markets.items():
            money_cost += list(self.products_in_markets[key].values())[int(x[prod_ind])] * self.product_quantities[
                prod_ind]
            prod_ind += 1

        time_cost /= 3600  # to hours
        dist_cost /= 1000  # to meters

        # For debugging purposes
        # print([models.Retailer.objects.get(
        #     id=list(list(self.products_in_markets.values())[0].keys())[int(i)]).name for i in
        #        unique_list_of_retailers])
        # print("Total Money Cost:" + str(money_cost) + "+" + str(int(dist_cost * FUEL_PRICE * FUEL_CONSUME)) + "=" + str(
        #     money_cost + int(dist_cost * FUEL_PRICE * FUEL_CONSUME)) + " | Distance:" + str(
        #     int(dist_cost)) + " | Time Spent:" + str(time_cost))

        # Dynamic objective count
        if self.factors[0] and self.factors[1] and self.factors[2]:
            return money_cost + (dist_cost * FUEL_PRICE * FUEL_CONSUME), dist_cost, time_cost,
        elif self.factors[0] and self.factors[1] and not self.factors[2]:
            return money_cost + (dist_cost * FUEL_PRICE * FUEL_CONSUME), dist_cost,
        elif self.factors[0] and not self.factors[1] and self.factors[2]:
            return money_cost + (dist_cost * FUEL_PRICE * FUEL_CONSUME), time_cost,
        elif not self.factors[0] and self.factors[1] and self.factors[2]:
            return dist_cost, time_cost,
        elif self.factors[0] and not self.factors[1] and not self.factors[2]:
            return money_cost + (dist_cost * FUEL_PRICE * FUEL_CONSUME),
        elif not self.factors[0] and self.factors[1] and not self.factors[2]:
            return dist_cost,
        elif not self.factors[0] and not self.factors[1] and self.factors[2]:
            return time_cost,

    def human_readable_extra(self, **kwargs):
        return "\n\tSingle-Objective problem"


def init_optimization(market_list, quantity_list, product_count, market_count, frm, to, facts, algorithm_type=0):
    routes = Routes(retailer_ids=list(list(market_list.values())[0].keys()), frm=frm, to=to)
    prob = CostOptimization(product_count=product_count, product_quantities=quantity_list, market_count=market_count,
                            products_in_markets=market_list,
                            routes=routes, facts=facts)
    if facts.count(True) == 1:
        # Not multi-objective, use different algorithm
        algo = algorithm.de_1220(gen=400)
    else:
        # Multi-objective
        # Bound to algorithm attribute choice order of user preferences model
        if algorithm_type == 0:
            algo = algorithm.nsga_II(gen=400)
        elif algorithm_type == 1:
            algo = algorithm.spea2(gen=400)

    pop = population(prob, 64)
    pop = algo.evolve(pop)

    decision_vectors, fitness_vectors = unique_population(pop)

    route_dicts, champ_indexes = convert_routes(decision_vectors, fitness_vectors, product_count,
                                                market_list, facts, prob.routes, prob.route_cache,
                                                quantity_list)
    return route_dicts, champ_indexes
