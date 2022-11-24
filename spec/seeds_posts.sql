TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_add, username) VALUES ('abc@gmail.com', 'abc');
INSERT INTO user_accounts (email_add, username) VALUES ('def@gmail.com', 'def');
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title1', 'content1', 1, 1);
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title2', 'content2', 2, 1);
