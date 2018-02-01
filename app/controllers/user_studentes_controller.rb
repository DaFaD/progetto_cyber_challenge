class UserStudentesController < ApplicationController
  before_action :logged_out_user, only: [:new, :newStudente, :create]
  before_action :logged_in_user, only: [:index, :edit, :editStudenteNow, :update, :show, :destroy, :destroyMySelf]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :passato_di_qua_studente, only: :new
  
  def index
    @user_studentes = UserStudente.paginate(page: params[:page]).order('username')
  end
  
  def show
    @userStudente = UserStudente.find(params[:id])
  end
  
  def newStudente
    session[:passatoQuaStudente] = "1"
    if session[:giaPresoStudente] != nil
        session.delete(:giaPresoStudente)
    end
    redirect_to signupStudenteNew_url
  end
  
  def new
    if session[:passatoQuaAdmin] != nil
        session.delete(:passatoQuaAdmin)
    end
    if session[:passatoQuaProfessore] != nil
        session.delete(:passatoQuaProfessore)
    end
    @userStudente = UserStudente.new
  end
  
  def create
    @userStudente = UserStudente.new(user_params)
    if UserAdmin.find_by(username: @userStudente.username.downcase) != nil || UserProfessore.find_by(username: @userStudente.username.downcase) != nil
        session[:giaPresoStudente] = "1"
        render 'new'
    elsif @userStudente.save
        if session[:giaPresoStudente] != nil
            session.delete(:giaPresoStudente)
        end
        if session[:passatoQuaStudente] != nil
            session.delete(:passatoQuaStudente)
        end
        UserMailer.account_activation(@userStudente).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
    else
        if session[:giaPresoStudente] != nil
            session.delete(:giaPresoStudente)
        end
        render 'new'
    end
  end
  
  def editStudenteNow
    if session[:giaPresoStudente] != nil
        session.delete(:giaPresoStudente)
    end
    redirect_to edit_user_studente_url(current_user)
  end
  
  def edit
  end
  
  def update
    if UserAdmin.find_by(username: params[:user_studente][:username].downcase) != nil || UserProfessore.find_by(username: params[:user_studente][:username].downcase) != nil
        session[:giaPresoStudente] = "1"
        render 'edit'
    elsif @userStudente.update_attributes(user_params_for_update)
        if session[:giaPresoStudente] != nil
            session.delete(:giaPresoStudente)
        end
        flash[:success] = "Profile updated"
        redirect_to @userStudente
    else
        if session[:giaPresoStudente] != nil
            session.delete(:giaPresoStudente)
        end
        render 'edit'
    end
  end
  
  def destroy
    UserStudente.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_studentes_url
  end
  
  def destroyMySelf
    @userCorrenteStudente= current_user
    log_out
    @userCorrenteStudente.destroy
    flash[:success] = "You deleted your account"
    redirect_to root_url
  end
  
  private
  
    def user_params
        params.require(:user_studente).permit(:name, :surname, :email, :username, :fiscalCode, :birthDay, :password, :password_confirmation)
    end
    
    def user_params_for_update
        params.require(:user_studente).permit(:name, :surname, :username, :fiscalCode, :birthDay, :password, :password_confirmation)
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
    
    # Confirms an admin user.
    def admin_user
        unless this_is_admin?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end
    
    def passato_di_qua_studente
        unless session[:passatoQuaStudente] == "1"
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end
end
