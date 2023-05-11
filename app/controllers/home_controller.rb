class HomeController < ApplicationController 
  # before_action :check_login
  # authorize_resource
    def index

      @active_stores = Store.active.alphabetical.to_a
      if logged_in? && current_user.employee_role?
        @upcoming_shifts = Shift.for_employee(current_user).upcoming
      end 
    end
  
    def about
    end 
  
    def contact
    end
  
    def privacy
    end
    
    def search
      redirect_back(fallback_location: home_path) if params[:query].blank?
      @query = params[:query]
    end
  end