module Api::V1
  class EmployeesController < ApiController
    # GET /employees.json
    def index
      @employees = Employee.active.alphabetical.to_a
      render json: EmployeeSerializer.new(@employees)
    end

    # GET /employees/1
    # GET /employees/1.json
    def show
      
      render json: EmployeeSerializer.new(@employee)
    end

    # before_action :login_admin
    # private
    # def login_admin
    #   @request.session[:user_id] = admin_user.id
    # end

  end
end 