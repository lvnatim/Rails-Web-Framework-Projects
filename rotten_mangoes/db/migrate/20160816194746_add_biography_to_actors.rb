class AddBiographyToActors < ActiveRecord::Migration[5.0]
  def change
    add_column :actors, :biography, :string
  end
end
