# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
  index do
    table_for Customize.all do
      column :name 
      column :content
      actions
    end
  end
  
end
# End for Iter 3-2