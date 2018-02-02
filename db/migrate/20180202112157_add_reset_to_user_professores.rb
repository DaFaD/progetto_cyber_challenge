class AddResetToUserProfessores < ActiveRecord::Migration
  def change
    add_column :user_professores, :reset_digest, :string
    add_column :user_professores, :reset_sent_at, :datetime
  end
end
