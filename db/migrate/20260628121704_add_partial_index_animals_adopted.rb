class AddPartialIndexAnimalsAdopted < ActiveRecord::Migration[8.1]
  def change
    add_index :animals, :adopted, where: "adopted = false", name: "index_animals_available"
  end
end
