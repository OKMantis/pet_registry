class AddCompositeIndexAnimals < ActiveRecord::Migration[8.1]
  def change
    add_index :animals, :shelter_id, where: "adopted = false", name: "index_animals_on_shelter_id_and_adopted"
  end
end
