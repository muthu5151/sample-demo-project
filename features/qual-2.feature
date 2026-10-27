@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Registration, Okta Login, and Forgot Password
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-001 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful user registration with valid details
    Given the user is on the registration page
    When the user enters valid mandatory information
      | Field       | Value               |
      | First Name  | John               |
      | Last Name   | Doe                |
      | Email       | john.doe@example.com |
      | Password    | ValidPass123!      |
    And the user submits the registration form
    Then the system displays a confirmation message "Registration successful"
    And the user's account is activated via the Okta registration/verification process

  @id:TC-002 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails when email is already registered
    Given the user is on the registration page
    When the user enters an email that is already registered
      | Field       | Value               |
      | First Name  | Jane               |
      | Last Name   | Smith              |
      | Email       | john.doe@example.com |
      | Password    | ValidPass123!      |
    And the user submits the registration form
    Then the system displays an error message "Email is already registered"

  @id:TC-003 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Registration fails when mandatory fields are missing
    Given the user is on the registration page
    When the user leaves mandatory fields empty
      | Field       | Value |
      | First Name  |       |
      | Last Name   |       |
      | Email       |       |
      | Password    |       |
    And the user submits the registration form
    Then the system displays error messages for each missing field
      | Field       | Error Message                |
      | First Name  | "First Name is required"     |
      | Last Name   | "Last Name is required"      |
      | Email       | "Email is required"          |
      | Password    | "Password is required"       |

  @id:TC-004 @positive @automated @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters valid credentials
      | Email       | john.doe@example.com |
      | Password    | ValidPass123!        |
    And the user submits the login form
    Then the user is redirected to the application dashboard

  @id:TC-005 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Login fails with invalid credentials
    Given the user is on the login page
    When the user enters invalid credentials
      | Email       | john.doe@example.com |
      | Password    | InvalidPass123!      |
    And the user submits the login form
    Then the system displays an error message "Invalid email or password"

  @id:TC-006 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p2 @story:QUAL-2
  Scenario: Forgot password functionality
    Given the user is on the login page
    And the user clicks on the "Forgot Password" link
    When the user enters their registered email address
      | Email       | john.doe@example.com |
    And the user submits the request
    Then the system sends a password reset email to the user
    And the email contains a link to reset the password