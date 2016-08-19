class DropTableMoviesCategories < ActiveRecord::Migration[5.0]
  def change
    drop_table :movies_categories
  end
end
