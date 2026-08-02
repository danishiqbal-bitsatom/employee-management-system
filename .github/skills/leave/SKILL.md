---
name: leave
description: 'Use when explaining or changing the leave module, leave requests, leave approval, leave rejection, leave balance, leave types, or leave notifications in this Rails app.'
argument-hint: 'Explain leave flow or update leave request behavior'
user-invocable: true
disable-model-invocation: false
---

# Leave Skill

Use this skill when someone wants to understand or change the leave module.

## When to Use

- Explain leave request creation or approval flow
- Change leave request status or validation
- Debug leave balance or approval behavior
- Update leave request views or notifications
- Work on admin or HR leave handling

## Project Context

This module is centered on the leave requests controller and leave request model.

Important files:

- [app/controllers/leave_requests_controller.rb](../../../app/controllers/leave_requests_controller.rb)
- [app/views/leave_requests/index.html.erb](../../../app/views/leave_requests/index.html.erb)
- [app/views/leave_requests/new.html.erb](../../../app/views/leave_requests/new.html.erb)
- [app/views/leave_requests/show.html.erb](../../../app/views/leave_requests/show.html.erb)
- [app/views/leave_requests/_form.html.erb](../../../app/views/leave_requests/_form.html.erb)
- [app/models/leave_request.rb](../../../app/models/leave_request.rb)
- [config/routes.rb](../../../config/routes.rb)

## How It Works

1. A signed-in user creates a leave request.
2. Admin and HR users can see all leave requests.
3. Normal users can see their own leave requests.
4. Admin or HR can approve or reject a request.
5. When approved or rejected, the app sends notifications.
6. Approved leaves can trigger leave balance updates and email jobs.

## Common Changes

### Change leave request fields

Edit [app/views/leave_requests/_form.html.erb](../../../app/views/leave_requests/_form.html.erb) and the strong params in the controller.

### Change approval or rejection logic

Update the `approve`, `reject`, and `update` actions in [app/controllers/leave_requests_controller.rb](../../../app/controllers/leave_requests_controller.rb).

### Change leave type handling

Review the leave type counts and validation in the index and model.

### Change notifications or jobs

Look at the notification calls and background jobs in the controller.

## How the AI Should Respond

When this skill is used, the AI should:

- explain the leave flow in simple words
- point to the controller first
- keep changes small and focused
- avoid breaking approval or balance logic
- mention whether the change affects employee, HR, or admin actions

## Example Prompts

- Explain the leave module in simple words.
- Show me how leave approval works.
- Help me change leave request fields.
- Update the leave request status flow.
- Explain how leave balance is updated after approval.
