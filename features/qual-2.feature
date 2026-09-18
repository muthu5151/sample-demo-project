@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-001 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid details including a unique email and a strong password
    And clicks the "Register" button
    Then the system should display a confirmation message
    And the user should receive an email to verify their account
    And the account should be activated upon successful verification via Okta

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    And an account already exists with the email "test@example.com"
    When the user attempts to register using "test@example.com"
    Then the system should display an error message "Email already registered"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format "invalid-email"
    And clicks the "Register" button
    Then the system should display an error message "Invalid email format"

  @id:TC-004 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters valid credentials and clicks "Login"
    Then the user should be redirected to the Okta authentication page
    And upon successful authentication, the user should be redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials and clicks "Login"
    Then the system should display an error message "Invalid username or password"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful password reset
    Given the user is on the "Forgot Password" page
    When the user enters their registered email and clicks "Submit"
    Then the system should send a password reset email to the user
    And the user should be able to reset their password using the link in the email

  @id:TC-007 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset fails with unregistered email
    Given the user is on the "Forgot Password" page
    When the user enters an unregistered email and clicks "Submit"
    Then the system should display an error message "Email not found"

  @id:TC-008 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Session timeout after inactivity
    Given the user is logged into the application
    And the user remains inactive for the configured session timeout duration
    When the session timeout occurs
    Then the user should be logged out automatically
    And the system should redirect the user to the login page