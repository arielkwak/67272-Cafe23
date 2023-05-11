class EmployeesController < ApplicationController 
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    # GET /employees.json
    def index
        if current_user.role == "admin"
            @active_employees = Employee.active.alphabetical.to_a
            @inactive_employees = Employee.inactive.alphabetical.to_a
            @current_assignments = current_user.current_assignment 
        elsif current_user.role == "manager"
            employees = current_user.current_assignment.store.employees.alphabetical.to_a
            @active_employees = employees.select(&:active?)
            @inactive_employees = employees.reject(&:active?)
        else
            redirect_to home_path, alert: "Access denied."
        end
    end

    # GET /employees/1
    # GET /employees/1.json
    def show
        @employee = Employee.find(params[:id])
        @current_assignment = @employee.current_assignment
        @other_assignments = @employee.assignments.current.where.not(id: @current_assignment&.id)
    end

    def new
        @employee = Employee.new
        render action: 'new'
    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
          flash[:notice] = "Successfully added #{employee_params[:first_name]} #{employee_params[:last_name]} as an employee."
          redirect_to @employee
        else
            render action: 'new'
        end 
    end

    def edit
        # @current_assignments = current_user.current_assignment.to_a
        @employee = Employee.find(params[:id])
        @current_assignment = @employee.current_assignment
        # @store = @current_assignment.store if @current_assignment
    end 
      
    def update
        @employee = Employee.find(params[:id])
        if @employee.update(employee_params)
          flash[:notice] = "Updated #{employee_params[:first_name]} #{employee_params[:last_name]}'s information."
          redirect_to @employee
        else
          render action: 'edit'
        end
    end
    
    def destroy
        if @employee.destroy
          flash[:notice] = "Successfully removed #{@employee.last_name}, #{@employee.first_name}."
          redirect_to employees_path
        else
          render action: 'show'
        end
    end

    private
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :username, :password, :password_confirmation, :active)
    end

    def set_employee
        @employee = Employee.find(params[:id])
    end

end