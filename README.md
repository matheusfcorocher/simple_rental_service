# Rental Service

## About

Welcome to the Rental Service! This project provides a robust and efficient solution for managing rental services, including client interactions, vehicle rentals, and more. Below you'll find instructions on how to compile and run the application on various platforms.

## Running the Application

### Requirements

To get started with this project, you will need the following:

- [Free Pascal Compiler (FPC)](https://www.freepascal.org/): Ensure you have the Free Pascal Compiler installed. You can download it from the official Free Pascal website.
- [Lazarus-IDE](https://www.lazarus-ide.org/): Comes with lazbuild.

### Running step by step

Follow the instructions below to compile and run the console application and rest api application. Depending on your operating system, use the appropriate commands.

For running console application and rest api, run the commands for optional platform:

### Unix-based Systems

```bash
# Compile all packages before running applications
lazbuild ./src/utils/rentalserviceutilitiespackage.lpk
lazbuild ./src/rental_ecosystem/rentalecosystempackage.lpk
lazbuild ./src/infrastructure/rentalserviceinfrastructurepackage.lpk
lazbuild ./src/presenters/rentalservicepresenterspackage.lpk
lazbuild ./src/controllers/rentalservicecontrollerspackage.lpk
lazbuild ./src/assemblers/RentalServicePackage.lpk
lazbuild ./src/applications/console/RentalServiceConsole.lpi

# Run executable console application
./src/applications/console/RentalServiceConsole

# Run executable rest api application
./src/applications/rest_api/RentalApiApp
```

### Windows

```cmd
REM Compile all packages before running applications
lazbuild .\src\utils\rentalserviceutilitiespackage.lpk
lazbuild .\src\rental_ecosystem\rentalecosystempackage.lpk
lazbuild .\src\infrastructure\rentalserviceinfrastructurepackage.lpk
lazbuild .\src\presenters\rentalservicepresenterspackage.lpk
lazbuild .\src\controllers\rentalservicecontrollerspackage.lpk
lazbuild .\src\assemblers\RentalServicePackage.lpk
lazbuild .\src\applications\console\RentalServiceConsole.lpi

REM Run console executable
.\src\applications\console\RentalServiceConsole.exe

REM Run executable rest api application
.\src\applications\rest_api\RentalApiApp.exe
```

## Additional Information

Feel free to explore the source code and modify it to suit your needs. If you encounter any issues or have suggestions for improvement, please open an issue or submit a pull request.
