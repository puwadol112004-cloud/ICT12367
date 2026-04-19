-- เลือกใช้งาน Database ที่เพิ่งสร้าง
USE DigitalLibraryDB;
GO

-- 1. สร้างตารางสมาชิก (MEMBER)
CREATE TABLE MEMBER (
    Member_ID CHAR(10) PRIMARY KEY,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. สร้างตารางสำนักพิมพ์ (PUBLISHER)
CREATE TABLE PUBLISHER (
    Publisher_ID INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) คือรันเลข Auto
    Pub_Name VARCHAR(150) NOT NULL
);

-- 3. สร้างตารางผู้แต่ง (AUTHOR)
CREATE TABLE AUTHOR (
    Author_ID INT IDENTITY(1,1) PRIMARY KEY,
    Author_Name VARCHAR(150) NOT NULL
);

-- 4. สร้างตารางหนังสือ (BOOK)
CREATE TABLE BOOK (
    Book_ID CHAR(13) PRIMARY KEY, -- ใช้ ISBN เป็น PK ได้
    Title VARCHAR(255) NOT NULL,
    Publish_Year INT,
    Publisher_ID INT,
    FOREIGN KEY (Publisher_ID) REFERENCES PUBLISHER(Publisher_ID)
);

-- 5. สร้างตารางเชื่อม ผู้แต่ง-หนังสือ (BOOK_AUTHOR) สำหรับ Many-to-Many
CREATE TABLE BOOK_AUTHOR (
    Book_ID CHAR(13),
    Author_ID INT,
    PRIMARY KEY (Book_ID, Author_ID), -- Composite Primary Key
    FOREIGN KEY (Book_ID) REFERENCES BOOK(Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES AUTHOR(Author_ID)
);

-- 6. สร้างตารางการยืม-คืน (BORROWING)
CREATE TABLE BORROWING (
    Borrow_ID INT IDENTITY(1,1) PRIMARY KEY,
    Member_ID CHAR(10),
    Book_ID CHAR(13),
    Borrow_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE NULL, -- ยอมให้เป็นค่าว่างได้ เพราะตอนยืมแรกๆ จะยังไม่มีวันคืน
    Fine_Amount DECIMAL(8,2) DEFAULT 0.00, -- ตั้งค่าเริ่มต้นค่าปรับเป็น 0
    FOREIGN KEY (Member_ID) REFERENCES MEMBER(Member_ID),
    FOREIGN KEY (Book_ID) REFERENCES BOOK(Book_ID)
);