class UserStudentesController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @userStudentes = UserStudente.all
  end
  
  def show
    @userStudente = UserStudente.find(params[:id])
  end
  
  def new
    @userStudente = UserStudente.new
  end
  
  def create
    @userStudente = UserStudente.new(user_params)
    if @userStudente.save
        log_in @userStudente
        flash[:success] = "Welcome to the Cyber Challenge Platform!"
        redirect_to @userStudente
    else
        render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @userStudente.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @userStudente
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
        params.require(:user_studente).permit(:name, :surname, :email, :username, :fiscalCode, :birthDay, :password, :password_confirmation)
    end
    
    # Before filters
    
    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
    
    # Confirms the correct user.
    def correct_user
        @userStudente = UserStudente.find(params[:id])
        unless current_user?(@userStudente)
            flash[:danger] = "You don't have the rights for this page/action."
            redirect_to(root_url)
        end
    end
end
