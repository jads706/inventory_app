class AddRequestorToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :requestor, :string, default:"N/A"
  end
end
