@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-001 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid mandatory details including a unique email and a strong password
    And clicks the "Register" button
    Then the system should display a confirmation message
    And the user should receive an account activation email
    And the account should be activated after completing the Okta verification process

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    When the user enters an email that is already registered
    And clicks the "Register" button
    Then the system should display an error message "Email already registered"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format
    And clicks the "Register" button
    Then the system should display an error message "Invalid email format"

  @id:TC-004 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters valid credentials
    And clicks the "Login" button
    Then the system should redirect the user to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials
    And clicks the "Login" button
    Then the system should display an error message "Invalid username or password"

  @id:TC-006 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Login fails with empty fields
    Given the user is on the login page
    When the user leaves the email or password field empty
    And clicks the "Login" button
    Then the system should display an error message "Email and password are required"

  @id:TC-007 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful password reset
    Given the user is on the "Forgot Password" page
    When the user enters a registered email address
    And clicks the "Reset Password" button
    Then the system should display a confirmation message
    And the user should receive a password reset email

  @id:TC-008 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Password reset fails with unregistered email
    Given the user is on the "Forgot Password" page
    When the user enters an unregistered email address
    And clicks the "Reset Password" button
    Then the system should display an error message "Email not found"

  @id:TC-009 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Session timeout redirects to login page
    Given the user is logged into the application
    And the session timeout duration has elapsed
    When the user attempts to perform an action
    Then the system should redirect the user to the login page
    And display a message "Session expired, please log in again"