module Api::V1
  class ShiftsController < ApiController
    # GET /shifts.json
    def index
      @shifts = Shift.all
      render json: ShiftSerializer.new(@shifts)
    end

    # GET /shifts/1
    # GET /shifts/1.json
    def show
        @shift = Shift.find(params[:id])
        render json: ShiftSerializer.new(@shift)
    end

    # GET /stores/{id}/upcoming
    def upcoming
        @store = Store.find(params[:id])
        @upcoming_shifts = @store.shifts.upcoming.chronological
        render json: ShiftUpcomingSerializer.new(@upcoming_shifts).serialized_json
    end  
 
  end
end