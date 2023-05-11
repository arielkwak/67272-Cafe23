class StoreShiftsSerializer
  include FastJsonapi::ObjectSerializer
  
  set_type :shift

  attribute :employee do |shift|
    ShiftEmployeeSerializer.new(shift)
  end 

  attribute :date do |shift|
    shift.date
  end 

  attribute :start_time do |shift|
    shift.start_time.strftime("%H:%M")
  end

  attribute :end_time do |shift|
    shift.end_time.strftime("%H:%M")
  end
end
