# Iter 3-1
@javascript
Feature: Admin user should be able to add topic to message board
    As an admin user
    I want to add a topic to the message board
    So that other users can comment on the threads 
    
Background: Admin User already login
  Given the default layout exist
  Given I am on the RateMyPup home page

  And the following users exist: 
    | username       | email                 | password       | password_confirmation| activated |
    | testuser       | testuser@berkeley.edu | 12345678       | 12345678             | true      |

  Given I log in as "testuser"
  Given I am on the Community Forum page


  Scenario: Admin user can add new topic
  Then I should see "Create a New Messageboard"
  Then I click link "Create a New Messageboard"
  Then I should be on the "new messageboard" page
  And I enter "messageboard_name" and "shuyin"
  And I enter "messageboard_description" and "test"
  Then I press "Create a New Messageboard"
  Then I should be on the Community Forum page
  Then I should see "test" 

  Scenario: Admin user can add new message group
  Then I should see "Create a New Messageboard Group"
  Then I click link "Create a New Messageboard Group"
  Then I should be on the "new messageboard group" page
  And I enter "messageboard_group_name" and "doggy"
  Then I press "Create a New Messageboard Group"
  Then I should be on the Community Forum page
  Then I should see "Messageboard group has been created" 

  Scenario: Admin user can add a comment
  Then I should see "Create a New Messageboard"
  Then I click link "Create a New Messageboard"
  Then I should be on the "new messageboard" page
  And I enter "messageboard_name" and "shuyin"
  And I enter "messageboard_description" and "test"
  Then I press "Create a New Messageboard"
  Then I should be on the Community Forum page
  Then I should see "test"
  Then I click link "test"
  Then I should see "Welcome to your messageboard's very first thread" 
  Then I click link "Welcome to your messageboard's very first thread"
  And I enter "post_content" and "this is post content"
  Then I press "Submit Reply"
  Then I should see "this is post content"

