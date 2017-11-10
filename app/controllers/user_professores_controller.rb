class UserProfessoresController < ApplicationController

  def show
    @userProfessore = UserProfessore.find(params[:id])
  end

  def new
  end
end
