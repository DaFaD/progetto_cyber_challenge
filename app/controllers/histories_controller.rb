class HistoriesController < ApplicationController
 before_action :logged_in_user, only: [:show, :create, :destroySelective]
 before_action :correct_user, only: :show

  def show
    @history = History.find(params[:id])
  end



  def create
     @history= History.new(id_user: params[:history_id_user],score: params[:history_score])
     @history.save
  end

  def destroySelective
    History.all.where(id_user: params[:history_id_user]).each |riga|
        riga.destroy
    end
  end

  private


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
        @userStudente = UserStudente.find(History.find(params[:id]).id_user)
        unless current_user?(@userStudente)
            flash[:danger] = "You don't have the rights for this page/action."
            redirect_to(root_url)
        end
    end

end

