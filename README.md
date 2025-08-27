# README

Jira Clone-Ruby on Rails

This is a simple project management tool inspired by Jira and created using Ruby on Rails. It includes features like user login, different roles for users, a system for managing tickets, a place for comments, and a way to keep track of changes.
**Features**

User Authentication using Devise

Role-based Access Control (Admin, Developer, Reporter)

Ticket Management: Create, assign, and track ticket status (To Do, In Progress, Done)

Comments System for collaborative updates

History Tracking to record every status or assignment change

Responsive UI using Bootstrap 

Clean RESTful Architecture with Rails 7 best practices

**Tech Stack**

Ruby: 3.2.x

Rails: 7.0.x

Database: PostgreSQL

Authentication: Devise

Authorization: Pundit

Front-end: Bootstrap 

Other Gems: List notable ones

Byebug

Rubocop

**Getting Started**

Ensure you have installed:

Ruby (via rbenv or rvm)

Rails (gem install rails)

Bundler (gem install bundler)

PostgreSQL (with a running user/password)

Setup Steps

**Clone the repository**

git clone https://github.com/Fassih21/jira_clone.git
cd jira-clone

**Install dependencies**

bundle install


**Configure database**

Update config/database.yml with your PostgreSQL username/password.

Create and migrate the database:

rails db:create db:migrate db:seed


Start the server

bin/dev       
# or
rails server


**Access the application**
Visit http://localhost:3000
 in your browser.


Project Structure

app/
  controllers/
    tickets_controller.rb
    comments_controller.rb
    ...
  models/
    ticket.rb
    comment.rb
    ...
  views/
    tickets/
    comments/
    ...
  helpers/
  services/      # if any custom services
config/
db/


RESTful routes keep the code organized and predictable.

Pundit policies ensure role-based access control.

Concerns/Services (if used) help maintain DRY code.

Testing

rails test       # For Minitest
# or
bundle exec rspec  # If using RSpec


**Contributing**
Fork the repository

Create a feature branch (git checkout -b feature-name)

Commit your changes (git commit -m "Add feature")

Push to your branch (git push origin feature-name)

Create a Pull Request for review

this is right should push it now?