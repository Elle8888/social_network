class PostsRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      #   # SELECT  id, title, content, views, user_accounts_id;
  
      # Returns an array of post objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECTid, title, content, views, user_accounts_id FROM posts WHERE id = $1;
  
      # Returns a single post object.
    end
  
    def create(post)
      # INSERT INTO post
      # (title, content, views, user_accounts_id)
      # VALUES (post.title, post.content, post.views, post.user_accounts_id
      # returns nil
    end
  
  #   # def update(student)
  #   # end
  
    def delete(id)
      # DELETE FROM post WHERE id = $1'
      # returns nil
    end
  end