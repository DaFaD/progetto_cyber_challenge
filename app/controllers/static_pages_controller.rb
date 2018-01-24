class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:listaStudenteOProfOAdmin]
  before_action :logged_out_user, only: [:paginaIniziale, :studenteOProfessore]

  def homeMomentanea
  end
  
  def paginaIniziale
  end
  
  def studenteOProfessore
  end
  
  def listaStudenteOProfOAdmin
  end
  
  #def testNavFoo
  #end
  
  
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
    
    # Confirms a logged-out user.
    def logged_out_user
        unless !logged_in?
            flash[:danger] = "Please log out."
            redirect_to root_url
        end
    end
end
