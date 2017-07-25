# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
    index do
        table_for(Customize.texts) do
            column :name
            column :content
        end
    end
end
# End for Iter 3-2