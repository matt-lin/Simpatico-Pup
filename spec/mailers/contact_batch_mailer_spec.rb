require "spec_helper"

describe ContactBatchMailer do
    before :each do
        @recipient = "test@test.com"
        @name = "Test_Name"
        @subject = "Pup test email"
        @body = "Test email body"
    end
    it 'create email with given parameter' do
        mail = ContactBatchMailer.contact_batch_email(@name, @body, @subject, @recipient)
        expect(mail.to).to eql([@recipient])
        expect(mail.subject).to eql(@subject)
        expect(mail.body.to_s).to eql(@body)
    end
end
