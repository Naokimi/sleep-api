# README

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
`DELTE /api/v1/users/:id`
```
curl -i -X DELETE http://localhost:3000/api/v1/users/6
```

**Response**
```
HTTP/1.1 200 OK

{"message":"User 6 successfully deleted"}
```
