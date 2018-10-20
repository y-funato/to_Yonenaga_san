class AddCompanies < ActiveRecord::Migration[5.2]
  def change
    change_table :companies do |t|
      t.string :address
      t.string :fax
      t.string :tel
      t.string :url
    end
  end
end
