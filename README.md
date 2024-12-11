# Rental Service

## About

Welcome to the Rental Service! This project provides a robust and efficient solution for managing rental services, including client interactions, vehicle rentals, and more. Below you'll find instructions on how to compile and run the application on various platforms.

## Running the Application

### Requirements

To get started with this project, you will need the following:

- [Free Pascal Compiler (FPC)](https://www.freepascal.org/): Ensure you have the Free Pascal Compiler installed. You can download it from the official Free Pascal website.

### Running step by step

Follow the instructions below to compile and run the console application. Depending on your operating system, use the appropriate commands.

For running console application, run the commands for optional platform:

### Unix-based Systems

```bash
# create a distribution folder
mkdir dist
# compile pascal file
fpc -FEdist ./src/applications/console/RentalServiceConsole.pas
# change directory to distribution folder
cd dist
# run executable file
./RentalServiceConsole
```

### Windows

```cmd
REM create a distribution folder
mkdir dist
REM compile pascal file
fpc -FEdist ./src/applications/console/RentalServiceConsole.pas
REM change directory to distribution folder
cd dist
REM run executable file
RentalServiceConsole.exe
```

## Additional Information

Feel free to explore the source code and modify it to suit your needs. If you encounter any issues or have suggestions for improvement, please open an issue or submit a pull request.
