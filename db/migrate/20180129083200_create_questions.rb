class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :ans1
      t.string :ans2
      t.string :ans3
      t.string :ans4
      t.string :ansOk

      t.timestamps null: false
    end
  end
end
