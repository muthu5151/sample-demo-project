@suite:user-authentication @env:qa1 @owner:manual-qa @story:QUAL-2 @priority:p1
Feature: User Registration, Okta Login and Forgot Password
  # Generated from QUAL-2 - review before merge.
  # The Jira Acceptance Criteria field duplicates the description and has no numbered ACs.
  # Traceability IDs are derived from the Scope bullets:
  #   AC-1  Allow a new user to register
  #   AC-2  Validate mandatory user information
  #   AC-3  Validate email format and password requirements
  #   AC-4  Prevent registration with an existing email
  #   AC-5  Provide appropriate confirmation/error messages
  #   AC-6  Activate the account per the configured Okta registration/verification process
  #   AC-7  Allow registered users to authenticate using Okta
  #   AC-8  Redirect the user to the Okta authentication page where applicable
  #   AC-9  Validate successful and unsuccessful login attempts
  #   AC-10 Redirect successfully authenticated users to the application
  #   AC-11 Prevent unauthorized users from accessing protected pages
  #   AC-12 Handle session timeout/logout appropriately
  #   AC-13 Forgot Password (from the user story statement; not listed in Scope)
  # Password policy, session timeout duration and lockout thresholds are not specified.
  # Steps refer to the "configured" values.

  Background:
    Given the QualityAI application is available in the "qa1" environment
    And the application is integrated with the configured Okta tenant

  # ---------------------------- USER REGISTRATION ----------------------------

  @id:TC-QUAL2-01 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: New user registers successfully with valid information (AC-1, AC-5)
    Given the user is on the registration page
    And the email "new.user@example.com" is not registered
    When the user enters valid first name, last name, email and a password that meets the password policy
    And the user submits the registration form
    Then the user account is created in Okta
    And a confirmation message is displayed to the user
    And no validation errors are displayed

  @id:TC-QUAL2-02 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Account is activated according to the configured Okta verification process (AC-6)
    Given a user has just completed registration with a valid email
    And the Okta tenant requires email verification
    When the user opens the verification email and completes the verification step
    Then the account status in Okta changes to "Active"
    And the user can log in to the application

  @id:TC-QUAL2-03 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Unverified user cannot log in before account activation (AC-6, AC-9)
    Given a user has registered but has not completed email verification
    When the user attempts to log in through Okta with the registered credentials
    Then access to the application is denied
    And a message indicates that the account is not yet activated

  @id:TC-QUAL2-04 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario Outline: Registration is blocked when a mandatory field is missing (AC-2, AC-5)
    Given the user is on the registration page
    When the user completes all fields except "<missing_field>"
    And the user submits the registration form
    Then the registration is not submitted
    And the error message "<error_message>" is displayed next to the "<missing_field>" field
    And no account is created in Okta

    Examples:
      | missing_field | error_message                  |
      | First Name    | First name is required         |
      | Last Name     | Last name is required          |
      | Email         | Email is required              |
      | Password      | Password is required           |

  @id:TC-QUAL2-05 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario Outline: Registration is blocked for an invalid email format (AC-3, AC-5)
    Given the user is on the registration page
    When the user enters the email "<email>" with otherwise valid data
    And the user submits the registration form
    Then an email format validation error is displayed
    And no account is created in Okta

    Examples:
      | email                |
      | plainaddress         |
      | user@                |
      | @example.com         |
      | user@@example.com    |
      | user@example         |
      | user name@example.com|

  @id:TC-QUAL2-06 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario Outline: Registration is blocked when the password violates the password policy (AC-3, AC-5)
    Given the user is on the registration page
    When the user enters a valid email and the password "<password>"
    And the user submits the registration form
    Then a password policy error describing the unmet requirement is displayed
    And no account is created in Okta

    Examples:
      | password             | violation                         |
      | Ab1!                 | Shorter than minimum length       |
      | alllowercase1!       | No uppercase character            |
      | ALLUPPERCASE1!       | No lowercase character            |
      | NoNumbers!!          | No numeric character              |
      | NoSpecial123         | No special character (if required)|
      | <contains username>  | Contains the username/email       |

  @id:TC-QUAL2-07 @edge @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Password length boundary values are enforced (AC-3)
    Given the user is on the registration page
    When the user registers with a compliant password exactly at the configured minimum length
    Then the registration succeeds
    When the user registers another account with a password one character shorter than the minimum length
    Then a password length validation error is displayed
    And no account is created for the second attempt

  @id:TC-QUAL2-08 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Registration with an existing email address is prevented (AC-4, AC-5)
    Given a user account already exists for "existing.user@example.com"
    And the user is on the registration page
    When the user submits valid registration data using "existing.user@example.com"
    Then the registration is rejected
    And an error message indicates the email is already registered
    And no duplicate account is created in Okta

  @id:TC-QUAL2-09 @edge @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Duplicate email check is case-insensitive and ignores surrounding spaces (AC-4)
    Given a user account already exists for "existing.user@example.com"
    When the user attempts to register with " Existing.User@Example.com "
    Then the registration is rejected as a duplicate
    And no duplicate account is created in Okta

  @id:TC-QUAL2-10 @ui @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p3 @story:QUAL-2
  Scenario: Inline validation errors clear once the user corrects the input (AC-5)
    Given the user submitted the registration form with an invalid email
    And the email validation error is displayed
    When the user corrects the email to a valid value
    Then the email validation error is removed
    And the data already entered in the other fields is retained

  @id:TC-QUAL2-11 @security @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Registration fields reject script and SQL injection payloads (AC-2, AC-3)
    Given the user is on the registration page
    When the user enters "<script>alert(1)</script>" in the name fields and "' OR 1=1 --" in the email field
    And the user submits the registration form
    Then the input is rejected or safely encoded
    And no script is executed in the browser
    And no account is created

  @id:TC-QUAL2-12 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p3 @story:QUAL-2
  Scenario: User receives a friendly error when Okta is unavailable during registration (AC-5)
    Given the Okta service is unreachable
    And the user is on the registration page
    When the user submits valid registration data
    Then a user-friendly error message is displayed
    And no technical stack trace or internal details are shown
    And the user can retry once Okta is available

  # --------------------------------- OKTA LOGIN ---------------------------------

  @id:TC-QUAL2-13 @positive @ui @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: User is redirected to the Okta authentication page on login (AC-7, AC-8)
    Given the user is not authenticated
    When the user clicks "Log In" on the application
    Then the browser is redirected to the configured Okta sign-in page
    And the Okta page is served over HTTPS

  @id:TC-QUAL2-14 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Registered user logs in successfully through Okta (AC-7, AC-9, AC-10)
    Given a registered and active user exists
    And the user is on the Okta sign-in page
    When the user enters valid credentials and submits
    Then the user is redirected back to the application
    And the application landing page is displayed
    And the user's identity is shown as logged in

  @id:TC-QUAL2-15 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Login fails with an incorrect password (AC-9)
    Given a registered and active user exists
    And the user is on the Okta sign-in page
    When the user enters a valid username and an incorrect password
    Then an authentication error is displayed on the Okta page
    And the user is not redirected to the application
    And no session is created in the application

  @id:TC-QUAL2-16 @negative @security @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Login fails for an unregistered user without disclosing account existence (AC-9)
    Given no account exists for "unknown.user@example.com"
    When the user attempts to log in with that username and any password
    Then the login is rejected
    And the error message does not reveal whether the username exists

  @id:TC-QUAL2-17 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Account is locked after repeated failed login attempts (AC-9)
    Given a registered user exists
    And the Okta lockout policy is set to a configured number of failed attempts
    When the user enters an incorrect password the configured number of times
    Then the account is locked according to the Okta policy
    And a valid password is also rejected while the account is locked

  @id:TC-QUAL2-18 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Deactivated or suspended user cannot log in (AC-9, AC-11)
    Given a user account has been deactivated or suspended in Okta
    When the user attempts to log in with the correct credentials
    Then access to the application is denied
    And no application session is created

  @id:TC-QUAL2-19 @negative @security @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Unauthenticated user cannot access a protected page directly (AC-11)
    Given the user is not authenticated
    When the user navigates directly to a protected application URL
    Then the user is redirected to the Okta authentication page
    And the protected content is not displayed

  @id:TC-QUAL2-20 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p3 @story:QUAL-2
  Scenario: User is returned to the originally requested page after login (AC-10, AC-11)
    Given the user is not authenticated
    And the user requested a protected page URL
    When the user is redirected to Okta and logs in successfully
    Then the user lands on the originally requested protected page

  @id:TC-QUAL2-21 @negative @security @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Expired or tampered session token is rejected (AC-11, AC-12)
    Given the user is logged in to the application
    When the session or access token is modified or replaced with an invalid value
    And the user requests a protected page
    Then the request is rejected
    And the user is redirected to the Okta authentication page

  @id:TC-QUAL2-22 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Session expires after the configured inactivity timeout (AC-12)
    Given the user is logged in to the application
    When the user remains inactive for longer than the configured session timeout
    And the user performs an action or refreshes the page
    Then the session is terminated
    And the user is redirected to the Okta sign-in page
    And a session expired message is displayed where applicable

  @id:TC-QUAL2-23 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: User logs out and cannot return to protected pages (AC-12, AC-11)
    Given the user is logged in to the application
    When the user clicks "Log Out"
    Then the application session is terminated
    And the user is redirected to the logged-out or sign-in page
    When the user clicks the browser Back button
    Then protected content is not displayed
    And the user is prompted to authenticate

  @id:TC-QUAL2-24 @edge @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p3 @story:QUAL-2
  Scenario: Logout in one browser tab ends the session in other open tabs (AC-12)
    Given the user is logged in with the application open in two browser tabs
    When the user logs out in the first tab
    And the user performs an action in the second tab
    Then the second tab requires re-authentication

  # ------------------------------- FORGOT PASSWORD -------------------------------

  @id:TC-QUAL2-25 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: Registered user requests a password reset (AC-13)
    Given a registered and active user exists
    And the user is on the Okta sign-in page
    When the user clicks "Forgot password" and submits the registered email
    Then a confirmation message is displayed
    And a password reset email is sent to the registered email address

  @id:TC-QUAL2-26 @negative @security @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Password reset request for an unregistered email does not disclose account existence (AC-13)
    Given no account exists for "unknown.user@example.com"
    When the user submits that email on the Forgot password page
    Then the same generic confirmation message is displayed as for a registered email
    And no reset email is sent

  @id:TC-QUAL2-27 @positive @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p1 @story:QUAL-2
  Scenario: User resets the password and logs in with the new password (AC-13, AC-9)
    Given the user has received a valid password reset link
    When the user opens the link and sets a new password that meets the password policy
    Then a password reset success message is displayed
    And the user can log in with the new password
    And the old password is rejected

  @id:TC-QUAL2-28 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: Expired or already used reset link is rejected (AC-13)
    Given the user has a password reset link that is expired or already used
    When the user opens the link
    Then the password cannot be reset using that link
    And a message prompts the user to request a new reset link

  @id:TC-QUAL2-29 @negative @manual @suite:user-authentication @env:qa1 @owner:manual-qa @priority:p2 @story:QUAL-2
  Scenario: New password that violates the password policy is rejected on reset (AC-13, AC-3)
    Given the user has opened a valid password reset link
    When the user enters a new password that does not meet the password policy
    Then a password policy error is displayed
    And the password is not changed