class AddPasswordDigestToUserAdmins < ActiveRecord::Migration
  def change
    add_column :user_admins, :password_digest, :string
  end
end
