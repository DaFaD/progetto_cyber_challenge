class SessionsController < ApplicationController
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
        redirect_to user
    else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
    end
  end
  
  def destroy
  end
end