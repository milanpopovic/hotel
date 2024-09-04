from bottle import route, run, template, static_file
from bottle import get, post, request, redirect
import sqlite3

con = sqlite3.connect('hotel.db')
cur = con.cursor()

@route('/admin')
def admin():
    return template('templates/admin.html')

@route('/')
@route('/index')
def index():
    return template('templates/index.html')
                    
@route('/help')
def help():
    return '''
       <br>/help
       <br>/create_tables
       <br>/new_guest/guest_name/room_no
       <br>/get_all_guests
       <br>
       '''
@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')

@route('/create_tables')
def create_db():
    cur.execute("CREATE TABLE room(room_no, floor, category, beds, price, status)")
    cur.execute("CREATE TABLE guest(room_no,first_name,last_name,phone, email,\
                arrival_date, departure_date,no_adults, no_children,comment)")

@route('/new_guest')
def new_guest():
    return template('templates/new_guest.tpl')

@route('/edit_guest/<id:int>')
def edit_guest(id):
    sql = '''SELECT rowid,room_no,first_name,last_name,  phone, email,arrival_date,
        departure_date,no_adults, no_children,comment FROM guest where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'room_no':row[1],'first_name':row[2],'last_name':row[3],  'phone':row[4], 'email':row[5],
            'arrival_date':row[6],'departure_date':row[7],'no_adults':row[8], 'no_children':row[9],'comment':row[10]}
    return template('templates/edit_guest.tpl',**data)

@post('/save_guest')
def save_guest():
    room_no = request.forms.get('room_no')
    first_name = request.forms.get('first_name')
    last_name = request.forms.get('last_name')
    phone = request.forms.get('phone')
    email = request.forms.get('email')
    arrival_date = request.forms.get('arrival_date')
    departure_date = request.forms.get('departure_date')
    adults = request.forms.get('no_adults')
    children = request.forms.get('no_children')
    comment = request.forms.get('comment')
    cur.execute('''INSERT into guest (room_no,first_name,last_name,  phone, email,
                arrival_date, departure_date,no_adults, no_children,comment) VALUES (?,?,?,?,?,?,?,?,?,?)''',\
                (room_no,first_name,last_name,phone,email,arrival_date,departure_date,adults,children,comment))
    con.commit()
    redirect('/guests')

def all_guests(status='active'):
    guests = []
    for row in cur.execute('''SELECT rowid,room_no,first_name,last_name,  phone, email,arrival_date,
        departure_date,no_adults, no_children,comment FROM guest ORDER BY room_no'''): 
        guests.append(row)
    return guests

@post('/update_guest')
def update_guest():
    rowid= request.forms.get('rowid')
    room_no = request.forms.get('room_no')
    first_name = request.forms.get('first_name')
    last_name = request.forms.get('last_name')
    phone = request.forms.get('phone')
    email = request.forms.get('email')
    arrival_date = request.forms.get('arrival_date')
    departure_date = request.forms.get('departure_date')
    adults = request.forms.get('no_adults')
    children = request.forms.get('no_children')
    comment = request.forms.get('comment')
    cur.execute('''UPDATE guest set room_no=?, first_name=?, last_name=?, phone=?, email=?, arrival_date=?,
                    departure_date=?, no_adults=?, no_children=?, comment=? where rowid=?''',\
                (room_no,first_name,last_name,phone,email,arrival_date,departure_date,adults,children,comment,rowid))
    con.commit()
    redirect('/guests')

@route('/delete_guest/<id:int>')
def delete_guest(id):
    sql='DELETE from guest where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/guests')
     
@route('/guests')
def get_all_guests():
    
    return template('templates/guests.html', guests=all_guests())

@route('/checkin')
def check_in():
    return template('templates/check_in.tpl')

@route('/checkout/<id>')
def check_in(id):
    sql = '''SELECT room_no,first_name,last_name,  phone, email,arrival_date,
        departure_date,no_adults, no_children,comment FROM guest where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'room_no':row[0],'first_name':row[1],'last_name':row[2],  'phone':row[3], 'email':row[4],
            'arrival_date':row[5],'departure_date':row[6]}
    return template('templates/checkout.tpl', **data)


@route('/new_room')
def new_room():
    return template('templates/new_room.tpl')

@post('/save_room')
def save_room():
    room_no = request.forms.get('room_no')
    floor = request.forms.get('floor')
    category = request.forms.get('category')
    beds = request.forms.get('beds')
    price = request.forms.get('price')
    status = request.forms.get('status')
    cur.execute('''INSERT into room(room_no,floor,category,beds,price,status) VALUES (?,?,?,?,?,?)''',\
                (room_no,floor,category,beds,price,status))
    con.commit()
    rooms = []
    for row in cur.execute("SELECT room_no, floor, category, beds, price, status FROM room ORDER BY room_no"):
        rooms.append(row)
    redirect('/rooms')

@route('/rooms')
def rooms():
    rooms = []
    for row in cur.execute("SELECT rowid,room_no, floor, category, beds, price, status FROM room ORDER BY room_no"):
        rooms.append(row)
    return template('templates/rooms.html', rooms=rooms)

@route('/delete_room/<id:int>')
def delete_guest(id):
    sql='DELETE from room where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/rooms')

@post('/update_room')
def update_room():
    rowid = request.forms.get('rowid')
    room_no = request.forms.get('room_no')
    floor = request.forms.get('floor')
    category = request.forms.get('category')
    beds = request.forms.get('beds')
    price = request.forms.get('price')
    status = request.forms.get('status')
    cur.execute('''UPDATE room set room_no=?, floor=?, category=?, beds=?, price=?, status=? where rowid=?''',\
                (room_no,floor,category,beds,price,status,rowid))
    con.commit()
    redirect('/rooms')

@route('/edit_room/<id:int>')
def edit_room(id):
    sql = '''SELECT rowid,room_no, floor, category, beds, price, status FROM room where rowid={}'''.format(id)
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'room_no':row[1],'floor':row[2],'category':row[3],'beds':row[4],'price':row[5],  'status':row[6]}
    return template('templates/edit_room.tpl',**data)
     
     
run(host='localhost', port=8000)
