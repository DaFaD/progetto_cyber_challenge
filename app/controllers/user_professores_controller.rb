class UserProfessoresController < ApplicationController
  before_action :logged_out_user, only: [:new, :newProfessore, :create]
  before_action :logged_in_user, only: [:index, :edit, :editProfessoreNow, :update, :show, :destroy, :destroyMySelf]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @user_professores = UserProfessore.paginate(page: params[:page]).order('username')
  end

  def show
    @userProfessore = UserProfessore.find(params[:id])
  end
  
  def newProfessore
    if session[:professorPasswordSbagliata] != nil
        session.delete(:professorPasswordSbagliata)
    end
    if session[:giaPresoProfessore] != nil
        session.delete(:giaPresoProfessore)
    end
    redirect_to signupProfessoreNew_url
  end

  def new
    @userProfessore = UserProfessore.new
  end
  
  def create
    @userProfessore = UserProfessore.new(user_params)
    if PwNewProfessore.right_pw?(params[:user_professore][:professor_password])
        if UserAdmin.find_by(username: @userProfessore.username.downcase) != nil || UserStudente.find_by(username: @userProfessore.username.downcase) != nil
            if session[:professorPasswordSbagliata] != nil
                session.delete(:professorPasswordSbagliata)
            end
            session[:giaPresoProfessore] = "1"
            render 'new'
        elsif @userProfessore.save
            if session[:professorPasswordSbagliata] != nil
                session.delete(:professorPasswordSbagliata)
            end
            if session[:giaPresoProfessore] != nil
                session.delete(:giaPresoProfessore)
            end
            UserMailer.account_activation(@userProfessore).deliver_now
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
        else
            if session[:professorPasswordSbagliata] != nil
                session.delete(:professorPasswordSbagliata)
            end
            if session[:giaPresoProfessore] != nil
                session.delete(:giaPresoProfessore)
            end
            render 'new'
        end
    else
        if session[:giaPresoProfessore] != nil
            session.delete(:giaPresoProfessore)
        end
        session[:professorPasswordSbagliata] = "1"
        render 'new'
    end
  end
  
  def editProfessoreNow
    if session[:giaPresoProfessore] != nil
        session.delete(:giaPresoProfessore)
    end
    redirect_to edit_user_professore_url(current_user)
  end
  
  def edit
  end
  
  def update
    if UserAdmin.find_by(username: params[:user_professore][:username].downcase) != nil || UserStudente.find_by(username: params[:user_professore][:username].downcase) != nil
        session[:giaPresoProfessore] = "1"
        render 'edit'
    elsif @userProfessore.update_attributes(user_params)
        if session[:giaPresoProfessore] != nil
            session.delete(:giaPresoProfessore)
        end
        flash[:success] = "Profile updated"
        redirect_to @userProfessore
    else
        if session[:giaPresoProfessore] != nil
            session.delete(:giaPresoProfessore)
        end
        render 'edit'
    end
  end
  
  def destroy
    UserProfessore.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_professores_url
  end
  
  def destroyMySelf
    @userCorrenteProfessore= current_user
    log_out
    @userCorrenteProfessore.destroy
    flash[:success] = "You deleted your account"
    redirect_to root_url
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
