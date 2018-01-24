class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]

  def new
  end
  
  def create
    user = UserAdmin.find_by(email: params[:session][:email].downcase)
    if user == nil
        user = UserProfessore.find_by(email: params[:session][:email].downcase)
    end
    if user == nil
        user = UserStudente.find_by(email: params[:session][:email].downcase)
    end
    if user && user.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page.
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
    else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
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
