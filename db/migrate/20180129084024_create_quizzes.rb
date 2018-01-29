class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.array{40} :Questions

      t.timestamps null: false
    end
  end
end
