class ClassificationsController < ApplicationController
    before_action :logged_in_user, only: [:selectClassification, :trainingClassificationSelectYear, :trainingClassification, :partecipantsClassificationSelectYear, :partecipantsClassification]
    before_action :professor_user, only: [:selectClassification, :trainingClassificationSelectYear, :trainingClassification, :partecipantsClassificationSelectYear, :partecipantsClassification]

    def selectClassification
    end
    
    def trainingClassificationSelectYear
    end
    
    def trainingClassification
        @year= params[:year]
        @users= Array.new()
        TrainingAverage.all.where(year: params[:year]).order("my_average DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def partecipantsClassificationSelectYear
    end
    
    def partecipantsClassification
        @year= params[:year]
        @users= Array.new()
        CompetitionSubscribed.all.where(year: params[:year]).order("score DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
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
        
        # Confirms an professor user.
        def professor_user
            unless this_is_professore?(current_user)
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
end
