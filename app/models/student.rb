class Student < ActiveRecord::Base
  belongs_to :enrollment
  delegate :name, to: :enrollment
end
