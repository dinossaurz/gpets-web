class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :type
      t.string :gender
      t.string :bearing
      t.boolean :castrated

      t.timestamps
    end
  end
end
