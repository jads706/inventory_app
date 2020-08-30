class CreateProductTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_types do |t|
      t.string :model
      t.string :brand

      t.timestamps
    end
  end
end
