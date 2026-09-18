@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # This feature covers user registration, Okta login, and password recovery functionality.

  @id:TC-001 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid details including a unique email and a strong password
    And clicks the "Register" button
    Then the system should display a confirmation message
    And the user should receive an account activation email
    And the account should be activated after completing the Okta verification process

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    And the email "test@example.com" is already registered
    When the user attempts to register using "test@example.com"
    Then the system should display an error message "Email is already registered"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format "invalid-email"
    And clicks the "Register" button
    Then the system should display an error message "Invalid email format"

  @id:TC-004 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters valid credentials and clicks "Login"
    Then the user should be redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials and clicks "Login"
    Then the system should display an error message "Invalid username or password"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Forgot password functionality
    Given the user is on the login page
    When the user clicks the "Forgot Password" link
    And enters their registered email address
    Then the system should send a password reset email to the user
    And display a confirmation message "Password reset email sent"

  @id:TC-007 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p3 @story:QUAL-2
  Scenario: Forgot password fails for unregistered email
    Given the user is on the login page
    When the user clicks the "Forgot Password" link
    And enters an unregistered email address
    Then the system should display an error message "Email not found"

  @id:TC-008 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Session timeout redirects to login page
    Given the user is logged into the application
    When the session times out due to inactivity
    Then the user should be redirected to the login page
    And a message "Session expired, please log in again" should be displayed