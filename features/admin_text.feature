#Iter 4-1 Test for editing format on text page (By Gung Hiu Ho, Licong Wang)

Feature: Admin edit the text in nevgation 
    As an administrator,
    I want to be able to change the word style (font, bullet point) of text in navigation bar,
    So that I can make the content nicer and more readable.
    
Background: Admin already login
    Given I login as an admin
        
    Scenario: admins inspect who are subscribing when there are subscriber
      When admin go to text
      Then I should see "How you can help"
      Then I should see "Chances are good that there is a dog at your feet as you read this"
      
    Scenario: admins can change the content
      When admin go to text
      And I click edit
      Then I should see "If you have a purebred dog"
      Then I fill in "•" in "text_body"
      When I go to the homepage
      And I follow "How you can help"
      Then I should see "•"
      
    Scenario: admins can change the title of nevgation bar
      When admin go to text
      And I click edit
      Then I should see "How you can help"
      Then I fill in "testing titile" in "text_title"
      When I go to the homepage
      Then I should see "testing title"
      