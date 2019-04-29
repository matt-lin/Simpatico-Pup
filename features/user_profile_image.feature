Feature: Users should be able to set their profile picture
    As a user
    I want to set a profile picture
    So others can see my dog

Background: User already login
    Given the default layout exist
    And I am on the RateMyPup home page

    And the following users exist:
        | username       | email               | password       | password_confirmation| activated |
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | true      |

Scenario: user sets profile image correctly
  Given I log in as "jeff"
  And I am on the "Edit Profile" page
  When I attach the file "./features/attachment/profile_image.jpg" to "user_avatar"
  And I press "Set Profile Image"
  Then I should see "You have successfully set your profile image!"
  And I should see "profile_image.jpg"

Scenario: user sets profile image incorrectly
  Given I log in as "jeff"
  And I am on the "Edit Profile" page
  When I attach the file "./features/attachment/profile_image.txt" to "user_avatar"
  And I press "Set Profile Image"
  Then I should see "Please submit a jpg or png file"

