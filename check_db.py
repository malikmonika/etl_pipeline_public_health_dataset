import sqlite3
import os

# Find database files
print("DB files found:")
for f in os.listdir('.'):
    if f.endswith('.db') or f == 'test_db':
        print(f, "—", os.path.getsize(f), "bytes")

# Connect and query
conn = sqlite3.connect('test_db')
cursor = conn.cursor()

# Show all tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
print("\nTables:", cursor.fetchall())

# Count rows
cursor.execute("SELECT COUNT(*) FROM test_db")
print("Total rows:", cursor.fetchone()[0])

# Preview
cursor.execute("SELECT * FROM test_db LIMIT 3")
for row in cursor.fetchall():
    print(row)
# Top 5 countries by confirmed cases
cursor.execute("""SELECT Country_Region, MAX(Confirmed) as max_confirmed FROM test_db GROUP BY Country_Region ORDER BY max_confirmed DESC LIMIT 5""")
for top_countries in cursor.fetchall():
    print(top_countries)
conn.close()