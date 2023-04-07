
---CÂU 1---
--A.--
CREATE TABLE giaovien (
magv nvarchar(30) PRIMARY KEY,
tengv nvarchar(100)
);
CREATE TABLE lop (
malop nvarchar(30) PRIMARY KEY,
tenlop nvarchar(50),
phong nvarchar(50),
Siso nvarchar(50),
magv nvarchar(30),
);
CREATE table sinhvien(
masv nvarchar(50),
tensv nvarchar(50),
gioitinh nvarchar(50),
quequan nvarchar(50),
malop nvarchar(30),
);
ALTER TABLE lop ADD CONSTRAINT FK_lop_giaovien FOREIGN KEY (magv) REFERENCES giaovien(magv);
ALTER TABLE sinhvien ADD CONSTRAINT FK_sinhvien_malop FOREIGN KEY (malop) REFERENCES lop(malop);
--B.---
insert into giaovien(magv,tengv)
values ('GV01','Bùi Th? Lan '),
('GV02','Tr?n V?n An '),
('GV03','?ào Th? Thanh  ')

insert into lop (malop,tenlop,phong,Siso,magv)
values ('PH01','Công ngh? thông tin 1','P01','20','GV01'),
('PH02','Công ngh? thông tin 2','P02','50','GV02'),
('PH03','Công ngh? thông tin 3','P02','40','GV03')
insert into sinhvien(masv, tensv, gioitinh, quequan, malop)
VALUES
('001', 'Nguy?n V?n Tú', 'Nu', 'HCM', 'PH01'),
('002', 'Ph?m Thành Công', 'Nam', 'HCM', 'PH01'),
('003', 'Tr?n Th? Lan', 'Nu', 'HCM', 'PH01'),
('004', 'Bùi Th? Tuy?n ', 'Nu', 'HCM', 'PH02'),
('005', 'Pham Quynh Giang', 'Nu', 'Dong Nai', 'PH03');
select * from sinhvien
select * from giaovien
select * from lop 
--CÂU 2:----
create function DanhSachSinhVien()
RETURNS TABLE
AS
RETURN
    SELECT SinhVien.tensv, lop.tenlop, giaovien.tengv FROM sinhvien
    INNER JOIN Lop ON sinhvien.malop = lop.malop
    INNER JOIN giaovien ON lop.magv = giaovien.magv;

---CÂU 3:---
CREATE PROCEDURE ThemSinhVien
    @MaSV varchar(10),
    @TenSV varchar(50),
    @GioiTinh varchar(3),
    @quequan varchar(100),
    @TenLop varchar(50)
AS
BEGIN
    
    IF NOT EXISTS(SELECT 1 FROM lop WHERE tenlop = @TenLop)
    BEGIN
        PRINT 'L?p ' + @TenLop + ' không t?n t?i.'
        RETURN
    END

    
    DECLARE @MaLop varchar(10)
    SELECT @MaLop = MaLop FROM lop WHERE tenlop = @TenLop

    
    INSERT INTO sinhvien(masv, tensv, gioitinh, quequan, malop) VALUES (@MaSV, @TenSV, @GioiTinh, @quequan, @MaLop)

    PRINT 'Thêm sinh viên ' + @TenSV + ' thành công.'
END
