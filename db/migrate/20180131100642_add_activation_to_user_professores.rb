class AddActivationToUserProfessores < ActiveRecord::Migration
  def change
    add_column :user_professores, :activation_digest, :string
    add_column :user_professores, :activated, :boolean, default: false
    add_column :user_professores, :activated_at, :datetime
  end
end
