| Test ID | Test Scenario / Summary | Type | Pre-conditions | Test Steps | Test Data | Expected Result | Traceability (AC #) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| TC-001 | Verify the registration page is displayed | Positive | User is not authenticated | 1. Select "Register / Sign Up" | N/A | Registration page is displayed with required fields | AC1 |
| TC-002 | Verify successful registration with valid data | Positive | User is on the registration page | 1. Enter valid registration details<br>2. Submit the form | Valid email, password | Account is created, confirmation message is displayed | AC2 |
| TC-003 | Verify mandatory field validation | Negative | User is on the registration page | 1. Submit the form without filling mandatory fields | Empty fields | Validation messages are displayed for missing fields | AC3 |
| TC-004 | Verify invalid email validation | Negative | User is on the registration page | 1. Enter invalid email<br>2. Submit the form | Invalid email | Email validation message is displayed | AC4 |
| TC-005 | Verify password policy validation | Negative | User is on the registration page | 1. Enter weak password<br>2. Submit the form | Weak password | Password validation message is displayed | AC5 |
| TC-006 | Verify duplicate email registration | Negative | User is on the registration page | 1. Enter an existing email<br>2. Submit the form | Existing email | Error message is displayed | AC6 |
| TC-007 | Verify login page is displayed | Positive | User is not authenticated | 1. Navigate to login page | N/A | Login page is displayed | AC7 |
| TC-008 | Verify successful Okta login | Positive | User has a valid Okta account | 1. Enter valid credentials<br>2. Complete authentication | Valid credentials | User is authenticated and redirected | AC8 |
| TC-009 | Verify invalid login attempt | Negative | User is on the login page | 1. Enter invalid credentials<br>2. Submit the form | Invalid credentials | Error message is displayed | AC9 |
| TC-010 | Verify unauthorized user access | Negative | User has authenticated through Okta | 1. Attempt to access restricted page | Unauthorized user | Access denied message is displayed | AC10 |
| TC-011 | Verify protected page access without authentication | Negative | User is not authenticated | 1. Attempt to access protected page directly | N/A | Redirected to login page | AC11 |
| TC-012 | Verify logout functionality | Positive | User is logged in | 1. Select "Logout" | N/A | Session is terminated, user cannot access protected pages | AC12 |
```