TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title1', 'content1', 1, 1);
INSERT INTO posts (title, content, views, user_accounts_id) VALUES ('title2', 'content2', 2, 2);