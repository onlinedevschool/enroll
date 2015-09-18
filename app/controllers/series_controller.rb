class SeriesController < ApplicationController
  layout 'blog'

  def index
    @series = Series.containing_posts
  end
end
