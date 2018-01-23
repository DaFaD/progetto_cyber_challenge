class StaticPagesController < ApplicationController
  before_action :logged_out_user, only: [:paginaIniziale, :studenteOProfessore]

  def homeMomentanea
  end
  
  def paginaIniziale
  end
  
  def studenteOProfessore
  end
  
  #def testNavFoo
  #end
  
  
  private
  
    # Before filters
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
end
