class CreateTrainingAverages < ActiveRecord::Migration
  def change
    create_table :training_averages do |t|
      t.integer :id_user
      t.float :average
      t.integer :ntest

      t.timestamps null: false
    end
  end
end
