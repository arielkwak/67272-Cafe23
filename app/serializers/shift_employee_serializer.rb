class ShiftEmployeeSerializer
  include FastJsonapi::ObjectSerializer
  set_type :employee  

  attribute :name do |shift|
    shift.employee.name
  end

  attribute :role do |shift|
    shift.employee.role.capitalize
  end

  attribute :pay_grade do |shift|
    shift.employee.current_pay_grade
  end

  attribute :pay_rate do |shift|
    shift.employee.current_pay_rate
  end 

  attribute :over_18 do |shift|
    shift.employee.over_18?
  end

  set_id do |shift|
    shift.employee.id
  end
end
