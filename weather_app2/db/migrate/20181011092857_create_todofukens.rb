class CreateTodofukens < ActiveRecord::Migration[5.2]
  def change
    create_table :todofukens do |t|
      t.integer :todofuken_id
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
