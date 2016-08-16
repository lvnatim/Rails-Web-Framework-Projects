class ActorsController < ApplicationController

  def index
    @actors = Actor.all
  end

  def new
    @actor = Actor.new
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def create
    @actor = Actor.new(actor_params)
    if @actor.save
      redirect_to actors_path, notice: "Actor saved successfully!"
    else
      render :new
    end
  end

  def edit
    @actor = Actor.find(params[:id])
  end

  def update
    @actor = Actor.find(params[:id])
    @actor.update_attributes(actor_params)
    if @actor.save
      redirect actor_path(@actor), notice: "Actor updated successfully!"
    else
      render :edit
    end
  end

  protected

  def actor_params
    params.require(:actor).permit(:name, :age, :gender, :biography)
  end 

end