import pyodbc

conn = pyodbc.connect("DRIVER={SQL Server}; SERVER=localhost; DATABASE=PracticeDB; Tuseted_Connection=Yes")
cursor = conn.cursor()

cursor.execute("SELECT * FROM photos")
row = cursor.fetchone()
id, photo = row
with open(f'{id}.jpg', 'wb') as f:
    f.write(photo)

cursor.close()
conn.close()