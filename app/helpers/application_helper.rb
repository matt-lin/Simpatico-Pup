# Iter 3-2 Customize the layout  (By Gung Hiu Ho, Licong Wang)
module ApplicationHelper
  def titles
    return Customize.find_by_name("Site_Name").content
  end
  
  def primary_title 
    return Customize.find_by_name("Primary_Title").content
  end
  
  def secondary_title
    return Customize.find_by_name("Secondary_Title").content
  end
  
  def rate_dog_top
    return Customize.find_by_name("Rate_Dog_Top").content
  end
  
  def rate_Dog_bottom
    return Customize.find_by_name("Rate_Dog_Bottom").content
  end
  
  def find_breed_top
    return Customize.find_by_name("Find_Breed_Top").content
  end
  
  def find_breed_bottom
    return Customize.find_by_name("Find_Breed_Bottom").content
  end
  
  def find_breeder_top
    return Customize.find_by_name("Find_Breeder_Top").content
  end
  
  def find_breeder_bottom
    return Customize.find_by_name("Find_Breeder_Bottom").content
  end
  
  def search_breeder_top
    return Customize.find_by_name("Search_Breeder_Top").content
  end
  
  def search_breeder_bottom
    return Customize.find_by_name("Search_Breeder_Bottom").content
  end
  
  def comment_title
    return Customize.find_by_name("Comment_Title").content
  end
    
  def top_left
    return Customize.find_by_name("Blue_Bar_Top_Left").content
  end
  
  def top_mid
    return Customize.find_by_name("Blue_Bar_Top_Middle").content
  end
  
  def top_right
    return Customize.find_by_name("Blue_Bar_Top_Right").content
  end
  
  def bot_left
    return Customize.find_by_name("Blue_Bar_Bottom_Left").content
  end
  
  def bot_mid
    return Customize.find_by_name("Blue_Bar_Bottom_Middle").content
  end
  
  def bot_right
    return Customize.find_by_name("Blue_Bar_Bottom_Right").content
  end
  
  def bootstrap_class_for flash_type
      case flash_type.to_s
      when "success"
        "alert-success"
      when "error"
        "alert-error"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
      end
  end
end

# End iter3-2
