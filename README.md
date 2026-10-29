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
