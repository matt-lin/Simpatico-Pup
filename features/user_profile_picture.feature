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
  When I press "Add Profile Picture"
  Then I should see "Choose a file"
  When I attach the file "./attachment/profile_image.jpg" to "image_link"
  And I press "Set Profile Picture"
  Then I should see "You have successfully set your profile image!"
  And I should see the image "test.jpg"

Scenario: user sets profile image incorrectly
  Given I log in as "jeff"
  And I am on the "Edit Profile" page
  When I press "Add Profile Picture"
  Then I should see "Choose a file"
  When I attach the file "./attachment/profile_image.txt" to "image_link"
  And I press "Set Profile Picture"
  Then I should see "Please submit a jpg or png file"

