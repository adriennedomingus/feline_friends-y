class ArticlesController < ApplicationController
  def index
    @articles = Articles.new.articles(20)
  end
end
