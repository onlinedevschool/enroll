class Post < ActiveRecord::Base
  belongs_to :author

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
