class UserAdminsController < ApplicationController

  def show
    @userAdmin = UserAdmin.find(params[:id])
  end

  def new
  end
end
