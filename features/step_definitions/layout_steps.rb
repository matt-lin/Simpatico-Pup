#Iter 3-2
Given (/^the default layout exist$/) do
  layouts = {
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
  }
  
  layouts.keys.each do |key|
    Customize.create!(name: key, content: layouts[key][0], location: layouts[key][1])
  end
  
end