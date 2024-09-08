from bottle.bottle import route, run, template, static_file
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

from user import *
from guest import *
from room import *

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()

GUEST = ['room_no','first_name','last_name','phone,email', 'city','address','country','arrival_date',
        'departure_date','no_adults','no_children','comment','status']
ROOM = ['room_no', 'floor', 'category', 'beds', 'price', 'status']

hotel = {}

@route('/')
@route('/index')
def index():
    return template('templates/index.html')
                    
@route('/help')
def help():
    return template('templates/help.tpl')

@route('/about')
def about():
    return template('templates/about.tpl')

@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')

@route('/create_database/<name>')
def create_db(name):
    con = sqlite3.connect('database/'+name+'.db')
    cur = con.cursor()
    cur.execute("CREATE TABLE if not exists room(room_no, floor, category, beds, price, status)")
    cur.execute("CREATE TABLE if not exists guest(room_no,first_name,last_name,phone, email,city,address,country,\
                arrival_date, departure_date,no_adults, no_children,comment,status)")
    cur.execute("CREATE TABLE if not exists user(login, password,status)")
    redirect('/')


@route('/login')
def login():
    return template('templates/login.tpl',hotel=hotel['name'])

@post('/login_check')
def login_check():
    login = request.forms.get('login')
    password = request.forms.get('password')
    redirect('/')

def read_setup():
    global hotel
    f = open('setup.json')
    hotel = json.load(f)
    f.close()

@route('/admin')
def admin():
    return template('templates/admin.html')

@route('/edit_setup')
def edit_setup():
    read_setup();
    return template('templates/edit_setup.tpl',**hotel)

@post('/save_setup')
def save_setup():
    name = request.forms.get('name')
    logo = request.forms.get('logo')
    address = request.forms.get('address')
    country = request.forms.get('country')
    phone = request.forms.get('phone')
    email = request.forms.get('email')
    vat = request.forms.get('vat')
    json_string = json.dumps({'name':name,'logo':logo,'address':address,'country':country,'phone':phone,'email':email,'vat':vat})
    f = open('setup.json','w')
    f.write(json_string)
    f.close()
    read_setup()
    redirect('/')

read_setup()     
run(host='0.0.0.0', port=8000)
