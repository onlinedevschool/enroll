class Student < ActiveRecord::Base
  belongs_to :enrollment
  has_many :private_sessions

  delegate :name, to: :enrollment
  delegate :enrolled_at, to: :enrollment
  delegate :enrolled_on, to: :enrollment

end
