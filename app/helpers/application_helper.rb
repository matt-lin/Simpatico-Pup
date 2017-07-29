# Iter 3-2 Customize the layout (By Gung Hiu Ho, Licong Wang)
module ApplicationHelper
  def titles
    return  Customize.find_by_name("Site_Name").content
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
