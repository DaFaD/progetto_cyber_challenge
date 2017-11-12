class UserAdminsController < ApplicationController

  def show
    @userAdmin = UserAdmin.find(params[:id])
  end

  def new
    @userAdmin = UserAdmin.new
  end
end
