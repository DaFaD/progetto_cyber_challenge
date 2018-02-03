class HistoriesController < ApplicationController
 before_action :logged_in_user, only: [:show, :create, :destroy]
 before_action :correct_user, only: :show
 before_action :admin_user, only: :destroy
  def show
    @history = History.find(params[:id])
  end

  def new
    @history = History.new
  end

  def create
     @history= History.new(history_params)
    if @quiz.save

    else
        render 'new'
    end

  end

  def destroy
    history.find(params[:id]).destroy
    flash[:success] = "History deleted"
    redirect_to histories_url
  end

  private

 def history_params
        params.require(:history).permit(:id_user, :id_quiz, :score)
    end
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end


    # Confirms the correct user.
    def correct_user
        @userstudente = UserStudente.find(params[:id])
        unless current_user?(@userStudente)
            flash[:danger] = "You don't have the rights for this page/action."
            redirect_to(root_url)
        end
    end
    # Confirms an admin user.
    def admin_user
        unless this_is_admin?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end
end

