# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
    index do
        table_for order.customizes do
          column(:payment_type) { |payment| payment.payment_type.titleize }
          column "Received On",     :created_at
          column "Details & Notes", :payment_details
          column "Amount",          :amount_in_dollars
        end
    end
end
# End for Iter 3-2