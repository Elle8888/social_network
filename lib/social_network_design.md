# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

# Social Network Two Tables Design Recipe

_Copy this recipe template to design and create two related database tables from a specification._

### 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

```
Nouns:

network user, user account, email address, username, posts, title, content, number of views
```

### 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| user_accounts          | email_add, username
| posts                 | title, content, views, user_id

1. Name of the first table (always plural): `user_accounts`

    Column names: `id`,`email_add`, `username`

2. Name of the second table (always plural): `posts`

    Column names: `id`, `title`, `content`, `views`, `user_id`

### 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```

Table: user_accounts
id: SERIAL
email_add: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int
user_accounts_id: int

```

### 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one user_accounts have many posts? (Yes/No) Yes
2. Can one posts have many user_accounts? (Yes/No) No

You'll then be able to say that:

-> Therefore,
-> A user_account HAS MANY posts
-> A posts BELONGS TO a single user_account

-> Therefore, the foreign key is on the posts table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

### 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_add text,
  username text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_account_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);

```

### 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < social_network.sql
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_add, username) VALUES ('abc@gmail.com', 'abc');
INSERT INTO user_accounts (email_add, username) VALUES ('def@gmail.com', 'def');
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title1', 'content1', 1, 1);
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title2', 'content2', 2, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_user_accounts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class UserAccount
end

# Repository class
# (in lib/student_repository.rb)
class UserAccountRepository
end

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Post
end

# Repository class
# (in lib/student_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_add, :username
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_accounts_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```


*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_add, username;

    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id,  email_add, username FROM user_accounts WHERE id = $1;

    # Returns a single UserAccount object.
  end

  def create(user_account)
    # INSERT INTO UserAccount
    # (email_add, username)
    # VALUES (user_account.email_add, user_account.username)
    # returns nil
  end

#   # def update(student)
#   # end

  def delete(id)
    # DELETE FROM user_account WHERE id = $1'
    # returns nil
  end
end

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    #   # SELECT  id, title, content, views, user_accounts_id;

    # Returns an array of post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECTid, title, content, views, user_accounts_id FROM posts WHERE id = $1;

    # Returns a single post object.
  end

  def create(post)
    # INSERT INTO post
    # (title, content, views, user_accounts_id)
    # VALUES (post.title, post.content, post.views, post.user_accounts_id
    # returns nil
  end

#   # def update(student)
#   # end

  def delete(id)
    # DELETE FROM post WHERE id = $1'
    # returns nil
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
#UserAccountRepository 
# 1
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all

user_accounts.length # =>  2

user_accounts[0].id # =>  1
user_accounts[0].email_add # =>  'abc@gmail.com'
user_accounts[0].username # =>  'abc'

user_accounts[1].id # =>  2
user_accounts[1].email_add # =>  'def@gmail.com
user_accounts[1].username # =>  'def'


# 2
# Get a single user_account

repo = UserAccountRepository.new

user_accounts = repo.find(1)

user_accounts.length # =>  2

user_accounts.id # =>  1
user_accounts.email_add # =>  'abc@gmail.com'
user_accounts.username # =>  'abc'

student = repo.find(2)

user_accounts.id # =>  2
user_accounts.email_add # =>  'def@gmail.com
user_accounts.username # =>  'def'

# 3
# create a new object

repo = UserAccountRepository.new

user_accounts.id # =>  1
user_accounts.email_add # =>  'abc@gmail.com'
user_accounts.username # =>  'abc'

repo.create(album)

albums = repo.all

expect(albums).to include(
  have_attributes(
    id: user_accounts.id,
    email_add: user_accounts.email_add
    username: user_accounts.username,
    )
  ) # => returns an array including the new object

# 4
# deletes all objects

repo = UserAccountRepository.new
repo.delete(1)
repo.delete(2)
user_accounts = repo.all
user_accounts.length # => 0

# 5
# deletes one object

repo = UserAccountRepository.new
repo.delete(1)
user_accounts = repo.all
user_accounts.length # => 1


#PostsRepository
# 1
# Get all user_accounts

repo = PostRepository.new

post = repo.all

post.length # =>  2

post[0].id # =>  1
post[0].title # =>  'title1'
post[0].content # =>  'contents1'
post[0].views # => 1
post[0].user_accounts_id # => 1

INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title1', 'content1', 1, 1);
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title2', 'content2', 2, 2);

# 2
# Get a single user_account

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'title1'
post.content # =>  'contents1'
post.views # => 1
post.user_accounts_id # => 1

# 3
# create a new object

repo = PostRepository.new

post.id # =>  1
post.title # =>  'title3'
post.content # =>  'contents3'
post.views # => 1
post.user_accounts_id # => 1

repo.create(album)

albums = repo.all

expect(albums).to include(
  have_attributes(
    id: user_accounts.id,
    email_add: user_accounts.email_add
    username: user_accounts.username,
    )
  ) # => returns an array including the new object

# 4
# deletes all objects

repo = PostRepository.new
repo.delete(1)
repo.delete(2)
post = repo.all
post.length # => 0

# 4
# deletes one object

repo = PostRepository.new
repo.delete(1)
post = repo.all
post.length # => 1

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

describe UserAccountsRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
