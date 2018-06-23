class Timelog < ActiveRecord::Base
  default_scope { order(start_at: :desc) }

  def duration
    ((end_at - start_at) / 1.minute).to_i
  end
end
