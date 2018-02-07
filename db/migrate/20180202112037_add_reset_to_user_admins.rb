class AddResetToUserAdmins < ActiveRecord::Migration
  def change
    add_column :user_admins, :reset_digest, :string
    add_column :user_admins, :reset_sent_at, :datetime
  end
end
