# CheeseApp Backend
Simple server application written in Swift with [Vapor](https://vapor.codes).
Comes with persistent storage and CRUD API:
| Route | Method | Description |
|-|-|-|
| /api/cheeses | GET | Get all the cheese items from the database |
| /api/cheeses | POST | Create new cheese item |
| /api/cheeses/:cheeseID | GET | Get specific cheese item by ID |
| /api/cheeses/random | GET | Get random cheese item from the database |
| /api/cheeses/:cheeseID | PUT | Update cheese item |
| /api/cheeses/:cheeseID | DELETE | Delete cheese item |

For more information on Vapor check out the [documentation](https://docs.vapor.codes)
## Requirements
Swift 5.5, Vapor 4, Xcode 13.3
## Database
For database I'm using [PostgreSQL](https://www.postgresql.org). However, it is possible to use MongoDB, SQLite and MySQL. 
To set up Postgres:
```sh
docker run --name postgres \
  -e POSTGRES_DB=vapor_database \
  -e POSTGRES_USER=vapor_username \
  -e POSTGRES_PASSWORD=vapor_password \
  -p 5432:5432 -d postgres
```
To set up database for testing
```sh
docker run --name postgres-test \
  -e POSTGRES_DB=vapor-test \
  -e POSTGRES_USER=vapor_username \
  -e POSTGRES_PASSWORD=vapor_password \
  -p 5433:5432 -d postgres
```
