CREATE DATABASE CarManagementSystem;

CREATE TABLE Customer ( 
Customer_ID INT PRIMARY KEY, 
Name VARCHAR(255) NOT NULL, 
Email VARCHAR(255) UNIQUE NOT NULL, 
MobileNumber VARCHAR(255) UNIQUE NOT NULL 
);
INSERT INTO Customer (Customer_ID, Name, Email, MobileNumber) VALUES
    (100, 'John Doe', 'john.doe@example.com', '1234567890'),
    (20, 'Jane Smith', 'jane.smith@example.com', '9876543210'),
    (30, 'Peter Jones', 'peter.jones@example.com', '5551234567'),
    (40, 'Mary Brown', 'mary.brown@example.com', '1112223333'),
    (50, 'David Wilson', 'david.wilson@example.com', '4445556666');

CREATE TABLE Manufacturer ( 
Manufacturer_ID INT PRIMARY KEY, 
Name VARCHAR(255) NOT NULL, 
Logo BLOB 
);

INSERT INTO Manufacturer (Manufacturer_ID, Name, Logo) VALUES
    (1, 'Lamborghini', 'lamborghini_logo.png'),
    (2, 'Porsche', 'porsche_logo.png'),
    (3, 'Ford', 'ford_logo.png'),
    (4, 'Chevrolet', 'chevrolet_logo.png'),
    (5, 'BMW', 'bmw_logo.png'),
	(6, 'Audi', 'audi_logo.png'),
	(7, 'Mercedes', 'mercedes_logo.png'),
    (8, 'Mazda', 'mazda_logo.png'),
	(9, 'Ferrari', 'ferrari_logo.png'),
	(10, 'Bugatti', 'bugatti_logo.png');
    
CREATE TABLE Branch ( 
    Branch_ID INT PRIMARY KEY, 
    Name VARCHAR(255) NOT NULL, 
    Location VARCHAR(255) NOT NULL, 
    OpenDate DATE NOT NULL 
);
INSERT INTO Branch (Branch_ID, Name, Location, OpenDate) VALUES
    (11, 'Downtown Branch', '123 Main Street', '2023-01-01'),
    (22, 'North Branch', '456 Oak Avenue', '2022-05-15'),
    (33, 'South Branch', '789 Pine Street', '2021-10-20'),
    (44, 'West Branch', '1011 Maple Lane', '2020-03-05'),
    (55, 'East Branch', '1213 Birch Drive', '2019-08-10');

CREATE TABLE Employee ( 
    Employee_ID INT PRIMARY KEY,
    
    Email VARCHAR(255) UNIQUE NOT NULL, 
    Password VARCHAR(255) UNIQUE NOT NULL, 
    FirstName VARCHAR(255) NOT NULL, 
    LastName VARCHAR(255) NOT NULL, 
    Gender ENUM('M', 'F', 'Other') NOT NULL, 
    Birthday DATE NOT NULL, 
    MobileNumber VARCHAR(255) UNIQUE NOT NULL,
    Branch_ID INT,
    Vehicle_ID INT,
    FOREIGN KEY (Branch_ID) REFERENCES Branch (Branch_ID),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle (Vehicle_ID)
    
);
INSERT INTO Employee (Employee_ID, Email, Password, FirstName, LastName, Gender, Birthday, MobileNumber,Branch_ID,Vehicle_ID) VALUES
    (01, 'john.smith@example.com', 'password123', 'John', 'Smith', 'M', '1990-01-15', '1234567890',11,121),
    (02, 'jane.doe@example.com', 'password456', 'Jane', 'Doe', 'F', '1992-03-20', '9876543210',22,211),
    (03, 'peter.brown@example.com', 'password789', 'Peter', 'Brown', 'M', '1995-05-25', '5551234567',33,312),
    (04, 'mary.wilson@example.com', 'password000', 'Mary', 'Wilson', 'F', '1998-07-30', '1112223333',44,434),
    (05, 'david.jones@example.com', 'password111', 'David', 'Jones', 'M', '2000-09-04', '4445556666',55,546);

CREATE TABLE Model ( 
    Model_ID INT PRIMARY KEY, 
    Year INT, 
    Volume DECIMAL(10,2), 
    Doors INT, 
    Seats INT,
    Manufacturer_ID INT,
    FOREIGN KEY (Manufacturer_ID) REFERENCES Manufacturer (Manufacturer_ID)
);

INSERT INTO Model (Model_ID, Manufacturer_ID, Year, Volume, Doors, Seats) VALUES
    (111, 1, 2023, 3.5, 2, 2),
    (222, 2, 2022, 3.8, 2, 2),
    (333, 3, 2021, 1.8, 4, 5),
    (444, 4, 2020, 3.0, 2, 4),
    (555, 5, 2019, 2.5, 4, 5),
    (666, 6, 2024, 3.0, 4, 5),
    (777, 7, 2024, 3.0, 4, 5),
    (888, 8, 2024, 2.5, 2, 2),
    (999, 9, 2023, 4.5, 2, 2),
    (1000, 10, 2020, 3.0, 2, 2);

CREATE TABLE Vehicle ( 
    Vehicle_ID INT PRIMARY KEY, 
    Model_ID INT, 
    Branch_ID INT,
    Customer_ID INT,
    BuyingPrice DECIMAL(10,2) NOT NULL, 
    AddDate DATE NOT NULL, 
    IsSold BOOLEAN NOT NULL DEFAULT FALSE, 
    FOREIGN KEY (Model_ID) REFERENCES Model(Model_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch (Branch_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID)
);
INSERT INTO Vehicle (Vehicle_ID, Model_ID, BuyingPrice, AddDate, IsSold, Branch_ID,Customer_ID) VALUES
    (121, 111,  25000.00, '2023-01-10', TRUE, 11,100),
    (211, 222,  20000.00, '2023-02-15', TRUE, 22,20),
    (312, 333,  30000.00, '2023-03-20', TRUE, 33,30),
    (434, 444,  28000.00, '2023-04-25', TRUE, 44,40),
    (546, 555,  35000.00, '2023-05-30', TRUE, 55,50),
    (672, 666,  25000.00, '2023-01-10', FALSE, 11,null),
    (787, 777,  20000.00, '2023-02-15', FALSE, 22,null),
    (894, 888,  30000.00, '2023-03-20', FALSE, 33,null),
    (902, 999,  28000.00, '2023-04-25', FALSE, 44,null),
    (107, 1000,  35000.00, '2023-05-30', FALSE, 55,null);
    



CREATE TABLE Sales ( 
    Customer_ID INT, 
    Vehicle_ID INT, 
    Employee_ID INT, 
    SaleNumber INT,
    SaleDate DATE NOT NULL, 
    PaymentType VARCHAR(15),
    SellingPrice DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (Customer_ID, Vehicle_ID, Employee_ID,SaleNumber), 
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID), 
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID), 
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) 
);
INSERT INTO Sales ( Customer_ID, Vehicle_ID, Employee_ID, SaleNumber,SaleDate, SellingPrice, PaymentType) VALUES
    ( 100, 121, 01,1, '2023-01-15', 27000.00, 'Credit Card'),
    ( 20, 211, 02,2, '2023-03-25', 33000.00, 'Debit Card'),
    ( 30, 312, 03,3, '2023-05-30', 38000.00, 'Cash'),
    ( 40, 434, 04,4, '2023-06-05', 22000.00, 'Bank Transfer'),
    ( 50, 546, 05,5, '2023-06-10', 30000.00, 'PayPal');



 CREATE TABLE Vehicle_Color(
  Vehicle_ID INT NOT NULL,
  VhColor VARCHAR(15) NOT NULL,
  PRIMARY KEY (Vehicle_ID,VhColor),
  FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle (Vehicle_ID));
  
  INSERT INTO Vehicle_Color ( Vehicle_ID, VhColor) VALUES 
  (121, 'Silver'),
  (211, 'Black'),
  (312, 'Blue'),
  (434, 'Red'),
  (546, 'Silver'),
  (672, 'Black'),
  (787, 'Yellow'),
  (894, 'White'),
  (902, 'White'),
  (107, 'Black');
  
  
  
  
CREATE INDEX idx_customer_email ON Customer (Email); 
CREATE INDEX idx_manufacturer_name ON Manufacturer (Name); 
CREATE INDEX idx_branch_location ON Branch (Location); 
CREATE INDEX idx_employee_email ON Employee (Email); 
CREATE INDEX idx_model_year ON Model (Year); 
CREATE INDEX idx_sales_saledate ON Sales (SaleDate); 


CREATE VIEW CustomerView AS
SELECT Customer_ID, Name, Email
FROM Customer;


CREATE VIEW VehicleSummaryView AS
SELECT Vehicle.Vehicle_ID, Model.Model_ID, Model.Year, Model.Volume, Model.Doors, Model.Seats 
FROM Vehicle
JOIN Model ON Vehicle.Model_ID = Model.Model_ID;


CREATE VIEW SalesView AS
SELECT Sales.SaleDate, Sales.SellingPrice, Customer.Name, Vehicle.Model_ID
FROM Sales
JOIN Customer ON Sales.Customer_ID = Customer.Customer_ID
JOIN Vehicle ON Sales.Vehicle_ID = Vehicle.Vehicle_ID;



DELIMITER //

CREATE TRIGGER AfterVehicleSold
AFTER UPDATE ON Vehicle
FOR EACH ROW
BEGIN
    IF NEW.IsSold = TRUE THEN
        INSERT INTO Sales (Vehicle_ID, SaleDate, SellingPrice) 
        VALUES (NEW.Vehicle_ID, CURDATE(), NEW.BuyingPrice);
    END IF;
END;
//

CREATE TRIGGER UpdateVehicleStatus
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Vehicle SET IsSold = TRUE WHERE Vehicle_ID = NEW.Vehicle_ID;
END;
//

CREATE TRIGGER CheckCustomerUniqueContact
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    DECLARE mobile_count INT;
    
    SELECT COUNT(*) INTO email_count FROM Customer WHERE Email = NEW.Email;
    SELECT COUNT(*) INTO mobile_count FROM Customer WHERE MobileNumber = NEW.MobileNumber;
    
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The email already exists.';
    END IF;
    
    IF mobile_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The mobile number already exists.';
    END IF;
END;
//

CREATE TRIGGER CheckEmployeeEmailUnique
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    
    IF NEW.Email <> OLD.Email THEN
        SELECT COUNT(*) INTO email_count FROM Employee WHERE Email = NEW.Email;
        IF email_count > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The email is already in use by another employee.';
        END IF;
    END IF;
END;
//


DELIMITER ;