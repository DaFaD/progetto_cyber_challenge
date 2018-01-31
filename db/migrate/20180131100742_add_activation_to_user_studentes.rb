class AddActivationToUserStudentes < ActiveRecord::Migration
  def change
    add_column :user_studentes, :activation_digest, :string
    add_column :user_studentes, :activated, :boolean, default: false
    add_column :user_studentes, :activated_at, :datetime
  end
end
