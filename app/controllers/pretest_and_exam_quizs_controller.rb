class PretestAndExamQuizsController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :show, :pretest, :pretestDone, :pretestDonePage, :getAnotherOTP, :insertOTPPage, :verifyOTP, :exam, :examDonePage, :examDone, :giveUp]
    before_action :professor_user, only: [:edit, :update, :show]
    before_action :studente_user, only: [:pretest, :pretestDone, :pretestDonePage, :getAnotherOTP, :insertOTPPage, :verifyOTP, :exam, :examDonePage, :examDone, :giveUp]
    before_action :not_a_partecipant, only: [:pretest, :pretestDone, :pretestDonePage]
    before_action :yes_a_partecipant, only: [:getAnotherOTP, :insertOTPPage, :verifyOTP, :exam, :examDonePage, :examDone, :giveUp]
    before_action :otp_verified, only: [:exam, :examDone]
    
    def show
        @pretestOrExam = PretestAndExamQuiz.find(params[:id])
    end
    
    def edit
    end

    def update
        if PretestAndExamQuiz.find(params[:id]).update_attributes(question_params)
            if PretestAndExamQuiz.find(params[:id]).id == 1
                flash[:success] = "Pretest quiz updated"
            elsif PretestAndExamQuiz.find(params[:id]).id == 2
                flash[:success] = "Exam quiz updated"
            end
            redirect_to PretestAndExamQuiz.find(params[:id])
        else
            render 'edit'
        end
    end
    
    def getAnotherOTP
        if Otp.find_by(id_user: current_user.id) == nil || (Otp.find_by(id_user: current_user.id) != nil && Otp.find_by(id_user: current_user.id).updated_at.year != Time.current.year)
            flash[:danger] = "You haven't got any OTP for the competition of this year. If you never had it or you already used it you can't receive another OTP"
            redirect_to competition_url
        else
            otp= Otp.createOtp(current_user)
            UserMailer.send_otp(current_user, otp).deliver_now
            flash[:info] = "Please check your email to find your new OTP."
            redirect_to competition_url
        end
    end
    
    def pretest
    end
    
    def pretestDonePage
    end

    def pretestDone
        @punteggio= PretestAndExamQuiz.first.score(params[:answer1], params[:answer2], params[:answer3], params[:answer4], params[:answer5], params[:answer6], params[:answer7], params[:answer8], params[:answer9], params[:answer10])
        @risposteUtente= Array.new()
        10.times do |n|
            @risposteUtente << params["answer#{n+1}".to_sym]
        end
        tuple=CompetitionSubscribed.all.where(year: Time.current.year).where(id_user: current_user.id)
        if !tuple.empty?
            flash[:danger] = "You are already a competition partecipant for this year! Your score won't be changed!"
            redirect_to root_url
        else
            otp= Otp.createOtp(current_user)
            CompetitionSubscribed.create(id_user: current_user.id, score: @punteggio, year: Time.current.year)
            UserMailer.send_otp(current_user, otp).deliver_now
            flash.now[:info] = "Now you are a competition partecipant. Please check your email to find your OTP."
            render 'pretestDonePage'
        end
    end
    
    def insertOTPPage
    end
    
    def exam
    end
    
    def examDonePage
    end

    def examDone
        @punteggio= PretestAndExamQuiz.find(2).score(params[:answer1], params[:answer2], params[:answer3], params[:answer4], params[:answer5], params[:answer6], params[:answer7], params[:answer8], params[:answer9], params[:answer10])
        @risposteEsameUtente= Array.new()
        10.times do |n|
            @risposteEsameUtente << params["answer#{n+1}".to_sym]
        end
        tuple=ExamDonePartecipant.all.where(year: Time.current.year).where(id_user: current_user.id)
        if !tuple.empty?
            session.delete(:otp)
            flash[:danger] = "You already did the exam for this year! Your score won't be changed!"
            redirect_to root_url
        else
            ExamDonePartecipant.create(id_user: current_user.id, score: @punteggio, year: Time.current.year)
            session.delete(:otp)
            flash.now[:success] = "Your exam finished. Now you can do what you want!"
            render 'examDonePage'
        end
    end
    
    def verifyOTP
        if Otp.find_by(id_user: current_user.id) == nil
            flash.now[:danger] = "You haven't got an OTP! (Maybe you already used your one) You can't do the exam!"
            render 'insertOTPPage'
        elsif Otp.find_by(id_user: current_user.id).authenticated?(params[:pretest_and_exam_quiz][:otp])
            Otp.find_by(id_user: current_user.id).destroy
            session[:otp] = "1"
            flash[:success] = "OTP verified!"
            redirect_to exam_url
        else
            flash.now[:danger] = "Uncorrect OTP!"
            render 'insertOTPPage'
        end
    end
    
    def giveUp
        if CompetitionSubscribed.find_by(id_user: current_user.id, year: Time.current.year) != nil
            CompetitionSubscribed.find_by(id_user: current_user.id, year: Time.current.year).destroy
        end
        if ExamDonePartecipant.find_by(id_user: current_user.id, year: Time.current.year) != nil
            ExamDonePartecipant.find_by(id_user: current_user.id, year: Time.current.year).destroy
        end
        if Otp.find_by(id_user: current_user.id) != nil
            Otp.find_by(id_user: current_user.id).destroy
        end
        if Winner.find_by(id_user: current_user.id, year: Time.current.year) != nil
            Winner.find_by(id_user: current_user.id, year: Time.current.year).destroy
        end
        flash[:success] = "You correctly gived up!"
        redirect_to competition_url
    end
    
    private

        def question_params
            params.require(:pretest_and_exam_quiz).permit(:text1, :ans1_1, :ans1_2, :ans1_3, :ans1_4, :ans1_ok, :text2, :ans2_1, :ans2_2, :ans2_3, :ans2_4, :ans2_ok, :text3, :ans3_1, :ans3_2, :ans3_3, :ans3_4, :ans3_ok, :text4, :ans4_1, :ans4_2, :ans4_3, :ans4_4, :ans4_ok, :text5, :ans5_1, :ans5_2, :ans5_3, :ans5_4, :ans5_ok, :text6, :ans6_1, :ans6_2, :ans6_3, :ans6_4, :ans6_ok, :text7, :ans7_1, :ans7_2, :ans7_3, :ans7_4, :ans7_ok, :text8, :ans8_1, :ans8_2, :ans8_3, :ans8_4, :ans8_ok, :text9, :ans9_1, :ans9_2, :ans9_3, :ans9_4, :ans9_ok, :text10, :ans10_1, :ans10_2, :ans10_3, :ans10_4, :ans10_ok)
        end

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
        
        # Confirms a student user.
        def studente_user
            unless this_is_studente?(current_user)
                flash[:danger] = "You don't have the rights for this page/action."
                redirect_to(root_url)
            end
        end
        
        def not_a_partecipant
            unless CompetitionSubscribed.all.where(year: Time.current.year).where(id_user: current_user.id).empty?
                flash[:danger] = "You are already a competition partecipant for this year! Your score won't be changed!"
                redirect_to(root_url)
            end
        end
        
        def yes_a_partecipant
            unless !CompetitionSubscribed.all.where(year: Time.current.year).where(id_user: current_user.id).empty?
                flash[:danger] = "You aren't a competition partecipant for this year!"
                redirect_to(root_url)
            end
        end
        
        def otp_verified
            unless session[:otp] == "1"
                flash[:danger] = "You aren't covered by an OTP!"
                redirect_to(root_url)
            end
        end
end
