class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :id_user
      t.integer :id_quiz
      t.integer :score

      t.timestamps null: false
    end
  end
end
