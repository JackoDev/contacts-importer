class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :birthdate
      t.integer :phone
      t.string :address
      t.integer :credit_card
      t.string :franchise
      t.string :email

      t.timestamps
    end
  end
end
