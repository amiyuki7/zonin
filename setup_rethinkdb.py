import hashlib
from rethinkdb import r

conn = r.connect(db='test')

# Setup users table and email secondary key
r.table_create('users').run(conn)
r.table('users').index_create('email').run(conn)

# Create a default user (for testing purposes)
hash = hashlib.sha256(b"admin888").hexdigest()
r.table('users').insert({'email': 'admin@zonin.dev', 'password': hash}).run(conn)
