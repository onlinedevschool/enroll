class PrivateSession < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor

  def ocurred_at_hour
    ts = started_at
    ts.strftime("%b #{ts.day.ordinalize} %l:%M%P").strip
  end

  def student_name
    student && student.name
  end

  def instructor_name
    instructor && instructor.name
  end
end
