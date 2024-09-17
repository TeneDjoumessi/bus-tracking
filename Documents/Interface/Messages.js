function getErrorMessage(type) {
    switch (type) {


        // Bus messages
        case "busEmptyField":
            return "This field cannot be empty.";
        case "busInvalidName":
            return "Please enter a valid bus name.";
        case "busInvalidColor":
            return "Please enter a valid bus color.";
        case "busInvalidSittingPlace":
            return "Please enter a valid number of sitting places.";
        case "busInvalidMatricule":
            return "Please enter a valid matricule.";
        case "busInvalidFuelType":
            return "Please enter a valid fuel type.";
        case "busAlreadyExists":
            return "Bus already exists.";
        case "busAddedSuccessfully":
            return "Bus added successfully.";

        // Staff messages
        case "emptyField":
            return "This field cannot be empty.";
        case "invalidFirstname":
            return "Please enter a valid first name.";
        case "invalidLastname":
            return "Please enter a valid last name.";
        case "invalidPhone":
            return "Please enter a valid phone number (9 digits).";
        case "invalidEmail":
            return "Please enter a valid email address (gmail.com).";
        case "invalidSalary":
            return "Please enter a valid salary.";
        case "invalidHireDate":
            return "Please enter a valid hire date.";
        case "staffAlreadyExists":
            return "Staff already exists.";
        case "staffAddedSuccessfully":
            return "Staff added successfully.";

        // Driver messages
        case "driverEmptyField":
            return "This field cannot be empty.";
        case "driverInvalidFirstname":
            return "Please enter a valid first name.";
        case "driverInvalidLastname":
            return "Please enter a valid last name.";
        case "driverInvalidPhone":
            return "Please enter a valid phone number (9 digits).";
        case "driverInvalidEmail":
            return "Please enter a valid email address (gmail.com).";
        case "driverInvalidSalary":
            return "Please enter a valid salary.";
        case "driverInvalidHireDate":
            return "Please enter a valid hire date.";
        case "driverAlreadyExists":
            return "Driver already exists.";
        case "driversAddedSuccessfully":
            return "Driver added successfully.";

            // Add Route Form messages
        case "routeEmptyField":
            return "This field cannot be empty.";
        case "routeInvalidId":
            return "Please enter a valid Route Id.";
        case "routeInvalidLocation":
            return "Please enter a valid Location.";
        case "routeInvalidDestination":
            return "Please enter a valid Destination.";
        case "routeInvalidStopName":
            return "Please enter a valid Stop Name.";
        case "routeInvalidLongLat":
            return "Please enter valid coordinates.";
        case "routeAddedSuccessfully":
            return "Route added successfully.";

            // Post Form messages
        case "postEmptyField":
             return "This field cannot be empty.";
        case "postInvalidDate":
             return "Please enter a valid date.";
        case "postInvalidDescription":
             return "Description cannot be empty.";
        /*case "postAddedSuccessfully":
            return "Post added successfully.";*/


        // Login message
        case "emptyField":
            return "This field cannot be empty.";
        case "loginInvalidTel":
            return "Invalid telephone number. Must be 9 digits.";
        case "loginInvalidPassword":
            return "Invalid password. Please try again.";
        case "loginInvalidCredentials":
            return "Incorrect telephone number or password.";

        default:
            return "Unknown error.";
    }
}
