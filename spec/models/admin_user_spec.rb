require 'spec_helper'

describe AdminUser do
    describe 'is_valid_breed' do
        it 'return true for id eq to 1' do
            expect(AdminUser.true_admin?(1)).to eq true
        end
    end
end
