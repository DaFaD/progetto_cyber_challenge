class CreateAdvices < ActiveRecord::Migration
  def change
    create_table :advices do |t|
      t.string :title
      t.string :content
      t.string :author
      t.datetime :writtenAt

      t.timestamps null: false
    end
  end
end
