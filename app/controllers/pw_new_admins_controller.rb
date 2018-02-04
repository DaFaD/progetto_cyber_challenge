class PwNewAdminsController < ApplicationController
    before_action :logged_in_user, only: [:editAdministratorsPassword, :updateAdministratorsPassword]
    before_action :admin_user, only: [:editAdministratorsPassword, :updateAdministratorsPassword]

    def editAdministratorsPassword
    end
    
    def updateAdministratorsPassword
        if PwNewAdmin.right_pw?(params[:pw_new_admin][:oldpassword])
            if params[:pw_new_admin][:newpassword].to_s.length < 6
                flash.now[:danger] = "New password too short!"
                render 'editAdministratorsPassword'
            else
                if params[:pw_new_admin][:newpassword] == params[:pw_new_admin][:confirmnewpassword]
                    PwNewAdmin.first.update_attributes(pw: PwNewAdmin.digest(params[:pw_new_admin][:newpassword]))
                    flash[:success] = "Administrators' password changed!"
                    redirect_to root_url
                else
                    flash.now[:danger] = "Confirmation doesn't match the new password!"
                    render 'editAdministratorsPassword'
                end
            end
        else
            flash.now[:danger] = "Uncorrect old password!"
            render 'editAdministratorsPassword'
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
    
    # Confirms an admin user.
    def admin_user
        unless this_is_admin?(current_user)
            flash[:danger] = "You don't have the rights for this action."
            redirect_to(root_url)
        end
    end
end
