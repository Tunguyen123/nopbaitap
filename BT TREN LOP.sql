- cau2.2
CHỌN  *  TỪ SANPHAM,KHACHHANG
-- cau2.3
UPDATE SANPHAM SET GIA = GIA + GIA / ( 100 / 5 ) WHERE NUOCSX = ' Thai Lan '
-- cau2.4
UPDATE SANPHAM SET GIA = GIA / ( 100 / 5 ) + GIA WHERE NUOCSX = ' TRUNG QUOC '  AND GIA > 10000
-- cau2.5
UPDATE KHACHHANG SET LOAIKH = ' Vip '  WHERE (NGDK < ' 2011/1/1 '  AND DOANHSO >= 10000000 ) OR (NGDK > ' 1/1 2011 '  AND DOANHSO >= 2000000 )

-- ------phần III-----------
-- 1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
CHỌN MASP, TENSP
TỪ SANPHAM
NƠI NUOCSX =  ' TRUNG QUỐC '
-- 2. In ra danh sách các sản phẩm (MASP, TENSP) có một đơn vị tính là “cây”, “quyen”.
CHỌN MASP, TENSP
TỪ SANPHAM
DVT Ở ĐÂU ( ' CAY ' , ' QUYEN ' )
-- 3. Trong danh sách các sản phẩm (MASP,TENSP) ra danh sách có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
CHỌN MASP, TENSP
TỪ SANPHAM
NƠI MASP NHƯ ' B%01 '
-- 4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
CHỌN MASP,TENSP,NUOCSX
TỪ SANPHAM
NƠI NUOCSX =  ' TRUNG QUỐC '
VÀ GIA GIỮA 30000  VÀ  40000
-- 5. Trong danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất ra có giá từ 30.000 đến 40.000.
CHỌN MASP, TENSP, NUOCSX
TỪ SANPHAM
WHERE (NUOCSX =  ' TRUNG QUOC '  OR NUOCSX =  ' THAI LAN ' ) VÀ GIA GIỮA 30000  VÀ  40000
-- 6. Trong các số hóa đơn, giá trị hóa đơn bán ra trong ngày 1/1/2007 và ngày 1/2/2007.
CHỌN SOHD, TRIGIA
TỪ HOAĐON
WHERE NGHD >=  ' 1/1/2007 '  VÀ NGHD <=  ' 2/1/2007 '
-- 7. Trong các số hóa đơn, giá trị hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và giá trị của hóa đơn (giảm dần).
CHỌN SOHD, TRIGIA
TỪ HOAĐON
TRONG ĐÓ THÁNG(NGHD) = 1  VÀ  NĂM (NGHD) =  2007
ĐẶT HÀNG THEO NGHD ASC , TRIGIA DESC
-- 8. Trong danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
CHỌN  K . MAKH , HOTEN
TỪ KHACHHANG K INNER THAM GIA HOADON H
TRÊN  K . MAKH  =  H . MAKH
WHERE NGHD =  ' 1/1/2007 '
-- 9. Trong ra số hóa đơn, giá trị của các đơn hóa đơn do nhân viên có tên “Nguyễn Văn B” lập vào ngày 28/10/2006.
CHỌN SOHD, TRIGIA
TỪ HOADON H INNER JOIN NHANVIEN N
TRÊN  H . MANV  =  N . MANV
WHERE NGHD =  ' 28/10/2006 '
VÀ HOTEN =  ' NGUYỄN VĂN B '
-- 10. Trong danh sách các sản phẩm (MASP,TENSP) được khách hàng tên “Nguyen Van A” mua vào tháng 10/2006.
CHỌN DISTINCT  S . MASP , TENSP
TỪ SANPHAM S INNER THAM GIA CTHD C
BẬT  S . MAS  =  C . MASP
VÀ TỒN TẠI ( CHỌN  *
TỪ CTHD C INNER THAM GIA HOADON H
TRÊN  C . SOHD  =  H . SOHD
VÀ THÁNG(NGHD) =  10  VÀ NĂM(NGHD) =  2006  AND MAKH IN ( SELECT  H . MAKH
TỪ HOADON H INNER JOIN KHACHHANG K
TRÊN  H . MAKH  =  K . MAKH
WHERE HOTEN =  ' NGUYEN VAN A ' ) AND  S . MAS  =  C . MASP )