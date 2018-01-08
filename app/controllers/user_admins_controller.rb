class UserAdminsController < ApplicationController

  def show
    @userAdmin = UserAdmin.find(params[:id])
  end

  def new
    @userAdmin = UserAdmin.new
  end
  
  def create
    @userAdmin = UserAdmin.new(user_params)
    if @userAdmin.save
        # Handle a successful save.
    else
        render 'new'
    end
  end
  
  private
  
    def user_params
        params.require(:user_admin).permit(:name, :surname, :email, :username, :password, :password_confirmation)
    end
end
