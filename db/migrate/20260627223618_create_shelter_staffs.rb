class CreateShelterStaffs < ActiveRecord::Migration[8.1]
  def change
    create_table :shelter_staffs do |t|
      t.references :shelter, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
