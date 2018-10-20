class AddUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :group_id
      t.string :name
      t.string :mail
      t.string :tel
    end
  end
end
