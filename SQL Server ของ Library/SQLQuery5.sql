USE DigitalLibraryDB; -- เปลี่ยนชื่อเป็น Database ของคุณ
GO

SELECT 
    BR.Borrow_ID AS 'รหัสการยืม',
    M.First_Name + ' ' + M.Last_Name AS 'ชื่อผู้ยืม',
    B.Title AS 'ชื่อหนังสือ',
    BR.Borrow_Date AS 'เวลายืม',
    BR.Due_Date AS 'กำหนดคืน',      -- เพิ่มคอลัมน์นี้
    BR.Return_Date AS 'เวลาคืน',
    BR.Fine_Amount AS 'ค่าปรับ (บาท)', -- เพิ่มคอลัมน์นี้
    CASE 
        WHEN BR.Return_Date IS NULL THEN 'ยังไม่คืน (ถูกยืมอยู่)'
        ELSE 'คืนแล้ว'
    END AS 'สถานะหน้าเว็บ'
FROM BORROWING BR
JOIN MEMBER M ON BR.Member_ID = M.Member_ID
JOIN BOOK B ON BR.Book_ID = B.Book_ID
ORDER BY BR.Borrow_Date DESC;

-- คำสั่งลบประวัติการยืมทั้งหมด
DELETE FROM BORROWING;
GO

คำสั่งลบเฉพาะคนที่ "คืนแล้ว"
USE DigitalLibraryDB;
GO

-- ลบเฉพาะรายการที่มีวันที่คืนแล้ว
DELETE FROM BORROWING WHERE Return_Date IS NOT NULL;
GO

วิธีสังเกตในตาราง:

ถ้ายังไม่คืน: ในคอลัมน์ Return_Date จะเป็นค่า NULL (ว่างเปล่า)

ถ้าคืนแล้ว: ในคอลัมน์ Return_Date จะมี "วันที่และเวลา" ระบุไว้ชัดเจน

USE DigitalLibraryDB;
GO

-- แกล้งแก้ Due_Date ของการยืมล่าสุดให้เป็นวันที่ 1 มีนาคม 2026 (เพื่อให้มันเลยกำหนด)
UPDATE BORROWING 
SET Due_Date = '2026-03-01' 
WHERE Borrow_ID = (SELECT MAX(Borrow_ID) FROM BORROWING);