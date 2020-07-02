# feature/protocol. feature
Feature: Protocol
  As a member of a project
   want to add/ edit/ delete a tag
   want to add/ edit task description
   want to complete / uncomplete task
   want to add / change due date

Background:
Given default screen size2
  Given the "BioSistemika Process" team exists
  Given the following users are registered
     | name        | email              | password       | password_confirmation |
     | Karli Novak | nonadmin@myorg.com | mypassword1234 | mypassword1234 |
  And "nonadmin@myorg.com" is in "BioSistemika Process" team as a "admin"
  Given Demo project exists for the "BioSistemika Process" team
  And "nonadmin@myorg.com" is signed in with "mypassword1234"

 @javascript
 Scenario: Successful add new tag to a task
   Given task page of Experiment design
   And I click element with css ".search-field"
   And I click element with css ".edit-tags-link"
   And I click on "New" tag button
   And I click on Edit sign of "New tag" tag
   And I fill in "Star" in "#tag_name" field
   And I click element with css ".btn-colorselector"
   And I select "#15369E" color
   And I make screenshot
   And I click element with css ".save-tag-link"
   Then I should see "Star"
   And I click "Close" button
   Then I should see "Star"

@javascript
 Scenario: Successful change a tag to a task
   Given task page of Experiment design
   And I click element with css ".search-field"
   And I click element with css ".edit-tags-link"
   And I click on "New" tag button
   And I click on Edit sign of "New tag" tag
   And I fill in "Sun" in "#tag_name" field
   And I click element with css ".btn-colorselector"
   And I select "#15369E" color
   And I click element with css ".save-tag-link"
   And I click on Edit sign of "Dry lab" tag
   And I fill in "Sky" in "#tag_name" field
   And I click element with css ".btn-colorselector"
   And I select "#DC143C" color
   And I click element with css ".save-tag-link"
   And I should see "Sky"
   And I click element with css "li.list-group-item:nth-child(1) > div:nth-child(1) > div:nth-child(2) > a:nth-child(2)"
   And WAIT
   And I click "Close" button
   And task page of Experiment design
   And I make screenshot
   Then I should see "Sun"
   Then I should not see "Sky"

@javascript
 Scenario: Successful add a tag to a task
   Given task page of Experiment design
   And I click element with css ".search-field"
   And I click element with css ".edit-tags-link"
   And I click element with css ".bootstrap-select"
   And WAIT
   And I click on "Plant" within dropdown menu
   And I click "Add" button
   And WAIT
   And I click element with css ".bootstrap-select"
   And WAIT
   And I click on "Bacteria" within dropdown menu
   And I click "Add" button
   And I click "Close" button
   And task page of Experiment design
   Then I should see "Plant"
   Then I should see "Bacteria"

@javascript
 Scenario: Successful delete a tag
   Given task page of Experiment design
   And I click element with css ".search-field"
   And I click element with css ".edit-tags-link"
   And I click element with css ".delete-tag-link"
   And I click "Close" button
   And task page of Experiment design
   Then I should not see "Dry lab"

# @javascript (cannot be used for now)
#  Scenario: Successful add a start date
#    Given task page of Experiment design
#    And I make screenshot
#    And I click element with css "#calendarStartDate"
#    And I click element with css "#my_module_due_date"
#    And I click "Save" button
#    And WAIT
#    Then I should not see "Due date: not set"

# @javascript (cannot be used for now)
#  Scenario: Successful remove a due date
#    Given task page of Experiment design
#    And I click on "#calendarDueDate" sign
#    And I click on "#my_module_due_date_clear" sign
#    And I click "Save" button
#    And WAIT
#    Then I should see "not set"
#    And I make screenshot

@javascript
 Scenario: Successful add description
   Given task page of Experiment design
   And I click element with css "#my_module_description_view"
   And confirm with ENTER key to "#my_module_description_textarea_ifr"
   And I fill in "I was on Triglav one summer" in "#my_module_description_textarea" rich text editor field
   And I click element with css ".tinymce-save-button"
   Then I should see "I was on Triglav one summer"

@javascript
 Scenario: Successful change description
   Given task page of Experiment design
   And I click element with css "#my_module_description_view"
   And confirm with ENTER key to "#my_module_description_textarea_ifr"
   And I fill in "I was on Triglav one summer" in "#my_module_description_textarea" rich text editor field
   And I click element with css ".tinymce-save-button"
   And I click element with css "#my_module_description_view"
   And confirm with ENTER key to "#my_module_description_textarea_ifr"
   And I fill in "I will go to Krn one day." in "#my_module_description_textarea" rich text editor field
   And I make screenshot
   And I click element with css ".tinymce-save-button"
   Then I should see "I will go to Krn one day."
  
@javascript
 Scenario: Successful Complete task
   Given task page of Experiment design
   And I click "Complete task" button
   Then I should see "Uncomplete task"

@javascript
 Scenario: Successful Uncomplete task
   Given task page of Experiment design
   And I click "Complete task" button
   And I click "Uncomplete task" button
   Then I should see "Complete task"
