class Enrollment < ActiveRecord::Base
  WEEK_OPTIONS     = [12, 18, 36]
  PRIVATE_SESSIONS = [3, 2, 1]

  belongs_to :course

  validates :email,       presence: true,
                          uniqueness: true,
                          format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :name,        presence: true

  validates :weeks,       presence: true,
                          inclusion: { in: WEEK_OPTIONS,
                                       message: "must be one of #{WEEK_OPTIONS.join(', ')}" }

  validates :course_id,   presence: true,
                          numericality: true

  validates :financed,    inclusion: { in: [true, false],
                                       message: "must be true or false" }
end
