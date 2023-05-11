class AssignmentSerializer
  include FastJsonapi::ObjectSerializer
  attribute :store do |assignment|
    assignment.store.name
  end

  attribute :pay_grade do |assignment|
    assignment.pay_grade.level
  end

  attribute :as_of do |assignment|
    assignment.start_date.strftime('%B %d, %Y')
  end
end
