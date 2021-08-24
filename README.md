# README

## Solution Description

The idea was to fetch information from the external API, cache it for reliability and consistency as the data is only updated once a day, store it in a table and use that data inside of the application without the need of reaching the API in every request in our endpoint. This is done by a crawler scheduled for running once a day for each user. The crawler is an async Sidekiq Worker as well as the register creator.

For the assembly of information, without a query to search the solution chosen was to get the main car recommendations (perfect matches, good matches and the top 5 ranked from API) in the requested order, combine the rest of the cars and paginate an array of results.

## Setup

For this setup, Docker as well as Docker Compose will be needed. Once both are installed, to build the project you will run the following command in the application's folder:

```
    $ docker-compose build
```

After building the application's image, it's time to create, migrate and populate our databases with the following command:

```
    $ docker-compose run app rails db:create db:migrate db:seed
```

To get the application up and running, use the command bellow:

```
    $ docker-compose up
```

You can test the API by accessing the URL http://localhost:3000/cars?user_id=1.

## Tests

Use the following command to run the specs of the application:

```
    $ docker-compose run app rspec
```