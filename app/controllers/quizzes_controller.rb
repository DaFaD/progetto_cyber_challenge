class QuizzesController < ApplicationController
    before_action :logged_in_user, only: [:newCasual, :trainingTestDone, :trainingTestDonePage]
    before_action :studente_user, only: [:newCasual, :trainingTestDone, :trainingTestDonePage]

    def newCasual
        @questions= Array.new()
        size=Question.count
        loop do
            q= Question.find(1+rand(size))
            if !@questions.include?(q)
                @questions << q
            end
            break if @questions.length == 10
        end
        #params[:question0]=@questions[0].id
        #params[:question1]=@questions[1].id
        #params[:question2]=@questions[2].id
        #params[:question3]=@questions[3].id
        #params[:question4]=@questions[4].id
        #params[:question5]=@questions[5].id
        #params[:question6]=@questions[6].id
        #params[:question7]=@questions[7].id
        #params[:question8]=@questions[8].id
        #params[:question9]=@questions[9].id

    end

    def trainingTestDonePage
    end

    def trainingTestDone
        @punteggio=0
        @risposteUtente= Array.new()
        @domande = Array.new()
        10.times do |n|
            @punteggio += Question.find(params["question#{n}".to_sym]).score_answer(params["answer#{n}".to_sym])
            @risposteUtente << params["answer#{n}".to_sym]
            @domande << params["question#{n}".to_sym]
        end
        History.create(id_user: current_user.id, score: @punteggio)
        #tuple contenente eventualmente una riga della TrainingAverage con id_user=currentuser.id e anno corrente
        tuple=TrainingAverage.all.where(year: Time.current.year).where(id_user: current_user.id)
        if !tuple.empty?
            myNewAverage = (tuple[0].my_average*tuple[0].ntest+@punteggio) /  (tuple[0].ntest+1)
            newNtest=tuple[0].ntest+1
            tuple[0].update_attributes(my_average: myNewAverage, ntest: newNtest)
        else
            TrainingAverage.create(id_user: current_user.id, my_average: @punteggio, ntest: 1, year: Time.current.year)
        end


        render 'trainingTestDonePage'
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

        # Confirms a studente user.
        def studente_user
            unless this_is_studente?(current_user)
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
end
