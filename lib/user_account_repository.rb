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