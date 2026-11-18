@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — review before merge.

  @id:TC-001 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid mandatory details including a unique email and a strong password
    And clicks the "Register" button
    Then the system displays a confirmation message
    And the user receives an account activation email
    And the account is activated after completing the Okta verification process

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    When the user enters an email address that is already registered
    And clicks the "Register" button
    Then the system displays an error message "Email already exists"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format (e.g., "user@com")
    And clicks the "Register" button
    Then the system displays an error message "Invalid email format"

  @id:TC-004 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login using valid Okta credentials
    Given the user is on the login page
    When the user enters valid Okta credentials
    And clicks the "Login" button
    Then the system redirects the user to the Okta authentication page
    And after successful authentication, the user is redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Login fails with invalid Okta credentials
    Given the user is on the login page
    When the user enters invalid Okta credentials
    And clicks the "Login" button
    Then the system displays an error message "Invalid credentials"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful password reset via Okta
    Given the user is on the "Forgot Password" page
    When the user enters their registered email address
    And clicks the "Reset Password" button
    Then the system sends a password reset email via Okta
    And the user can reset their password using the provided link

  @id:TC-007 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password reset fails for unregistered email
    Given the user is on the "Forgot Password" page
    When the user enters an unregistered email address
    And clicks the "Reset Password" button
    Then the system displays an error message "Email not found"

  @id:TC-008 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Session timeout redirects to login page
    Given the user is logged into the application
    And the session timeout duration has elapsed
    When the user attempts to perform any action
    Then the system redirects the user to the login page
    And displays a message "Session expired, please log in again"