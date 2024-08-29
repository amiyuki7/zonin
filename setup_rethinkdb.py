import hashlib
from rethinkdb import r

conn = r.connect(db='test')

# Setup users table and email secondary key
r.table_create('users').run(conn)
r.table('users').index_create('email').run(conn)

r.table_create('activities').run(conn)

# Create a default user (for testing purposes)
hash = hashlib.sha256(b"admin888").hexdigest()
result = r.table('users').insert({'email': 'admin@zonin.dev', 'password': hash}, return_changes=True).run(conn)
userId = result['changes'][0]['new_val']['id']

# Create default activities for our default user, 'style': ' '
r.table('activities').insert({'userId': userId, 'name': 'Mathematics', 'description': 'Extension 2', 'style': ' ', 'order': 0}).run(conn)
r.table('activities').insert({'userId': userId, 'name': 'English', 'description': ' ', 'style': ' ', 'order': 1}).run(conn)