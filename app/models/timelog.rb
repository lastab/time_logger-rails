class Timelog < ActiveRecord::Base

  def duration
    ((end_at - start_at)/ 1.minute).to_i
  end
end
