class ShiftSerializer
  include FastJsonapi::ObjectSerializer
  attribute :store do |shift|
    ShiftStoreSerializer.new(shift)
  end 

  attribute :employee do |shift|
    ShiftEmployeeSerializer.new(shift)
  end

  attribute :date

  attribute :start_time do |shift|
    shift.start_time.strftime("%H:%M")
  end

  attribute :end_time do |shift|
    shift.end_time.strftime("%H:%M")
  end

  attribute :duration do |shift|
    shift.duration
  end

  attribute :report_completed do |shift| 
    shift.report_completed?
  end
  
  attribute :jobs_worked do |shift|
    shift.jobs.map(&:name)
  end 
end
