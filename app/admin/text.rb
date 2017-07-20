ActiveAdmin.register Text do
    
    sidebar :"How to use" do
    
        h6"Avaliable title:"
        ul do
            li "Mission"
            li "Background"
            li "Goals"
            li "How you can help"
        end
           
        text_node "Assign the title to the page that you would like to edit. "         
        "If mutiple same title exist, the texts will be assign to the earliest version"
    end

end
