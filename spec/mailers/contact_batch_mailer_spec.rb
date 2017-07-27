#Created Rspec for mailer (Gilbert Lo)
require "spec_helper"

describe ContactBatchMailer do
  before :each do
    @recipient = "test@test.com"
    @name = "Test_Name"
    @subject = "Pup test email"
    @body = "Test email body"
    @send = "on"
    @text_attach = FactoryGirl.create(:attachment, :marked => true)
  end

  it 'create email with given parameter' do
    @send = "off"
    mail = ContactBatchMailer.contact_batch_email(@name, @body, @subject, @recipient, @send)
    expect(mail.to).to eql([@recipient])
    expect(mail.subject).to eql(@subject)
    expect(mail.body.to_s).to eql(@body)
  end

  it 'create email with attachment if attachment is marked' do
    mail = ContactBatchMailer.contact_batch_email(@name, @body, @subject, @recipient, @send)
    mail.attachments.should have(1).attachment
    attachment = mail.attachments[0]
    attachment.filename.should == @text_attach.document_file_name
    attachment.content_type.should be_start_with("text/plain")
  end

  it 'only attach attachments that are mark true' do
    text_not_attach = FactoryGirl.create(:attachment, :marked => false, :document => File.new("#{Rails.root}/spec/support/fixtures/b.txt"))
    mail = ContactBatchMailer.contact_batch_email(@name, @body, @subject, @recipient, @send)
    mail.attachments.should have(1).attachment
    attachment = mail.attachments[0]
    attachment.filename.should_not == text_not_attach.document_file_name
  end

  it 'create email with non-txt attachment if attachment is marked' do
    @text_attach.destroy
    doc = FactoryGirl.create(:attachment, :marked => true, :document => File.new("#{Rails.root}/spec/support/fixtures/c.doc"))
    mail = ContactBatchMailer.contact_batch_email(@name, @body, @subject, @recipient, @send)
    mail.attachments.should have(1).attachment
    attachment = mail.attachments[0]
    attachment.filename.should == doc.document_file_name
    attachment.content_type.should be_start_with("application/msword")
  end
end
