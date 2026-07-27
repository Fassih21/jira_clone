# Jira Clone

A simplified project-management and ticket-tracking tool inspired by Jira, built with Ruby on Rails. Supports role-based access control, ticket lifecycle management, comments, and full status-change history tracking.

## Goal

Build a Jira-style ticketing system where different user roles (admin, developer, QA, and regular users) each see and act on tickets differently — with every status change logged for accountability.

## Features

- **Authentication (Devise)**
  - Sign up, log in, log out, password recovery
- **Role-Based Access Control (Pundit)**
  - Roles: `admin`, `dev`, `qa`, `user`
  - Access to viewing, editing, and closing tickets is scoped per role via `TicketPolicy` and a policy `Scope` — each role only sees the tickets relevant to them (created, assigned as dev, or assigned as QA), while admins see everything
- **Ticket Management**
  - Create, edit, assign (to a dev and/or QA reviewer), and delete tickets
  - Statuses: `open`, `in_progress`, `closed`
  - `mark_done` action advances a ticket's status differently depending on who marks it: a dev moves it to `in_progress`, QA closes it, and an admin can close it directly
- **History Tracking**
  - Every status change (manual update or via `mark_done`) creates a `History` record with the old status, new status, who made the change, and when — viewable per ticket
- **Comments**
  - Ticket-scoped comments with title and body, tied to the commenting user
- **Contact Form**
  - Plain Ruby object (`Contactform`, using `ActiveModel::Model`) for a non-persisted contact form with name/email/message validation

## Design Decisions

- **Models**
  - `User` → has a `role` enum; distinguishes `created_tickets`, `assigned_tickets_as_dev`, and `assigned_tickets_as_qa` as separate associations on the same `Ticket` model
  - `Ticket` → belongs to a `creator`, optional `dev`, and optional `qa` (three separate `belongs_to` associations to `User`, disambiguated with `foreign_key`)
  - `Comment` → belongs to a ticket and a user
  - `History` → belongs to a ticket and a user, stores `from_status` / `to_status`
- **Authorization**
  - Implemented entirely through Pundit policies rather than scattering role checks across controllers — `TicketPolicy` centralizes who can view, create, update, destroy, or mark a ticket done, and its `Scope` class centralizes what each role is allowed to *see* in the index
- **Status Transitions**
  - Handled through a dedicated `mark_done` member route rather than overloading the generic `update` action, keeping the "advance the workflow" behavior separate from a general field edit
- **History as a Side Effect, Not a Separate Step**
  - History records are created inline whenever a status actually changes (in both `update` and `mark_done`), so history-keeping can't be skipped by going through a different code path

## Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/Fassih21/jira_clone.git
cd jira_clone
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Setup the database
```bash
bin/rails db:create db:migrate db:seed
```

### 4. Run the server
```bash
bin/dev
```

### 5. Open in browser
```
http://localhost:3000
```

## Tech Stack

- Ruby 3.4.4, Rails 7.1
- SQLite (development), PostgreSQL (production)
- Devise (authentication)
- Pundit (authorization)
- Bootstrap (UI)
- Turbo & Stimulus (Hotwire)
- Solid Queue / Solid Cache / Solid Cable
- Kamal (deployment)

## Example User Flow

1. A user signs up and logs in
2. User creates a ticket → it starts as `open`
3. An admin (or the ticket policy scope) assigns a dev and/or QA reviewer
4. The dev works the ticket and marks it done → status moves to `in_progress`
5. QA reviews and marks it done → status moves to `closed`
6. Every transition along the way is recorded in that ticket's history
7. Comments can be added at any point by anyone with access to the ticket

## Notes

- Role permissions are enforced at the policy layer, not just hidden in the UI — directly hitting a restricted action redirects/raises via Pundit
- `mark_done` behavior is role-dependent rather than a single fixed transition, which keeps the workflow realistic (a dev "finishing" a ticket isn't the same as QA closing it)
- Can be extended with: ticket priority levels, due dates, file attachments, email notifications on assignment/status change

## Known Limitations / Next Steps

- No automated test coverage yet for `TicketsController` or the policy scopes (only `comments` and `histories` controller tests currently exist)
- `Contactform` model exists but isn't wired to a controller/route yet
- No pagination on the tickets index — will need one as ticket volume grows

## Contact

Feel free to reach out for feedback, collaboration, or freelance/internship opportunities.