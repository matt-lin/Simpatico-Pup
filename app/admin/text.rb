ActiveAdmin.register Text do
    actions :all, except: [:new, :show]
    
    index do
       column :title
       column :body
       actions
    end
    
    form do |f|
        f.inputs "Content editor" do
            f.input :title
            f.input :body, :as => :rich, :config => { :width => '100%', :height => '400px' , :allow_embeds => true}
        end
        f.actions
    end
    
    sidebar :"How to use" do
    
        h6 "Avaliable title:"
        ul do
            li "Mission"
            li "Background"
            li "Goals"
            li "How you can help"
        end
           
        text_node "Tips: The text editor can edit page accepts HTML"         
    end
    
    
    controller do
        def update
            super do
                flash[:notice] = "The text has been updated."
                redirect_to collection_url and return if resource.valid?
            end
        end
    end
end
