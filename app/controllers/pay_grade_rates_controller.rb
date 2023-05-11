class PayGradeRatesController < ApplicationController 
    before_action :set_pay_grade_rates, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def new 
        @pay_grade = PayGrade.find(params[:pay_grade_id])
        @pay_grade_rate = PayGradeRate.new(pay_grade_id: @pay_grade.id)
    end 

    def create
        @pay_grade_rate = PayGradeRate.new(pay_grade_rate_params)
        if @pay_grade_rate.save
            flash[:success] = "Pay grade rate created successfully"
            redirect_to pay_grade_path(@pay_grade_rate.pay_grade)
        else
            render :new
        end
    end

    private
    def pay_grade_rate_params
        params.require(:pay_grade_rate).permit(:pay_grade_id, :rate, :start_date, :end_date)
    end

    def set_pay_grade_rates
        @pay_grade_rate = PayGradeRate.find(params[:id])
    end
end 