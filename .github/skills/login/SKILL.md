---
name: login
description: 'Use when explaining, debugging, or changing login, sign-in, sign-out, authentication, Devise, sessions, redirects, or API login in this Rails app.'
argument-hint: 'Explain login flow or update authentication behavior'
user-invocable: true
disable-model-invocation: false
---

# Login Skill

Use this skill when someone wants to understand or change the login flow in this Rails app.

## When to Use

- Explain how users sign in or sign out
- Update login behavior or redirects
- Debug authentication problems
- Change the login page text or layout
- Work on Devise or API login

## Project Context

This app uses Devise for web authentication.
It also has an API login endpoint for client apps.

Important files:

- [config/routes.rb](../../../config/routes.rb)
- [Gemfile](../../../Gemfile)
- [config/initializers/devise.rb](../../../config/initializers/devise.rb)
- [app/controllers/users/sessions_controller.rb](../../../app/controllers/users/sessions_controller.rb)
- [app/views/devise/sessions/new.html.erb](../../../app/views/devise/sessions/new.html.erb)
- [app/views/devise/shared/_links.html.erb](../../../app/views/devise/shared/_links.html.erb)
- [app/controllers/api/v1/auth_controller.rb](../../../app/controllers/api/v1/auth_controller.rb)

## How Login Works

1. A user opens the app.
2. If the user is not signed in, the app sends them to the Devise sign-in page.
3. The user enters email and password.
4. Devise checks the credentials.
5. If the login succeeds, the user is redirected to the authenticated home page.
6. If the login fails, the app shows an error message.

In [config/routes.rb](../../../config/routes.rb), the app uses:

- `authenticated :user` for signed-in users
- `unauthenticated` for visitors who are not logged in
- `devise_scope :user` to send visitors to the login form

## What to Change for Common Tasks

### Change the login page text

Edit [app/views/devise/sessions/new.html.erb](../../../app/views/devise/sessions/new.html.erb).

### Change the redirect after login

Check [config/routes.rb](../../../config/routes.rb) and the sessions controller.

### Add custom login logic

Use [app/controllers/users/sessions_controller.rb](../../../app/controllers/users/sessions_controller.rb).

### Update API login

Use [app/controllers/api/v1/auth_controller.rb](../../../app/controllers/api/v1/auth_controller.rb).

### Change Devise settings

Use [config/initializers/devise.rb](../../../config/initializers/devise.rb).

## How the AI Should Respond

When this skill is used, the AI should:

- explain the flow in simple words
- point to the right file before suggesting code changes
- keep the solution small and focused
- avoid changing unrelated authentication code
- mention whether the change affects web login or API login

## Example Prompts

- Explain how login works in this app in simple words.
- Show me where the login redirect happens after sign in.
- Update the login page text so it is easier for new users.
- Help me fix a login issue where the user is not redirected correctly.
- Add a friendly error message when login fails.
- Explain the API login flow for a beginner.
