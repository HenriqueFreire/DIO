-- Creating the database for the service order system
CREATE DATABASE IF NOT EXISTS service_workshop;
USE service_workshop;

-- Table for clients
CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    cpf CHAR(11) NOT NULL,
    address VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cpf_client UNIQUE (cpf)
);

-- Table for employees/technicians
CREATE TABLE employees(
    idEmployee INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    cpf CHAR(11) NOT NULL,
    contact CHAR(11),
    department VARCHAR(45),
    position VARCHAR(45),
    CONSTRAINT unique_cpf_employee UNIQUE (cpf)
);

-- Table for service orders
CREATE TABLE service_orders(
    idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    status ENUM('Processing', 'Canceled', 'Confirmed', 'Completed') DEFAULT 'Processing',
    description VARCHAR(255),
    category VARCHAR(45),
    priority ENUM('Low', 'Medium', 'High', 'Urgent', 'Undefined') DEFAULT 'Undefined',
    CONSTRAINT fk_service_order_client FOREIGN KEY(idClient) REFERENCES clients(idClient)
);

-- Assignment table to link employees to service orders
CREATE TABLE assignments(
    idServiceOrder INT,
    idEmployee INT,
    PRIMARY KEY (idServiceOrder, idEmployee),
    CONSTRAINT fk_assignment_order FOREIGN KEY (idServiceOrder) REFERENCES service_orders(idServiceOrder),
    CONSTRAINT fk_assignment_employee FOREIGN KEY (idEmployee) REFERENCES employees(idEmployee)
);

-- Inserting sample data into the tables

-- Inserting clients
INSERT INTO clients (firstName, lastName, cpf, address, contact) VALUES
('John', 'Doe', '11122233344', '123 Maple St, Anytown', '11987654321'),
('Jane', 'Smith', '55566677788', '456 Oak Ave, Somecity', '21987654322'),
('Robert', 'Johnson', '99988877766', '789 Pine Ln, Otherplace', '31987654323');

-- Inserting employees
INSERT INTO employees (firstName, lastName, cpf, department, position) VALUES
('Peter', 'Jones', '12345678900', 'Mechanical', 'Senior Mechanic'),
('Mary', 'Williams', '00987654321', 'Electrical', 'Electrician Specialist');

-- Inserting service orders
INSERT INTO service_orders (idClient, status, description, category, priority) VALUES
(1, 'Confirmed', 'Standard oil change and filter replacement.', 'Routine Maintenance', 'Medium'),
(2, 'Processing', 'Inspection and repair of front brakes.', 'Corrective Maintenance', 'High'),
(3, 'Confirmed', 'Diagnose check engine light.', 'Diagnostics', 'High'),
(1, 'Processing', 'Tire rotation and pressure check.', 'Routine Maintenance', 'Low');

-- Assigning employees to service orders
INSERT INTO assignments (idServiceOrder, idEmployee) VALUES
(1, 1), -- Peter Jones assigned to oil change
(2, 1), -- Peter Jones assigned to brake repair
(3, 2), -- Mary Williams assigned to check engine light
(4, 1); -- Peter Jones assigned to tire rotation

-- SQL QUERIES --
-- The following queries fulfill the project requirements by demonstrating various SQL clauses.

-- Question 1: What is the full name of each client and their contact number?
-- Clause demonstrated: Simple SELECT with a derived attribute (CONCAT).
SELECT
    CONCAT(firstName, ' ', lastName) AS fullName,
    contact
FROM
    clients;

-- Question 2: Which service orders are currently 'Processing' or have 'High' priority?
-- Clause demonstrated: WHERE with OR and ORDER BY.
SELECT
    idServiceOrder,
    description,
    status,
    priority
FROM
    service_orders
WHERE
    status = 'Processing' OR priority = 'High'
ORDER BY
    FIELD(priority, 'High', 'Medium', 'Low'), idServiceOrder;

-- Question 3: What are the details of each service order, including the client's name?
-- Clause demonstrated: JOIN to link two tables.
SELECT
    so.idServiceOrder,
    so.description,
    so.status,
    so.priority,
    CONCAT(c.firstName, ' ', c.lastName) AS clientName
FROM
    service_orders so
JOIN
    clients c ON so.idClient = c.idClient;

-- Question 4: How many service orders are assigned to each employee? Show only employees with more than one assignment.
-- Clause demonstrated: GROUP BY, COUNT (aggregate function), and HAVING.
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    COUNT(a.idServiceOrder) AS numberOfOrders
FROM
    employees e
JOIN
    assignments a ON e.idEmployee = a.idEmployee
GROUP BY
    employeeName
HAVING
    numberOfOrders > 1;

-- Question 5: Provide a complete overview of all non-canceled service orders, showing client and assigned employee.
-- Also, include a calculated 'estimatedCost' based on priority.
-- Clause demonstrated: Multiple JOINs (LEFT JOIN), WHERE, and a derived attribute with CASE.
SELECT
    so.idServiceOrder,
    so.description AS orderDescription,
    CONCAT(c.firstName, ' ', c.lastName) AS clientName,
    CONCAT(e.firstName, ' ', e.lastName) AS assignedEmployee,
    e.position,
    so.status,
    CASE
        WHEN so.priority = 'High' OR so.priority = 'Urgent' THEN 300.00
        WHEN so.priority = 'Medium' THEN 180.00
        WHEN so.priority = 'Low' THEN 90.00
        ELSE 50.00
    END AS estimatedCost
FROM
    service_orders so
JOIN
    clients c ON so.idClient = c.idClient
LEFT JOIN
    assignments a ON so.idServiceOrder = a.idServiceOrder
LEFT JOIN
    employees e ON a.idEmployee = e.idEmployee
WHERE
    so.status != 'Canceled'
ORDER BY
    estimatedCost DESC;
