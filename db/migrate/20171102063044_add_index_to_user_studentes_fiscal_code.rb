class AddIndexToUserStudentesFiscalCode < ActiveRecord::Migration
  def change
    add_index :user_studentes, :fiscalCode, unique: true
  end
end
