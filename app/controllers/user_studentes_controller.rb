class UserStudentesController < ApplicationController
  
  def show
    @userStudente = UserStudente.find(params[:id])
  end
  
  def new
    @userStudente = UserStudente.new
  end
  
  def create
    @userStudente = UserStudente.new(user_params)
    if @userStudente.save
        # Handle a successful save.
    else
        render 'new'
    end
  end
  
  private
  
    def user_params
        params.require(:user_studente).permit(:name, :surname, :email, :username, :fiscalCode, :birthDay, :password, :password_confirmation)
    end
end
