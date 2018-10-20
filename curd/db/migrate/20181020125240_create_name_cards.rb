class CreateNameCards < ActiveRecord::Migration[5.2]
  def change
    create_table :name_cards do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :fax
      t.string :tel
      t.string :url
    end
  end
end
