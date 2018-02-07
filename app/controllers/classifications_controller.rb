class ClassificationsController < ApplicationController
    before_action :logged_in_user, only: [:selectClassification, :trainingClassificationSelectYear, :trainingClassification, :partecipantsClassificationSelectYear, :partecipantsClassification, :postExamClassificationSelectYear, :postExamClassification, :addToWinners, :winnersClassificationSelectYear, :winnersClassification, :editWinners, :removeWinner]
    before_action :professor_user, only: [:selectClassification, :trainingClassificationSelectYear, :trainingClassification, :partecipantsClassificationSelectYear, :partecipantsClassification, :postExamClassificationSelectYear, :postExamClassification, :addToWinners, :winnersClassificationSelectYear, :winnersClassification, :editWinners, :removeWinner]

    def selectClassification
    end
    
    def trainingClassificationSelectYear
    end
    
    def trainingClassification
        @year= params[:year]
        @users= Array.new()
        TrainingAverage.all.where(year: params[:year]).order("my_average DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def partecipantsClassificationSelectYear
    end
    
    def partecipantsClassification
        @year= params[:year]
        @users= Array.new()
        CompetitionSubscribed.all.where(year: params[:year]).order("score DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def postExamClassificationSelectYear
    end
    
    def postExamClassification
        @year= params[:year]
        @users= Array.new()
        ExamDonePartecipant.all.where(year: params[:year]).order("score DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def addToWinners
        tupla= ExamDonePartecipant.find(params[:id_tupla])
        studente= UserStudente.find(tupla.id_user)
        if Winner.all.where(id_user: tupla.id_user, year: tupla.year).empty?
            Winner.create(id_user: tupla.id_user, score: tupla.score, year: tupla.year)
            @year= params[:year]
            @users= Array.new()
            params[:id_users].split.each do |u|
                @users << UserStudente.find(u.to_i)
            end
            flash.now[:success]= "Now #{studente.username} is a winner!"
            render 'postExamClassification'
        else
            @year= params[:year]
            @users= Array.new()
            params[:id_users].split.each do |u|
                @users << UserStudente.find(u.to_i)
            end
            flash.now[:danger]= "#{studente.username} is already a winner!"
            render 'postExamClassification'
        end
    end
    
    def winnersClassificationSelectYear
    end
    
    def winnersClassification
        @year= params[:year]
        @users= Array.new()
        Winner.all.where(year: params[:year]).order("score DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def editWinners
        @year= params[:year]
        @users= Array.new()
        Winner.all.where(year: params[:year]).order("score DESC").select("id_user").each do |user|
            @users << UserStudente.find(user.id_user)
        end
    end
    
    def removeWinner
        tupla= Winner.find(params[:id_tupla])
        studente= UserStudente.find(tupla.id_user)
        if Winner.all.where(id_user: tupla.id_user, year: tupla.year).empty?
            @year= params[:year]
            @users= Array.new()
            params[:id_users].split.each do |u|
                @users << UserStudente.find(u.to_i)
            end
            flash.now[:danger]= "#{studente.username} isn't a winner, it's impossible remove this student from winners because this student isn't among the winners!"
            render 'editWinners'
        else
            tupla.destroy
            @year= params[:year]
            @users= Array.new()
            params[:id_users].split.each do |u|
                @users << UserStudente.find(u.to_i)
            end
            flash.now[:success]= "#{studente.username} isn't a winner anymore!"
            render 'editWinners'
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
        
        # Confirms an professor user.
        def professor_user
            unless this_is_professore?(current_user)
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
end
