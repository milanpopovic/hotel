from bottle.bottle import route, run, template, static_file
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()

@route('/new_guest')
def new_guest():
    return template('templates/new_guest.tpl')

@route('/room_reservation/<room_no>/<arrival_date>/<departure_date>')
def room_reservation(room_no,arrival_date,departure_date):
    return template('templates/room_reservation.tpl',room_no=room_no,arrival_date=arrival_date,departure_date=departure_date)

@route('/edit_guest/<id:int>')
def edit_guest(id):
    sql = '''SELECT rowid,room_no,first_name,last_name,phone,email, city,address,country,arrival_date,
        departure_date,no_adults,no_children,comment,status FROM guest where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'room_no':row[1],'first_name':row[2],'last_name':row[3],  'phone':row[4], 'email':row[5], 'city':row[6], 'address':row[7], 'country':row[8],
            'arrival_date':row[9],'departure_date':row[10],'no_adults':row[11], 'no_children':row[12],'comment':row[13],'status':row[14]}
    return template('templates/edit_guest.tpl',**data)

@post('/save_guest')
def save_guest():
    room_no = request.forms.get('room_no')
    first_name = request.forms.get('first_name')
    last_name = request.forms.get('last_name')
    phone = request.forms.get('phone')
    email = request.forms.get('email')
    city = request.forms.get('city')
    address = request.forms.get('address')
    country = request.forms.get('country')
    arrival_date = request.forms.get('arrival_date')
    departure_date = request.forms.get('departure_date')
    adults = request.forms.get('no_adults')
    children = request.forms.get('no_children')
    comment = request.forms.get('comment')
    status = request.forms.get('status')
    if not check_room_exists(room_no):
        message='Room {} does not exist'.format(room_no)
        return template('templates/error_message.tpl',message=message)
    cur.execute('''INSERT into guest (room_no,first_name,last_name,  phone, email,city,address,country,
                arrival_date, departure_date,no_adults, no_children,comment,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)''',\
                (room_no,first_name,last_name,phone,email,city,address,country,arrival_date,departure_date,adults,children,comment,status))
    con.commit()
    redirect('/guests'+'/'+status)

@post('/update_guest')
def update_guest():
    
    rowid= request.forms.get('rowid')
    room_no = request.forms.get('room_no')
    first_name = request.forms.get('first_name')
    last_name = request.forms.get('last_name')
    phone = request.forms.get('phone')
    email = request.forms.get('email')
    city = request.forms.get('city')
    address = request.forms.get('address')
    country = request.forms.get('country')
    arrival_date = request.forms.get('arrival_date')
    departure_date = request.forms.get('departure_date')
    adults = request.forms.get('no_adults')
    children = request.forms.get('no_children')
    comment = request.forms.get('comment')
    status = request.forms.get('status')
    if not check_room_exists(room_no):
        message='Room {} does not exist'.format(room_no)
        return template('templates/error_message.tpl',message=message)
    cur.execute('''UPDATE guest set room_no=?, first_name=?, last_name=?, phone=?, email=?, city=?, address=?, country=?, arrival_date=?,\
                    departure_date=?, no_adults=?, no_children=?, comment=?, status=? where rowid=?''',\
                (room_no,first_name,last_name,phone,email,city,address,country,arrival_date,departure_date,adults,children,comment,status,rowid))
    con.commit()
    redirect('/guests'+'/'+status)

@route('/delete_guest/<id>')
def delete_guest(id):
    sql='DELETE from guest where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/guests/Checked-in')

def all_guests(status):
    guests = []
    sql = '''SELECT rowid,room_no,first_name,last_name,  phone, email,city,address,country,arrival_date,departure_date,
            no_adults, no_children,comment,status  FROM guest where status="{}" ORDER BY room_no'''.format(status)
    rows = cur.execute(sql)
    for row in rows: 
        guests.append(row)
    return guests

@route('/guests/<status>')
def get_all_guests(status):
    return template('templates/guests.tpl', title=status, guests=all_guests(status))

@route('/checkin/<id>')
def checkin(id):
    sql='''UPDATE guest set status="Checked-in" where rowid={}'''.format(id)
    cur.execute(sql)
    redirect('/guests/Checked-in')

@route('/checkout/<id>')
def checkout(id):
    sql='''UPDATE guest set status="Checked-out" where rowid={}'''.format(id)
    cur.execute(sql)
    redirect('/guests/Checked-out')

def convert_date(date):
    months={'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06','Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}
    parts=date.split()
    month = months[parts[1]]
    return (int(parts[3]), int(month), int(parts[2]))

def days_between(d1, d2):
    date1 = datetime.datetime(d1[0], d1[1], d1[2])
    date2 = datetime.datetime(d2[0], d2[1], d2[2])
    return abs((date2 - date1).days)

def check_room_exists(room_no):
    sql = '''SELECT * FROM room where room_no="{}"'''.format(room_no)
    rooms = cur.execute(sql)
    room=cur.fetchone()
    return room
    
@route('/invoice/<id>')
def invoice(id):
    sql = '''SELECT rowid,room_no,first_name,last_name,  phone, email, city, address, country, arrival_date,
        departure_date,no_adults, no_children,comment,status FROM guest where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    if not check_room_exists(row[1]):
        message='Room {} does not exist'.format(room_no)
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

@route('/reservation/<id>')
def reservation(id):
    sql='''UPDATE guest set status="Reservation" where rowid={}'''.format(id)
    cur.execute(sql)
    redirect('/guests/Reservation')                           

@route('/invoices')
def invoices():
    return template('templates/guests.tpl', guests=all_guests('Checked-out'))
    
@route('/reservations')
def reservations():
    return template('templates/guests.tpl', guests=all_guests('Reservations'))

@route('/booking_import')
def booking_import():
    f=open('contacts.csv')
    guests = f.readlines()
    for guest in guests:
        name,phone,email,city,country = guest.split(',')
        name = name.split()
        sql='''INSERT into guest (first_name,last_name,phone,email,city,country,status) values("{}","{}","{}","{}","{}","{}","Reservation");'''.format(name[0],name[1],phone,email,city,country)
        cur.execute(sql)
        f.close()
    con.commit()
    return template('templates/guests.tpl', guests=all_guests('Reservations'))
