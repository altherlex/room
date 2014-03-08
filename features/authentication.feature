Feature: Authenticating users

  In order to use the website
  As a user
  I should be able to sign up & sign in

  Scenario: Signing up
    Given I am on the homepage
    When I follow "Sign up"
    And I fill in "Email" with "john@doe.com"
    And I fill in password fields with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully."

  Scenario: Signing in & Signing out
    Given I am registered
    And I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "john@doe.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
    Given I am on the homepage
    When I follow "exit"
    Then I should see "Sign in"

  Scenario: User forgot password
    Given I am registered
    And I am on the homepage
    And I follow "Sign in"
    And I follow "Forgot your password?"
    When I fill in "Email" with "john@doe.com"
    And I press "Send me instructions to reset password"
    Then "john@doe.com" should receive an email
