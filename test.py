##import datetime
##date_obj = datetime.datetime.strptime('Tue Sep 03 2024', '%a %b %d %Y')
##print(date_obj)
##return (t1start <= t2start <= t1end) or (t2start <= t1start <= t2end)


##import random
##from datetime import date
##from dateutil.relativedelta import relativedelta
##
##from_now = random.randint(1,60) # in days
##no_days = random.randint(1,5) # stay duration in days
##start_date = date.today() + relativedelta(days=from_now)
##end_date = start_date + relativedelta(days=no_days)
##print(start_date.strftime("%a %b %d %Y"),end_date.strftime("%a %b %d %Y"))
##

import sqlite3
from datetime import datetime

con = sqlite3.connect('database/hotel.db')
cur = con.cursor()
sql='select * from guest'
cur.execute(sql)
rows = cur.execute(sql)
for row in rows:
    if row[13] != 'Reservation':
        continue
    arrival_str = row[8]
    departure_str = row[9]
    arrival_date = datetime.strptime(arrival_str, '%a %b %d %Y')
    departure_date = datetime.strptime(departure_str, '%a %b %d %Y')
    arrival = datetime.timestamp(arrival_date)
    departure = datetime.timestamp(departure_date)
    arrival_obj = datetime.fromtimestamp(arrival)
    departure_obj = datetime.fromtimestamp(departure)
    print(arrival,departure,arrival_obj.strftime("%a %b %d %Y"),departure_obj.strftime("%a %b %d %Y"))
    sql = "update guest set arrival_date='{}',departure_date='{}'".format(arrival,departure)
    print(sql)
    cur.execute(sql)
    con.commit()
