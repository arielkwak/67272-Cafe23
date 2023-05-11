class StoresController < ApplicationController 
    before_action :set_store, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        @active_stores = Store.active.alphabetical.to_a
        @inactive_stores = Store.inactive.alphabetical.to_a
    end

    def show
        @store = Store.find(params[:id])
        @current_employees = @store.employees.active.alphabetical.to_a
    end

    def new
        @store = Store.new
        render action: 'new'
    end

    def create
        @store = Store.new(store_params)
        if @store.save
          flash[:notice] = "Store was successfully created."
          redirect_to @store
        else
          render :new
        end
    end

    def edit
        # @store = Store.find(params[:id])
    end 

    def update
        if @store.update(store_params)
          flash[:notice] = "Updated store information for #{@store.name}."
          redirect_to store_path(@store)
        else
          render action: 'edit'
        end
    end

    # rescue_from ActionController::UrlGenerationError, with: :destroy_not_allowed
    # def destroy
    #     # flash[:notice] = "Store cannot be destroyed in the system"
    #     # redirect_to @store
    #     rescue_from ActionController::UrlGenerationError, with: :not_found
    # end

    private
    def store_params
        params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
    end

    def set_store
        @store = Store.find(params[:id])
    end

    # def destroy_not_allowed
    #     flash[:error] = "Store cannot be destroyed in the system"
    #     # redirect_to store_path(@store)
    # end

end 