require 'user_account'

class UserAccountsRepository

  def all
    sql = 'SELECT id, email_add, username FROM user_accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    accounts = []

    result_set.each do |account|
      newAccount = UserAccount.new

      newAccount.id = account['id']
      newAccount.email_add = account['email_add']
      newAccount.username = account['username']

      accounts << newAccount

    end

    return accounts

  end

  def find(id)
    sql = 'SELECT id, email_add, username FROM user_accounts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    newAccount = UserAccount.new

    newAccount.id = result_set[0]['id']
    newAccount.email_add = result_set[0]['email_add']
    newAccount.username = result_set[0]['username']

    return newAccount

  end

  def create(user_account)
    sql = 'INSERT INTO user_accounts (email_add, username)
      VALUES ($1, $2);'
    sql_params = [user_account.email_add, user_account.username]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM user_accounts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(id)
    sql = 'UPDATE user_accounts SET email_add = $1, username = $2
      WHERE id = $3;'
    sql_params = ['newabc@gmail.com', 'newabc', id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end