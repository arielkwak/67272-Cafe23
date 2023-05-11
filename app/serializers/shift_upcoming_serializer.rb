class ShiftUpcomingSerializer
  include FastJsonapi::ObjectSerializer
  # set_type :shift_upcoming

  attribute :store do |object|
    object.store.name 
  end

  attribute :shifts do |object|
    StoreShiftsSerializer.new(object).as_json
  end
end
