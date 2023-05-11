class ShiftStoreSerializer
  include FastJsonapi::ObjectSerializer
  set_type :store   

  attribute :name do |shift|
    shift.store.name
  end

  set_id do |shift|
    shift.store.id
  end
end
