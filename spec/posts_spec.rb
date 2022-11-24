require 'posts_repository'

RSpec.describe PostsRepository do

  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it 'gets all posts' do

    repo = PostsRepository.new

    post = repo.all

    expect(post.length).to eq 2

    expect(post[0].id).to eq '1'
    expect(post[0].title).to eq 'title1'
    expect(post[0].content).to eq 'content1'
    expect(post[0].views).to eq '1'
    expect(post[0].user_accounts_id).to eq '1'

    expect(post[1].id).to eq '2'
    expect(post[1].title).to eq 'title2'
    expect(post[1].content).to eq 'content2'
    expect(post[1].views).to eq '2'
    expect(post[1].user_accounts_id).to eq '1'

  end

  it 'get a single user_account' do

    repo = PostsRepository.new

    post = repo.find(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'title1'
    expect(post.content).to eq 'content1'
    expect(post.views).to eq '1'
    expect(post.user_accounts_id).to eq '1'

    post = repo.find(2)

    expect(post.id).to eq '2'
    expect(post.title).to eq 'title2'
    expect(post.content).to eq 'content2'
    expect(post.views).to eq '2'
    expect(post.user_accounts_id).to eq '1'

  end

  it 'create a new object' do

    repo = PostsRepository.new

    post = Post.new

    post.id = '3'
    post.title =  'title3'
    post.content =  'content3'
    post.views = 3
    post.user_accounts_id = 1

    repo.create(post)

    posts = repo.all

    expect(posts.length).to eq 3

    expect(posts[2].id).to eq '3'
    expect(posts[2].title).to eq 'title3'
    expect(posts[2].content).to eq 'content3'
    expect(posts[2].views).to eq '3'
    expect(posts[2].user_accounts_id).to eq '1'

  end

  it 'deletes all objects' do

    repo = PostsRepository.new
    repo.delete(1)
    repo.delete(2)
    post = repo.all
    expect(post.length).to eq 0

  end

  it 'deletes one object' do

    repo = PostsRepository.new
    post = repo.all

    expect(post.length).to eq 2

    repo.delete(1)
    post = repo.all
    expect(post.length).to eq 1
    
    expect(post[0].id).to eq '2'
    expect(post[0].title).to eq 'title2'
    expect(post[0].content).to eq 'content2'
    expect(post[0].views).to eq '2'
    expect(post[0].user_accounts_id).to eq '1'

  end
end