class PretestAndExamQuiz < ActiveRecord::Base
    validates :text1, presence: true
    validates :ans1_1, presence: true
    validates :ans1_2, presence: true
    validates :ans1_3, presence: true
    validates :ans1_4, presence: true
    validates :ans1_ok, presence: true
    validates :text2, presence: true
    validates :ans2_1, presence: true
    validates :ans2_2, presence: true
    validates :ans2_3, presence: true
    validates :ans2_4, presence: true
    validates :ans2_ok, presence: true
    validates :text3, presence: true
    validates :ans3_1, presence: true
    validates :ans3_2, presence: true
    validates :ans3_3, presence: true
    validates :ans3_4, presence: true
    validates :ans3_ok, presence: true
    validates :text4, presence: true
    validates :ans4_1, presence: true
    validates :ans4_2, presence: true
    validates :ans4_3, presence: true
    validates :ans4_4, presence: true
    validates :ans4_ok, presence: true
    validates :text5, presence: true
    validates :ans5_1, presence: true
    validates :ans5_2, presence: true
    validates :ans5_3, presence: true
    validates :ans5_4, presence: true
    validates :ans5_ok, presence: true
    validates :text6, presence: true
    validates :ans6_1, presence: true
    validates :ans6_2, presence: true
    validates :ans6_3, presence: true
    validates :ans6_4, presence: true
    validates :ans6_ok, presence: true
    validates :text7, presence: true
    validates :ans7_1, presence: true
    validates :ans7_2, presence: true
    validates :ans7_3, presence: true
    validates :ans7_4, presence: true
    validates :ans7_ok, presence: true
    validates :text8, presence: true
    validates :ans8_1, presence: true
    validates :ans8_2, presence: true
    validates :ans8_3, presence: true
    validates :ans8_4, presence: true
    validates :ans8_ok, presence: true
    validates :text9, presence: true
    validates :ans9_1, presence: true
    validates :ans9_2, presence: true
    validates :ans9_3, presence: true
    validates :ans9_4, presence: true
    validates :ans9_ok, presence: true
    validates :text10, presence: true
    validates :ans10_1, presence: true
    validates :ans10_2, presence: true
    validates :ans10_3, presence: true
    validates :ans10_4, presence: true
    validates :ans10_ok, presence: true

    def score(studentAnswer1, studentAnswer2, studentAnswer3, studentAnswer4, studentAnswer5, studentAnswer6, studentAnswer7, studentAnswer8, studentAnswer9, studentAnswer10)
        score= 0
        if studentAnswer1.to_s==self.ans1_ok.to_s
            score += 3
        elsif studentAnswer1.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer2.to_s==self.ans2_ok.to_s
            score += 3
        elsif studentAnswer2.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer3.to_s==self.ans3_ok.to_s
            score += 3
        elsif studentAnswer3.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer4.to_s==self.ans4_ok.to_s
            score += 3
        elsif studentAnswer4.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer5.to_s==self.ans5_ok.to_s
            score += 3
        elsif studentAnswer5.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer6.to_s==self.ans6_ok.to_s
            score += 3
        elsif studentAnswer6.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer7.to_s==self.ans7_ok.to_s
            score += 3
        elsif studentAnswer7.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer8.to_s==self.ans8_ok.to_s
            score += 3
        elsif studentAnswer8.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer9.to_s==self.ans9_ok.to_s
            score += 3
        elsif studentAnswer9.to_s==""
            score += 0
        else
            score -= 1
        end
        if studentAnswer10.to_s==self.ans10_ok.to_s
            score += 3
        elsif studentAnswer10.to_s==""
            score += 0
        else
            score -= 1
        end
        score
    end
end
