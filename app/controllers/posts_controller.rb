class PostsController < ApplicationController
  layout 'blog'

  def index
    recent_posts
  end

  def show
    post
  end

private

  def recent_posts
    @posts ||= Post.homepage
  end

  def post
    @post ||= Post.find_by(permalink: params[:id])
  end

end
