class UserProfessoresController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @user_professores = UserProfessore.paginate(page: params[:page]).order('username')
  end

  def show
    @userProfessore = UserProfessore.find(params[:id])
  end

  def new
    @userProfessore = UserProfessore.new
  end
  
  def create
    @userProfessore = UserProfessore.new(user_params)
    if @userProfessore.save
        log_in @userProfessore
        flash[:success] = "Welcome to the Cyber Challenge Platform!"
        redirect_to @userProfessore
    else
        render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @userProfessore.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @userProfessore
    else
      render 'edit'
    end
  end
  
  def destroy
    UserProfessore.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_professores_url
  end
  
  private
  
    def user_params
        params.require(:user_professore).permit(:name, :surname, :email, :username, :password, :password_confirmation)
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
        @userProfessore = UserProfessore.find(params[:id])
        unless current_user?(@userProfessore)
            flash[:danger] = "You don't have the rights for this page/action."
            redirect_to(root_url)
        end
    end
    
    # Confirms an admin user.
    def admin_user
        unless this_is_admin?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end
end
