import json
import urllib3
from urllib3.exceptions import InsecureRequestWarning
from gisModule import models
import googlemaps


class Routes:
    gmaps = googlemaps.Client(key='AIzaSyBn5odGE6z77jcKm_D9wVS3W1JhWCeiJHU')
    http = urllib3.PoolManager()
    retailer_ids = []
    coordinates = []
    frm = None
    to = None

    def __init__(self, retailer_ids, frm, to):
        urllib3.disable_warnings(InsecureRequestWarning)
        self.retailer_ids = retailer_ids
        self.frm = frm
        self.to = to
        self.get_coordiates()

    def get_coordiates(self):
        for id in self.retailer_ids:
            ret = models.Retailer.objects.get(retailerID=id)
            self.coordinates.append(ret.geoLocation)  # Lat Long values are reversed for Google API defaults

    def calculate_legs(self, current_retailers):
        # js = self.gmaps.directions("%s,%s" % (self.frm.coords[1], self.frm.coords[0]),
        #                                "%s,%s" % (self.to.coords[1], self.to.coords[0]),
        #                                waypoints=["%s,%s" % (self.coordinates[int(i)].coords[1], self.coordinates[int(i)].coords[0]) for i in current_retailers],
        #                                optimize_waypoints=True)

        request_str = "http://router.project-osrm.org/trip/v1/driving/"
        request_str += "%s,%s" % (self.frm.coords[0], self.frm.coords[1])
        for i in current_retailers:
            request_str += ";%s,%s" % (self.coordinates[int(i)].coords[0], self.coordinates[int(i)].coords[1])
        request_str += ";%s,%s" % (self.to.coords[0], self.to.coords[1])
        request_str += "?source=first&destination=last&roundtrip=false"
        results = self.http.request('GET', request_str)
        js = json.loads(results.data.decode('utf-8'))

        # request_str = "https://maps.googleapis.com/maps/api/directions/json?origin=%s,%s&destination=%s,%s&waypoints=optimize:true" % (self.frm.coords[1], self.frm.coords[0], self.to.coords[1], self.to.coords[0])
        # for i in current_retailers:
        #     request_str += "|%s,%s" % (self.coordinates[int(i)].coords[1], self.coordinates[int(i)].coords[0])
        # request_str += "&key=%s" % "AIzaSyBn5odGE6z77jcKm_D9wVS3W1JhWCeiJHU"
        # results = self.http.request('GET', request_str)
        # js = json.loads(results.data.decode('utf-8'))

        total_dist = 0.0
        total_time = 0.0
        for leg in js['trips'][0]['legs']:  # Iterate in each leg of route
            total_dist += leg['distance']
            total_time += leg['duration']
        return total_dist, total_time
