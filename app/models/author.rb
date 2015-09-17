class Author < ActiveRecord::Base
  devise :database_authenticatable, :rememberable,
         :trackable, :validatable

  include Gravtastic
  gravtastic :secure => true,
             :size => 120

  has_many :posts
end
