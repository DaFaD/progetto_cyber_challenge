class CreateSurveyActivations < ActiveRecord::Migration
  def change
    create_table :survey_activations do |t|
      t.boolean :activated

      t.timestamps null: false
    end
  end
end
