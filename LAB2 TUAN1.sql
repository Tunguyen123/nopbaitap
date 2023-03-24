--Câu 1---
SELECT* FROM Sanpham 
SELECT* FROM Hangsx 
SELECT* FROM Nhanvien
SELECT* FROM Nhap
SELECT* FROM Xuat

---Câu 2---
select masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota from Sanpham
inner join Hangsx on  Sanpham.mahangsx=Hangsx.mahangsx
order by  giaban desc
--- Câu 3---
select * from Sanpham
inner join Hangsx on Sanpham.mahangsx=Hangsx.mahangsx
where tenhang='samsung'
---Câu 4----
select * from Nhanvien
where gioitinh='Nữ'
--Câu 5---
select *,(soluongN*dongiaN)as tiennhap  from Nhap
order by sohdn asc
--Câu 6---
select * from Xuat
inner join Sanpham on Xuat.masp=Sanpham.masp
inner join Nhanvien on Xuat.manv=Nhanvien.manv
order by sohdx asc
---câu 7---
SELECT sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap 
inner JOIN Sanpham ON Nhap.masp = Sanpham.masp 
inner JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
inner JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2017;
--câu 8---
SELECT TOP 10 Xuat.sohdx, Sanpham.tensp, Xuat.soluongX
FROM Xuat 
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = '2023' 
ORDER BY Xuat.soluongX DESC;
---câu 9---
select top 10  tensp,giaban  from Sanpham
order by giaban desc
--câu 10--
select * from Sanpham
inner join Hangsx on Hangsx.tenhang=Sanpham.mahangsx
where (100000< giaban and giaban < 500000 )and tenhang='samsung '
--câu 11--
select sum((soluongN * dongiaN)) as tongtien from Nhap
inner join Sanpham on Sanpham.masp= Nhap.masp
inner join Hangsx on Sanpham.mahangsx=Hangsx.mahangsx
where tenhang='samsung' and year(ngaynhap)=2018
---câu12--
select sum((soluongX* giaban )) as tongtien from Xuat
inner join Sanpham on Sanpham.masp=Xuat.masp
where ngayxuat='2018-09-02'
--câu 13--
SELECT TOP 1 sohdn, ngaynhap, dongiaN
FROM Nhap
where year(ngaynhap)=2018
ORDER BY dongiaN DESC
---câu 14--
select top 10 tensp from Nhap
inner join Sanpham on Nhap.masp=Sanpham.masp
where YEAR(ngaynhap)=2019
order by soluongN desc
--câu 15--
SELECT Sanpham.masp, Sanpham.tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND Nhanvien.manv = 'NV01';
--câu 16--
select sohdn,Nhap.masp,soluongN,ngaynhap from Nhap
inner join Sanpham on  Sanpham.masp=Nhap.masp
inner join Xuat on Sanpham.masp=Xuat.masp
inner join Nhanvien on Xuat.manv=Nhanvien.manv
where Nhap.masp='SP02' and Xuat.manv='NV02'
--câu 17--
select Nhanvien.manv,tennv from Nhanvien
join Xuat on Nhanvien.manv=Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02'

