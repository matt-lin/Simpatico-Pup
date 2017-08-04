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
            f.input :body, :as => :rich, :config => { :width => '76%', :height => '400px' }
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
           
        text_node "Assign the title to the page that you would like to edit. "         
        "If mutiple same title exist, the texts will be assign to the earliest version"
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
