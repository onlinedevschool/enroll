class Series < ActiveRecord::Base
  has_many :posts

  def to_s
    name
  end

  def name=(val)
    write_attribute(:name, val)
    return if permalink.present?
    write_attribute(:permalink, name.parameterize)
  end

  def self.fuzzy(id)
    by_id = find_by(id: id)
    return by_id if by_id
    find_by(permalink: id)
  end
end
