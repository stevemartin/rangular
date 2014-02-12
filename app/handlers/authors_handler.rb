class AuthorsHandler < Struct.new(:listener)
  attr_accessor :state_change, :params, :author
  def perform params, author
    @author = author
    @params = params
    set_request_type
    if state_change?
      manage_articles
      listener.recycle_form
    else
      if author.save
        listener.author_create_succeeded
      else
        listener.author_create_failed
      end
    end
  end

  def set_request_type
    @state_change = false
    @state_change = true if params['add_article'] || params['remove_article']
  end

  def state_change?
    state_change == true
  end

  def manage_articles
    if params['add_article']
      author.articles.build
    end

    if params['remove_article']
      articles = author.articles.to_a
      articles.delete_at(remove_article_id)
      author.articles = articles
    end
  end

  def remove_article_id
    params['remove_article'].keys.first.to_i
  end
end

