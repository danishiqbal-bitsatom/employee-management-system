---
name: attendance
description: 'Use when explaining or changing the attendance module, check-in, check-out, attendance history, attendance filters, or attendance notifications in this Rails app.'
argument-hint: 'Explain attendance flow or update check-in/check-out behavior'
user-invocable: true
disable-model-invocation: false
---

# Attendance Skill

Use this skill when someone wants to understand or change the attendance module.

## When to Use

- Explain check-in and check-out flow
- Change attendance history or filters
- Debug duplicate attendance problems
- Update attendance notifications
- Work on employee attendance pages

## Project Context

This module uses the attendances controller and the attendance model.

Important files:

- [app/controllers/attendances_controller.rb](../../../app/controllers/attendances_controller.rb)
- [app/views/attendances/index.html.erb](../../../app/views/attendances/index.html.erb)
- [app/views/attendances/new.html.erb](../../../app/views/attendances/new.html.erb)
- [app/models/attendance.rb](../../../app/models/attendance.rb)
- [config/routes.rb](../../../config/routes.rb)

## How It Works

1. A signed-in user opens the attendance page.
2. Admin and HR users can see all attendance records.
3. Normal employees can see only their own attendance.
4. A user can check in once per day.
5. A user can check out after check-in.
6. The app sends notifications when attendance is created or updated.

## Common Changes

### Change check-in or check-out rules

Edit [app/controllers/attendances_controller.rb](../../../app/controllers/attendances_controller.rb).

### Change attendance filters or history view

Edit [app/views/attendances/index.html.erb](../../../app/views/attendances/index.html.erb) and the index action.

### Change duplicate attendance handling

Look at the check-in logic that checks for an existing record for the same day.

### Change notifications

Review the notification calls in the controller.

## How the AI Should Respond

When this skill is used, the AI should:

- explain the check-in/check-out flow in simple words
- point to the attendance controller first
- keep changes small and focused
- avoid breaking existing attendance rules
- mention whether the change affects employees, admin, or HR

## Example Prompts

- Explain the attendance module in simple words.
- Show me how check-in works in this app.
- Help me prevent duplicate attendance records.
- Update the attendance history filter.
- Explain how check-out is calculated.
