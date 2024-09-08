from bottle.bottle import route, template
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()

@route('/new_user')
def new_user():
    return template('templates/new_user.tpl')

@post('/save_user')
def save_user():
    login = request.forms.get('login')
    password = request.forms.get('password')
    status = request.forms.get('status')
    cur.execute('''INSERT into user(login,password,status) VALUES (?,?,?)''',(login,password,status))
    con.commit()
    redirect('/users')

@route('/users')
def users():
    users = []
    for row in cur.execute("SELECT rowid,login,password,status FROM user ORDER BY login"):
        users.append(row)
    return template('templates/users.tpl', users=users)

@route('/delete_user/<id:int>')
def delete_user(id):
    sql='DELETE from user where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/users')

@post('/update_user')
def update_user():
    rowid = request.forms.get('rowid')
    login = request.forms.get('login')
    password = request.forms.get('password')
    status = request.forms.get('status')
    cur.execute('''UPDATE user set login=?, password=?, status=? where rowid=?''',(login,password,status,rowid))
    con.commit()
    redirect('/users')

@route('/edit_user/<id>')
def edit_user(id):
    sql='''SELECT rowid,login,password,status FROM user where rowid={}'''.format(id) 
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'login':row[1],'password':row[2],'status':row[3]}
    return template('templates/edit_user.tpl',**data)
