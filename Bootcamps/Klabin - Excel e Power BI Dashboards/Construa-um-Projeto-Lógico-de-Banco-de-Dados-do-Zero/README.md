# Service Workshop Database Project

This repository contains a complete SQL script (`database_schema.sql`) for creating and populating a database for a vehicle service workshop. This project is part of the "Build a Logical Database Project from Scratch" challenge from DIO.

## Project Description

The goal of this project is to design and implement a relational database for managing clients, employees, and service orders in a workshop. The logical schema was designed to be clear, efficient, and to meet the specified business requirements.

## Logical Schema

The database, `service_workshop`, consists of four main tables:

1.  **`clients`**: Stores information about the workshop's clients.
    - `idClient` (Primary Key)
    - `firstName`, `lastName`
    - `cpf` (Unique)
    - `address`
    - `contact`

2.  **`employees`**: Stores information about the employees or technicians.
    - `idEmployee` (Primary Key)
    - `firstName`, `lastName`
    - `cpf` (Unique)
    - `department`
    - `position`

3.  **`service_orders`**: The central table, containing details about each service requested by a client.
    - `idServiceOrder` (Primary Key)
    - `idClient` (Foreign Key to `clients`)
    - `status` (e.g., 'Processing', 'Completed')
    - `description`
    - `category`
    - `priority`

4.  **`assignments`**: A linking table that assigns one or more employees to a specific service order.
    - `idServiceOrder` (Composite Primary Key, Foreign Key to `service_orders`)
    - `idEmployee` (Composite Primary Key, Foreign Key to `employees`)

## SQL Script (`database_schema.sql`)

The `database_schema.sql` file is structured to be executed in a single run and performs the following actions:
1.  Creates the `service_workshop` database.
2.  Defines and creates the four tables described above with their respective constraints.
3.  Populates the tables with sample data for clients, employees, and service orders.
4.  Includes a series of complex queries designed to answer specific business questions and demonstrate the use of various SQL clauses as required by the challenge.

### Sample Queries

The script includes queries to answer questions such as:
- Which service orders are currently in progress?
- How many orders is each employee assigned to?
- What is the complete overview of a service order, including client and employee details?
