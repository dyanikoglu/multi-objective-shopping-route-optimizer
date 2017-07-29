# Multi-Objective Shopping Route Optimizer

![Main Page](https://i.hizliresim.com/N1GbVO.png)

### Server Installation

Because of the high count of dependencies of required modules, Anaconda must be used for Python environment management.

- Download Anaconda from https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh

- Install Anaconda with default options:
```sh
bash Anaconda3-4.4.0-Linux-x86_64.sh
```
- Upgrade your default environment to Python 3.6.1:
```sh
conda install python=3.6.1
```
- Install Django 1.11.3:
```sh
conda install -c conda-forge django=1.11.3
```
- Install PyGMO:
```sh
conda install -c conda-forge pygmo=1.1.7
```
- Install gdal:
```sh
conda install -c conda-forge gdal=2.1.3
```
- Install psycopg:
```sh
conda install -c anaconda psycopg2=2.7.1
```
- Install urllib3:
```sh
conda install -c conda-forge urllib3=1.21.1
```
- Install passlib:
```sh
conda install -c anaconda passlib=1.7.1
```
- Switch to default environment:
```sh
source activate root
```
- Install googlemaps via pip:
```sh
pip install -U googlemaps
```
- Install django-background-tasks via pip:
```sh
pip install -U django-background-tasks
```

- Go to directory:`/home/<UserName>/anaconda3/lib/python3.6/site-packages/django/contrib/admin/static`

- Copy js, img & css contents from `gisModule/Templates/gisModule` project folder to this directory.

- Setup database:
```sh
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
# Note your installed postgresql version
sudo apt-get install -y postgis postgresql-9.x-postgis # Change x with your postgresql version
sudo apt-get install -y postgis postgresql-9.x-pgrouting # Change x with your postgresql version
sudo -u postgres createuser -P USER_NAME_HERE
sudo -u postgres createdb -O USER_NAME_HERE TEMP_DATABASE_NAME_HERE
sudo su - postgres
psql TEMP_DATABASE_NAME_HERE < PATH_TO_PROJECT_FOLDER_HERE/backup.sql
```
- Install PGAdmin III from Ubuntu Store.

- Setup and run OSRM-Backend server on localhost. Guide and source code can be found on https://github.com/Project-OSRM/osrm-backend

### Starting The Server

- Switch to default Anaconda Environment:
```sh
source activate root
```
- Start server by running the command in project's root folder:
```sh
python manage.py runserver --noreload
```
- Start background tasks by running the command in project's root folder:
```sh
python manage.py process_tasks
```

### Guide

- Server can be accessed from `localhost:8000`.
- Login is required for using shopping page. Login or register a new account from http://localhost:8000/gisModule/login/ 
- Shopping page can be found on http://localhost:8000/gisModule/shop/.
- Shopping cart can be found on http://localhost:8000/gisModule/cart/.
- Account settings page can be found on http://localhost:8000/gisModule/account/.
- Admin panel for server can be found on http://localhost:8000/admin/. Credentials are username `dyanikoglu` and password `django1234`.
