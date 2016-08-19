class MoviesController < ApplicationController


  def add_genre
    category = Category.find(params[:data_category_id])
    movie = Movie.find(params[:data_movie_id])
    movie.categories << category
    movie.save 
  end

  def sort
    @movies = Movie.all.order(params[:by].to_sym).page params[:page]
    render :index
  end

  def index
    @movies = Movie.order(:id).page params[:page]
    # if params[:title] && !params[:title].empty?
    #   @movies = @movies.filter_title(params[:title])
    # end
    # if params[:director] && !params[:director].empty?
    #   @movies = @movies.filter_director(params[:director])
    # end
    if params[:title_or_director] && !params[:title_or_director].empty?
      @movies = @movies.filter_title_or_director(params[:title_or_director])
    end
    if params[:runtime_in_minutes] && !params[:runtime_in_minutes].empty?
      @movies = @movies.filter_runtime_in_minutes(params[:runtime_in_minutes])
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @categories = Category.all
  end

  def new
    @movie ||= Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was saved successfully!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    @categories = Category.all
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was saved successfully!"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date, :poster)
  end

  def category_params
    params.require(:categories).permit(:genre)
  end

  def search_params
    params.permit(:title, :director, :runtime_in_minutes)
  end

end