# Iter3-2
Given (/^the default layout exist$/) do
  layouts = {
    Site_Name: ['SimpaticoPup', 'site_title'],
    Primary_Title: ['Better Way to Find a Great Dog', 'main_title'],
    Secondary_Title: ['Find a pup from a reliable source', 'main_title'],
    Title_Button: ['Find out more', 'main_title'],
    
    Transition_Title: ['Why are we doing this?', 'transition'],
    Transition_Body: ['At SimpaticoPup.com, we believe that no one should EVER pay money for a puppy unless they verify that the breeder 
      standards listed above are being met. Buying a dog from an irresponsible breeder supports the largely unseen and unregulated industry of 
      puppy mills and profit-motivated breeding.', 'transition'],
    Transition_Button: ['Get Started', 'transition'],
  
    Function_Title: ['What We Provide', 'fuction'],
    Function_leftmost_Top: ['Rate your','fuction'],
    Function_leftmost_Bottom: ['Dog','fuction'],
    Function_left_mid_Top: ['Find Ratings for a', 'fuction'],
    Function_left_mid_Bottom: ['Breed', 'fuction'],
    Function_right_mid_Top: ['Find Ratings for a', 'fuction'],
    Function_right_mid_Bottom: ['Breeder', 'fuction'],
    Function_rightmost_Top: ['Search for a', 'fuction'],
    Function_rightmost_Bottom: ['Breeder', 'fuction'],
    
    Blue_Bar_Top_Left: ['For More Information on Breed Health', 'main_bar'],
    Blue_Bar_Top_Middle: ['Privacy Policy', 'main_bar'],
    Blue_Bar_Top_Right: ['Contact Info', 'main_bar'],
    Blue_Bar_Bottom_Left: ['Canine Health Information Center', 'main_bar'],
    Blue_Bar_Bottom_Middle: ['Terms of Service', 'main_bar'],
    Blue_Bar_Bottom_Right: ['LSandersDVM@gmail.com', 'main_bar'],
    
    Comment_Title: ['Featured Comment', 'message'],
    
    Nav_Bar_1: ['Mission', 'navigation_bar'],
    Nav_Bar_2: ['Background', 'navigation_bar'],
    Nav_Bar_3: ['Goals', 'navigation_bar'],
    Nav_Bar_4: ['How You Can Help', 'navigation_bar'],
    Nav_Bar_5: ['Community Forum', 'navigation_bar']}
    
  layouts.keys.each do |key|
    Customize.create!(name: key, content: layouts[key][0], location: layouts[key][1])
  end
end

# End of Iter3-2