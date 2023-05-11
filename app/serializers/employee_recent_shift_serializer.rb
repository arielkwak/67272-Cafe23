class EmployeeRecentShiftSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :status
  
  attribute :start_time do |shift|
    shift.start_time.strftime("%H:%M")
  end

  attribute :end_time do |shift|
    shift.end_time.strftime("%H:%M")
  end

  set_type :shift
end
