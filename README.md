# Tasks API

A simple Rails 8.0.2 API-only application to manage tasks using PostgreSQL.

## Features

- RESTful API for managing tasks
- Task model with:
  - `title` (string, required)
  - `description` (text, optional)
  - `completed` (boolean, default: false)
- Endpoints:
  - `GET /api/tasks` – List all tasks
  - `POST /api/tasks` – Create a new task
  - `DELETE /api/tasks/:id` – Delete a task
- Basic validation for the `title` field
- CORS configured for cross-origin access
- Seed data included (3 sample tasks)


## Requirements

- Ruby 3.4.3+ 
- Rails 8.0.2  
- PostgreSQL

## Setup
1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/tasks_api.git
   cd tasks_api

## Install dependencies
CORS is enabled via rack-cors for all origins in development.
Update config/initializers/cors.rb to restrict origins in production.

 ```
 bundle install
 ```

## Setup the database
Update the database settings to your environment variables in the config/database.yml file
or if in development you can simply hardcode to be changed later. However do not pass clear text passwords to github.

```
rails db:create
rails db:migrate
rails db:seed
```

## Run the server
```
rails server
```
By default, it runs at http://localhost:3000.

### API Endpoints

| Method | Endpoint         | Description       |
| ------ | ---------------- | ----------------- |
| GET    | `/api/tasks`     | List all tasks    |
| POST   | `/api/tasks`     | Create a new task |
| DELETE | `/api/tasks/:id` | Delete a task     |


### Sample POST Body
```json
{
  "task": {
    "title": "New Task",
    "description": "Optional description"
  }
}
```
