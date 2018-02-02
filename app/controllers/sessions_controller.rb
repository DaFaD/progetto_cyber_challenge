class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:new, :create, :createAdmin, :createProfessore, :createStudente]

  def new
    if session[:passatoQuaAdmin] != nil
        session.delete(:passatoQuaAdmin)
    end
    if session[:passatoQuaProfessore] != nil
        session.delete(:passatoQuaProfessore)
    end
    if session[:passatoQuaStudente] != nil
        session.delete(:passatoQuaStudente)
    end
  end
  
  def create
    if params[:userTypeField] == nil
        flash.now[:danger] = 'User type required!'
        render 'new'
    else
        user = nil
        if params[:userTypeField] == "UserAdmin"
            user = UserAdmin.find_by(email: params[:session][:email].downcase)
        elsif params[:userTypeField] == "UserProfessore"
            user = UserProfessore.find_by(email: params[:session][:email].downcase)
        elsif params[:userTypeField] == "UserStudente"
            user = UserStudente.find_by(email: params[:session][:email].downcase)
        end
        if user && user.authenticate(params[:session][:password])
            if user.activated?
                log_in user
                params[:session][:remember_me] == '1' ? remember(user) : forget(user)
                redirect_back_or user
            else
                message = "Account not activated. "
                message += "Check your email for the activation link."
                flash[:warning] = message
                redirect_to root_url
            end
        else
            flash.now[:danger] = 'Invalid email/password/user type combination'
            render 'new'
        end
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  def createAdmin
    user = UserAdmin.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
        else
            message = "Account not activated. "
            message += "Check your email for the activation link."
            flash[:warning] = message
            redirect_to root_url
        end
    else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
    end
  end
  
  def createProfessore
    user = UserProfessore.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
        else
            message = "Account not activated. "
            message += "Check your email for the activation link."
            flash[:warning] = message
            redirect_to root_url
        end
    else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
    end
  end
  
  def createStudente
    user = UserStudente.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
        else
            message = "Account not activated. "
            message += "Check your email for the activation link."
            flash[:warning] = message
            redirect_to root_url
        end
    else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
    end
  end
  
  private
  
    # Before filters
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
end
