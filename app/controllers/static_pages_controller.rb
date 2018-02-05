class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:competition, :trainingPage, :listaStudenteOProfOAdmin, :trainingQuestionsManage]
  before_action :logged_out_user, only: [:paginaIniziale, :studenteOProfessore]
  before_action :professor_user, only: [:trainingQuestionsManage]
  before_action :student_user, only: [:competition, :trainingPage]
  before_action :subscribe_activated, only: :competition

  def competition
  end

  def trainingPage
  end

  def trainingQuestionsManage
  end

  def paginaIniziale
    if session[:passatoQuaAdmin] != nil
        session.delete(:passatoQuaAdmin)
    end
    if session[:passatoQuaProfessore] != nil
        session.delete(:passatoQuaProfessore)
    end
    if session[:passatoQuaStudente] != nil
        session.delete(:passatoQuaStudente)
    end
  end

  def studenteOProfessore
    if session[:passatoQuaAdmin] != nil
        session.delete(:passatoQuaAdmin)
    end
    if session[:passatoQuaProfessore] != nil
        session.delete(:passatoQuaProfessore)
    end
    if session[:passatoQuaStudente] != nil
        session.delete(:passatoQuaStudente)
    end
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

    # Confirms an professor user.
    def professor_user
        unless this_is_professore?(current_user)
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end

    # Confirms an professor user.
    def student_user
        unless this_is_studente?(current_user)
            flash[:danger] = "You don't have the rights for this page."
            redirect_to(root_url)
        end
    end

    def subscribe_activated
        unless SubscribeAndExamActivation.first.subscribe
            flash[:danger] = "The competition of this year isn't ready yet!"
            redirect_to(root_url)
        end
    end
end
