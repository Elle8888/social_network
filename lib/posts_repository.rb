require 'post'

class PostsRepository

  def all
    sql = 'SELECT id, title, content, views, user_accounts_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |entry|
      post = Post.new

      post.id = entry['id']
      post.title = entry['title']
      post.content = entry['content']
      post.views = entry['views']
      post.user_accounts_id = entry['user_accounts_id']

      posts << post
    end

    return posts

  end

  def find(id)
      sql = 'SELECT id, title, content, views, user_accounts_id FROM posts WHERE id = $1;'
      sql_params = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)

      post = Post.new

      post.id = result_set[0]['id']
      post.title = result_set[0]['title']
      post.content = result_set[0]['content']
      post.views = result_set[0]['views']
      post.user_accounts_id = result_set[0]['user_accounts_id']

      return post
  end

  def create(post)
      sql = 'INSERT INTO posts (title, content, views, user_accounts_id)
      VALUES ($1, $2, $3, $4);'
      sql_params = [post.title, post.content, post.views, post.user_accounts_id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)

      return nil
  end

  def delete(id)
      sql = 'DELETE FROM posts WHERE id = $1'
      sql_params = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)

      return nil
  end
end