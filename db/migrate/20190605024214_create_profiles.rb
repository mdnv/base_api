class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.attachment :avatar
      t.string :phone
      t.boolean :gender, default: false
      t.date :birthday
      t.integer :user_id

      t.timestamps
    end
  end
end
