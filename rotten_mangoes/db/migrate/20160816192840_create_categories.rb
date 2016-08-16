class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.references :movie, foreign_key: true
      t.string :genre

      t.timestamps
    end
  end
end
