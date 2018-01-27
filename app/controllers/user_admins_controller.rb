class UserAdminsController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy, :destroyMySelf]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @user_admins = UserAdmin.paginate(page: params[:page]).order('username')
  end
  
  def show
    @userAdmin = UserAdmin.find(params[:id])
  end

  def new
    @userAdmin = UserAdmin.new
  end
  
  def create
    @userAdmin = UserAdmin.new(user_params)
    if @userAdmin.save
        log_in @userAdmin
        flash[:success] = "Welcome to the Cyber Challenge Platform!"
        redirect_to @userAdmin
    else
        render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @userAdmin.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @userAdmin
    else
      render 'edit'
    end
  end
  
  def destroy
    UserAdmin.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_admins_url
  end
  
  def destroyMySelf
    @userCorrenteAdmin= current_user
    log_out
    @userCorrenteAdmin.destroy
    flash[:success] = "You deleted your account"
    redirect_to root_url
  end
  
  private
  
    def user_params
        params.require(:user_admin).permit(:name, :surname, :email, :username, :password, :password_confirmation)
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
        @userAdmin = UserAdmin.find(params[:id])
        unless current_user?(@userAdmin)
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
