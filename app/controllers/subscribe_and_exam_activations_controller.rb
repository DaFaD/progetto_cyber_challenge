class SubscribeAndExamActivationsController < ApplicationController
    before_action :logged_in_user, only: [:manageSubscribeOrExamActivation, :subscribeActivationPage, :subscribeActivation, :examActivationPage, :examActivation]
    before_action :professor_user, only: [:manageSubscribeOrExamActivation, :subscribeActivationPage, :subscribeActivation, :examActivationPage, :examActivation]

    def manageSubscribeOrExamActivation
    end
    
    def subscribeActivationPage
    end

    def subscribeActivation
        if SubscribeAndExamActivation.first.subscribe == true
            SubscribeAndExamActivation.first.update_attributes(subscribe: false)
        elsif SubscribeAndExamActivation.first.subscribe == false
            SubscribeAndExamActivation.first.update_attributes(subscribe: true)
        end
        redirect_to activeSubscribePage_url
    end
    
    def examActivationPage
    end

    def examActivation
        if SubscribeAndExamActivation.first.exam == true
            SubscribeAndExamActivation.first.update_attributes(exam: false)
        elsif SubscribeAndExamActivation.first.exam == false
            SubscribeAndExamActivation.first.update_attributes(exam: true)
        end
        redirect_to activeExamPage_url
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
    
    # Confirms a professor user.
    def professor_user
        unless this_is_professore?(current_user)
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end
end
