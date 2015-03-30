class BreedersController < ApplicationController
  skip_before_filter :delete_pup_from_session, :except => [:index, :substring_match, :search_name]

  def index
    if request.xhr?
      render :json => Breeder.all
    else
      @breeders = Breeder.all
    end
  end

  def substring_match
    render :json => Breeder.find_by_substring(params[:name], params[:limit].to_i)
  end

  def search_name
    @breeder = Breeder.find_by_name(params[:breeders][:breeder_name])
    if !@breeder
      flash[:message] = "Sorry there are not reviews for #{params[:breeders][:breeder_name]}"
      redirect_to root_path and return
    end
    @avg_ratings = @breeder.avg_pup_rating
    @pups = @breeder.pups
  end

  def create
    name, location, website = params[:breeder][:name], params[:breeder][:location], params[:breeder][:website]
    breeder, message = Breeder.find_or_create(name, location, website)
    if session[:pup]
      session[:pup][:breeder] = breeder.id
      redirect_to :controller => 'pups', :action => 'create', :pup => session[:pup]
    else
      flash[:message] = message
      redirect_to root_path
    end
  end

end