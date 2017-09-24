# Iter3-2 Site preference  (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
  
  menu :priority => 11
  menu :label => 'Site Preference'
  config.clear_sidebar_sections!
  config.batch_actions = false

  actions :index, :edit
  
  scope :all, :default => true
  scope :'Site Title' do |a|
    a.where(:location => "site_title")
  end
  scope :'Main Page Navigation Bar Layout' do |a|
    a.where(:location => "navigation_bar")
  end
  scope :'Main page cover Layout' do |a|
    a.where(:location => "main_title")
  end
  scope :'Main Page transition Layout' do |a|
    a.where(:location => "transition")
  end
  scope :'Main Page service Layout' do |a|
    a.where(:location => "fuction")
  end
  scope :'Main Page Message display' do |a|
    a.where(:location => "message")
  end
  scope :'Main Page Blur Bar' do |a|
    a.where(:location => "main_bar")
  end

  scope :Others do |a|
    a.where(:location => "Others")
  end
  
  index do
    Customize.delete
    column :name
    column :content
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
