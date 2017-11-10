class UserStudentesController < ApplicationController
  
  def show
    @userStudente = UserStudente.find(params[:id])
  end
  
  def new
  end
end
