Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # provide the routes for the API here
      
      # http://localhost:3000/v1/employees
      get 'employees', to: 'employees#index', as: :employees

      # http://localhost:3000/v1/shifts/1.json
      get 'shifts/:id', to: 'shifts#show', as: :shift
      
      # http://localhost:3000/v1/stores/{id}/upcoming
      get 'stores/:id/upcoming', to: 'shifts#upcoming', as: :upcoming_shifts
    end
  end


  # Routes for regular HTML views go here... 
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  resources :employees
  resources :shifts
  resources :stores, except: :destroy
  # resources :users 
  resources :sessions
  resources :assignments
  resources :jobs, except: :show
  resources :pay_grades, except: :destroy
  resources :pay_grade_rates, only: [:new, :create, :edit, :update, :destroy]
  resources :payrolls, except: :index
  resources :shift_jobs, only: [:new, :create, :destroy], except: [:index, :show, :edit, :update]
  resources :shifts

  # get 'users/new', to: 'users#new', as: :signup
  # get 'users/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  get 'time_clock', to: 'shifts#time_clock', as: :time_clock
  patch 'time_in', to: 'shifts#time_in'
  patch 'time_out', to: 'shifts#time_out'
  get 'store_form', to: 'payrolls#store_form', as: 'store_form'
  get 'employee_form', to: 'payrolls#employee_form', as: 'employee_form'
  get 'employee_payroll', to: 'payrolls#employee_payroll', as: 'employee_payroll'
  get 'store_payroll', to: 'payrolls#store_payroll', as: 'store_payroll'
 

  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
