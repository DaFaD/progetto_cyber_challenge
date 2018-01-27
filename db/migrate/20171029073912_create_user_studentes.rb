class CreateUserStudentes < ActiveRecord::Migration
  def change
    create_table :user_studentes do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :username
      t.string :fiscalCode
      t.date :birthDay

      t.timestamps null: false
    end
  end
end
