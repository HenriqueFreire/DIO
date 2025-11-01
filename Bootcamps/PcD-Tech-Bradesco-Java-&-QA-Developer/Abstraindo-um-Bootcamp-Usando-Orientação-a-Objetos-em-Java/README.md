# Object-Oriented Programming Challenge: Encapsulation in Java

This project is a simple educational example created to demonstrate a fundamental concept of Object-Oriented Programming (OOP): **Encapsulation**.

## About the Project

The code implements a `Course` class with its data (attributes) kept `private`. Access to this data is controlled through `public` methods, known as getters and setters. This prevents direct, uncontrolled access to the object's state, which is the core idea of encapsulation.

A `Main` class is used to create an instance of the `Course` and interact with it, showing how the public methods are used to set and retrieve its data.

## Prerequisites

- [Nix](https://nixos.org/) package manager.

## How to Run

1.  **Load the development environment:**
    Open your terminal in the project's root directory and run:
    ```bash
    nix-shell
    ```
    This command will automatically install Java and Maven as specified in the `shell.nix` file.

2.  **Compile the code:**
    Inside the `nix-shell`, run the following command to compile the Java source files. This will create an `out` directory with the compiled `.class` files.
    ```bash
    javac -d out src/Main.java src/br/com/dio/challenge/domain/Course.java
    ```

3.  **Run the application:**
    Finally, execute the compiled code:
    ```bash
    java -cp out Main
    ```

You should see the following output on your console:

```
Course Title: Java Basics
Description: A course for beginners in Java.
Workload: 8 hours
```
