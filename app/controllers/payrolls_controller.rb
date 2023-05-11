class PayrollsController < ApplicationController 
    before_action :check_login

    def store_form
        authorize! :store_form, :payrolls_controller
        render "store_form"
    end

    def employee_form
        authorize! :employee_form, :payrolls_controller
        render "employee_form"
    end
     
    
    def employee_payroll
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        date_range = DateRange.new(start_date, end_date)
        @employee = Employee.find(params[:employee_id])
        @calculator = PayrollCalculator.new(date_range)

        # Create a payroll record for the specified employee
        @payroll = @calculator.create_payroll_record_for(@employee)

        # Assign the payroll object to an instance variable
        @employee_payroll = @payroll

        render 'employee_payroll'
    end 

    def store_payroll
        authorize! :store_payroll, :payrolls_controller
    
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        date_range = DateRange.new(start_date, end_date)
        @calculator = PayrollCalculator.new(date_range)
    
        if params[:store_id]
            @store = Store.find(params[:store_id])
            @payroll = @calculator.create_payrolls_for(@store)
            @store_payroll = @payroll
        else
            @store =  current_user.current_assignment.store
            @payrolls = @calculator.create_payrolls_for(@store)
            @store_payroll = @payrolls
        end

        render 'store_payroll'
    end
end 