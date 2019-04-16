@javascript
Feature: Normal user should be able to add comments to topics on message board
    As an normal user
    I want to add a comment to a topic on the message board
    So that I can communicate with other users

Background: Admin User already created some forum topics and normal user is logged in
  Given the default layout exist
  Given I am on the RateMyPup home page

  And the following users exist: 
    | username       | email                   | password       | password_confirmation | activated |
    | testuser       | testuser@berkeley.edu   | 12345678       | 12345678              | true      |
    | normaluser     | normaluser@berkeley.edu | 12345678       | 12345678              | true      |

  Given I log in as "testuser"
  Given I am on the Community Forum page
  Then I should see "Create a New Messageboard"
  Then I click link "Create a New Messageboard"
  Then I should be on the "new messageboard" page
  And I enter "messageboard_name" and "shuyin"
  And I enter "messageboard_description" and "test"
  Then I press "Create a New Messageboard"
  Then I should be on the Community Forum page
  Then I should see "test"
  Then I click the nav bar dropdown button
  And I click link "Logout"
  Then I log in as "normaluser"
  Then I am on the Community Forum page


  Scenario: Normal user can add a comment
  Then I should see "test" 
  Then I click link "test"
  Then I should see "Welcome to your messageboard's very first thread" 
  Then I click link "Welcome to your messageboard's very first thread"
  And I enter "post_content" and "this is post content"
  Then I press "Submit Reply"
  Then I should see "this is post content"