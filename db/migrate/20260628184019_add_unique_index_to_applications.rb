class AddUniqueIndexToApplications < ActiveRecord::Migration[8.1]
  def change
    execute(<<~SQL)
      DELETE FROM applications
      WHERE id NOT IN (
        SELECT MIN(id) FROM applications
        GROUP BY user_id, animal_id
      )
    SQL

    add_index :applications, [:user_id, :animal_id], unique: true, name: "index_applications_user_animal_unique"
  end
end
