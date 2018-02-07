class CreatePretestAndExamQuizzes < ActiveRecord::Migration
  def change
    create_table :pretest_and_exam_quizzes do |t|
      t.string :text1
      t.string :ans1_1
      t.string :ans1_2
      t.string :ans1_3
      t.string :ans1_4
      t.integer :ans1_ok
      t.string :text2
      t.string :ans2_1
      t.string :ans2_2
      t.string :ans2_3
      t.string :ans2_4
      t.integer :ans2_ok
      t.string :text3
      t.string :ans3_1
      t.string :ans3_2
      t.string :ans3_3
      t.string :ans3_4
      t.integer :ans3_ok
      t.string :text4
      t.string :ans4_1
      t.string :ans4_2
      t.string :ans4_3
      t.string :ans4_4
      t.integer :ans4_ok
      t.string :text5
      t.string :ans5_1
      t.string :ans5_2
      t.string :ans5_3
      t.string :ans5_4
      t.integer :ans5_ok
      t.string :text6
      t.string :ans6_1
      t.string :ans6_2
      t.string :ans6_3
      t.string :ans6_4
      t.integer :ans6_ok
      t.string :text7
      t.string :ans7_1
      t.string :ans7_2
      t.string :ans7_3
      t.string :ans7_4
      t.integer :ans7_ok
      t.string :text8
      t.string :ans8_1
      t.string :ans8_2
      t.string :ans8_3
      t.string :ans8_4
      t.integer :ans8_ok
      t.string :text9
      t.string :ans9_1
      t.string :ans9_2
      t.string :ans9_3
      t.string :ans9_4
      t.integer :ans9_ok
      t.string :text10
      t.string :ans10_1
      t.string :ans10_2
      t.string :ans10_3
      t.string :ans10_4
      t.integer :ans10_ok

      t.timestamps null: false
    end
  end
end
