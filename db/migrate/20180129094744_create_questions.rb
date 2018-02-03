class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :ans1
      t.string :ans2
      t.string :ans3
      t.string :ans4
      t.integer :ans_ok

      t.timestamps null: false
    end
  end
end
