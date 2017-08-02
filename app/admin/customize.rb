# Iter3-2 Site preference  (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
  config.clear_sidebar_sections!
  actions :index, :edit
  menu :label => 'Site preference'
  
  scope :all, :default => true
  scope :'Site Title' do |a|
    a.where(:location => "site_title")
  end
  scope :'Main Page Welcome Title' do |a|
    a.where(:location => "main_title")
  end
  scope :'Main Page Buttons' do |a|
    a.where(:location => "main_button")
  end
  scope :'Main Page Blue Bar' do |a|
    a.where(:location => "main_bar")
  end
  scope :Others do |a|
    a.where(:location => "Others")
  end
  
  index do
    column :name 
    column :content
    column :location
    actions
  end
  
  form do |f|
    f.inputs "Customize" do
        f.input :content
    end
    f.button :Submit
  end
    
  controller do
    def update
      super do
        puts 
        flash[:notice] = "The content has been modified"
        redirect_to collection_url and return if resource.valid?
      end
    end
  end
end
# End of Iter3-2 
