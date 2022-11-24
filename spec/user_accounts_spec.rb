require 'user_account_repository'

RSpec.describe UserAccountsRepository do

    def reset_user_accounts_table
        seed_sql = File.read('spec/seeds_user_accounts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
      end
      

        before(:each) do 
          reset_user_accounts_table
        end
      
        # (your tests will go here).


    it 'gets all user accounts' do

        repo = UserAccountsRepository.new

        user_accounts = repo.all

        expect(user_accounts.length).to eq  2

        expect(user_accounts[0]['id']).to eq '1' # =>  1
        expect(user_accounts[0]['email_add']).to eq 'abc@gmail.com'
        expect(user_accounts[0]['username']).to eq 'abc'

        expect(user_accounts[1]['id']).to eq '2'
        expect(user_accounts[1]['email_add']).to eq 'def@gmail.com'
        expect(user_accounts[1]['username']).to eq 'def'

    end
end

# Get all user_accounts

