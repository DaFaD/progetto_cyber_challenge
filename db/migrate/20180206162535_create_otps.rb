class CreateOtps < ActiveRecord::Migration
  def change
    create_table :otps do |t|
      t.integer :id_user
      t.string :otp_digest

      t.timestamps null: false
    end
  end
end
