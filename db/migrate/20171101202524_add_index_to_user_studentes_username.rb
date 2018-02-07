class AddIndexToUserStudentesUsername < ActiveRecord::Migration
  def change
    add_index :user_studentes, :username, unique: true
  end
end
