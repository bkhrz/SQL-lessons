DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Loan;

CREATE TABLE Book(
    book_id INT PRIMARY KEY IDENTITY, 
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INT CHECK(published_year > 0)
);

CREATE TABLE Member(
    member_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, 
    phone_number VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Loan(
    loan_id INT PRIMARY KEY IDENTITY, 
    book_id INT FOREIGN KEY REFERENCES Book(book_id),
    member_id INT FOREIGN KEY REFERENCES Member(member_id),
    loan_date DATE NOT NULL,
    return_date DATE NULL 
);


--sample books
INSERT INTO Book(title, author, published_year) VALUES
    ('Pride and Prejudice', 'Jane Austen', 1813),
    ('Moby-Dick', 'Herman Melville', 1851),
    ('Jane Eyre', 'Charlotte Brontë', 1847);

--sample members
INSERT INTO Member(name, email, phone_number) VALUES
    ('Charlie Brown', 'charlie@example.com', '321-654-9870'),
    ('Diana Prince', 'diana@example.com', '456-789-1234');