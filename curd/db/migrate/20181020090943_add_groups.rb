class AddGroups < ActiveRecord::Migration[5.2]
  def change
    change_table :groups do |t|
      t.integer :company_id
      t.string :name
    end
  end
end
