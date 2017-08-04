#Iter 4-1 Test for editing format on text page (By Gung Hiu Ho, Licong Wang)

Feature: Admin edit the text in nevgation 
    As an administrator,
    I want to be able to change the word style (font, bullet point) of text in navigation bar,
    So that I can make the content nicer and more readable.
    
    Background: Admin already login
      Given the default layout exist
      And I login as an admin
      And the following texts exist:
        | id  | title            | body                                           |
        | 1   | Mission          | designed to help dog lovers                    |
        | 2   | Background       | the first species to be domesticated by humans |
        | 3   | Goals            | improve how companion puppies are produced     |
        | 4   | How you can help | contribute to our website                      |
        
    Scenario: admins inspect the current content of navigation text
      When admin go to texts
      Then I should see "Mission"
      Then I should see "designed to help dog lovers"
      
    Scenario: admins can change the title of nevgation text
      When admin go to texts
      And admin go to texts/1/edit
      Then I should see "designed to help dog lovers"
      Then I fill in "text_title" with "Testing title"
      And I press "Update Text"
      When I go to the RateMyPup home page
      And I follow "Mission"
      Then I should see "Testing title"
      
    Scenario: admins can change the content of nevgation text
      When admin go to texts
      And admin go to texts/1/edit
      Then I should see "designed to help dog lovers"
      Then I fill in "text_body" with "Testing body"
      And I press "Update Text"
      When I go to the RateMyPup home page
      And I follow "Mission"
      Then I should see "Testing body"
      

      