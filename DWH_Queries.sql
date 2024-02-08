
-- Creating Dim Book Table

CREATE TABLE 
     Dim_Book (
             BookID_SK INT IDENTITY(1,1) PRIMARY KEY,
			   book_id_BK INT NOT NULL,
			   title VARCHAR(400),
			   isbn13 VARCHAR(13),
			   language_name VARCHAR(50),
			   num_pages INT,			   
			   publisher_name NVARCHAR(1000),
			   Source_System_Code INT,
			   Start_Date DATETIME,
			   End_Date DATETIME,
			   Is_Current INT
			   )

-- Creating Dim Author Table

CREATE TABLE 
     Dim_Author (
	          AuthorID_SK INT IDENTITY(1,1) PRIMARY KEY,
			  author_id_BK INT NOT NULL,
			  author_name VARCHAR(400),
			  Source_System_Code INT,
			  Start_Date DATETIME,
			  End_Date DATETIME,
			  Is_Current INT
			  )

-- Creating Dim Book_Author Table

CREATE TABLE 
     Dim_Book_Author (
	          BookAuthorID_SK INT IDENTITY(1,1) PRIMARY KEY,
			  BookID_FK INT,
			  AuthorID_FK INT,
			  Source_System_Code INT,
			  Start_Date DATETIME,
			  End_Date DATETIME,
			  Is_Current INT,
CONSTRAINT bookidfk FOREIGN KEY (BookID_FK) REFERENCES Dim_Book (BookID_SK),
CONSTRAINT authoridfk FOREIGN KEY (AuthorID_FK) REFERENCES Dim_Author (AuthorID_SK))
	                  
-- Creating Dim Customer Table

CREATE TABLE
     Dim_Customer (
	               CustomerID_SK INT IDENTITY(1,1) PRIMARY KEY,
				   customer_id_BK INT NOT NULL,
				   first_name VARCHAR(200),
				   last_name  VARCHAR(200),
				   email VARCHAR(350),
				   Source_System_Code INT,
				   Start_Date DATETIME,
				   End_Date DATETIME,
				   Is_Current INT
	               )

-- Creating Dim Address Table

CREATE TABLE 
     Dim_Address (
	              AddressID_SK INT IDENTITY(1,1) PRIMARY KEY,
                  address_id_BK INT NOT NULL,
                  street_number VARCHAR(10),
                  street_name VARCHAR(200),
                  city VARCHAR(100),
                  country_id_BK INT,
                  country_name VARCHAR(200),
                  Source_System_Code INT,
                  Start_Date DATETIME,
                  End_Date DATETIME,
                  Is_Current INT )

-- Creating Dim Customer_Address Table

CREATE TABLE 
     Dim_Customer_Address (
	                CustomerAddressID_SK INT IDENTITY(1,1) PRIMARY KEY, 
                    CustomerID_FK INT,
                    AddressID_FK INT,
                    Source_System_Code INT,
                    Start_Date DATETIME,
                    End_Date DATETIME,
                    Is_Current INT,
CONSTRAINT customeridfk FOREIGN KEY (CustomerID_FK) REFERENCES Dim_Customer(CustomerID_SK),
CONSTRAINT addressidfk FOREIGN KEY (AddressID_FK) REFERENCES Dim_Address(AddressID_SK))

-- Creating Dim Shipping Table

CREATE TABLE 
     Dim_Shipping (
                 MethodID_SK INT IDENTITY(1,1) PRIMARY KEY,
				   method_id_BK INT NOT NULL,
				   method_name VARCHAR(100),
				   Source_System_Code INT,
				   Start_Date DATETIME,
				   End_Date DATETIME ,
				   Is_Current INT
	               )

-- Creating Dim Status Table

CREATE TABLE
     Dim_Status (
	             StatusID_SK INT IDENTITY(1,1) PRIMARY KEY, 
				 status_id_BK INT NOT NULL,
				 status_value  VARCHAR(20),
				 Source_System_Code INT,
				 Start_Date DATE, 
				 End_Date DATE,
				 Is_Current INT
				 )

-- Creating Fact Order_History Table

CREATE TABLE
     Fact_Order_History (
	                     OrderHistory_ID_SK INT IDENTITY(1,1) PRIMARY KEY,
                         order_id_BK INT NOT NULL, 
                         StatusID_FK INT,
                         Status_1 INT, 
                         Status_1_Date_FK INT,
                         Status_2 INT,
                         Status_2_Date_FK INT,
                         Status_3 INT,
                         Status_3_Date_FK INT,
                         Status_4 INT,
                         Status_4_Date_FK INT, 
                         Status_5 INT,
                         Status_5_Date_FK INT,
                         Created_at DATETIME,
                         Status_6_Date_FK INT,
                         Created_at DATETIME,
	                     
CONSTRAINT Statusfk1 FOREIGN KEY (Status_1_Date_FK) REFERENCES DimDate (DateSK),
CONSTRAINT Statusfk2 FOREIGN KEY (Status_2_Date_FK) REFERENCES DimDate (DateSK),
CONSTRAINT Statusfk3 FOREIGN KEY (Status_3_Date_FK) REFERENCES DimDate (DateSK),
CONSTRAINT Statusfk4 FOREIGN KEY (Status_4_Date_FK) REFERENCES DimDate (DateSK),
CONSTRAINT Statusfk5 FOREIGN KEY (Status_5_Date_FK) REFERENCES DimDate (DateSK),
CONSTRAINT Statusfk6 FOREIGN KEY (Status_6_Date_FK) REFERENCES DimDate (DateSK))

-- Creating Fact Order Table

CREATE TABLE
     Fact_Order (
	             OrderID_SK INT IDENTITY(1,1) PRIMARY KEY,
				 order_id_BK INT NOT NULL,
				 CustomerID_FK INT,
				 BookID_FK INT,
				 MethodID_FK INT,
				 Date_FK INT,
				 Time_FK INT,
				 OrderHistory_ID_FK INT,
				 price DECIMAL(6,2),
				 Method_Cost DECIMAL(6,2),
				 Total_Price AS (Price + Method_Cost),
				 Created_at DATE,

CONSTRAINT customerFK FOREIGN KEY (CustomerID_FK) REFERENCES Dim_Customer (CustomerID_SK),
CONSTRAINT bookFK FOREIGN KEY (BookID_FK) REFERENCES Dim_Book (BookID_SK),
CONSTRAINT methodFK FOREIGN KEY (MethodID_FK) REFERENCES Dim_Shipping (MethodID_SK),				
CONSTRAINT DateFK FOREIGN KEY (Date_FK) REFERENCES DimDate (DateSK),




--Create Meta control table 

CREATE TABLE MetaControl (
                         ID INT,
                         Last_Load_Date Datetime,
                         Last_Load_OrderDetailsID_BK INT
                         )

INSERT INTO MetaControl 
           (ID,Last_Load_Date,Last_Load_OrderDetailsID_BK)
           VALUES (1,'1900-1-1',0)

