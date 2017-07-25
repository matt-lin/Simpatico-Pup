# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
  config.clear_sidebar_sections!
  actions :index, :edit
  index do
    table_for Customize.all do
      column :name 
      column :content
      actions
    end
  end
  
  form do |f|
    f.inputs "Customize" do
        f.input :content
    end
    f.button :Submit
  end
    
  controller do
    def update
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end
  end
end
# End for Iter 3-2