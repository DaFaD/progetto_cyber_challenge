class AddIndexToUserAdminsEmail < ActiveRecord::Migration
  def change
    add_index :user_admins, :email, unique: true
  end
end
