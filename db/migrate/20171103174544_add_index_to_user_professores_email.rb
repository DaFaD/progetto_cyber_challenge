class AddIndexToUserProfessoresEmail < ActiveRecord::Migration
  def change
    add_index :user_professores, :email, unique: true
  end
end
