# README

### Prerequisites

- Ruby 3.2.1
- gem rails 7.0.4.2
- gem bundler 2.4.7
- PostgreSQL 12.13

I recommend following [LeWagon's setup](https://github.com/lewagon/setup) to get your environment ready, but you'll probably have to install the required ruby version with rbenv

### Set up

Start in your folder with dev projects and run the following commands:

- `gh repo clone Naokimi/sleep-api`
- `cd sleep-api`
- `bundle install`
- `rails db:create db:migrate`

### Running

Start in the project folder and run the following command:

- `rails s`

The server listens on port 3000.

# API Endpoints

## User

### #create
Creates a user

**Request**
`POST /api/v1/users`
```
curl -i -X POST http://localhost:3000/api/v1/users -d 'user[name]=Bob'
```

**Response**
```
HTTP/1.1 201 Created

{"user":{"id":6,"name":"Bob","created_at":"2023-03-08T08:20:32.518Z","updated_at":"2023-03-08T08:20:32.518Z"}}
```

### #destroy
Deletes a user

**Request**
`DELETE /api/v1/users/:id`
```
curl -i -X DELETE http://localhost:3000/api/v1/users/6
```

**Response**
```
HTTP/1.1 200 OK

{"message":"User 6 successfully deleted"}
```

## Relationship

### #follow
User follows another user

**Request**
`POST /api/v1/users/:user_id/follow/:follower_id`
```
curl -i -X POST http://localhost:3000/api/v1/users/5/follow/8'
```

**Response**
```
HTTP/1.1 201 Created

{"message":"User 8 is now following user 5"}
```

### #unllow
User unfollows another user

**Request**
`DELETE /api/v1/users/:user_id/unfollow/:follower_id`
```
curl -i -X DELETE http://localhost:3000/api/v1/users/5/unfollow/8'
```

**Response**
```
HTTP/1.1 200 OK

{"message":"User 8 stopped following user 5"}
```

## Sleep Session

### #clock_in
Creates a sleep session for the given user

**Request**
`POST /api/v1/users/:user_id/sleep_sessions/clock_in`
```
curl -i -X POST http://localhost:3000/api/v1/users/5/sleep_sessions/clock_in
```

**Response**
```
HTTP/1.1 201 Created

{"sleep_session":{"id":2,"ended_at":null,"user_id":5,"created_at":"2023-03-09T07:06:37.891Z","updated_at":"2023-03-09T07:06:59.544Z","length":null}}
```

### #clock_out
Updates the clock_out time of the sleep session

**Request**
`PATCH /api/v1/users/:user_id/sleep_sessions/clock_out`
```
curl -i -X PATCH http://localhost:3000/api/v1/users/5/sleep_sessions/clock_out
```

**Response**
```
HTTP/1.1 200 OK

{"sleep_session":{"id":2,"ended_at":"2023-03-09T07:06:59.543Z","user_id":5,"created_at":"2023-03-09T07:06:37.891Z","updated_at":"2023-03-09T07:06:59.544Z","length":21}}
```

### #index
Lists all sleep sessions for the given user

**Request**
`GET /api/v1/users/:user_id/sleep_sessions`
```
curl -i http://localhost:3000/api/v1/users/5/sleep_sessions
```

**Response**
```
HTTP/1.1 200 OK

{"sleep_sessions":[{"id":2,"ended_at":"2023-03-09T07:06:59.543Z","user_id":5,"created_at":"2023-03-09T07:06:37.891Z","updated_at":"2023-03-09T07:06:59.544Z","length":21}]}
```

### #friends
Lists sleep sessions up to 1 week old for the users followed by the given user

**Request**
`GET /api/v1/users/:user_id/sleep_sessions/friends`
```
curl -i http://localhost:3000/api/v1/users/8/sleep_sessions/friends
```

**Response**
```
HTTP/1.1 200 OK

{"sleep_sessions":[{"id":2,"ended_at":"2023-03-09T07:06:59.543Z","user_id":5,"created_at":"2023-03-09T07:06:37.891Z","updated_at":"2023-03-09T07:06:59.544Z","length":21},{"id":4,"ended_at":"2023-03-09T07:07:36.559Z","user_id":5,"created_at":"2023-03-09T07:07:32.255Z","updated_at":"2023-03-09T07:07:36.560Z","length":4}]}
```
