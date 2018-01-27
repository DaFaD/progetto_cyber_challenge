class AddIndexToUserStudentesEmail < ActiveRecord::Migration
  def change
    add_index :user_studentes, :email, unique: true
  end
end
