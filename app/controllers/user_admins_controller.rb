class UserAdminsController < ApplicationController
  before_action :logged_out_user, only: [:new, :newAdmin, :create]
  before_action :logged_in_user, only: [:index, :edit, :editAdminNow, :update, :show, :destroy, :destroyMySelf]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :passato_di_qua_admin, only: :new
  
  def index
    @user_admins = UserAdmin.where(activated: true).paginate(page: params[:page]).order('username')
  end
  
  def show
    @userAdmin = UserAdmin.find(params[:id])
    redirect_to root_url and return unless @userAdmin.activated == true
  end
  
  def newAdmin
    session[:passatoQuaAdmin] = "1"
    if session[:administratorPasswordSbagliata] != nil
        session.delete(:administratorPasswordSbagliata)
    end
    if session[:giaPresoAdmin] != nil
        session.delete(:giaPresoAdmin)
    end
    redirect_to signupAdminNew_url
  end

  def new
    if session[:passatoQuaProfessore] != nil
        session.delete(:passatoQuaProfessore)
    end
    if session[:passatoQuaStudente] != nil
        session.delete(:passatoQuaStudente)
    end
    @userAdmin = UserAdmin.new
  end
  
  def create
    @userAdmin = UserAdmin.new(user_params)
    if PwNewAdmin.right_pw?(params[:user_admin][:administrator_password])
        if UserProfessore.find_by(username: @userAdmin.username.downcase) != nil || UserStudente.find_by(username: @userAdmin.username.downcase) != nil
            if session[:administratorPasswordSbagliata] != nil
                session.delete(:administratorPasswordSbagliata)
            end
            session[:giaPresoAdmin] = "1"
            render 'new'
        elsif @userAdmin.save
            if session[:administratorPasswordSbagliata] != nil
                session.delete(:administratorPasswordSbagliata)
            end
            if session[:giaPresoAdmin] != nil
                session.delete(:giaPresoAdmin)
            end
            if session[:passatoQuaAdmin] != nil
                session.delete(:passatoQuaAdmin)
            end
            UserMailer.account_activation(@userAdmin).deliver_now
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
        else
            if session[:administratorPasswordSbagliata] != nil
                session.delete(:administratorPasswordSbagliata)
            end
            if session[:giaPresoAdmin] != nil
                session.delete(:giaPresoAdmin)
            end
            render 'new'
        end
    else
        if session[:giaPresoAdmin] != nil
            session.delete(:giaPresoAdmin)
        end
        session[:administratorPasswordSbagliata] = "1"
        render 'new'
    end
  end
  
  def editAdminNow
    if session[:giaPresoAdmin] != nil
        session.delete(:giaPresoAdmin)
    end
    redirect_to edit_user_admin_url(current_user)
  end
  
  def edit
  end
  
  def update
    if UserProfessore.find_by(username: params[:user_admin][:username].downcase) != nil || UserStudente.find_by(username: params[:user_admin][:username].downcase) != nil
        session[:giaPresoAdmin] = "1"
        render 'edit'
    elsif @userAdmin.update_attributes(user_params_for_update)
        if session[:giaPresoAdmin] != nil
            session.delete(:giaPresoAdmin)
        end
        flash[:success] = "Profile updated"
        redirect_to @userAdmin
    else
        if session[:giaPresoAdmin] != nil
            session.delete(:giaPresoAdmin)
        end
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
    
    def user_params_for_update
        params.require(:user_admin).permit(:name, :surname, :username, :password, :password_confirmation)
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
    
    def passato_di_qua_admin
        unless session[:passatoQuaAdmin] == "1"
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end
end
