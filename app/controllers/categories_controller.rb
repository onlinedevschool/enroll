class CategoriesController < ApplicationController
  layout 'blog'

  def index
    @categories = Category.containing_posts
  end
end
