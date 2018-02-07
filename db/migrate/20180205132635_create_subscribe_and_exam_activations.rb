class CreateSubscribeAndExamActivations < ActiveRecord::Migration
  def change
    create_table :subscribe_and_exam_activations do |t|
      t.boolean :subscribe
      t.boolean :exam

      t.timestamps null: false
    end
  end
end
