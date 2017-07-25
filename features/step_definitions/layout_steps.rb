# Iter 3-2
Given (/^the default layout exist$/) do
  layouts = {
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
  }
  
  layouts.keys.each do |key|
    Customize.create!(name: key, content: layouts[key])
  end
end

# End for Iter 3-2