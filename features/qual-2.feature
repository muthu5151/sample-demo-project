@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication (User Registration, Okta Login, and Forgot Password)
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-001 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid registration details
      | Field       | Value               |
      | First Name  | John                |
      | Last Name   | Doe                 |
      | Email       | john.doe@example.com|
      | Password    | ValidPass123!       |
    And clicks the "Register" button
    Then the user should see a confirmation message "Registration successful. Please verify your email."
    And the user account should be created in Okta in an inactive state
    And a verification email should be sent to "john.doe@example.com"

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with an already registered email
    Given the user is on the registration page
    When the user enters an email that is already registered
      | Email       | john.doe@example.com |
    And clicks the "Register" button
    Then the user should see an error message "This email is already registered. Please log in or use Forgot Password."

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails with invalid email format
    Given the user is on the registration page
    When the user enters an invalid email format
      | Email       | john.doe@com        |
    And clicks the "Register" button
    Then the user should see an error message "Please enter a valid email address."

  @id:TC-004 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters valid credentials
      | Email       | john.doe@example.com |
      | Password    | ValidPass123!        |
    And clicks the "Login" button
    Then the user should be redirected to the application dashboard
    And the session should be active for the configured timeout period

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials
      | Email       | john.doe@example.com |
      | Password    | WrongPass123!        |
    And clicks the "Login" button
    Then the user should see an error message "Invalid email or password. Please try again."

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Forgot Password flow
    Given the user is on the login page
    When the user clicks the "Forgot Password" link
    And enters their registered email address
      | Email       | john.doe@example.com |
    And clicks the "Submit" button
    Then the user should see a confirmation message "Password reset instructions have been sent to your email."
    And a password reset email should be sent to "john.doe@example.com"