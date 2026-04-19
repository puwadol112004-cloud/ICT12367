--เรียกดูรายชื่อบัญชี Admin (ที่เห็นในรูป)
USE DigitalLibraryDB;
GO

SELECT id, username, email, is_staff, is_superuser 
FROM auth_user;

--เรียกดูข้อมูลสมาชิก (ตารางที่เราสร้างเอง)
SELECT * FROM MEMBER;

--เรียกดูประวัติการยืม-คืน (ตารางธุรกรรม)
SELECT 
    b.Borrow_ID, 
    m.First_Name + ' ' + m.Last_Name AS MemberName, 
    bk.Title, 
    b.Borrow_Date, 
    b.Due_Date, 
    b.Fine_Amount
FROM BORROWING b
JOIN MEMBER m ON b.Member_ID = m.Member_ID
JOIN BOOK bk ON b.Book_ID = bk.Book_ID;