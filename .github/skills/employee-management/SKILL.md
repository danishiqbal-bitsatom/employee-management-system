---
name: employee-management
description: 'Use when explaining or changing the employee management module, employee details, staff list, employee profile, CRUD, search, status filters, or admin/hr access in this Rails app.'
argument-hint: 'Explain employee management flow or update employee details'
user-invocable: true
disable-model-invocation: false
---

# Employee Management Skill

Use this skill when someone wants to understand or change the employee management module.

## When to Use

- Explain the employee list or employee profile flow
- Create, update, or delete employee details
- Change search, filtering, sorting, or pagination
- Debug admin or HR access rules
- Update employee-related views or redirects

## Project Context

This module is driven by the employee detail screens and the main user details controller.

Important files:

- [app/controllers/user_details_controller.rb](../../../app/controllers/user_details_controller.rb)
- [app/views/user_details/index.html.erb](../../../app/views/user_details/index.html.erb)
- [app/views/user_details/show.html.erb](../../../app/views/user_details/show.html.erb)
- [app/views/user_details/new.html.erb](../../../app/views/user_details/new.html.erb)
- [app/views/user_details/edit.html.erb](../../../app/views/user_details/edit.html.erb)
- [app/views/user_details/_form.html.erb](../../../app/views/user_details/_form.html.erb)
- [app/models/user.rb](../../../app/models/user.rb)
- [app/models/department.rb](../../../app/models/department.rb)

## How It Works

1. A signed-in user opens the employee area.
2. The controller checks whether the user is admin, HR, or a normal employee.
3. Admin and HR users can see all employees.
4. Normal users can usually see only their own record.
5. The module supports create, edit, update, show, and delete actions.

## Common Changes

### Show more or fewer employees

Check the `index` action in [app/controllers/user_details_controller.rb](../../../app/controllers/user_details_controller.rb).

### Change employee form fields

Edit [app/views/user_details/_form.html.erb](../../../app/views/user_details/_form.html.erb) and the permitted params in the controller.

### Change access rules

Review `authenticate_user!`, `require_hr_or_admin`, and `require_admin` in the controller.

### Change employee search or filters

Look at the `search`, `filter_by_status`, and `sorted` calls in the `index` action.

## How the AI Should Respond

When this skill is used, the AI should:

- explain the employee flow in simple words
- point to the controller first
- keep changes small and focused
- avoid changing unrelated modules
- mention whether the change affects admin, HR, or normal employees

## Example Prompts

- Explain the employee management module in simple words.
- Show me where the employee list is loaded.
- Help me change employee form fields.
- Update the employee search and filter flow.
- Explain who can edit or delete employee records.
