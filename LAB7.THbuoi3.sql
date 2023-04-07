---Cau1---
CREATE PROCEDURE sp_InsertHangsx
    @mahangsx nvarchar(10),
    @tenhang nvarchar(50),
    @diachi nvarchar(100),
    @sodt nvarchar(20),
    @email nvarchar(50)
AS
BEGIN
    IF EXISTS(SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'T�n h�ng s?n xu?t ?� t?n t?i. Vui l�ng ki?m tra l?i!'
    END
    ELSE
    BEGIN
        INSERT INTO Hangsx(mahangsx, tenhang, diachi, sodt, email)
        VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
    END
END

EXEC sp_InsertHangsx 'HSX01', 'Samsung', 'H�n Qu?c', '0123456789', 'contact@samsung.com'

---C�u 2---
CREATE PROCEDURE sp_ThemSuaSanPham
    @masp NVARCHAR(10),
    @mahangsx NVARCHAR(10),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(20),
    @mota NVARCHAR(200)
AS
BEGIN
    IF EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        UPDATE Sanpham SET 
            mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp
    END
    ELSE
    BEGIN
        INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    END
END
EXEC sp_ThemSuaSanPham 'SP01', 'H01', 'Galaxy Note 11', '50', '??','1900000.00','Chi?c','H�ng c?n c?o c?p'


---C�u 3---

CREATE PROCEDURE sp_DeleteHangSX
    @tenhang NVARCHAR(50)
AS
BEGIN
    
    IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'H�ng kh�ng t?n t?i trong b?ng'
        RETURN
    END

    BEGIN TRANSACTION

    DELETE FROM Sanpham WHERE mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang)

    
    DELETE FROM Hangsx WHERE tenhang = @tenhang

    COMMIT TRANSACTION
END

---C�u 4---
CREATE PROCEDURE sp_NhapNhanVien
    @manv VARCHAR(10),
    @tennv NVARCHAR(50),
    @gioitinh NVARCHAR(3),
    @diachi NVARCHAR(100),
    @sodt VARCHAR(20),
    @email NVARCHAR(50),
    @phong NVARCHAR(50),
    @flag BIT
AS
BEGIN
    IF @flag = 0
    BEGIN
        UPDATE Nhanvien
        SET tennv = @tennv,
            gioitinh = @gioitinh,
            diachi = @diachi,
            sodt = @sodt,
            email = @email,
            phong = @phong
        WHERE manv = @manv;
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
        BEGIN
            RAISERROR('M� nh�n vi�n ?� t?n t?i!', 16, 1);
            RETURN;
        END
        INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong);
    END
END

---C�u 5---

CREATE PROCEDURE ThemNhap(@sohdn varchar(20), @masp varchar(20), @manv varchar(20), @ngaynhap date, @soluongN int, @dongiaN float)
AS
BEGIN
    
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'M� s?n ph?m kh�ng t?n t?i'
        RETURN
    END
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'M� nh�n vi�n kh�ng t?n t?i'
        RETURN
    END

  
    IF EXISTS(SELECT * FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        UPDATE Nhap SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    END
    ELSE 
    BEGIN
        INSERT INTO Nhap(sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES(@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    END

   
    IF EXISTS(SELECT * FROM Xuat WHERE sohdx = @sohdn)
    BEGIN
        UPDATE Xuat SET masp = @masp, manv = @manv, ngayxuat = @ngaynhap, soluongX = @soluongN
        WHERE sohdx = @sohdn
    END
    ELSE 
    BEGIN
        DECLARE @sohdx varchar(20)
        SET @sohdx = 'X' + @sohdn
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES(@sohdx, @masp, @manv, @ngaynhap, @soluongN)
    END
END

---C�u 6---
CREATE PROCEDURE them_capnhat_Xuat 
(
    @sohdx INT,
    @masp INT,
    @manv INT,
    @ngayxuat DATE,
    @soluongX INT
)
AS
BEGIN
    
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'M� s?n ph?m kh�ng t?n t?i trong b?ng Sanpham.'
        RETURN
    END
    
    
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'M� nh�n vi�n kh�ng t?n t?i trong b?ng Nhanvien.'
        RETURN
    END
    
    
    IF @soluongX > (SELECT soluong FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'S? l??ng xu?t v??t qu� s? l??ng t?n kho.'
        RETURN
    END
    
    
    IF EXISTS (SELECT * FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
        UPDATE Xuat 
        SET masp = @masp, manv = @manv, ngayxuat = @ngayxuat, soluongX = @soluongX 
        WHERE sohdx = @sohdx
        PRINT 'C?p nh?t d? li?u b?ng Xuat th�nh c�ng.'
    END
    ELSE
    BEGIN
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
        PRINT 'Th�m d? li?u v�o b?ng Xuat th�nh c�ng.'
    END
END

---C�u 7---
CREATE PROCEDURE sp_DeleteNhanvien 
    @manv INT
AS
BEGIN
    
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'Kh�ng t�m th?y nh�n vi�n v?i m� ' + CAST(@manv AS NVARCHAR)
        RETURN
    END

   
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv

 
    DELETE FROM Nhanvien WHERE manv = @manv

    PRINT '?� x�a nh�n vi�n v?i m� ' + CAST(@manv AS NVARCHAR)
END


---C�u 8---
CREATE PROCEDURE sp_DeleteSanpham
  @masp VARCHAR(10)
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM Sanpham WHERE masp = @masp)
  BEGIN
    PRINT 'Kh�ng t�m th?y s?n ph?m ?? x�a!'
    RETURN;
  END

  BEGIN TRY
    BEGIN TRANSACTION

  
    DELETE FROM Nhap WHERE masp = @masp;

    
    DELETE FROM Xuat WHERE masp = @masp;

   
    DELETE FROM Sanpham WHERE masp = @masp;

    COMMIT TRANSACTION
    PRINT '?� x�a s?n ph?m ' + @masp
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT '?� x?y ra l?i trong qu� tr�nh x�a s?n ph?m!'
  END CATCH
END