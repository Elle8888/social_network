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

      accounts << account

    end

    return accounts

  end

  def find(id)
    sql = 'SELECT id, email_add, username FROM user_accounts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return result_set

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
end