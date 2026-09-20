-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100),
    Genre VARCHAR(50),
    PublicationYear INT
);

-- Create BookAuthors table
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create Borrowers table
CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MembershipDate DATE
);

-- Create BorrowedBooks table
CREATE TABLE BorrowedBooks (
    BorrowerID INT,
    BookID INT,
    BorrowedDate DATE,
    ReturnDate DATE,
    PRIMARY KEY (BorrowerID, BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert values into Authors
INSERT INTO Authors (FirstName, LastName)
VALUES
('George', 'Orwell'),
('Aldous', 'Huxley'),
('J.K.', 'Rowling');

-- Insert values into Books
INSERT INTO Books (Title, Genre, PublicationYear)
VALUES
('1984', 'Dystopian', 1949),
('Brave New World', 'Dystopian', 1932),
('Harry Potter and the Sorcerer''s Stone', 'Fantasy', 1997);

-- Insert values into BookAuthors
INSERT INTO BookAuthors (BookID, AuthorID)
VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insert values into Borrowers
INSERT INTO Borrowers (FirstName, LastName, MembershipDate)
VALUES
('John', 'Doe', '2023-01-01'),
('Jane', 'Smith', '2023-02-15');

-- Insert values into BorrowedBooks
INSERT INTO BorrowedBooks
    (BorrowerID, BookID, BorrowedDate, ReturnDate)
VALUES
    (1, 1, '2023-03-01', '2023-03-15'),
    (2, 3, '2023-03-05', '2023-03-20');

SELECT * FROM Authors;

AuthorID | FirstName | LastName
---------+-----------+----------
1        | George    | Orwell
2        | Aldous    | Huxley
3        | J.K.      | Rowling


SELECT * FROM Books;

BookID | Title                                | Genre     | PublicationYear
-------+--------------------------------------+-----------+----------------
1      | 1984                                 | Dystopian | 1949
2      | Brave New World                      | Dystopian | 1932
3      | Harry Potter and the Sorcerer's Stone | Fantasy   | 1997


SELECT * FROM BookAuthors;

BookID | AuthorID
-------+---------
1      | 1
2      | 2
3      | 3


SELECT * FROM Borrowers;

BorrowerID | FirstName | LastName | MembershipDate
-----------+-----------+----------+---------------
1          | John      | Doe      | 2023-01-01
2          | Jane      | Smith    | 2023-02-15


SELECT * FROM BorrowedBooks;

BorrowerID | BookID | BorrowedDate | ReturnDate
-----------+--------+--------------+-----------
1          | 1      | 2023-03-01   | 2023-03-15
2          | 3      | 2023-03-05   | 2023-03-20
