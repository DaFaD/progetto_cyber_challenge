class AddIndexToUserAdminsUsername < ActiveRecord::Migration
  def change
    add_index :user_admins, :username, unique: true
  end
end
