# Project Management System

This is a simplified project management system built using **Rails 6**, **Ruby 3.0.6**, **React**, and **PostgreSQL**. It includes API endpoints for authentication, project management, and task management. The system has user roles (Admin, User) with different levels of access to project resources.

## Features

- **User Authentication** (Login/Logout)
- **Admin CRUD operations** on projects
- **User assignment** to projects and tasks
- **Active Project Listings**
- **Task Creation for Users**

## Setup

### Prerequisites
- Ruby 3.0.6
- Rails 6
- PostgreSQL
- Node.js & yarn (for frontend)

### Steps to Run the Application

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/project-management.git
    cd project-management
    ```

2. **Install Ruby gems**:
    ```bash
    bundle install
    ```

3. **Set up the database**:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed  # To seed some initial data for project demo
    ```

4. **Set up frontend**:
    ```bash
    yarn install
    run in root dir: ./bin/webpack-dev-server
    ```

5. **Start the Rails server**:
    ```bash
    rails server
    ```

6. **Visit the application**:
   Open `http://localhost:3000` in your browser.

### API Documentation

**Authentication**
- **POST** `/api/v1/login` – Logs in a user and returns a JWT token.
- **DELETE** `/api/v1/logout` – Logs out a user by revoking the JWT token.

**Projects**
- **GET** `/api/v1/projects` – Returns a list of active projects.

- For detailed API documentation postman collection added

### Tests

To run the tests:

```bash
bundle exec rspec
