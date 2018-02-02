class AddActivationToUserAdmins < ActiveRecord::Migration
  def change
    add_column :user_admins, :activation_digest, :string
    add_column :user_admins, :activated, :boolean, default: false
    add_column :user_admins, :activated_at, :datetime
  end
end
