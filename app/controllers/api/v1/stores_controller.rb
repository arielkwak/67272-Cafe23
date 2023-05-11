require 'action_controller/base'

class StoresController < ActionController::Base
    # GET /stores.json
    def index
      @stores = Store.active 
      render json: StoreSerializer.new(@stores)
    end 

    # GET /stores/1
    # GET /stores/1.json
    def show
      render json: StoreSerializer.new(@store)
    end
end 