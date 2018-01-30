class CreatePwNewAdmins < ActiveRecord::Migration
  def change
    create_table :pw_new_admins do |t|
      t.string :pw

      t.timestamps null: false
    end
  end
end
