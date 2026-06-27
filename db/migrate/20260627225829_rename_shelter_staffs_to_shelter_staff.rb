class RenameShelterStaffsToShelterStaff < ActiveRecord::Migration[8.1]
  def change
    rename_table :shelter_staffs, :shelter_staff
  end
end
