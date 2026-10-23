@suite:user-authentication @env:qa1 @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-001 @positive @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid mandatory information including email and password
    And the user submits the registration form
    Then the system validates the email format and password requirements
    And the system confirms the registration with a success message
    And the user receives an account activation email

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    And the email entered is already associated with an existing account
    When the user submits the registration form
    Then the system displays an error message "Email already registered"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format (e.g., "userexample.com")
    And the user submits the registration form
    Then the system displays an error message "Invalid email format"

  @id:TC-004 @positive @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid Okta credentials
    Given the user is on the login page
    When the user enters valid Okta credentials
    And the user submits the login form
    Then the system redirects the user to the Okta authentication page
    And the user is successfully authenticated
    And the user is redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Login fails with invalid Okta credentials
    Given the user is on the login page
    When the user enters invalid Okta credentials
    And the user submits the login form
    Then the system displays an error message "Invalid username or password"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset request
    Given the user is on the login page
    And the user clicks on the "Forgot Password" link
    When the user enters their registered email address
    And submits the password reset request
    Then the system sends a password reset email to the user
    And the user receives a confirmation message "Password reset email sent"

  @id:TC-007 @negative @manual @suite:user-authentication @env:qa1 @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset fails with unregistered email
    Given the user is on the login page
    And the user clicks on the "Forgot Password" link
    When the user enters an unregistered email address
    And submits the password reset request
    Then the system displays an error message "Email not found"