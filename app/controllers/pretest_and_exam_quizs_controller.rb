class PretestAndExamQuizsController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :professor_user, only: [:edit, :update, :show]
    
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
end
