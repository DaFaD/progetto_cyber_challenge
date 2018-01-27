class AddPasswordDigestToUserStudentes < ActiveRecord::Migration
  def change
    add_column :user_studentes, :password_digest, :string
  end
end
