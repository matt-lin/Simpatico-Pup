class BreedersController < ApplicationController
  skip_before_filter :delete_pup_from_session, :except => [:index, :substring_match, :search_name]
  before_filter :set_states, only: [:search_nearer_breeders, :new]

  def index
    if request.xhr?
      render :json => Breeder.all
    else
      @breeders = Breeder.all
    end
  end

  def search_breeder
    name, limit= params[:name], params[:limit].to_i
    render :json => Breeder.find_by_substring(name, limit)
  end

  def search_name

    if params[:breeder].present?

      search_str = params[:breeder][:name]

      @breeder = Breeder.find_by_formatted_string(search_str)
      if !@breeder
        flash[:notice] = "Sorry, we do not yet have any ratings for #{search_str}"
        redirect_to root_path and return
      end
      @avg_ratings = @breeder.avg_pup_rating
      @pups = @breeder.all_pups

    elsif params[:id].present?

      @breeder = Breeder.find_by_id(params[:id])
      @avg_ratings = @breeder.avg_pup_rating
      @pups = @breeder.all_pups

    else

      redirect_to root_path

    end

  end



  def search_nearer_breeders
    @breeds = Breed.all

  end

  def nearer_breeders

    # Iter 2-2 Breeder location validation (By Gilbert Lo, Jeff Yu)
    @valid_location = true
    # if params[:breeder][:city].present? && params[:breeder][:state] == ""
    #   @valid_location = false
    #   @message = "Please select a state"
    #   return
    # end

    if params[:breeder][:city].present? && params[:breeder][:state] != ""
      cities = CS.cities(params[:breeder][:state].downcase, :us).map(&:downcase)
      if !cities.include? params[:breeder][:city].downcase
        @valid_location = false
        @message = "The city you entered is not a valid city in the selected state"
        return
      end
    else
      @valid_location = false
      @message = "Please select both city and state"
      return
    end
  
    # End for Iter 2-2
    
    # if params[:breeder][:breed_name].present? && params[:breeder][:city].present?
    #   @breeders = Breeder.joins(pups: :breed).where("breeds.name = ?", params[:breeder][:breed_name]).near("#{params[:breeder][:city]}, #{params[:breeder][:state]}", params[:breeder][:search_distance])
    # elsif params[:breeder][:breed_name].present?
    #   @breeders = Breeder.joins(pups: :breed).where("breeds.name = ?", params[:breeder][:breed_name]).near("#{params[:breeder][:state]}", params[:breeder][:search_distance])
    # elsif params[:breeder][:city].present?
    #   @breeders = Breeder.joins(pups: :breed).near("#{params[:breeder][:city]}, #{params[:breeder][:state]}", params[:breeder][:search_distance])
    # else
    #   @breeders = Breeder.joins(pups: :breed).near("#{params[:breeder][:state]}", params[:breeder][:search_distance])
    # end
    
    if params[:breeder][:breed_name].present? 
      @breeders = Breeder.joins(pups: :breed).where("breeds.name = ?", params[:breeder][:breed_name]).near("#{params[:breeder][:city]}, #{params[:breeder][:state]}", params[:breeder][:search_distance])
    else
      @breeders = Breeder.joins(pups: :breed).near("#{params[:breeder][:city]}, #{params[:breeder][:state]}", params[:breeder][:search_distance])
    end
    @breeders = @breeders.uniq
  end

  def new
    
  end

  def create
    name, city, state = params[:breeder][:name], params[:breeder][:city], params[:breeder][:state]
    
    # Iter 2-2 Breeder location validation (By Gilbert Lo, Jeff Yu)
    cities = CS.cities(state.downcase, :us).map(&:downcase)
    if state.empty?
      flash[:notice] = "Please select a state."
      redirect_to new_breeder_path and return
    elsif !cities.include? city.downcase
      flash[:notice] = "The city you entered is not a valid city in the selected state. Please re-enter your infomation."
      redirect_to new_breeder_path and return
    end
    #End for Iter 2-2
    breeder, message = Breeder.create!(:name => name, :city => city, :state => state)
    if !breeder
      flash[:message] = message
    end
    flash[:notice] = "Breeder #{name} has been added to our database!"
    
    # Iter 3-2 (Gilbert Lo and Jeff Yu)
    # Possible session didn't get delete, if not found dog, then not from edit page
    # do nothing and delete the session
    if session[:pup_id]
      pup = Pup.find_by_id session[:pup_id]
      session.delete :pup_id
      if pup
        pup.breeder = breeder
        pup.save
        redirect_to edit_pup_path(pup) and return
      end
    end
    # End iter 3-2
    
    redirect_to new_pup_path(:breeder => {:name => (name+' - '+city+', '+state)})
  end

  private

  def set_states

    @states = ['AL - Alabama', 'AK - Alaska', 'AZ - Arizona', 'AR - Arkansas',
               'CA - California', 'CO - Colorado', 'CT - Connecticut', 'DE - Delaware',
               'FL - Florida', 'GA - Georgia', 'HI -  Hawaii', 'ID -  Idaho',
               'IL - Illinois', 'IN - Indiana', 'IA - Iowa', 'KS - Kansas',
               'KY - Kentucky', 'LA - Louisiana', 'ME - Maine', 'MD - Maryland',
               'MA - Massachusetts', 'MI - Michigan', 'MN - Minnesota', 'MS - Mississippi',
               'MO - Missouri', 'MT - Montana', 'NE - Nebraska', 'NV - Nevada',
               'NH - New Hampshire', 'NJ - New Jersey', 'NM - New Mexico', 'NY - New York',
               'NC - North Carolina', 'ND - North Dakota', 'OH - Ohio', 'OK - Oklahoma',
               'OR - Oregon', 'PA - Pennsylvania', 'RI - Rhode Island', 'SC -South Carolina',
               'SD - South Dakota', 'TN - Tennessee', 'TX - Texas', 'UT - Utah',
               'VT - Vermont', 'VA - Virginia', 'WA - Washington', 'WV - West Virginia',
               'WI - Wisconsin', 'WY -  Wyoming']

  end

end