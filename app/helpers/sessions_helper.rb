module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        session[:user_type_string] = user.class.to_s
    end
    
    # Returns the current logged-in user (if any).
    def current_user
        if @current_user != nil
            @current_user
        elsif session[:user_type_string] == "UserAdmin"
            @current_user = UserAdmin.find_by(id: session[:user_id])
        elsif session[:user_type_string] == "UserProfessore"
            @current_user = UserProfessore.find_by(id: session[:user_id])
        elsif session[:user_type_string] == "UserStudente"
            @current_user = UserStudente.find_by(id: session[:user_id])
        else
            nil
        end
    end
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    
    # Returns "nil" if current_user== nil , otherwise returns a string that shows the logged user's type
    def current_user_type_to_s
        stringa_res= ""
        if current_user == nil
            stringa_res= "nil"
        else
            stringa_res= current_user.class.to_s
        end
        stringa_res
    end
    
    def user_admin?
        current_user_type_to_s == "UserAdmin"
    end
    
    def user_professore?
        current_user_type_to_s == "UserProfessore"
    end
    
    def user_studente?
        current_user_type_to_s == "UserStudente"
    end
    
    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        session.delete(:user_type_string)
        @current_user = nil
    end
end
