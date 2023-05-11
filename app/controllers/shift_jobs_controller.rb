class ShiftJobsController < ApplicationController 
    before_action :set_shift_jobs, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def new
        @shift = Shift.find(params[:shift_id])
        # @shift_job = @shift.shift_jobs.new
        @shift_job = ShiftJob.new
        @shift_job.shift_id = @shift.id 
    end
      
    def create
        @shift = Shift.find(params[:shift_job][:shift_id])
        @shift_job = ShiftJob.new(shift_job_params)
      
        if @shift_job.save
          redirect_to shift_path(@shift_job.shift)
        else
          render :new
        end
    end
    
    def destroy
        @shift_job = ShiftJob.find(params[:id])
        @shift = @shift_job.shift
         
        if @shift_job.destroy
          redirect_to shift_path(@shift)
        else
          flash[:error] = "Failed to delete shift job."
          redirect_to shift_path(@shift)
        end
    end

    def edit
        # @shift_job = ShiftJob.find(params[:id])
    end

    private
    def shift_job_params
        params.require(:shift_job).permit(:shift_id, :job_id)
    end

    def set_shift_jobs
        @shift_job = ShiftJob.find(params[:id])
    end
end 