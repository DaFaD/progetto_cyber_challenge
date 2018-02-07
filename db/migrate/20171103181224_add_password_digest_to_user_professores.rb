class AddPasswordDigestToUserProfessores < ActiveRecord::Migration
  def change
    add_column :user_professores, :password_digest, :string
  end
end
