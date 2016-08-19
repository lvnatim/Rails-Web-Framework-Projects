class CreateMoviesCategoriesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_movies, id: false do |t|
      t.integer :category_id
      t.integer :movie_id
    end
    add_index :categories_movies, [:category_id, :movie_id], unique: true
  end
end
