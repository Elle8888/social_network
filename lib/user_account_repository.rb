require 'user_account'

class UserAccountsRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, email_add, username FROM user_accounts;'
      result_set = DatabaseConnection.exec_params(sql, [])

      accounts = []

      result_set.each do |account|
        newAccount = UserAccount.new

        newAccount.id = account['id']
        newAccount.email_add = account['email_add']
        newAccount.username = account['username']

        accounts << account
        p account
      end
    #   p accounts
      return accounts

      # Returns an array of UserAccount objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
        sql = 'SELECT id, email_add, username FROM user_accounts WHERE id = $1;'
        sql_params = [id]

        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return result_set
      # Returns a single UserAccount object.
    end
  
    def create(user_account)
      sql = 'INSERT INTO user_accounts (email_add, username)
      VALUES ($1, $2);'

      sql_params = [user_account.email_add, user_account.username]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      
      return nil
    end
  
  #   # def update(student)
  #   # end
  
    def delete(id)
      sql = 'DELETE FROM user_accounts WHERE id = $1'
      sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil
    end
  end