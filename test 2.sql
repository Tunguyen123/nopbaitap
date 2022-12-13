
---câu 1-----
create database [kiem tra 2]
go
use [kiem tra 2]
go

create table vattu(
mavt nvarchar(20) primary key,
tenvt varchar(20),
dvtinh nvarchar(20),
sl int
)

create table hdban(
mahd nvarchar(20) primary key,
ngayxuat date,
hotenkh nvarchar(20),

)

create table hangxuat(
mahd nvarchar(20) ,
mavt varchar(20),
dongia int,
slban int,
 Constraint hangxuat_pk primary key (mahd, mavt)
)
alter table hangxuat add constraint fk_hangxuat_hdban
foreign key (mahd) references hdban (mahd);
alter table hangxuat add constraint fk_hangxuat_vattu
foreign key (mavt) references vattu (mavt);


insert into vattu(mavt,tenvt,dvtinh,sl)
values ('A01','Xi mang','Tui',200),
 ('A02','Cat','Tan',600)

 insert into hdban(mahd ,ngayxuat,hotenkh)
values ('B01','2022/02/10','Nguyen Van A'),
 ('B02','2022/05/11','Nguyen Thi Tam')

 insert into hangxuat(mahd,mavt,dongia,slban)
values ('B01','A01',1000,200),
 ('B02','A02',2000,200),
 ('B03','A03',10000,500),
 ('B04','A04',30000,100)

 
 ---câu 2---
 select top 1 (slban* dongia) as 'Tong tien ', mahd 
 from  hangxuat
 order by [Tong tien ] desc  
 --cau 3--
 create function p3 (
    @mahd varchar(10)
)
return table
as
return 
    select
        hx.mahd,
        hd.ngayxuat,
        hd.mahd,
        hx.dongia,
        hx.slban,  
        case
            when weekday(hd.ngayxuat) = 0 then N'Th? hai'            
            when weekday(hd.ngayxuat) = 1 then N'Th? ba'
            when weekday(hd.ngayxuat) = 2 then N'Th? t?'
            when weekday(hd.ngayxuat) = 3 then N'Th? n?m'
            when weekday(hd.ngayxuat) = 4 then N'Th? sáu'
            when weekday(hd.ngayxuat) = 5 then N'Th? b?y'
            else N'Ch? nh?t'
        end as ngaythu
    from hangxuat HX
    inner  join HDBAN HD on HX.MAHD = HD.MAHD
    where hx.mahd = @mahd;

 --cau 4--
create proc cau4 
@thang int, @nam int 
as
select
sum(slban * dongia)
from hangxuat hx
inner join hdban hd on hx.mahd = hd.mahd
where month(hd.ngayxuat) = @thang and year(hd.ngayxuat) = @nam;