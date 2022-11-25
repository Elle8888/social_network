CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_add text,
  username: text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content: text,
  views: int
  user_account_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);