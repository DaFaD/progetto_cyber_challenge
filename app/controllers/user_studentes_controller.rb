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
        log_in @userStudente
        flash[:success] = "Welcome to the Cyber Challenge Platform!"
        redirect_to @userStudente
    else
        render 'new'
    end
  end
  
  def edit
    @userStudente = UserStudente.find(params[:id])
  end
  
  def update
    @userStudente = UserStudente.find(params[:id])
    if @userStudente.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @userStudente
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
        params.require(:user_studente).permit(:name, :surname, :email, :username, :fiscalCode, :birthDay, :password, :password_confirmation)
    end
end
