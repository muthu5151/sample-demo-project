@suite:user-authentication @env:qa @owner:qa-team @story:QUAL-2 @priority:p1
Feature: User Authentication - Registration, Okta Login, and Forgot Password
  # Generated from QUAL-2 — User Authentication functionality.

  @id:TC-AC1 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Display Registration Page
    Given the user is not authenticated
    When the user selects "Register / Sign Up"
    Then the registration page should be displayed with all required fields
    And the page should clearly identify mandatory and optional fields

  @id:TC-AC2 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful Registration
    Given the user enters valid registration information
    When the user submits the registration form
    Then the user account should be created successfully
    And the user should receive the configured account verification/activation communication
    And the user should see an appropriate confirmation message

  @id:TC-AC3 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Mandatory Field Validation
    Given the user is on the registration page
    When the user submits the form without completing mandatory fields
    Then validation messages should be displayed for the missing fields
    And the registration request should not be submitted

  @id:TC-AC4 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Invalid Email Validation
    Given the user enters an invalid email address
    When the user submits the registration form
    Then the system should display an appropriate email validation message
    And the account should not be created

  @id:TC-AC5 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Password Policy Validation
    Given the user enters a password that does not satisfy the configured password policy
    When the user submits the registration form
    Then the system should display the applicable password validation message
    And the account should not be created

  @id:TC-AC6 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Existing User Registration
    Given an account already exists for the provided email address
    When the user attempts to register using the same email address
    Then the registration should not create a duplicate account
    And an appropriate error/information message should be displayed

  @id:TC-AC7 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Display Login Page
    Given the user is not authenticated
    When the user navigates to the login page
    Then the login option should be displayed
    And the user should be able to initiate authentication through Okta

  @id:TC-AC8 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Successful Okta Login
    Given the user has a valid and active Okta account
    When the user provides valid credentials and completes authentication
    Then Okta should authenticate the user successfully
    And the user should be redirected to the application
    And the authenticated session should be established

  @id:TC-AC9 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Invalid Login
    Given the user provides invalid authentication credentials
    When the user attempts to log in
    Then authentication should fail
    And the user should remain unauthenticated
    And an appropriate error message should be displayed

  @id:TC-AC10 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Unauthorized User Access
    Given the user does not have the required application access
    When the user successfully authenticates through Okta
    Then the application should prevent unauthorized access
    And an appropriate access-denied message/page should be displayed

  @id:TC-AC11 @negative @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Protected Page Access Without Authentication
    Given the user is not authenticated
    When the user attempts to access a protected application page directly
    Then the user should not be granted access
    And the user should be redirected to the login/authentication page

  @id:TC-AC12 @positive @manual @suite:user-authentication @env:qa @owner:qa-team @priority:p1 @story:QUAL-2
  Scenario: Logout Functionality
    Given the user is successfully logged into the application
    When the user selects "Logout"
    Then the application session should be terminated
    And the user should no longer be able to access protected pages without logging in again