# Employee Management System

This repository contains a Ruby on Rails application that implements a simple
employee management system used internally for tracking employees, attendances,
leave requests, departments, profiles and automated background jobs.

Current progress
- Core Rails app scaffolded with controllers, models, views and jobs.
- Authentication and user/profile management controllers present.
- Attendance and leave management implemented (controllers and background jobs).
- Background jobs include reminders, leave assignment and notification delivery.
- Importmap + Rails frontend assets are present.

Key directories

- [app/](app) — main application code (controllers, models, views, mailers, jobs).
- [config/](config) — Rails configuration and routes.
- [db/](db) — database schema, seeds and migrations.
- [bin/](bin) — executable helpers (rails, rake, dev tools).
- [test/](test) — test suite skeleton.

Tech stack

- Ruby (see `.ruby-version` if present)
- Ruby on Rails
- SQLite (development/test by default) — see `config/database.yml`.
- Importmap for JavaScript (no Webpack/Yarn required by default).

Prerequisites

- Ruby (matching the project's Ruby version)
- Bundler
- SQLite3 (or the database you're configuring)

Quickstart — Local (development)

1. Install dependencies

```bash
gem install bundler
bundle install
```

2. Set up the database

```bash
bundle exec rails db:create db:migrate db:seed
```

3. Start the Rails server

```bash
bin/rails server
# or using the dev script if present:
bin/dev
```

4. Visit the app

Open http://localhost:3000 in your browser.

Docker (optional)

This repository includes a `Dockerfile` and `docker-entrypoint` to help
containerize the app. Basic build/run workflow:

```bash
# build image
docker build -t employee-app .

# run container (example)
docker run -p 3000:3000 --env RAILS_ENV=development employee-app
```

Database notes

- The project uses `config/database.yml` for DB configuration. Development and
	test currently point to SQLite files in `db/` and `storage/`.
- To switch to Postgres or MySQL, update `config/database.yml` and install
	the appropriate adapter gem.

Background jobs and scheduled tasks

- Jobs are defined under [app/jobs/](app/jobs). Examples:
	- `attendance_reminder_job.rb` — sends reminders for attendance
	- `assign_initial_leaves_job.rb` — assigns starting leave balances
	- `deduct_leave_balance_job.rb` — runs leave deductions
- Configure a job runner (Sidekiq, Async, or built-in ActiveJob adapter) in
	`config/application.rb` or `config/environments/*.rb` depending on your setup.

Running tests

```bash
bundle exec rails test
```

Linting and static analysis

- `rubocop` is present under `bin/` — run `bin/rubocop` to lint the codebase.
- Security tools like `brakeman` and `bundler-audit` are available in `bin/`.

Configuration & credentials

- Encrypted credentials are in `config/credentials.yml.enc` and require the
	master key to be provided via `RAILS_MASTER_KEY` or `config/master.key`.
- Environment-specific settings live in `config/environments/`.

Useful commands

```bash
# DB: reset (destructive)
bundle exec rails db:reset

# Run a single test file
bundle exec rails test test/models/user_test.rb

# Run migrations
bundle exec rails db:migrate
```

Contributing

If you'd like to contribute, please open an issue describing the change and
submit a pull request. Follow the existing code style and run tests before
submitting.

Where to look next

- Authentication and user flows: [app/controllers/users](app/controllers/users)
- Attendance & leave logic: [app/controllers/attendances_controller.rb](app/controllers/attendances_controller.rb) and [app/controllers/leave_requests_controller.rb](app/controllers/leave_requests_controller.rb)
- Background jobs: [app/jobs/](app/jobs)

Contact

For questions, reach out to the repository owner or open an issue on GitHub.

-------------------------------
