class SurveyActivationsController < ApplicationController
    before_action :logged_in_user, only: [:activationPage, :activation, :manageSurveyOrActivationPage, :manageSurvey]
    before_action :admin_user, only: [:activationPage, :activation, :manageSurveyOrActivationPage, :manageSurvey]
    before_action :logged_out_user, only: :doSurvey

    def manageSurveyOrActivationPage
    end
    
    def manageSurvey
    end

    def activationPage
    end

    def activation
        if SurveyActivation.first.activated == true
            SurveyActivation.first.update_attributes(activated: false)
        elsif SurveyActivation.first.activated == false
            SurveyActivation.first.update_attributes(activated: true)
        end
        redirect_to activeSurveyPage_url
    end
    
    def doSurvey
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
    
    # Confirms an admin user.
    def admin_user
        unless this_is_admin?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
end
