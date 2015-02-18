class MoviesController < ApplicationController
   attr_accessor :checked_rating

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #reset_session
    @all_ratings = Movie.all_ratings
    @sort = params[:sort]
    #if (params[:sort] == nil && params[:ratings] == nil && session[:ratings] == nil)
    #    session[:ratings] = {"G" => "1","PG" => "1","PG-13" => "1","R" => "1"} 
    #    redirect_to movies_path(:ratings => session[:ratings])
    #    return
    #end
    #if (params[:sort] == nil && session[:sort] == nil && params[:ratings] == nil && session[:ratings] == nil)
	#moveon = 0
    if ((params[:sort] == nil && session[:sort] != nil) || (params[:ratings] == nil && session[:ratings] != nil))
        redirect_to movies_path(:sort => params[:sort] || session[:sort], :ratings => params[:ratings] || session[:ratings])
    end
    if (params[:ratings] != nil)
        @checked_rating = params[:ratings]
        session[:ratings] = params[:ratings]
    else 
        @checked_rating = {"G"=>"1", "PG"=>"1", "PG-13" => "1","R" => "1"} 
    end
    if (@sort == "title" || @sort == "release_date")
        session[:sort] = params[:sort]
	@movies = Movie.where("rating IN (?)", @checked_rating.keys).order(params[:sort])
    else
        @movies = Movie.where("rating IN (?)", @checked_rating.keys)
    end
  end

  def new
    # default: render 'new' template
    reset_session
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
