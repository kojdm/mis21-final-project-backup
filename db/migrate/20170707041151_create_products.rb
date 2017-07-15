class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
