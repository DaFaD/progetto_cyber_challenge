class AddResetToUserStudentes < ActiveRecord::Migration
  def change
    add_column :user_studentes, :reset_digest, :string
    add_column :user_studentes, :reset_sent_at, :datetime
  end
end
