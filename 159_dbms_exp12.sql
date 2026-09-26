/* =========================================================
   RAILWAY RESERVATION SYSTEM
   ========================================================= */

SET SERVEROUTPUT ON;
SET LINESIZE 120;
SET PAGESIZE 50;


/* =========================================================
   1. DROP OLD TABLES
   ========================================================= */

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Reservations CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Passenger CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Train CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


/* =========================================================
   2. CREATE TRAIN TABLE
   ========================================================= */

CREATE TABLE Train (
    TrainID NUMBER PRIMARY KEY,
    TrainName VARCHAR2(50),
    SourceStation VARCHAR2(50),
    DestinationStation VARCHAR2(50),
    TotalSeats NUMBER
);


/* =========================================================
   3. CREATE PASSENGER TABLE
   ========================================================= */

CREATE TABLE Passenger (
    PassengerID NUMBER PRIMARY KEY,
    PassengerName VARCHAR2(50),
    Age NUMBER,
    Gender VARCHAR2(10),
    Phone VARCHAR2(15)
);


/* =========================================================
   4. CREATE RESERVATIONS TABLE
   ========================================================= */

CREATE TABLE Reservations (
    ReservationID NUMBER PRIMARY KEY,
    PassengerID NUMBER REFERENCES Passenger(PassengerID),
    TrainID NUMBER REFERENCES Train(TrainID),
    JourneyDate DATE,
    SeatNumber NUMBER,
    Class VARCHAR2(20),
    Fare NUMBER(10,2),
    Status VARCHAR2(20)
);


/* =========================================================
   5. INSERT TRAIN DATA
   ========================================================= */

INSERT INTO Train VALUES
(101,'Chennai Express','Chennai','Mumbai',500);

INSERT INTO Train VALUES
(102,'Vaigai Express','Chennai','Madurai',400);

INSERT INTO Train VALUES
(103,'Shatabdi Express','Bangalore','Chennai',300);


/* =========================================================
   6. INSERT PASSENGER DATA
   ========================================================= */

INSERT INTO Passenger VALUES
(1,'Arun',25,'Male','9876543210');

INSERT INTO Passenger VALUES
(2,'Divya',30,'Female','9876543211');

INSERT INTO Passenger VALUES
(3,'Rahul',40,'Male','9876543212');

INSERT INTO Passenger VALUES
(4,'Priya',28,'Female','9876543213');

INSERT INTO Passenger VALUES
(5,'Karthik',35,'Male','9876543214');


/* =========================================================
   7. INSERT RESERVATION DATA
   ========================================================= */

INSERT INTO Reservations VALUES
(5001,1,101,DATE '2026-10-01',15,'AC',850,'Confirmed');

INSERT INTO Reservations VALUES
(5002,2,102,DATE '2026-10-02',20,'Sleeper',450,'Confirmed');

INSERT INTO Reservations VALUES
(5003,3,103,DATE '2026-10-03',35,'AC',700,'Waiting');

INSERT INTO Reservations VALUES
(5004,4,102,DATE '2026-10-02',21,'Sleeper',450,'Confirmed');

INSERT INTO Reservations VALUES
(5005,5,101,DATE '2026-10-04',25,'AC',850,'Confirmed');

COMMIT;


/* =========================================================
   8. DISPLAY ALL TRAINS
   ========================================================= */

SELECT *
FROM Train;

/*
OUTPUT:

TRAINID  TRAINNAME          SOURCESTATION  DESTINATIONSTATION  TOTALSEATS
-------  -----------------  -------------  ------------------  ----------
101      Chennai Express    Chennai        Mumbai              500
102      Vaigai Express     Chennai        Madurai             400
103      Shatabdi Express   Bangalore      Chennai             300
*/


/* =========================================================
   9. DISPLAY ALL PASSENGERS
   ========================================================= */

SELECT *
FROM Passenger;

/*
OUTPUT:

PASSENGERID  PASSENGERNAME  AGE  GENDER  PHONE
-----------  -------------  ---  ------  ----------
1            Arun           25   Male    9876543210
2            Divya          30   Female  9876543211
3            Rahul          40   Male    9876543212
4            Priya          28   Female  9876543213
5            Karthik        35   Male    9876543214
*/


/* =========================================================
   10. DISPLAY ALL RESERVATIONS
   ========================================================= */

SELECT *
FROM Reservations;

/*
OUTPUT:

RESERVATIONID  PASSENGERID  TRAINID  JOURNEYDATE  SEATNUMBER
-------------  -----------  -------  -----------  ----------
5001           1            101      01-OCT-26    15
5002           2            102      02-OCT-26    20
5003           3            103      03-OCT-26    35
5004           4            102      02-OCT-26    21
5005           5            101      04-OCT-26    25

CLASS       FARE  STATUS
----------  ----  ----------
AC          850   Confirmed
Sleeper     450   Confirmed
AC          700   Waiting
Sleeper     450   Confirmed
AC          850   Confirmed
*/


/* =========================================================
   11. DISPLAY RESERVATION DETAILS
   ========================================================= */

SELECT
    r.ReservationID,
    p.PassengerName,
    t.TrainName,
    t.SourceStation,
    t.DestinationStation,
    r.JourneyDate,
    r.SeatNumber,
    r.Class,
    r.Fare,
    r.Status
FROM Reservations r
JOIN Passenger p
ON r.PassengerID = p.PassengerID
JOIN Train t
ON r.TrainID = t.TrainID;

/*
OUTPUT:

RESERVATIONID  PASSENGERNAME  TRAINNAME          SOURCE    DESTINATION
-------------  -------------  -----------------  --------  -----------
5001           Arun           Chennai Express    Chennai   Mumbai
5002           Divya          Vaigai Express     Chennai   Madurai
5003           Rahul          Shatabdi Express   Bangalore Chennai
5004           Priya          Vaigai Express     Chennai   Madurai
5005           Karthik        Chennai Express    Chennai   Mumbai

JOURNEYDATE  SEATNUMBER  CLASS     FARE  STATUS
-----------  ----------  --------  ----  ----------
01-OCT-26    15          AC        850   Confirmed
02-OCT-26    20          Sleeper   450   Confirmed
03-OCT-26    35          AC        700   Waiting
02-OCT-26    21          Sleeper   450   Confirmed
04-OCT-26    25          AC        850   Confirmed
*/


/* =========================================================
   12. DISPLAY CONFIRMED RESERVATIONS
   ========================================================= */

SELECT
    r.ReservationID,
    p.PassengerName,
    t.TrainName,
    r.Fare
FROM Reservations r
JOIN Passenger p
ON r.PassengerID = p.PassengerID
JOIN Train t
ON r.TrainID = t.TrainID
WHERE r.Status = 'Confirmed';

/*
OUTPUT:

RESERVATIONID  PASSENGERNAME  TRAINNAME          FARE
-------------  -------------  -----------------  ----
5001           Arun           Chennai Express    850
5002           Divya          Vaigai Express     450
5004           Priya          Vaigai Express     450
5005           Karthik        Chennai Express    850
*/


/* =========================================================
   13. TOTAL CONFIRMED FARE
   ========================================================= */

SELECT
    SUM(Fare) AS Total_Confirmed_Fare
FROM Reservations
WHERE Status = 'Confirmed';

/*
OUTPUT:

TOTAL_CONFIRMED_FARE
--------------------
2600
*/


/* =========================================================
   14. NUMBER OF RESERVATIONS PER TRAIN
   ========================================================= */

SELECT
    t.TrainName,
    COUNT(r.ReservationID) AS Number_Of_Reservations
FROM Train t
LEFT JOIN Reservations r
ON t.TrainID = r.TrainID
GROUP BY t.TrainName;

/*
OUTPUT:

TRAINNAME           NUMBER_OF_RESERVATIONS
------------------  ----------------------
Chennai Express     2
Vaigai Express      2
Shatabdi Express    1
*/


/* =========================================================
   15. PASSENGERS ABOVE 30 YEARS
   ========================================================= */

SELECT
    PassengerID,
    PassengerName,
    Age
FROM Passenger
WHERE Age > 30;

/*
OUTPUT:

PASSENGERID  PASSENGERNAME  AGE
-----------  -------------  ---
3            Rahul          40
5            Karthik        35
*/


/* =========================================================
   16. HIGHEST FARE
   ========================================================= */

SELECT
    p.PassengerName,
    r.Fare
FROM Reservations r
JOIN Passenger p
ON r.PassengerID = p.PassengerID
WHERE r.Fare = (
    SELECT MAX(Fare)
    FROM Reservations
);

/*
OUTPUT:

PASSENGERNAME  FARE
-------------  ----
Arun           850
Karthik        850
*/


/* =========================================================
   17. WAITING LIST PASSENGERS
   ========================================================= */

SELECT
    p.PassengerName,
    t.TrainName,
    r.Status
FROM Reservations r
JOIN Passenger p
ON r.PassengerID = p.PassengerID
JOIN Train t
ON r.TrainID = t.TrainID
WHERE r.Status = 'Waiting';

/*
OUTPUT:

PASSENGERNAME  TRAINNAME          STATUS
-------------  -----------------  -------
Rahul          Shatabdi Express   Waiting
*/


/* =========================================================
   18. RESERVATIONS FOR VAIGAI EXPRESS
   ========================================================= */

SELECT
    p.PassengerName,
    r.JourneyDate,
    r.SeatNumber,
    r.Fare
FROM Reservations r
JOIN Passenger p
ON r.PassengerID = p.PassengerID
WHERE r.TrainID = 102;

/*
OUTPUT:

PASSENGERNAME  JOURNEYDATE  SEATNUMBER  FARE
-------------  -----------  ----------  ----
Divya          02-OCT-26    20          450
Priya          02-OCT-26    21          450
*/


/* =========================================================
   19. UPDATE WAITING RESERVATION
   ========================================================= */

UPDATE Reservations
SET Status = 'Confirmed'
WHERE ReservationID = 5003;

COMMIT;


/* =========================================================
   20. DISPLAY UPDATED RESERVATION
   ========================================================= */

SELECT *
FROM Reservations
WHERE ReservationID = 5003;

/*
OUTPUT:

RESERVATIONID  PASSENGERID  TRAINID  JOURNEYDATE  SEATNUMBER
-------------  -----------  -------  -----------  ----------
5003           3            103      03-OCT-26    35

CLASS  FARE  STATUS
-----  ----  ----------
AC     700   Confirmed
*/


/* =========================================================
   21. CANCEL A RESERVATION
   ========================================================= */

UPDATE Reservations
SET Status = 'Cancelled'
WHERE ReservationID = 5004;

COMMIT;


/* =========================================================
   22. DISPLAY CANCELLED RESERVATION
   ========================================================= */

SELECT *
FROM Reservations
WHERE ReservationID = 5004;

/*
OUTPUT:

RESERVATIONID  PASSENGERID  TRAINID  JOURNEYDATE  SEATNUMBER
-------------  -----------  -------  -----------  ----------
5004           4            102      02-OCT-26    21

CLASS     FARE  STATUS
--------  ----  ----------
Sleeper   450   Cancelled
*/


/* =========================================================
   FINAL VERIFICATION
   ========================================================= */

SELECT * FROM Train;

SELECT * FROM Passenger;

SELECT * FROM Reservations;


/* =========================================================
   END OF RAILWAY RESERVATION SYSTEM
   ========================================================= */
