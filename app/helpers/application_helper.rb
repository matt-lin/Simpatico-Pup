# Iter3-2 Customize the layout  (By Gung Hiu Ho, Licong Wang)
module ApplicationHelper
  def titles
    return Customize.find_by_name("Site_Name").content
  end
  
  #Cover page UI
  def primary_title 
    return Customize.find_by_name("Primary_Title").content
  end
  
  def secondary_title
    return Customize.find_by_name("Secondary_Title").content
  end
  
  def title_button
    return Customize.find_by_name("Title_Button").content
  end
  
  #Transition UI
  def transition_title
    return Customize.find_by_name("Transition_Title").content
  end
  
  def transition_body
    return Customize.find_by_name("Transition_Body").content
  end
  
  def transition_button
    return Customize.find_by_name("Transition_Button").content
  end
  
  #Service UI
  def function_title
    return Customize.find_by_name("Function_Title").content
  end
  
  def rate_dog_top
    return Customize.find_by_name("Function_leftmost_Top").content
  end
  
  def rate_Dog_bottom
    return Customize.find_by_name("Function_leftmost_Bottom").content
  end
  
  def find_breed_top
    return Customize.find_by_name("Function_left_mid_Top").content
  end
  
  def find_breed_bottom
    return Customize.find_by_name("Function_left_mid_Bottom").content
  end
  
  def find_breeder_top
    return Customize.find_by_name("Function_right_mid_Top").content
  end
  
  def find_breeder_bottom
    return Customize.find_by_name("Function_right_mid_Bottom").content
  end
  
  def search_breeder_top
    return Customize.find_by_name("Function_rightmost_Top").content
  end
  
  def search_breeder_bottom
    return Customize.find_by_name("Function_rightmost_Bottom").content
  end
  
  #Message UI
  def comment_title
    return Customize.find_by_name("Comment_Title").content
  end
    
  #Buttom bar UI
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
  
  #Navagation bar UI
  def nav_bar_1
    return Customize.find_by_name("Nav_Bar_1").content
  end
  
  def nav_bar_2
    return Customize.find_by_name("Nav_Bar_2").content
  end
  
  def nav_bar_3
    return Customize.find_by_name("Nav_Bar_3").content
  end
  
  def nav_bar_4
    return Customize.find_by_name("Nav_Bar_4").content
  end
  
  def nav_bar_5
    return Customize.find_by_name("Nav_Bar_5").content
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
