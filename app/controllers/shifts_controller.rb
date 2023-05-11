class ShiftsController < ApplicationController 
    before_action :set_shifts, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
      @upcoming_shifts = Shift.upcoming.chronological.to_a
      @completed_shifts = Shift.past.chronological.to_a
    end 

    def show
        @employee = @shift.employee
        # @jobs = @shift_jobs.jobs
        @jobs = @shift.shift_jobs.alphabetical
    end 

    def new
        @shift = Shift.new 
    end 

    def create
        @shift = Shift.new(shift_params)
        if @shift.save
          flash[:notice] = "Successfully added shift."
          redirect_to @shift
        else
          flash[:notice] = "Failed."
          render :new
        end
    end 

    def edit
        # @shift = Shift.find(params[:id])
    end

    def update
        if @shift.update(shift_params)
          redirect_to @shift
        else
          render action: 'edit'
        end
    end

    def destroy
        @shift = Shift.find(params[:id])
        if @shift.date > Date.current
          @shift.destroy
          redirect_to shifts_path, notice: 'Shift was 
          successfully destroyed.'
        else
          render action: 'show'
        end
    end
    
    def time_clock
        shift_today = current_user.shifts.find_by(date: Date.current)
        if shift_today.present?
          timeclock_service = TimeClock.new(shift_today)
          @start_time = shift_today.start_time
          @end_time = shift_today.end_time
          @shift_today = shift_today
        else shift_today.present?
          flash[:notice] = "You do not have any shifts today"
          redirect_to home_path
        end
    end
  
    def time_in
        shift_today = current_user.shifts.find_by(date: Date.current)
        if shift_today.present?
          timeclock_service = TimeClock.new(shift_today)
          if timeclock_service.start_shift_at()
            flash[:notice] = "Your shift has started."
          end 
        else
          flash[:notice] = "You do not have any shifts today"
        end
        redirect_to home_path
    end

    def time_out
      shift_today = current_user.shifts.find_by(date: Date.current)
    
      if shift_today.present? 
        time_clock = TimeClock.new(shift_today)
        if time_clock.end_shift_at()
          flash[:notice] = "Your shift has ended."
        end
      else
        flash[:notice] = "You do not have any shifts today"
      end
    
      redirect_to home_path
    end

    private
    def shift_params
        params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end

    def set_shifts
        @shift = Shift.find(params[:id])
    end
end 