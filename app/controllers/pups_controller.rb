class PupsController < ApplicationController

  before_filter :breeder_exists, :only => :create
  before_filter :check_sign_in, :only => [:new, :dog_name, :dog_how_long, :dog_breed, :dog_breeder]

  # Devise. Methods not in the list below will require a user to be logged in.
  before_filter :authenticate_user!, except: [:index, :new, :main, :show, :breed, :search_breed]


  def breeder_exists
    if params[:pup][:breeder_id].to_i == -1
      breeder = Breeder.find_or_create(params[:breeder][:name], params[:breeder][:city], params[:breeder][:state])
      params[:pup][:breeder_id] = breeder.id
    end
  end



  # The Root Path
  def main
    start_over
    selected_comment = SelectedComment.find_randomly
    if selected_comment
      @comment_content = selected_comment.content
      @comment_user = selected_comment.user
    end
  end



  # The true rating page
  def new
    if !session[:step1] || !session[:step2] || !session[:step3]
      redirect_to root_path and return
    end
    session.delete(:breeder_id)
    if !session[:breeder_id]
      breeder_str = params[:breeder][:name]
      if breeder_str.empty?
        session[:breeder_id] = 1
        return
      end
      breeder = Breeder.find_by_formatted_string(breeder_str)
      if breeder
        @same_breeder = Pup.where("user_id = ? and breeder_id = ?", current_user.id, breeder.id)
        if @same_breeder.length >= 2
          redirect_to root_path, flash: {notice: 'SimpaticoPup is a website designed to collect information from dog
lovers about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety
of dog owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog
owner to rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.'}
          return
        else
          session[:breeder_id] = breeder.id
          return
        end
      end
      flash[:notice] = "The dog breeder or kennel you entered is not yet in our database.
      Please click here to add it to our database."
      redirect_to dog_breeder_path and return
    end
  end



  # Rails default methods
  def index
    @pups = Pup.all
  end


  def show
    @pup = Pup.find params[:id]
  end

  def create
    # gather pup ifo
    
    new_pup = {}
    new_pup[:pup_name] = session[:pup_name]
    new_pup[:year] = session[:years] || 0
    new_pup[:month] = session[:months] || 0
    new_pup[:breeder_responsibility] = params[:pup][:breeder_responsibility]
    new_pup[:overall_health] = params[:pup][:overall_health]
    new_pup[:trainability] = params[:pup][:trainability]
    new_pup[:social_behavior] = params[:pup][:social_behavior]
    new_pup[:dog_behavior] = params[:pup][:dog_behavior]
    new_pup[:energy_level] = params[:pup][:energy_level]
    new_pup[:simpatico_rating] = params[:pup][:simpatico_rating]
    new_pup[:hashtag_1] = params[:pup][:hashtag_1]
    new_pup[:hashtag_2] = params[:pup][:hashtag_2]
    new_pup[:hashtag_3] = params[:pup][:hashtag_3]
    new_pup[:breed_id] = Breed.find_by_name(session[:breed]).id
    new_pup[:breeder_id] = session[:breeder_id]
    new_pup[:user_id] = current_user.id
    @pup = Pup.new(new_pup)
    new_comment = {:content => params[:pup][:comments]}
    @Comment = Comment.new(new_comment)


    if @pup.user.pups(:reload).size > 8
      flash[:notice] = 'SimpaticoPup is a website designed to collect information from dog lovers about their own
companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog owners, we are
currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to rating only two
 dogs that come from the same dog breeder. Thank you for your contributions to our database.'
      redirect_to new_pup_path and return
    end

    #Problem 2
    puts '*'*80
    puts new_pup
    puts '*'*80
    if !@pup.valid?
      flash[:notice] = 'Please make sure all fields are complete!'
      redirect_to new_pup_path and return
    end
    if !@Comment.valid?
      flash[:notice] = 'Please make sure the comment is less than 140 characters.'
      redirect_to new_pup_path and return
    end

    @pup.save
    @Comment.pup_id = @pup.id
    @Comment.save

    # Successfully save pup & comment
    flash[:notice] = "Thank You! #{@pup.pup_name} was successfully added to our database."
    redirect_to root_path
  end

  def update
    @pup = Pup.find params[:id]
    @pup.update_attributes(params[:pup])
    redirect_to pups_path
  end

  def destroy
    @pup = Pup.find params[:id]
    @pup.destroy
    redirect_to pups_path
  end



  #################### Start Questionnaire ####################

  # step 0
  def dog_name
    if current_user.pups.count >= 8
      redirect_to root_path, flash: {notice: 'SimpaticoPup is a website designed to collect information from dog lovers
 about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog
 owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to
 rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.'}
    end
  end

  # step 1
  def dog_how_long
    if params[:pup]
      pup_name = params[:pup][:name]
    else
      pup_name = session[:pup_name]
    end
    if pup_name.nil? || pup_name.empty?
      flash[:notice] = "Please input a name"
      session[:step1] = false
      redirect_to dog_name_path and return      
    else
      session[:pup_name] = pup_name
      session[:step1] = true
    end
  end

  #step2
  def dog_breed
    if !session[:step1]
      redirect_to root_path and return
    end
    if params[:pup]
      years = params[:pup][:years]
      months = params[:pup][:months]
    else
      years = session[:years]
      months = session[:months]
    end
    # tmp_session = {:name => session[:pup_name]}
    if years.nil? || months.nil? || (years.empty? && months.empty?)
      flash[:notice] = "Please enter how long you have owned your dog."
    elsif (!years.empty? && !is_num?(years)) || (!months.empty? && !is_num?(months))
      flash[:notice] = "Please enter a valid integer number for year/month."
    elsif is_valid_year_month?(years, months)
      session[:years] = years
      session[:months] = months
      session[:step2] = true
      return
    else
      flash[:modal] = "To keep our database as accurate as possible,
we are collecting information only for dogs that have been residing 
in their current home for six months or more. Please come back to our 
site and rate your dog after s/he has lived 
with you for a minimum of six months. Thank you."
    end
    session[:step2] = false
    redirect_to dog_how_long_path(:pup => {:pup_name => session[:pup_name]})
  end

  #step3
  def dog_breeder
    if !session[:step1] || !session[:step2]
      redirect_to root_path and return
    end
    if params[:breed]
      breed = params[:breed][:name]
    else
      breed = session[:breed]
    end
    if !Breed.is_valid_breed breed
      session[:step3] = false
      flash[:modal] = "modal"
      temp_session = {:years => session[:years], :months => session[:months]}
      redirect_to dog_breed_path and return
    end
    session[:breed] = breed
    session[:step3] = true

  end

  #################### End Questionnaire ####################



  # search for breeds when doing auto-fill
  def search_breed
    name = params[:name]
    render :json => Breed.find_breed_by_substr(name)
  end

  # search pups by breed name
  def breed
    name = params[:breed][:name]
    if !Breed.is_valid_breed(name)
      flash[:notice] = "Please enter a valid breed name."
      redirect_to root_path
    end
    @pups = Pup.find_by_breed(name)
    @avg_ratings = Pup.avg_ratings_by_breeds(name)
  end



  private
  def check_sign_in
    unless user_signed_in?
      redirect_to welcome_path
    end
  end
  
  def is_valid_year_month?(years, months)
    return years.to_i * 12 + months.to_i >= 6
  end

  def is_num?(str)
    Integer(str)
    return true
  rescue ArgumentError, TypeError
    return false
  end

  def start_over
    session[:step1] = false
    session[:step2] = false
    session[:step3] = false
    session[:pup_name] = nil
    session[:breed] = nil
    session[:years] = nil
    session[:months] = nil
    session[:breeder_id] = nil
  end
end
  
