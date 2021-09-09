class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :category
      t.string :unit
      t.string :unit_tag
      t.string :user
      t.datetime :time

      t.timestamps
    end
  end
end
