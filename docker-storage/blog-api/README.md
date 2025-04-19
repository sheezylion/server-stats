# Task Objective: Refactor a legacy or non-Dockerized app to work with Docker, handle persistent storage, and use secure environment variable injection.

## Project Overview:

We are building a simple blog API using Node.js and SQLite. This API will allow us to:

- **Create blog** posts using a POST request.

- **Retrieve** blog posts using a GET request.

Additionally, we'll be dockerizing this application to deploy it inside a container, ensuring portability and scalability.

## Step-by-Step Process

### Step 1: Create a New Folder for Your Project

We open our terminal and create a new directory for our project.

```
mkdir blog-api
cd blog-api
```

### Step 2: Initialize a Node.js Project

Initialize the project by creating a package.json file.

```
npm init -y
```

<img src="images/Screenshot 2025-04-19 at 09.36.18.png" alt="npm init screenshot ofr package.json file">

This creates a default package.json file.

### Step 3: Install the Needed Packages

Install the necessary packages for Express, SQLite3, and dotenv:

```
npm install express sqlite3 dotenv
```

<img src="images/Screenshot 2025-04-19 at 09.39.25.png" alt="screenshot showing express.js,sqlite being installed">

(Note: We ensure we're installing sqlite3, not sqlite to avoid issues.)

### Step 4: Create the app.js File

Now create the app.js file, which will handle the API logic.

```
touch app.js
```

Paste the following code inside app.js:

```
const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Enable JSON body parsing
app.use(express.json());

// Create SQLite database
const db = new sqlite3.Database("./blog.db", (err) => {
  if (err) {
    console.error("Database opening error:", err);
  } else {
    console.log("Connected to SQLite database.");
  }
});

// Create the posts table if it doesn’t exist
db.run(`
  CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL
  )
`);

// GET all posts
app.get("/posts", (req, res) => {
  db.all("SELECT * FROM posts", [], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// POST a new blog post
app.post("/posts", (req, res) => {
  const { title, content } = req.body;

  if (!title || !content) {
    return res.status(400).json({ error: "Title and content are required." });
  }

  const query = "INSERT INTO posts (title, content) VALUES (?, ?)";
  db.run(query, [title, content], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(201).json({ id: this.lastID, title, content });
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
```

<img src="images/Screenshot 2025-04-19 at 10.18.25.png" alt="screenshot of app.js file">

This file sets up an Express server with two main routes:

- GET /posts: Fetches all blog posts.

- POST /posts: Adds a new blog post to the database.

### Step 5: Update package.json to Add Start Script

Open package.json and add the start script:

```
"scripts": {
  "start": "node app.js"
}
```

Make sure there is no "type": "module" entry in your package.json to avoid issues with require not being defined.

<img src="images/Screenshot 2025-04-19 at 10.18.55.png" alt="screenshot of package.json edited file">

### Step 6: Run Your App

Run the app using:

```
npm start
```

You should see:

```
Connected to SQLite database.
Server is running on http://localhost:3000
```

<img src="images/Screenshot 2025-04-19 at 10.19.42.png" alt="npm start running">

### Step7: Test with Postman

Now that the API is running locally, we can test it using Postman.

Testing the POST Request (Create a New Blog Post)

- Open Postman and create a new POST request.

- Set the URL to:

```
http://localhost:3000/posts
```

Set the Body:

- Click on the Body tab.

- Select raw and choose JSON from the dropdown.

- Paste this JSON data:

```
{
  "title": "My First Blog Post",
  "content": "Learning to build APIs step by step!"
}
```

Send the Request:

- Click Send.

- You should receive a 201 Created response with the new post's id, like:

```
{
  "id": 1,
  "title": "My First Blog Post",
  "content": "Learning to build APIs step by step!"
}
```

<img src="images/Screenshot 2025-04-19 at 10.20.34.png" alt="image of post request">

**Testing the GET Request (Fetch All Blog Posts)**

- Create a new GET request in Postman.

- Set the URL to:

```
http://localhost:3000/posts
```

Send the Request:

- Click Send.

- You should see a response like this, showing all blog posts:

```
[
  {
    "id": 1,
    "title": "My First Blog Post",
    "content": "Learning to build APIs step by step!"
  }
]
```

<img src="images/Screenshot 2025-04-19 at 10.21.04.png" alt="image of get request">

## Dockerizing the Application

Once the app works locally, we can move on to Dockerizing it.

STEP 8: Create a Dockerfile
In the root of the blog-api folder, create a Dockerfile:

```
touch Dockerfile
```

Paste the following content into Dockerfile:

```
# Build stage
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

# Production stage
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app /app

EXPOSE 3000

CMD ["npm", "start"]
```

<img src="images/Screenshot 2025-04-19 at 10.30.41.png" alt="image of dockerfile">

### Step 9: Create a .dockerignore File

Prevent unnecessary files from being copied into the Docker image by creating a .dockerignore file:

```
touch .dockerignore
```

Inside .dockerignore, add:

```
node_modules
npm-debug.log
.env
```

<img src="images/Screenshot 2025-04-19 at 10.30.50.png" alt="image of dockerignore file">

### Step 10: Build the Docker Image

Build the Docker image by running:

```
docker build -t blog-api .
```

This will create the Docker image for your app.

### Step 11: Run the Container

Run the Docker container using:

```
docker run -p 3000:3000 blog-api
```

Now, your blog API should be running inside a Docker container on http://localhost:3000.

<img src="images/Screenshot 2025-04-19 at 11.48.57.png" alt="image screenshot of browser page">
   
### Step 12: Add Volume for Persisting SQLite Database

To ensure your SQLite database persists even when the container is removed or restarted, we’ll use Docker volumes.

1. Create a Volume for the Database

Inside the project directory, let's create a volume to store the SQLite database file outside of the container.

The **Dockerfile** and app already use **./blog.db** as the SQLite database file location. We’ll now modify the **docker-compose.yml** to mount this as a volume.

### Step 13: Create docker-compose.yml File

In the root of your blog-api directory, create a docker-compose.yml file.

```
touch docker-compose.yml
```

Then paste the following code into it:

```
version: "3.8"
services:
  blog-api:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - ./blog.db:/app/blog.db
    environment:
      - NODE_ENV=production
    networks:
      - blog-network

networks:
  blog-network:
    driver: bridge
```

### Step 14: Build and Start with Docker Compose

With Docker Compose, you can easily manage multi-container setups. For now, we’ll just have one container for the blog API, but we still use docker-compose.yml to simplify the process.

To build and run the application:

1. Build the Image and Start the Container

```
docker-compose up --build
```

<img src="images/Screenshot 2025-04-19 at 10.35.18.png" alt="ss of docker compose up">

This will automatically create the container, mount the volume, and expose the app on http://localhost:3000.

We test our Application again in Postman (or browser):

POST to: http://localhost:3000/posts

GET from: http://localhost:3000/posts

We would see the same behavior as before, but now our SQLite database file (blog.db) is stored in the blog-api folder, which persists even if the container is stopped or removed.

## Conclusion

Now that we’ve added volume support and Docker Compose, here’s a summary of what we’ve accomplished:

- Dockerizing the app: We created a Docker image for the blog API, optimized the image size by using a smaller base image and multi-stage builds.

- Volume for SQLite: We added a volume for persisting the SQLite database outside the Docker container, ensuring that our data remains intact across container restarts.

- Docker Compose: We set up a docker-compose.yml to simplify the process of building and running our app, allowing easy configuration for future scaling or additional services.
