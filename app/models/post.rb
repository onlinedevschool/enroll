class Post < ActiveRecord::Base
  belongs_to :author

  scope :ordered, -> {
    order( created_at: :desc )
  }

  scope :published, -> {
    where('posts.published_at <= NOW()')
  }

  scope :homepage, -> {
    published.ordered.limit(6)
  }

  def author_name
    author && author.name
  end

  def author_avatar
    author && author.gravatar_url
  end

  def published?
    published_at.present? &&
      published_at <= DateTime.now
  end

  def title=(val)
    write_attribute(:title, val)
    return if permalink.present?
    write_attribute(:permalink, val.parameterize)
  end

  def markdown=(val)
    write_attribute(:markdown, val)
    write_attribute(:html, to_html(val))
  end

private

  def to_html(val)
    RDiscount.new(val).to_html
  end
end
