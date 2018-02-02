module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
        session[:user_type_string] = user.class.to_s
    end
    
    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent.signed[:user_type_string] = user.class.to_s
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    # Returns true if the given user is the current user.
    def current_user?(user)
        user == current_user
    end
    
    # Returns the user corresponding to the remember token cookie.
    def current_user
        if (user_id = session[:user_id])
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
        elsif (user_id = cookies.signed[:user_id])
            if cookies.signed[:user_type_string] == "UserAdmin"
                user = UserAdmin.find_by(id: user_id)
            elsif cookies.signed[:user_type_string] == "UserProfessore"
                user = UserProfessore.find_by(id: user_id)
            elsif cookies.signed[:user_type_string] == "UserStudente"
                user = UserStudente.find_by(id: user_id)
            end
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
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
    
    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:user_type_string)
        cookies.delete(:remember_token)
    end
    
    # Logs out the current user.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        session.delete(:user_type_string)
        @current_user = nil
    end
    
    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
    
    # Stores the URL trying to be accessed.
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end
