from bottle.bottle import auth_basic, route, run, template, static_file
from bottle.bottle import get, post, request, redirect, abort
import sqlite3, datetime, json, functools
import smtplib, ssl
from email.message import EmailMessage

from user import *
from guest import *
from room import *
from iot import *
from asset import *

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()

GUEST = ['room_no','first_name','last_name','phone,email', 'city','address','country','arrival_date',
        'departure_date','no_adults','no_children','comment','status']
ROOM = ['room_no', 'floor', 'category', 'beds', 'price', 'status']

hotel = {}
  
users={user[0]:user[1] for user in cur.execute("select login,password from user")}
logged = False

def is_authenticated_user(user, password):
    global logged
    # You write this function. It must return
    # True if user/password is authenticated, or False to deny access.
    result = user in users and users[user] == password and logged
    if not logged:
        logged = True
    return result

@route('/logout', method=["GET", "POST"])
#@auth_basic(is_authenticated_user)
def logout():
    global logged
    logged = False
    redirect('/')
    #return "You're no longer logged in"
    #abort(401, "You're no longer logged in")

@route('/')
@route('/index')
#@auth_basic(is_authenticated_user)
def index():
    return template('templates/index.html',hotel_name=hotel['name'])

@route('/invoice/<id>')
def invoice(id):
    sql = '''SELECT rowid,room_no,first_name,last_name,  phone, email, city, address, country, arrival_date,
        departure_date,no_adults, no_children,comment,status FROM guest where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    sql = '''SELECT price FROM room where room_no="{}"'''.format(row[1])
    rooms = cur.execute(sql)
    room=cur.fetchone()
    if not room:
        message='Room {} does not exist'.format(row[1])
        return template('templates/error_message.tpl',message=message)
    price = float(room[0].replace(',','.'))
    arrival = convert_date(row[9])
    departure = convert_date(row[10])
    days = days_between(departure, arrival)
    total = days*price
    vat = total*float(hotel['vat'])/100
    data = {'rowid':row[0],'room_no':row[1],'first_name':row[2],'last_name':row[3],  'phone':row[4], 'email':row[5],'city':row[6],'address':row[7],'country':row[8],
            'arrival_date':row[9],'departure_date':row[10],'no_adults':row[11], 'no_children':row[12],'comment':row[13],'status':row[14],
            'days':days,'price':price,'total':total,'vat':vat,'hotel_name':hotel['name'],'hotel_logo':hotel['logo'],"hotel_address":hotel['address'],
            "hotel_country":hotel['country'],"hotel_phone":hotel['phone'],"hotel_email":hotel['email'],"hotel_vat":hotel["vat"]}
    return template('templates/invoice.tpl',**data)
                    
@route('/help')
def help():
    return template('templates/help.tpl')

@route('/about')
def about():
    return template('templates/about.tpl')

@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')

@route('/admin')
def admin():
    return template('templates/admin.tpl')

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
    smtp_server = request.forms.get('smtp_server')
    port = request.forms.get('port')
    password = request.forms.get('password')
    json_string = json.dumps({'name':name,'logo':logo,'address':address,'country':country,'phone':phone,'email':email,'vat':vat, 'smtp_server':smtp_server,'port':port,'password':password}, indent=4)
    f = open('setup.json','w')
    f.write(json_string)
    f.close()
    read_setup()
    redirect('/admin')

@post('/send_mail')
def send_mail():
    receiver_email = request.forms.get('to')
    subject = request.forms.get('subject')
    message = request.forms.get('msg')
    to = request.forms.get('who')
    id = request.forms.get('id')
  
    if to == 'guest':
        sql = '''SELECT rowid,first_name,email FROM guest where rowid={}'''.format(id)
    else:
        sql = '''SELECT rowid,login,email FROM user where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    name = row[1]
    #receiver_email = row[2]
    sender_email = hotel['email']
    text = 'Hi {}, \n\n{}\n\nRespectfully,\n\nHotel {}\n{}\nPhone: {}\nEmail: {}'.format(name, message,hotel['name'],hotel['address'],hotel['phone'],hotel['email'])
    msg = EmailMessage()
    msg.set_content(text)
    msg['Subject'] = subject
    msg['From'] = sender_email
    msg['To'] = receiver_email
    password =  hotel['password']
    port = hotel['port']
    smtp_server = hotel['smtp_server']
    context = ssl.create_default_context()
    with smtplib.SMTP_SSL(smtp_server, port, context=context) as server:
        server.login(sender_email, password)
        server.send_message(msg)
    if to == 'guest':
        redirect("/edit_guest/"+id)
    else:
        redirect('/users')

@route('/guest_search/<text>')
def guest_search(text):
    sql = "SELECT rowid,room_no,first_name,last_name,  phone, email,city,address,country,arrival_date,departure_date,no_adults, no_children,comment,status  FROM guest where room_no || first_name ||\
    last_name  || phone || email || city || country || arrival_date || departure_date || status || comment like '%{}%' ORDER BY room_no".format(text)
    rows = cur.execute(sql)
    return template('templates/guests.tpl', title="Search results", guests=rows)

@route('/find_free_room')
def find_free_room():
    
    return template('templates/search_room.tpl')
                    
read_setup()   
run(host='0.0.0.0', port=8000)
