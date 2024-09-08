from bottle.bottle import route, run, template, static_file
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()
               
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
    cur.execute('''INSERT into room(room_no,floor,category,beds,price,status) VALUES (?,?,?,?,?,?)''',(room_no,floor,category,beds,price,status))
    con.commit()
    redirect('/rooms')

@route('/rooms')
def rooms():
    rooms = []
    for row in cur.execute("SELECT rowid,room_no, floor, category, beds, price, status FROM room ORDER BY room_no"):
        rooms.append(row)
    return template('templates/rooms.tpl', rooms=rooms)

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
    cur.execute('''UPDATE room set room_no=?, floor=?, category=?, beds=?, price=?, status=? where rowid=?''',(room_no,floor,category,beds,price,status,rowid))
    con.commit()
    redirect('/rooms')

@route('/edit_room/<id>')
def edit_room(id):
    sql='''SELECT rowid,room_no, floor, category, beds, price, status FROM room where rowid={}'''.format(id) 
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'room_no':row[1],'floor':row[2],'category':row[3],'beds':row[4],'price':row[5],  'status':row[6]}
    return template('templates/edit_room.tpl',**data)
