class Question < ActiveRecord::Base
    validates :text, presence: true
    validates :ans1, presence: true
    validates :ans2, presence: true
    validates :ans3, presence: true
    validates :ans4, presence: true
    validates :ans_ok, presence: true

    def score_answer(studentAnswer)
        if studentAnswer.to_s==self.ans_ok.to_s
            2
        elsif studentAnswer.to_s==""
            0
        else
            -1
        end
    end
end
