class AddRememberDigestToUserAdmins < ActiveRecord::Migration
  def change
    add_column :user_admins, :remember_digest, :string
  end
end
