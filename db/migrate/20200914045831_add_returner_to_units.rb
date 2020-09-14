class AddReturnerToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :returner, :string, default:"N/A"
  end
end
