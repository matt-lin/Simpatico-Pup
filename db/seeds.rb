#encoding: utf-8
customizes = [
  {:name => 'Site_Name', :content => 'SimpaticoPup', :location => "site_title" },
  {:name => 'Primary_Title', :content => 'Better Way to Find a Great Dog', :location => "main_title" }, 
  {:name => 'Secondary_Title', :content => 'Find Dog Breeders Near You', :location => "main_title" },
  {:name => 'Rate_Dog_Top', :content => 'Rate your', :location => "main_button" },
  {:name => 'Rate_Dog_Bottom', :content => 'Dog', :location => "main_button" },
  {:name => 'Find_Breed_Top', :content => 'Find Ratings for a', :location => "main_button" },
  {:name => 'Find_Breed_Bottom', :content => 'Breed', :location => "main_button" },
  {:name => 'Find_Breeder_Top', :content => 'Find Ratings for a', :location => "main_button" },
  {:name => 'Find_Breeder_Bottom', :content => 'Breeder', :location => "main_button" },
  {:name => 'Search_Breeder_Top', :content => 'Search for a', :location => "main_button" },
  {:name => 'Search_Breeder_Bottom', :content => 'Breeder', :location => "main_button" },
  {:name => 'Blue_Bar_Top_Left', :content => 'For More Information on Breed Health', :location => "main_bar" },
  {:name => 'Blue_Bar_Top_Middle', :content => 'Privacy Policy', :location => "main_bar" },
  {:name => 'Blue_Bar_Top_Right', :content => 'Contact Info', :location => "main_bar" },
  {:name => 'Blue_Bar_Bottom_Left', :content => "Canine Health Information Center", :location => "main_bar" },
  {:name => 'Blue_Bar_Bottom_Middle', :content => 'Terms of Service', :location => "main_bar" },
  {:name => 'Blue_Bar_Bottom_Right', :content => 'LSandersDVM@gmail.com', :location => "main_bar" }
  ]
  
customizes.each do |customize|
  Customize.create!(customize)
end

pups = [{:pup_name => 'Chloe', :year => 1, :month => 0, :breeder_id => '1', :breed_id => '1', :breeder_responsibility => '5', :overall_health => '5', :trainability => '3', :social_behavior => '4', :dog_behavior => '4', :energy_level => '4', :simpatico_rating => '5'},
  	 	{:pup_name => 'Spot', :year => 2, :month => 1, :breeder_id => '2', :breed_id => '1', :breeder_responsibility => '3', :overall_health => '3', :trainability => '3', :social_behavior => '3', :dog_behavior => '3', :energy_level => '3', :simpatico_rating => '3'},
  	 	{:pup_name => 'Gypsy', :year => 0, :month => 6, :breeder_id => '1', :breed_id => '1', :breeder_responsibility => '5', :overall_health => '4', :trainability => '3', :social_behavior => '2', :dog_behavior => '2', :energy_level => '1', :simpatico_rating => '5'},
  	 	{:pup_name => 'Jenny', :year => 1, :month => 0, :breeder_id => '2', :breed_id => '2', :breeder_responsibility => '3', :overall_health => '4', :trainability => '5', :social_behavior => '5', :dog_behavior => '5', :energy_level => '3', :simpatico_rating => '4'}]

comments = [
    {:content => 'great dog!', :pup_id => '1'},
    {:content => 'love my dog!', :pup_id => '2'},
    {:content => 'not very playful', :pup_id => '3'},
    {:content => 'very well behaved!', :pup_id => '4'}]

breeders = [
      {:name => 'Unknown', :city => '', :state => ''},
      {:name => 'Justin MacMillin', :city => "Porterville", :state => 'CA'},
			{:name => 'Alex McGourty', :city => "San Francisco", :state => 'CA'}]

users = [{:email => 'admin@berkeley.edu', :encrypted_password => '123456789'}]

texts = [
    {:title => "Mission", :body => 'Our Mission is to create a database of user-generated content about companion dogs and dog breeders, designed to help dog lovers find simpatico puppies with whom to share their homes and lives.'},
    {:title => "Background", :body => 'Chances are good that there is a dog at your feet as you read this, just as there is one at mine.  Dogs were probably the first species to be domesticated by humans around 15,000—30,000 years ago, and since then the histories of our two species have been closely intertwined. The association between humans and dogs began as one in which dogs served various utilitarian purposes such as guarding and hunting. Today, the vast majority of our dogs fill the role of family member and companion, as opposed to serving as working dogs. But even though most dogs no longer serve a practical role in our lives, the relationship between human and dog is certainly no less deep or meaningful. Pulitzer prize-winning biologist EO Wilson popularized the concept of biophilia to describe the powerful and subconscious urge that human beings have to connect with other forms of life, and nowhere is this urge better illustrated than the desire that many people have to spend their lives with a companion dog living in their home, at their side, and sharing almost every aspect of their lives.



    Just as the relationship between humans and dogs has changed in recent times, so has our means of producing and acquiring them. Few dogs today are bred for their working ability. Thanks to the widespread availability of spaying and neutering and an increased awareness of the problems of dog overpopulation, responsible dog owners no longer allow their dogs to breed randomly and indiscriminately, and produce unwanted litters. But too many dogs are irresponsibly bred by small time breeders who are just trying to turn a quick profit, or by large-scale puppy mills whose puppies are marketed online or through puppy wholesalers, without an easy way for puppy seekers to evaluate whether or not the dog breeder is ethical, humane, and breeding for good health and good temperament. Still other dogs are bred by breed fanciers who breed mainly for success in the dog show ring, and then cull their less desirable show stock to be sold as “pet quality” dogs.  Good health and good temperament are to a great degree heritable in dogs, and many dogs that are bred primarily for profit or for the show ring often fall short of the ideal in terms of health and temperament. The fact that a young puppy is cute and sweet and irresistibly appealing is no assurance that it will grow up to be a healthy, suitable companion dog. Far too many dog lovers discover the heartbreak of investing a huge amount of time, money and emotional involvement in a puppy that later turns out to have serious health or behavioral problems.

    Many dog lovers suggest that anyone looking for a companion dog should adopt one from a shelter. Shelter adoption offers a lifeline to those unfortunate dogs that find themselves in such desperate circumstances, and many shelter dogs make fine companions. But our ultimate goal must be to move beyond a system in which the general public acquires dogs that are largely unknown in terms of their health and temperament, were by definition irresponsibly bred (because responsible breeders do not allow the puppies they breed to end up in shelters), and have been put through the tremendous physical and emotional stress of passing through an animal shelter. Our long term goal must certainly be to create a system in which we reduce the number of irresponsibly bred dogs that end up in shelters.  Making spaying and neutering available and affordable is an important goal, but it is not sufficient to reduce the flood of dogs that enter our shelters, as long as irresponsible and strictly profit-motivated dog breeders can find a market for their puppies, and can unload their excess inventory in the night drop box of their local shelter. We also need to decrease the market share for irresponsibly bred puppies, by giving people a clear and better alternative.

    As a society, we have the potential to improve the way that companion dogs are produced and obtained in this country. Using technology, we can create a tool that will help dog lovers demand greater accountability with respect to the breeding of their companion dogs. Bill Gates, founder of Microsoft and global philanthropist, recently stated, “In the past year, I have been struck by how important measurement is to improving the human condition. You can achieve incredible progress if you set a clear goal and find a measure that will drive progress toward that goal.” The same must be true with respect to our companion dogs. Specialized groups have already worked diligently and successfully to develop lines of dogs specifically suited to being service dogs and working dogs of various sorts. By developing a way to measure the success of dog breeders at producing excellent companion dogs, and by giving dog owners the opportunity to provide feedback as to the suitability of their own companion dogs, we can drive the progress of improving the overall health and suitability of companion dogs in this country.  We just have to create the metric, and convince members of the dog-loving public to each take the time to contribute information about the dogs that they have owned. As an added benefit, when the market share for irresponsibly bred dogs decreases,  the number of these dogs that will end up cast off in shelters will decrease.

    The ideal companion dog has an agreeable temperament, has good social behavior around people and other animals, and is a pleasure to be around. People who make the effort to find this website have probably had the pleasure of knowing a dog like this--the description may bring to mind the image of a Labrador retriever, or a toy poodle. You may think of a German shepherd, a sheltie, or a dog that is some blend of these breeds. I call these exceptional dogs simpatico dogs. Simpatico is a word that means like-minded, or compatible. Simpatico dogs come in all shapes and sizes, but what sets them apart is their sound health and temperament, and their desire to be with and communicate with their human family. And dogs that have these desirable qualities are generally rewarded by being able to participate extensively in the lives and activities of their human families.

    So how can you maximize the chance that you will find a simpatico puppy when you make the decision to add a new canine member to your family? It is clear that good health and good temperament in dogs are, to a great degree, heritable. And although we may not all agree precisely on exactly what constitutes an “ideal temperament”, we can all agree that too many dogs lose their lives, lose their homes, or are relegated to a lonely life isolated in a back yard away from their human pack members because they are aggressive, excessively fearful or anxious, or have other recognized health, behavior or temperament problems.

    This website represents an attempt to create a yardstick that will identify and recognize those dedicated dog breeders who are work tirelessly and responsibly, for the love of their breed, to creating simpatico puppies for other dog lovers to cherish and enjoy. It is an attempt to provide a way for the dog-loving public to identify and obtain carefully bred puppies that have had a healthy and well-socialized start, and that have the potential to develop into exceptional companion dogs that will enrich the lives of their forever families. It is also an attempt to improve the lives of dogs--because puppies with good health, good temperaments, and good early socialization and training will develop into dogs that can participate more fully in their owners\' lives and be treasured by them.

    This site is a work in progress. It will only become a useful tool if dog lovers everywhere take the time to contribute user-generated content about the dogs that they have lived with and loved. I believe we can create a network of information and education that will benefit responsible breeders, the dog-loving public, and companion dogs alike. In the spirit of working together to achieve this goal, I welcome the input, comments and suggestions of dog lovers everywhere in order to realize it.

    Linda H Sanders, DVM'},
    {:title => "Goals", :body => 'The SimpaticoPup website was created to help improve how companion puppies are produced, and how they find their way to their forever homes. We believe that:

    Responsible dog breeders should be willing and able to demonstrate their commitment to the following standards:

      1. They are putting top priority on breeding dogs with excellent health and temperament, which have the potential to become excellent companion dogs to their human families.
      2. Their puppies are raised in a healthy environment, and provided with an early environment that promotes optimal socialization, behavior and development.
      3. They are willing to provide ongoing help/support to families who purchase their puppies, to facilitate the puppy’s transition into its new home and continued development. Ideally, they should be willing to provide a life-long commitment and safety net to provide for the well-being of the puppies they produce.
      4. Their breeding dogs are kept in a loving and healthy environment, where their physical, psychological and social needs are all met throughout their lives.
      5. Their breeding dogs receive adequate medical care, and have been screened for genetic/heritable health problems as recommended by the Canine Health Information Center (CHIC) http://www.caninehealthinfo.org/

    Dog lovers who are looking for a new puppy should:

      1. Buy a puppy only from a breeder who is willing to demonstrate that they meet all of the standards shown above.
      2. Carefully choose a puppy that will be suitable for their environment and lifestyle.
      3. Provide their puppy with a loving and healthy environment, where its physical, social and psychological needs will be met.
      4. Provide the puppy with adequate ongoing medical care and prevention.
      5. Continue the puppy’s socialization and training in order for it to develop to its full potential as a companion dog.
      6. Provide a life-long commitment to care for the puppy, or re-home it responsibly.

    At SimpaticoPup.com, we believe that no one should EVER pay money for a puppy unless they verify that the breeder standards listed above are being met. Buying a dog from an irresponsible breeder supports the largely unseen and unregulated industry of puppy mills and profit-motivated breeding, in which dogs are often mistreated as livestock or cash commodities.

    Dog lovers have the power to boycott irresponsible breeders, and to support only responsible breeders. If they do so, the number of irresponsible for-profit breeders will decline, the number of irresponsibly bred dogs that end up dumped into shelters as surplus inventory will decline, the health and temperament of our companion dogs will improve, and our relationships with them will be enriched.
  %center'},
    {:title => "How you can help", :body => '1. If you have a purebred dog (or one of the common crossbreeds that we are also collecting information on), please contribute to our website by clicking on "Rate Your Dog". This website is designed to create a large searchable database of information that will help dog lovers identify responsible dog breeders who have a track record for producing puppies that become excellent companion dogs. This user-generated content will also quantify some important characteristics for various dog breeds. It will take just a few minutes to give us some basic information about your dog\'s breed, tell us where you acquired him/her, and evaluate your dog\'s health, temperament and behavior. This information will help empower others to make a responsible choice when they seek a new puppy, and optimize their chances of finding a simpatico pup with the good health and temperament that they are looking for. It will also encourage dog breeders to prioritize good health and temperament in the puppies they produce, and recognize those responsible dog breeders who have a track record of producing healthy, well-socialized, excellent companion dogs.

    2. If you decide to purchase a puppy, only purchase one from a dog breeder who is able to demonstrate that they are breeding dogs responsibly and humanely, and are producing excellent companion dogs. This website is designed to help you find such a breeder, and maximize the chances that the puppy you choose will develop into the simpatico dog that you hope for. Don\'t purchase a dog from a "middleman" such as a pet store, or a puppy broker. Many seemingly legitimate websites that offer puppies for sale are actually puppy brokers. When you buy from a broker or middleman, the accountability of the actual breeder is lost, and it is difficult to know whether that cute puppy you buy was responsibly and humanely bred, or whether it is actually the product of a profit-motivated, irresponsible and sometimes inhumane breeding operation. Furthermore, you have no idea what that puppy\'s health and temperament will be as an adult. Please do not use your dollars to support irresponsible breeding.

    3. Consider adopting a dog from a shelter, if you are willing to take more of a gamble by acquiring a dog or puppy with unknown genetics, health, temperament, and behavioral traits. Many dogs end up in shelters through no fault of their own, and it is a testament to canine adaptability that a great many of these dogs can blossom and become wonderful companions and treasured family members when they finally find the right home. Until every adoptable dog that enters a shelter leaves it with a new forever family, we must continue to encourage spaying and neutering, and encourage shelter adoption for those individuals who are willing to take a leap of faith when seeking a new dog. At the same time, the database of user-generated content in this website will help discourage irresponsible breeding, which will ultimately decrease the number of dogs that pass through our shelters\' doors.
  %center'}
]

breeds = [
      { :name => 'Affenpinscher' },
      { :name => 'Afghan Hound' },
      { :name => 'Airedale Terrier' },
      { :name => 'Akita' },
      { :name => 'Alaskan Malamute' },
      { :name => 'American English Coonhound' },
      { :name => 'American Eskimo Dog' },
      { :name => 'American Foxhound' },
      { :name => 'American Staffordshire Terrier' },
      { :name => 'American Water Spaniel' },
      { :name => 'Anatolian Shepherd Dog' },
      { :name => 'Australian Cattle Dog' },
      { :name => 'Australian Shepherd' },
      { :name => 'Australian Terrier' },
      { :name => 'Basenji' },
      { :name => 'Basset Hound' },
      { :name => 'Beagle' },
      { :name => 'Bearded Collie' },
      { :name => 'Beauceron' },
      { :name => 'Bedlington Terrier' },
      { :name => 'Belgian Malinois' },
      { :name => 'Belgian Sheepdog' },
      { :name => 'Belgian Tervuren' },
      { :name => 'Bernese Mountain Dog' },
      { :name => 'Black Russian Terrier' },
      { :name => 'Black and Tan Coonhound' },
      { :name => 'Bloodhound' },
      { :name => 'Bluetick Coonhound' },
      { :name => 'Boerboel' },
      { :name => 'Border Collie' },
      { :name => 'Border Terrier' },
      { :name => 'Borzoi' },
      { :name => 'Boston Terrier' },
      { :name => 'Bouvier des Flandres' },
      { :name => 'Boxer' },
      { :name => 'Boykin Spaniel' },
      { :name => 'Briard' },
      { :name => 'Brittany' },
      { :name => 'Brussels Griffon' },
      { :name => 'Bull Terrier' },
      { :name => 'Bulldog' },
      { :name => 'Bullmastiff' },
      { :name => 'Cairn Terrier' },
      { :name => 'Canaan Dog' },
      { :name => 'Cane Corso' },
      { :name => 'Cardigan Welsh Corgi' },
      { :name => 'Cavalier King Charles Spaniel' },
      { :name => 'Cesky Terrier' },
      { :name => 'Chesapeake Bay Retriever' },
      { :name => 'Chihuahua' },
      { :name => 'Chinese Crested' },
      { :name => 'Chinese Shar-Pei' },
      { :name => 'Chinook' },
      { :name => 'Chow Chow'},
      { :name => 'Cirneco dell' },
      { :name => 'Etna' },
      { :name => 'Clumber Spaniel' },
      { :name => 'Cocker Spaniel' },
      { :name => 'Collie' },
      { :name => 'Coton de Tulear' },
      { :name => 'Curly-Coated Retriever' },
      { :name => 'Dachshund' },
      { :name => 'Dalmatian' },
      { :name => 'Dandie Dinmont Terrier' },
      { :name => 'Doberman Pinscher' },
      { :name => 'Dogue de Bordeaux' },
      { :name => 'English Cocker Spaniel' },
      { :name => 'English Foxhound' },
      { :name => 'English Setter' },
      { :name => 'English Springer Spaniel' },
      { :name => 'English Toy Spaniel' },
      { :name => 'Entlebucher Mountain Dog' },
      { :name => 'Field Spaniel' },
      { :name => 'Finnish Lapphund' },
      { :name => 'Finnish Spitz' },
      { :name => 'Flat-Coated Retriever' },
      { :name => 'French Bulldog' },
      { :name => 'German Pinscher' },
      { :name => 'German Shepherd Dog' },
      { :name => 'German Shorthaired Pointer' },
      { :name => 'German Wirehaired Pointer' },
      { :name => 'Giant Schnauzer' },
      { :name => 'Glen of Imaal Terrier' },
      { :name => 'Golden Retriever' },
      { :name => 'Gordon Setter' },
      { :name => 'Great Dane' },
      { :name => 'Great Pyrenees' },
      { :name => 'Greater Swiss Mountain Dog' },
      { :name => 'Greyhound' },
      { :name => 'Harrier' },
      { :name => 'Havanese' },
      { :name => 'Ibizan Hound' },
      { :name => 'Icelandic Sheepdog' },
      { :name => 'Irish Red and White Setter' },
      { :name => 'Irish Setter' },
      { :name => 'Irish Terrier' },
      { :name => 'Irish Water Spaniel' },
      { :name => 'Irish Wolfhound' },
      { :name => 'Italian Greyhound' },
      { :name => 'Japanese Chin' },
      { :name => 'Keeshond' },
      { :name => 'Kerry Blue Terrier' },
      { :name => 'Komondor' },
      { :name => 'Kuvasz' },
      { :name => 'Labrador Retriever' },
      { :name => 'Lakeland Terrier' },
      { :name => 'Leonberger' },
      { :name => 'Lhasa Apso' },
      { :name => 'Lowchen' },
      { :name => 'Maltese' },
      { :name => 'Manchester Terrier' },
      { :name => 'Mastiff' },
      { :name => 'Miniature Bull Terrier' },
      { :name => 'Miniature Pinscher' },
      { :name => 'Miniature Schnauzer' },
      { :name => 'Neapolitan Mastiff' },
      { :name => 'Newfoundland' },
      { :name => 'Norfolk Terrier' },
      { :name => 'Norwegian Buhund' },
      { :name => 'Norwegian Elkhound' },
      { :name => 'Norwegian Lundehund' },
      { :name => 'Norwich Terrier' },
      { :name => 'Nova Scotia Duck Tolling Retriever' },
      { :name => 'Old English Sheepdog' },
      { :name => 'Otterhound' },
      { :name => 'Papillon' },
      { :name => 'Parson Russell Terrier' },
      { :name => 'Pekingese' },
      { :name => 'Pembroke Welsh Corgi' },
      { :name => 'Petit Basset Griffon Vendeen' },
      { :name => 'Pharaoh Hound' },
      { :name => 'Plott' },
      { :name => 'Pointer' },
      { :name => 'Polish Lowland Sheepdog' },
      { :name => 'Pomeranian' },
      { :name => 'Poodle' },
      { :name => 'Portuguese Podengo Pequeno' },
      { :name => 'Portuguese Water Dog' },
      { :name => 'Pug' },
      { :name => 'Puli' },
      { :name => 'Pyrenean Shepherd' },
      { :name => 'Rat Terrier' },
      { :name => 'Redbone Coonhound' },
      { :name => 'Rhodesian Ridgeback' },
      { :name => 'Rottweiler' },
      { :name => 'Russell Terrier' },
      { :name => 'Saluki' },
      { :name => 'Samoyed' },
      { :name => 'Schipperke' },
      { :name => 'Scottish Deerhound' },
      { :name => 'Scottish Terrier' },
      { :name => 'Sealyham Terrier' },
      { :name => 'Shetland Sheepdog' },
      { :name => 'Shiba Inu' },
      { :name => 'Shih Tzu' },
      { :name => 'Siberian Husky' },
      { :name => 'Silky Terrier' },
      { :name => 'Skye Terrier' },
      { :name => 'Smooth Fox Terrier' },
      { :name => 'Soft Coated Wheaten Terrier' },
      { :name => 'Spanish Water Dog' },
      { :name => 'Spinone Italiano' },
      { :name => 'St. Bernard' },
      { :name => 'Staffordshire Bull Terrier' },
      { :name => 'Standard Schnauzer' },
      { :name => 'Sussex Spaniel' },
      { :name => 'Swedish Vallhund' },
      { :name => 'Tibetan Mastiff' },
      { :name => 'Tibetan Spaniel' },
      { :name => 'Tibetan Terrier' },
      { :name => 'Toy Fox Terrier' },
      { :name => 'Treeing Walker Coonhound' },
      { :name => 'Vizsla' },
      { :name => 'Weimaraner' },
      { :name => 'Welsh Springer Spaniel' },
      { :name => 'Welsh Terrier' },
      { :name => 'West Highland White Terrier' },
      { :name => 'Whippet' },
      { :name => 'Wire Fox Terrier' },
      { :name => 'Wirehaired Pointing Griffon' },
      { :name => 'Wirehaired Vizsla' },
      { :name => 'Xoloitzcuintli' },
      { :name => 'Yorkshire Terrier' },
      { :name => 'Goldendoodle (Golden Retriever x Poodle)' },
      { :name => 'Labradoodle (Labrador Retriever x Poodle)' },
      { :name => 'Puggle (Pug x Beagle)' },
      { :name => 'Maltipoo (Maltese x Poodle)' },
      { :name => 'Yorkipoo (Yorkshire Terrier x Poodle)' },
      { :name => 'Shihpoo (Shih Tzu x Poodle)' }]
      

newsletter_users = [
    {:email => 'nu1@gmail.com', :created_at => DateTime.now, :updated_at => DateTime.now},
    {:email => 'nu2@gmail.com', :created_at => DateTime.now, :updated_at => DateTime.now},
    {:email => 'nu3@gmail.com', :created_at => DateTime.now, :updated_at => DateTime.now},
    {:email => 'nu4@gmail.com', :created_at => DateTime.now, :updated_at => DateTime.now}]

newsletter_users.each do |nl_user|
  NewsletterUser.create!(nl_user)
end

breeders.each do |breed|
  Breeder.create!(breed)
end

breeds.each do |breed|
  Breed.create!(breed)
end

pups.each do |pup|
  Pup.create!(pup)
end

comments.each do |comment|
  Comment.create!(comment)
end

texts.each do |text|
  Text.create!(text)
end

AdminUser.create!(:email => 'admin@berkeley.edu', :password => 'password', :password_confirmation => 'password')
