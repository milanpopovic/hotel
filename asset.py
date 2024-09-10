from bottle.bottle import route, run, template, static_file
from bottle.bottle import get, post, request, redirect
import sqlite3
import datetime, json

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()
               
@route('/new_asset')
def new_asset():
    return template('asset_templates/new_asset.tpl')

@post('/save_asset')
def save_asset():
    name = request.forms.get('name')
    location = request.forms.get('location')
    category = request.forms.get('category')
    year = request.forms.get('year')
    status = request.forms.get('status')
    cur.execute('''INSERT into asset(name,location,category,year,status) VALUES (?,?,?,?,?)''',(name,location,category,year,status))
    con.commit()
    redirect('/assets')

@route('/assets')
def assets():
    assets = []
    for row in cur.execute("SELECT rowid,name,location,category,year,status FROM asset ORDER BY location"):
        assets.append(row)
    return template('asset_templates/assets.tpl', assets=assets)

@route('/delete_asset/<id:int>')
def delete_asset(id):
    sql='DELETE from asset where rowid={}'.format(id)
    cur.execute(sql)
    con.commit()
    redirect('/assets')

@post('/update_asset')
def update_asset():
    rowid = request.forms.get('rowid')
    name = request.forms.get('name')
    location = request.forms.get('location')
    category = request.forms.get('category')
    year = request.forms.get('year')
    status = request.forms.get('status')
    cur.execute('''UPDATE asset set name=?, location=?, category=?, year=?, status=? where rowid=?''',(name,location,category,year,status,rowid))
    con.commit()
    redirect('/assets')

@route('/edit_asset/<id>')
def edit_asset(id):
    sql='''SELECT rowid,name,location,category,year,status FROM asset where rowid={}'''.format(id) 
    rows = cur.execute(sql)
    row = cur.fetchone()
    data = {'rowid':row[0],'name':row[1],'location':row[2],'category':row[3],'year':row[4],'status':row[5]}
    return template('asset_templates/edit_asset.tpl',**data)
