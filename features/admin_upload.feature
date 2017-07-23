# Iter 2-2
@javascript
Feature: Admin should be able to upload file to the file manager 
    As an administrator
    I want to be able to upload any file into file manager
    So that I store my data on my website
    
  Background: Logged in to database
    Given I login as an admin
    Given admin go to attachments
        
    Scenario: admins should be able to upload file
      Then I should see "There are no Attachments yet."
      Then I follow "Upload File"
      And I should see "Upload File"
      Then I attach the file "features/attachment/eecs.jpg" to "attachment_attachment"
      And I press "Create Attachment"
      Then I should see "The attachment has been uploaded."
      And I should see "eecs.jpg"
      
    Scenario: admins should be able to manage document
      When I follow "Upload File"
      Then I attach the file "features/attachment/honor.pdf" to "attachment_attachment"
      And I press "Create Attachment"
      And I should see "honor.pdf"
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage media file
      When I follow "Upload File"
      Then I attach the file "features/attachment/Velonica.mp3" to "attachment_attachment"
      And I press "Create Attachment"
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage text file
      When I follow "Upload File"
      Then I attach the file "features/attachment/text.txt" to "attachment_attachment"
      And I press "Create Attachment"
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage image file
      When I follow "Upload File"
      Then I attach the file "features/attachment/eecs.jpg" to "attachment_attachment"
      And I press "Create Attachment"
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
# End for Iter 2-2
