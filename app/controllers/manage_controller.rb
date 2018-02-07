class ManageController < ApplicationController
  before_action :logged_in_user, only: :manage
  before_action :admin_or_professor_user, only: :manage

  def manage
  end
  
  private
  
    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
    
    # Confirms an admin user.
    def admin_or_professor_user
        unless this_is_admin?(current_user) || this_is_professore?(current_user)
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end
end
