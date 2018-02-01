class HomePageController < ApplicationController
  def homepage
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
end
