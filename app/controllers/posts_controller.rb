class PostsController < ApplicationController
  belongs_to :author, class_name: 'User'

  def title=(val)
    write_attribute(:title, val)
    set_permalink(val)
  end

  def markdown=(val)
    write_attribute(:markdown, val)
    cache_html(val)
  end

private

  def cache_html(val)
    html = RDiscount.new(val).to_html
    write_attribute(:html, val)
  end

  def set_permalink(val)
    return if permalink.present?
    write_attribute(:permalink, val.parameterize)
  end
end
