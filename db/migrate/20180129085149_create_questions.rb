class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :Text
      t.text :Ans1
      t.text :Ans2
      t.text :Ans3
      t.text :Ans4
      t.string :Ans_ok

      t.timestamps null: false
    end
  end
end
