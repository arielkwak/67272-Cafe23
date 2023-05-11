class JobsController < ApplicationController 
    before_action :set_job, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index 
    end 

    def new 
        @job = Job.new
        render action: 'new'
    end 

    def edit
        # @job = Job.find(params[:id])
    end 

    def create
        @job = Job.new(job_params)
        if @job.save
          redirect_to jobs_path
        else
          render :new
        end
    end 

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
          redirect_to jobs_path
        else
          render :edit
        end
    end

    def destroy
        if @job.destroy
          flash[:notice] = "Removed job from the system."
          redirect_to jobs_path
        else
          render action: 'index'
        end
    end
    
    
    private
    def job_params
        params.require(:job).permit(:name, :description, :active)
    end

    def set_job
        @job = Job.find(params[:id])
    end


end 