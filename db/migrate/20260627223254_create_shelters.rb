class CreateShelters < ActiveRecord::Migration[8.1]
  def change
    create_table :shelters do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :email

      t.timestamps
    end
  end
end
