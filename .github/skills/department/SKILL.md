---
name: department
description: 'Use when explaining or changing the department module, department CRUD, department list, department form, department routes, or admin-only access in this Rails app.'
argument-hint: 'Explain department flow or update department management'
user-invocable: true
disable-model-invocation: false
---

# Department Skill

Use this skill when someone wants to understand or change the department module.

## When to Use

- Explain department listing or detail pages
- Create, update, or delete departments
- Change department form fields or validation
- Debug admin-only access rules
- Update department views or redirects

## Project Context

This module is centered on the departments controller and department model.

Important files:

- [app/controllers/departments_controller.rb](../../../app/controllers/departments_controller.rb)
- [app/views/departments/index.html.erb](../../../app/views/departments/index.html.erb)
- [app/views/departments/show.html.erb](../../../app/views/departments/show.html.erb)
- [app/views/departments/new.html.erb](../../../app/views/departments/new.html.erb)
- [app/views/departments/edit.html.erb](../../../app/views/departments/edit.html.erb)
- [app/views/departments/_form.html.erb](../../../app/views/departments/_form.html.erb)
- [app/models/department.rb](../../../app/models/department.rb)
- [config/routes.rb](../../../config/routes.rb)

## How It Works

1. A signed-in user opens the department area.
2. The controller checks authentication.
3. Admin users can manage departments.
4. The module supports index, new, create, show, edit, update, and destroy actions.
5. The department name is sent through the form and saved in the database.

## Common Changes

### Change department fields

Edit [app/views/departments/_form.html.erb](../../../app/views/departments/_form.html.erb) and the strong params in the controller.

### Change access rules

Check `before_action :require_admin` in [app/controllers/departments_controller.rb](../../../app/controllers/departments_controller.rb).

### Change redirects or flash messages

Update the create, update, and destroy actions in the controller.

### Change routes

Review [config/routes.rb](../../../config/routes.rb).

## How the AI Should Respond

When this skill is used, the AI should:

- explain the department flow in simple words
- point to the controller and form first
- keep the solution small and focused
- avoid changing unrelated authentication or employee code
- mention that department management is admin-only

## Example Prompts

- Explain the department module in simple words.
- Show me where department create and update are handled.
- Help me change the department form.
- Explain why only admin users can manage departments.
- Update the department success messages.
