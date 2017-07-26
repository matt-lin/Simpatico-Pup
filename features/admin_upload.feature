# Iter 2-2 File manager validation (By Gung Hiu Ho, Licong Wang)
#Iter 3-1 verify if multiple scope exist in this page (By Gung Hiu Ho, Licong Wang)
@javascript
Feature: Admin should be able to upload file to the file manager 
    As an administrator
    I want to be able to upload any file into file manager
    So that I store my data on my website
    
  Background: Logged in to database
    Given the default layout exist
    Given I login as an admin
    Given admin go to attachments
        
    Scenario: admins should be able to upload file
      Then I should see "There are no Attachments yet."
      Then I follow "Upload File"
      And I should see "Upload File"
      Then I attach the file "features/attachment/eecs.jpg" to "attachment_attachment"
      And I press "Create Attachment"
      And I should see all of:
      | eecs.jpg      |
      | Others      |
      | The attachment has been uploaded. |
      When I follow "Delete"
      And I accept confirmation dialogs
      
    Scenario: admins should be able to manage document
      When I follow "Upload File"
      Then I attach the file "features/attachment/honor.pdf" to "attachment_attachment"
      And I choose "Document"
      And I press "Create Attachment"
      And I should see all of:
      | honor.pdf      |
      | Document      |
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage media file
      When I follow "Upload File"
      Then I attach the file "features/attachment/Velonica.mp3" to "attachment_attachment"
      And I choose "Music"
      And I press "Create Attachment"
      And I should see all of:
      | Velonica.mp3      |
      | Music      |
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage text file
      When I follow "Upload File"
      Then I attach the file "features/attachment/text.txt" to "attachment_attachment"
      And I choose "Administive"
      And I press "Create Attachment"
      And I should see all of:
      | text.txt      |
      | Administive      |
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
    Scenario: admins should be able to manage image file
      When I follow "Upload File"
      Then I attach the file "features/attachment/eecs.jpg" to "attachment_attachment"
      And I choose "Image"
      And I press "Create Attachment"
      And I should see all of:
      | eecs.jpg      |
      | Image      |
      When I follow "Delete"
      And I accept confirmation dialogs
      Then I should see "Attachment was successfully destroyed."
      
      Scenario: admins should be able to manage image file
      When I follow "Upload File"
      Then I attach the file "features/attachment/eecs.jpg" to "attachment_attachment"
      And I press "Create Attachment"
      When I follow "Others"
      Then I should see "eecs.jpg"
      When I follow "Document"
      Then I should see "No Attachments found"
    #End for Iter 3-1
# End for Iter 2-2
