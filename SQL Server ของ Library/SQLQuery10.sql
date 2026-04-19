USE DigitalLibraryDB;
GO

SELECT 
    bk.Book_ID AS 'รหัสหนังสือ',
    bk.Title AS 'ชื่อหนังสือ',
    
    -- 1. เช็คสถานะ: ถ้ามีข้อมูลในตารางยืมและยังไม่คืน = ถูกยืมอยู่
    CASE 
        WHEN br.Borrow_ID IS NOT NULL THEN 'ถูกยืมอยู่'
        ELSE 'ว่าง'
    END AS 'สถานะปัจจุบัน',

    -- 2. แสดงชื่อคนยืม (ถ้ามี)
    ISNULL(m.First_Name + ' ' + m.Last_Name, '-') AS 'ผู้ยืมปัจจุบัน',
    
    -- 3. แสดงวันกำหนดคืน
    br.Due_Date AS 'กำหนดส่งคืน',

    -- 4. คำนวณค่าปรับแบบ Real-time (วันละ 5 บาท)
    CASE
        -- ถ้าถูกยืมอยู่ และเลยกำหนดคืนแล้ว ให้คำนวณ: วันที่เลยกำหนด x 5 บาท
        WHEN br.Borrow_ID IS NOT NULL AND GETDATE() > br.Due_Date 
             THEN DATEDIFF(day, br.Due_Date, GETDATE()) * 5.00
        -- ถ้าว่าง หรือยังไม่เลยกำหนด ให้ค่าปรับเป็น 0
        ELSE 0.00
    END AS 'ค่าปรับสะสม (บาท)'

FROM BOOK bk
-- ใช้ LEFT JOIN เพื่อเอาหนังสือ "ทุกเล่ม" เป็นหลัก แม้จะไม่มีคนยืมก็ตาม
-- และดึงมาเฉพาะรายการยืมที่ "ยังไม่ได้คืน" (Return_Date IS NULL)
LEFT JOIN BORROWING br ON bk.Book_ID = br.Book_ID AND br.Return_Date IS NULL
LEFT JOIN MEMBER m ON br.Member_ID = m.Member_ID

ORDER BY 'สถานะปัจจุบัน' DESC, 'ค่าปรับสะสม (บาท)' DESC;