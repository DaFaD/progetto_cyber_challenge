class PasswordResetsController < ApplicationController
    before_action :get_user, only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update]
    before_action :logged_out_user, only: [:new, :create, :edit, :update]

  def new
  end
  
  def create
    if params[:userTypeField] == nil
        flash.now[:danger] = "User type required!"
        render 'new'
    else
        @user = nil
        if params[:userTypeField] == "UserAdmin"
            @user = UserAdmin.find_by(email: params[:password_reset][:email].downcase)
        elsif params[:userTypeField] == "UserProfessore"
            @user = UserProfessore.find_by(email: params[:password_reset][:email].downcase)
        elsif params[:userTypeField] == "UserStudente"
            @user = UserStudente.find_by(email: params[:password_reset][:email].downcase)
        end
        if @user
            @user.create_reset_digest
            @user.send_password_reset_email
            flash[:info] = "Email sent with password reset instructions"
            redirect_to root_url
        else
            flash.now[:danger] = "Email address not found"
            render 'new'
        end
    end
  end

  def edit
  end
  
  def update
    if password_blank?
        flash.now[:danger] = "Password can't be blank"
        render 'edit'
    elsif @user.update_attributes(user_params)
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
    else
        render 'edit'
    end
  end
  
    private
    
    def user_params
        if @user.class.to_s == "UserAdmin"
            params.require(:user_admin).permit(:password, :password_confirmation)
        elsif @user.class.to_s == "UserProfessore"
            params.require(:user_professore).permit(:password, :password_confirmation)
        elsif @user.class.to_s == "UserStudente"
            params.require(:user_studente).permit(:password, :password_confirmation)
        end
    end

    # Returns true if password is blank.
    def password_blank?
        if @user.class.to_s == "UserAdmin"
            params[:user_admin][:password].blank?
        elsif @user.class.to_s == "UserProfessore"
            params[:user_professore][:password].blank?
        elsif @user.class.to_s == "UserStudente"
            params[:user_studente][:password].blank?
        end
    end
  
    # Before filters
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
    
    def get_user
        @user = nil
        if params[:userType] == "UserAdmin"
            @user = UserAdmin.find_by(email: params[:email])
        elsif params[:userType] == "UserProfessore"
            @user = UserProfessore.find_by(email: params[:email])
        elsif params[:userType] == "UserStudente"
            @user = UserStudente.find_by(email: params[:email])
        end
    end
    
    # Confirms a valid user.
    def valid_user
        unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
            redirect_to root_url
        end
    end
    
    # Checks expiration of reset token.
    def check_expiration
        if @user.password_reset_expired?
            flash[:danger] = "Password reset has expired."
            redirect_to new_password_reset_url
        end
    end
end
