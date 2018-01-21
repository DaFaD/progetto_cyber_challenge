class AddRememberDigestToUserStudentes < ActiveRecord::Migration
  def change
    add_column :user_studentes, :remember_digest, :string
  end
end
