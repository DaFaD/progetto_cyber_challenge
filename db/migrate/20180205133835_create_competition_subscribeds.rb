class CreateCompetitionSubscribeds < ActiveRecord::Migration
  def change
    create_table :competition_subscribeds do |t|
      t.integer :id_user
      t.integer :score
      t.integer :year

      t.timestamps null: false
    end
  end
end
