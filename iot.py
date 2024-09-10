from bottle.bottle import route, template
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()

@route('/new_device')
def new_device():
    return template('iot_templates/new_device.tpl')

@post('/save_device')
def save_device():
    name = request.forms.get('name')
    ip = request.forms.get('ip')
    status = request.forms.get('status')
    comment = request.forms.get('comment')
    cur.execute('''INSERT into device(name,ip,status,comment) VALUES (?,?,?,?)''',(name,ip,status,comment))
    con.commit()
    redirect('/devices')

@route('/devices')
def devices():
    devices = []
    for row in cur.execute("SELECT rowid,name,ip,status,comment FROM device ORDER BY name"):
        devices.append(row)
    return template('iot_templates/devices.tpl', devices=devices)

@route('/delete_device/<id:int>')
def delete_device(id):
    sql='DELETE from device where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/devices')

@post('/update_device')
def update_device():
    rowid = request.forms.get('rowid')
    name = request.forms.get('name')
    ip = request.forms.get('ip')
    status = request.forms.get('status')
    comment = request.forms.get('comment')
    cur.execute('''UPDATE device set name=?, ip=?, status=?, comment=? where rowid=?''',(name,ip,status,comment,rowid))
    con.commit()
    redirect('/devices')

@route('/toggle_status/<id>')
def toggle_status(id):
    sql='''SELECT rowid,name,ip,status,comment FROM device where rowid={}'''.format(id) 
    rows = cur.execute(sql)
    row = cur.fetchone()
    status = row[3]
    status = 'ON' if status=='OFF' else 'OFF'
    cur.execute('''UPDATE device set status=? where rowid=?''',(status,id))
    con.commit()
    redirect('/devices')

@route('/edit_device/<id>')
def edit_device(id):
    sql='''SELECT rowid,name,ip,status,comment FROM device where rowid={}'''.format(id) 
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'name':row[1],'ip':row[2],'status':row[3],'comment':row[4]}
    return template('iot_templates/edit_device.tpl',**data)
