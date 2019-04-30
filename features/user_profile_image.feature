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

    Given I log in as "jeff"
    And I am on the "Edit Profile" page

Scenario: user sets profile image correctly
  When I attach the file "./features/attachment/profile_image.jpg" to "Choose File"
  And I press "Save"
  Then I should see "You have successfully set your profile image!"
  And I should see the image "thumb_profile_image.jpg"

Scenario: user sets profile image incorrectly
  When I attach the file "./features/attachment/profile_image.txt" to "Choose File"
  And I press "Save"
  Then I should see "Please submit an image file"

