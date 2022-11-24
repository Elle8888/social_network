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

    it 'gets a single user account' do

        repo = UserAccountsRepository.new

        user_accounts = repo.find(1)

        # expect(user_accounts.length).to eq 2

        expect(user_accounts[0]['id']).to eq '1'
        expect(user_accounts[0]['email_add']).to eq 'abc@gmail.com'
        expect(user_accounts[0]['username']).to eq 'abc'

        user_accounts = repo.find(2)

        expect(user_accounts[0]['id']).to eq '2'
        expect(user_accounts[0]['email_add']).to eq 'def@gmail.com'
        expect(user_accounts[0]['username']).to eq 'def'

    end

    it 'adds an object' do
        repo = UserAccountsRepository.new

        newAccount = UserAccount.new
        newAccount.email_add = 'ghi@gmail.com'
        newAccount.username = 'ghi'
        newAccount.id = '3'

        repo.create(newAccount)

        user_accounts = repo.all

        expect(user_accounts.length).to eq 3

        expect(user_accounts[2]['id']).to eq '3'
        expect(user_accounts[2]['email_add']).to eq 'ghi@gmail.com'
        expect(user_accounts[2]['username']).to eq 'ghi'

        # expect(newAccounts).to include(
        #  have_attributes(
        #    id: newAccount.id,
        #    email_add: newAccount.email_add,
        #    username: newAccount.username,
        #    )
        #  )
    end

    it 'deletes all acounts' do

    repo = UserAccountsRepository.new
    repo.delete(1)
    repo.delete(2)
    user_accounts = repo.all
    expect(user_accounts.length).to eq 0

    end
end

# Get all user_accounts

