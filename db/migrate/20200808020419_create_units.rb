class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name_id
      t.string :vsu_id
      t.references :product_type, null: false, foreign_key: true
      t.string :condition
      t.string :location

      t.timestamps
    end
  end
end
