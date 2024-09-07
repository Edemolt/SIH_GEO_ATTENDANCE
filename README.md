Project Setup
Clone the repository.
Install dependencies:
bash
Copy code
npm install
Set up Prisma and MongoDB:
Initialize Prisma:
bash
Copy code
npx prisma init
Modify prisma.schema to use the MongoDB provider.
Apply migrations to your MongoDB:
bash
Copy code
npx prisma generate
Start the server:
bash
Copy code
npm start
By default, the server will run on http://localhost:3000.

API Endpoints
1. Register User
URL: POST /users/signup
Description: Registers a new user.
Body Example:
json
Copy code
{
  "uuid": "123e4567-e89b-12d3-a456-426614174000",
  "email": "test@example.com",
  "name": "John Doe",
  "password": "your_password",
  "currentLocation": "Office A",
  "workMode": "WFO"
}
Response Example:
json
Copy code
{
  "uuid": "123e4567-e89b-12d3-a456-426614174000",
  "email": "test@example.com",
  "name": "John Doe",
  "currentLocation": "Office A",
  "workMode": "WFO"
}
2. Login User
URL: POST /users/login
Description: Logs a user into the system.
Body Example:
json
Copy code
{
  "email": "test@example.com",
  "password": "your_password"
}
Response Example:
json
Copy code
{
  "user": {
    "id": "66dc8ff42ced445c792643c2",
    "uuid": "123e4567-e89b-12d3-a456-426614174000",
    "email": "test@example.com",
    "name": "John Doe",
    "currentLocation": "Office A"
  }
}
3. Get All Users
URL: GET /users/
Description: Retrieves a list of all registered users.
Response Example:
json
Copy code
[
  {
    "uuid": "123e4567-e89b-12d3-a456-426614174000",
    "email": "test@example.com",
    "name": "John Doe",
    "currentLocation": "Office A",
    "workMode": "WFO"
  }
]
4. Get User by UUID
URL: GET /users/:uuid
Description: Retrieves a specific user by UUID.
Response Example:
json
Copy code
{
  "uuid": "123e4567-e89b-12d3-a456-426614174000",
  "email": "test@example.com",
  "name": "John Doe",
  "currentLocation": "Office A",
  "workMode": "WFO"
}
5. Update User
URL: PUT /users/:uuid
Description: Updates the user information (e.g., location, work mode).
Body Example:
json
Copy code
{
  "currentLocation": "Office B",
  "workMode": "WFH"
}
Response Example:
json
Copy code
{
  "uuid": "123e4567-e89b-12d3-a456-426614174000",
  "email": "test@example.com",
  "name": "John Doe",
  "currentLocation": "Office B",
  "workMode": "WFH"
}
6. Delete User
URL: DELETE /users/:uuid
Description: Deletes a user by UUID.
Response Example:
json
Copy code
{
  "message": "User deleted successfully"
}
7. Update Timestamp (Clock In/Out)
URL: POST /users/:uuid/timestamp
Description: Updates the user's entry or exit time based on whether they clocked in or out.
Body Example (Clock In):
json
Copy code
{
  "currentTime": "2024-09-01T08:00:00",
  "entered": "true"
}
Body Example (Clock Out):
json
Copy code
{
  "currentTime": "2024-09-01T17:00:00",
  "entered": "false"
}
Response Example:
json
Copy code
{
  "status": "OK",
  "updatedTimes": {
    "2024-09-01": [
      "08:00:00",
      "17:00:00"
    ]
  }
}
8. Get Total Time Spent
URL: GET /users/:uuid/totalTime/:date
Description: Calculates the total time the user spent in the office (or working remotely) for a specific date.
Response Example:
json
Copy code
{
  "date": "2024-09-01",
  "totalTime": 9
}
Authentication & Login/Logout for Frontend Developers
The login functionality generates a session that the frontend can use to track if a user is logged in.

Login Flow (Frontend)

Send a POST request to /users/login with the user's credentials.
If the login is successful, the response contains the user data (without the password).
Store the user object in the frontend state or local storage.
Example:

js
Copy code
const loginUser = async (email, password) => {
  const response = await fetch('http://localhost:3000/users/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const data = await response.json();
  localStorage.setItem('user', JSON.stringify(data.user));
};
Logout Flow (Frontend)

To "logout" the user, simply remove the user data from local storage or state.
Example:

js
Copy code
const logoutUser = () => {
  localStorage.removeItem('user');
};