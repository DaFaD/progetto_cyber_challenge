class CreatePwNewProfessores < ActiveRecord::Migration
  def change
    create_table :pw_new_professores do |t|
      t.string :pw

      t.timestamps null: false
    end
  end
end
