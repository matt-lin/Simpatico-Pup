# Iter 3-2
Given (/^the default layout exist$/) do
  layouts = {
<<<<<<< HEAD
    Primary_Title: ['Better Way to Find a Great Dog', 'main_title'],
    Secondary_Title: ['Find Dog Breeders Near You', 'main_title'],
    Rate_Dog_Top: ['Rate your','main_button'],
    Rate_Dog_Bottom: ['Dog','main_button'],
    Find_Breed_Top: ['Find Ratings for a', 'main_button'],
    Find_Breed_Bottom: ['Breed', 'main_button'],
    Find_Breeder_Top: ['Find Ratings for a', 'main_button'],
    Find_Breeder_Bottom: ['Breeder', 'main_button'],
    Search_Breeder_Top: ['Search for a', 'main_button'],
    Search_Breeder_Bottom: ['Breeder', 'main_button']
=======
    Site_Name: 'SimpaticoPup',
    Primary_Title: 'Better Way to Find a Great Dog',
    Secondary_Title: 'Find Dog Breeders Near You',
    Rate_Dog_Top: 'Rate your',
    Rate_Dog_Bottom: 'Dog',
    Find_Breed_Top: 'Find Ratings for a',
    Find_Breed_Bottom: 'Breed',
    Find_Breeder_Top: 'Find Ratings for a',
    Find_Breeder_Bottom: 'Breeder',
    Search_Breeder_Top: 'Search for a',
    Search_Breeder_Bottom: 'Breeder',
    Blue_Bar_Top_Left: 'For More Information on Breed Health',
    Blue_Bar_Top_Middle: 'Privacy Policy',
    Blue_Bar_Top_Right: 'Contact Info',
    Blue_Bar_Bottom_Left: 'Canine Health Information Center',
    Blue_Bar_Bottom_Middle: 'Terms of Service',
    Blue_Bar_Bottom_Right: 'LSandersDVM@gmail.com'
>>>>>>> 5ec3dcf3a0f32031122c40b35c653f7f53e772b2
  }
  
  layouts.keys.each do |key|
    Customize.create!(name: key, content: layouts[key][0], location: layouts[key][1])
  end
end

# End for Iter 3-2