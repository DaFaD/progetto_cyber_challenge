class PwNewProfessoresController < ApplicationController
    before_action :logged_in_user, only: [:editProfessorsPassword, :updateProfessorsPassword]
    before_action :admin_user, only: [:editProfessorsPassword, :updateProfessorsPassword]

    def editProfessorsPassword
    end
    
    def updateProfessorsPassword
        if PwNewProfessore.right_pw?(params[:pw_new_professore][:oldpassword])
            if params[:pw_new_professore][:newpassword].to_s.length < 6
                flash.now[:danger] = "New password too short!"
                render 'editProfessorsPassword'
            else
                if params[:pw_new_professore][:newpassword] == params[:pw_new_professore][:confirmnewpassword]
                    PwNewProfessore.first.update_attributes(pw: PwNewProfessore.digest(params[:pw_new_professore][:newpassword]))
                    flash[:success] = "Professors' password changed!"
                    redirect_to root_url
                else
                    flash.now[:danger] = "Confirmation doesn't match the new password!"
                    render 'editProfessorsPassword'
                end
            end
        else
            flash.now[:danger] = "Uncorrect old password!"
            render 'editProfessorsPassword'
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
