class AddRememberDigestToUserProfessores < ActiveRecord::Migration
  def change
    add_column :user_professores, :remember_digest, :string
  end
end
