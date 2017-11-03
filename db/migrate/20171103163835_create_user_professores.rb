class CreateUserProfessores < ActiveRecord::Migration
  def change
    create_table :user_professores do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :username

      t.timestamps null: false
    end
  end
end
