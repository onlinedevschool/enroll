class Authoring::PostsController < ApplicationController
  before_action :authenticate_author!

  layout 'bootstrap'

  def index
    posts
  end

  def new
    new_post
  end

  def edit
    post
  end

  def create
  end

  def update
    if post.update_attributes(post_params)
      redirect_to authoring_posts_path
    else
      render :edit
    end
  end

private

  def posts
    @posts ||= Post.all.ordered
  end

  def new_post
    @post ||= current_author.posts.build
  end

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :markdown)
  end
end
