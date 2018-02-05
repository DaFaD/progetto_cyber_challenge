class CreateTrainingAverages < ActiveRecord::Migration
  def change
    create_table :training_averages do |t|
      t.integer :id_user
      t.float :my_average
      t.integer :ntest
      t.integer :year

      t.timestamps null: false
    end
  end
end
