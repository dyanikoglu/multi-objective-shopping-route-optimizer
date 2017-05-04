# Multi-Objective Shopping Route Optimizer

### Server Installation

Because of the high count of dependencies of required modules, Anaconda must be used for Python environment management. For DB, PostgreSQL is required. PGAdmin III can be used for DB management. It's assumed that these components are already installed on your Linux system.

-- Download Anaconda from https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh

-- Install Anaconda with default options:
```sh
bash Anaconda3-4.3.1-Linux-x86_64.sh
```
-- Upgrade your default environment to Python 3.6.1:
```sh
conda install python=3.6.1
```
-- Install Django 1.11:
```sh
conda install -c conda-forge django=1.11
```
-- Install PyGMO:
```sh
conda install -c conda-forge pygmo=1.1.7
```
-- Install gdal:
```sh
conda install -c conda-forge gdal=2.1.3
```
-- Install psycopg:
```sh
conda install -c anaconda psycopg2=2.7.1
```
-- Install urllib3:
```sh
conda install -c conda-forge urllib3=1.20
```
-- Install passlib:
```sh
conda install -c anaconda passlib=1.7.1
```
-- Switch to default environment:
```sh
source activate root
```
-- Install googlemaps via pip:
```sh
pip install -U googlemaps
```

-- Go to directory:`/home/<UserName>/anaconda3/lib/python3.6/site-packages/django/contrib/admin/static`
-- Copy js, img & css contents from `gisModule/Templates` project folder to this directory.

-- Restore PostgreSQL Server backup named `DjangoServer` from project with PGAdmin III. Enable the server.
