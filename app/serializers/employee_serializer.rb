class EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  attribute :name do |object|
    "#{object.last_name}, #{object.first_name}"
  end

  attributes :phone do |employee|
    format_phone = employee.phone.insert(3, '-').insert(7, '-')
    format_phone 
  end

  attribute :age do |employee|
    # Calculate age based on date of birth
    now = Date.current.to_date
    dob = employee.date_of_birth
    now.year - dob.year - (dob.to_date.change(year: now.year) > now ? 1 : 0)
  end

  attributes :role do |employee|
    employee.role.capitalize
  end 

  attribute :current_assignment do |object|
    current_assignment = object.current_assignment
    if current_assignment.present?
      AssignmentSerializer.new(current_assignment)
    else
      { "data": nil }
    end
  end 

  attribute :recent_shifts do |employee|
    employee.shifts.joins(:assignment).where("shifts.date >= ? AND shifts.date <= ? AND shifts.status = ?", Date.current - 7.days, Date.current, 3)
                   .map { |shift| EmployeeRecentShiftSerializer.new(shift)}
  end

end
