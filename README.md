# TaskList Flutter

A simple Todo List app made with Flutter (& NestJs/Mongodb for API).

## How to run the app 

#### 1. Install & run API dev server

```sh
cd api
```

Start by going to the API folder, and createa .env file from the .env.dist present on the repo.
Note that to run the API, you need a running mongodb instance. If you need to change username, host ..., edit the DATABASE_URL env. var on the .env

Now you can run the API server :

```sh
npm install
npm run start:dev
```

App should now be running on port 3000. Open http://localhost:3000 on your browser. If you see "Hello world", then you're good to go.

#### 2. Run the flutter app 

This is a standard flutter app, run the dev server using `flutter run`


### FEATURES :

- Authentication : Sign up / Sign in to the app
- Profile : Visualise personnal informations
- Tasks management :
  - Visualise todo lists by tabs
  - Refresh tasks by dragging list downward
  - Sort & filter dynamically tasks
  - Create tasks
  - Add updates to tasks, visualise updates
  - Share a task by email (Opens email app with pre-filled content, issue text)

