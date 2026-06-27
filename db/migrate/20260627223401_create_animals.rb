class CreateAnimals < ActiveRecord::Migration[8.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.string :breed
      t.integer :age_years
      t.boolean :adopted
      t.references :shelter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
