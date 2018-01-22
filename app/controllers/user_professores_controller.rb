class UserProfessoresController < ApplicationController

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
    @userProfessore = UserProfessore.find(params[:id])
  end
  
  def update
    @userProfessore = UserProfessore.find(params[:id])
    if @userProfessore.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
        params.require(:user_professore).permit(:name, :surname, :email, :username, :password, :password_confirmation)
    end
end
