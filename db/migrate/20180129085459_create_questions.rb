class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.text :ans1
      t.text :ans2
      t.text :ans3
      t.text :ans4
      t.string :ans_ok

      t.timestamps null: false
    end
  end
end
