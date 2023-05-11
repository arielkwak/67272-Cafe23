class AssignmentsController < ApplicationController 
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
      if current_user.role == "employee"
          assignments = current_user.assignments
          @current_assignments = assignments.current
          @past_assignments = assignments.past
      else
          @current_assignments = Assignment.all.current.chronological
          @past_assignments = Assignment.all.past.chronological 
          # @shifts = current_user.shifts
      end 
    end

    def show
        @assignment = Assignment.find(params[:id])
    end

    def new
        @assignment = Assignment.new
        render action: 'new'
    end

    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save 
          flash[:notice] = "Successfully added the assignment."
          redirect_to assignments_path
        else
          render :new
        end
    end

    def edit
        # @assignment = Assignment.find(params[:id])
    end 

    def update
        if @assignment.update(assignment_params)
          flash[:notice] = "Updated assignment information."
          redirect_to assignments_path
        else
          render action: 'edit'
        end
    end

    def destroy
        if @assignment.destroy
          flash[:notice] = "Removed assignment from the system."
          redirect_to assignments_path
        else
          render action: 'show'
        end
    end



    private
    def assignment_params
        params.require(:assignment).permit(:store_id, :employee_id, :start_date, :end_date, :pay_grade_id)
    end

    def set_assignment
        @assignment = Assignment.find(params[:id])
    end
end 