@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — review before execution.

  @id:TC-001 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid details including a unique email and a strong password
    And clicks the "Register" button
    Then the system displays a confirmation message
    And the user receives an account activation email
    And the account is activated upon following the activation link

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    When the user enters an email that is already registered
    And clicks the "Register" button
    Then the system displays an error message "Email already in use"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format
    And clicks the "Register" button
    Then the system displays an error message "Invalid email format"

  @id:TC-004 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials via Okta
    Given the user is on the login page
    When the user enters valid credentials
    And clicks the "Login" button
    Then the user is redirected to the Okta authentication page
    And upon successful authentication, the user is redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials
    And clicks the "Login" button
    Then the system displays an error message "Invalid username or password"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset request
    Given the user is on the "Forgot Password" page
    When the user enters a registered email address
    And clicks the "Submit" button
    Then the system sends a password reset email to the user
    And the user can reset their password using the link in the email

  @id:TC-007 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset fails for unregistered email
    Given the user is on the "Forgot Password" page
    When the user enters an unregistered email address
    And clicks the "Submit" button
    Then the system displays an error message "Email not found"

  @id:TC-008 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Session timeout redirects to login page
    Given the user is logged in
    And the session timeout duration has elapsed
    When the user attempts to access a protected page
    Then the system redirects the user to the login page
    And displays a message "Session expired, please log in again"