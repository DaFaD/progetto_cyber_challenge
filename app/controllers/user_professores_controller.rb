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
        # Handle a successful save.
    else
        render 'new'
    end
  end
  
  private
  
    def user_params
        params.require(:user_professore).permit(:name, :surname, :email, :username, :password, :password_confirmation)
    end
end
