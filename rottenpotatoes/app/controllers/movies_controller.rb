class MoviesController < ApplicationController
   attr_accessor :checked_rating

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @sort = params[:sort]
    if (params[:ratings] != nil)
     @checked_rating = params[:ratings].keys
    else 
     @checked_rating = @all_ratings
    end
    if (@sort == "title" || @sort == "release_date")
	@movies = Movie.where("rating IN (?)", @checked_rating).order(params[:sort])
    else 
	@movies = Movie.where("rating IN (?)", @checked_rating)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
