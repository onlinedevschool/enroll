class PrivateSession < ActiveRecord::Base
  belongs_to :student
  belongs_to :instructor

  def ocurred_at_hour
    ts = started_at
    ts.strftime("%b #{ts.day.ordinalize} %l%P").strip
  end
end
