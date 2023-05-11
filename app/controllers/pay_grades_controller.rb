class PayGradesController < ApplicationController 
    before_action :set_pay_grades, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index 
    end 

    def show
        @pay_grade = PayGrade.find(params[:id])
        @pay_grade_rate_history = @pay_grade.pay_grade_rates.chronological
    end

    def new 
      @pay_grade = PayGrade.new
    end 

    def edit
        # @pay_grade = PayGrade.find(params[:id])
    end 

    def create
        @pay_grade = PayGrade.new(pay_grade_params)
        if @pay_grade.save
          flash[:notice] = "Successfully added the pay grade."
          redirect_to pay_grades_path
        else
          render :new
        end
    end

    def update
        if @pay_grade.update(pay_grade_params)
          flash[:notice] = "Updated pay grade information."
          redirect_to pay_grades_path
        else
          render action: 'edit'
        end
    end

    private
    def pay_grade_params
        params.require(:pay_grade).permit(:level, :active)
    end

    def set_pay_grades
        @pay_grade = PayGrade.find(params[:id])
    end
end 