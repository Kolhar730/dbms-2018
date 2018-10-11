from pymongo import MongoClient
client = MongoClient('localhost', 27017)

db = client.test

posts = db.posts

post_data_1 = {
	'title': 'Python and MongoDB',
    'content': 'PyMongo is fun, you guys',
    'author': 'Scott'
}

post_data_2 = {
    'title': 'Virtual Environments',
    'content': 'Use virtual environments, you guys',
    'author': 'Scott'
}

post_data_3 = {
    'title': 'Learning Python',
    'content': 'Learn Python, it is easy',
    'author': 'Bill'
}

res = posts.insert(post_data_1)

print('The First Post: '.format(res.inserted_id))

new_res = posts.insert([post_data_1,post_data_2, post_data_3])

print('All of the posts: '.format(new_res.inserted_ids))

