class AddIndexToUserProfessoresUsername < ActiveRecord::Migration
  def change
    add_index :user_professores, :username, unique: true
  end
end
