<style>
a {
    text-decoration: none;
    color: #464feb;
}
tr th, tr td {
    border: 1px solid #e6e6e6;
}
tr th {
    background-color: #f5f5f5;
}
</style>

# Team Notes API

A JSON REST API for managing team-scoped notes. Built with Ruby on Rails 7.1.

## Requirements

- Ruby 3.3.0
- PostgreSQL

## Setup

```bash
# Install dependencies
bundle install
```

Edit `config/database.yml` if your PostgreSQL credentials differ from the defaults (`username: postgres`, `host: 127.0.0.1`).

```bash
# Create and migrate the database
bin/rails db:create db:migrate

# (Optional) Load sample seed data
bin/rails db:seed

# Start the server
bin/rails server
```

The API will be available at `http://localhost:3000`.

## Running Tests

```bash
bin/rails test
```

---

## API Endpoints

All requests and responses use JSON. Include `Content-Type: application/json` on requests with a body.

### `POST /notes`

Create a note.

**Request body:**
```json
{ "note": { "title": "...", "content": "...", "team_id": 1, "created_by_user_id": 1 } }
```

| Status | Meaning |
|--------|---------|
| `201 Created` | Note created; returns the note object |
| `422 Unprocessable Content` | Validation failed; returns `{ "errors": [...] }` |

---

### `GET /notes/:id`

Fetch a single note.

| Status | Meaning |
|--------|---------|
| `200 OK` | Returns the note object |
| `404 Not Found` | Note does not exist |

---

### `PATCH /notes/:id`

Update a note. Supply any subset of writable fields.

**Request body:**
```json
{ "note": { "title": "...", "content": "..." } }
```

| Status | Meaning |
|--------|---------|
| `200 OK` | Returns the updated note object |
| `422 Unprocessable Content` | Validation failed; returns `{ "errors": [...] }` |
| `404 Not Found` | Note does not exist |

---

### `DELETE /notes/:id`

Delete a note.

| Status | Meaning |
|--------|---------|
| `204 No Content` | Note deleted |
| `404 Not Found` | Note does not exist |

---

### `GET /teams/:team_id/notes`

List all notes belonging to a team.

| Status | Meaning |
|--------|---------|
| `200 OK` | Returns an array of note objects |
| `404 Not Found` | Team does not exist |

---

### `GET /users/:user_id/notes`

List all notes across every team the user belongs to.

| Status | Meaning |
|--------|---------|
| `200 OK` | Returns an array of note objects |
| `404 Not Found` | User does not exist |

---

## Note Object

```json
{
  "id": 1,
  "title": "Sprint Planning",
  "content": "Goals for this sprint...",
  "team_id": 1,
  "created_by_user_id": 1,
  "created_at": "2026-10-29T12:00:00.000Z",
  "updated_at": "2026-10-29T12:00:00.000Z"
}
```

---

## Design Decisions

### 1. Notes Are Owned by Teams

The assignment specifies that notes are shared among small teams. To support collaboration, notes are associated with a team rather than an individual user. This allows every member of a team to access the same notes and provides a clear ownership model for shared information.

### 2. Note Access Is Governed by Team Membership

A user belongs to many teams and a team has many users, modeled through a `team_memberships` join table. Notes belong to a team, so a user's access to notes is derived entirely from their team memberships. This keeps the access model simple — `GET /users/:user_id/notes` resolves to a single query across the user's teams — and the `role` column on `team_memberships` provides a hook for future per-team permission levels without schema changes. Individual authorship is captured by `created_by_user_id` on each note.

### 3. Rails API-Only Architecture

A Rails API-only application was chosen because the requirements focus on backend service functionality. This approach removes unnecessary view-layer components while still benefiting from Rails conventions, routing, Active Record, validation, and testing support.

---

## Future Improvements

Given additional time, I would prioritize the following enhancements:

### Authentication and Authorization

The current implementation focuses on core CRUD functionality. In a production environment, API access should require authentication, and authorization rules should control which users can create, edit, or delete notes.

Possible approaches include:

- JWT-based authentication
- API keys
- Role-based permissions (Owner, Editor, Viewer)

### Note Version History

Collaborative note systems benefit from retaining previous revisions. A version history would allow users to view changes, track authorship, and restore previous versions when necessary.

### Search Functionality

As the number of notes grows, users need efficient ways to find information. PostgreSQL full-text search or a dedicated search solution could be added to support searching note titles and content.

### Pagination

Currently all matching notes are returned in a single response. Pagination would improve performance and scalability for larger datasets.

---

## Tradeoffs

### Simplicity vs. Completeness

This implementation prioritizes delivering a functional, well-tested REST API within the time constraints of the exercise. Features such as authentication, authorization, note history, and advanced search were intentionally deferred in favor of completing the core CRUD experience.

### Team Collaboration Model

The current data model is designed around team collaboration. This keeps the API straightforward, but future requirements may require more granular permissions at the individual note level.

---

## Testing

The application includes automated tests covering:

- Note creation
- Note retrieval
- Note updates
- Note deletion
- Error handling and validations

Additional tests would be added for authentication, authorization, and edge cases if those features were implemented.

---

## What Would I Change With More Time?

If I had additional time, I would add authentication, role-based authorization, note version history, search capabilities, and pagination. I would also expand the test suite to cover authorization scenarios and improve API documentation through OpenAPI/Swagger. Conversely, I would avoid adding unnecessary complexity such as real-time collaboration or microservice decomposition until there was a demonstrated business need. This implementation intentionally focuses on delivering a clean, maintainable foundation before introducing additional architectural complexity.
