create database QuanLyBanHang2;
use QuanLyBanHang2;
create table KhachHang(
clientId nvarchar(4) primary key,
clientName nvarchar(30) not null,
address nvarchar(50),
brithDay datetime,
phone nvarchar(15) unique
);
create table NhanVien(
staffId nvarchar(4) primary key,
staffName nvarchar(30) not null,
sex bit(1) not null,
birthDay datetime not null,
phone nvarchar(15),
email text,
address nvarchar(20) not null,
startDay datetime DEFAULT CURRENT_TIMESTAMP,
nqlId nvarchar(4)
);
create table NhaCungCap(
providerId nvarchar(5) primary key,
providerName nvarchar(50) not null,
address nvarchar(50) not null,
phone nvarchar(15) not null,
email nvarchar(30) not null,
website nvarchar(30)
);
create table LoaiSP(
producTypetId nvarchar(4) primary key,
producTypeName nvarchar(30) not null,
note nvarchar(100)
);
create table SanPham(
productId nvarchar(4) primary key,
producTypetId nvarchar(4) not null,
productName nvarchar(50) not null,
unit nvarchar(10) not null,
note nvarchar(100)
);
create table PhieuNhap(
importBillId nvarchar(5) primary key,
staffId nvarchar(4) not null,
providerId nvarchar(5)not null,
importDay datetime DEFAULT CURRENT_TIMESTAMP not null,
note nvarchar(100)
);
create table CtPhieuNhap(
productId nvarchar(4) not null,
importBillId nvarchar(5) not null,
primary key(productId,importBillId),
quantity smallint default 0 not null,
importPrice real not null check(importPrice>=0)
);
create table PhieuXuat(
billId nvarchar(5) primary key,
staffId nvarchar(4) not null,
clientId nvarchar(4) not null,
saleDay datetime not null,
note text
);
create table CtPhieuXuat(
billId nvarchar(5),
productId nvarchar(4),
quantity smallint  not null check(quantity>0),
salePrice real not null check(salePrice>0),
primary key(billId,productId)

);
-- Bai 2:
alter table PhieuXuat add foreign key (staffId) references NhanVien(staffId);
alter table PhieuXuat add foreign key (clientId) references KhachHang(clientId);
alter table CtPhieuXuat add foreign key (billId) references PhieuXuat(billId);
alter table CtPhieuXuat add foreign key (productId) references SanPham(productId);
alter table SanPham add foreign key(producTypetId) references LoaiSP(producTypetId);
alter table CtPhieuNhap add foreign key (productId) references SanPham(productId);
alter table CtPhieuNhap add foreign key (importBillId) references PhieuNhap(importBillId);
alter table PhieuNhap add foreign key (staffId) references NhanVien(staffId);
alter table PhieuNhap add foreign key (providerId) references NhaCungCap(providerId);
-- Bai 3:
insert into KhachHang (clientId,clientName,address) values ('KH01','Nguyen Van A','Ha Noi' );
insert into KhachHang (clientId,clientName,address) values ('KH02','Nguyen Van B','Da Nang' );
insert into KhachHang (clientId,clientName,address) values ('KH03','Nguyen Van C','Thanh Hoa' );
insert into KhachHang (clientId,clientName,address) values ('KH04','Nguyen Van D','Nha Trang' );
insert into KhachHang (clientId,clientName,address) values ('KH05','Nguyen Van E','Phu Quoc' );
update KhachHang set brithDay ='1993-01-01' where clientId ='KH01';
update KhachHang set brithDay ='1999-02-09' where clientId ='KH02';
update KhachHang set brithDay ='1989-04-05' where clientId ='KH03';
update KhachHang set brithDay ='1990-09-11' where clientId ='KH04';
update KhachHang set brithDay ='1994-09-14' where clientId ='KH05';

-- thêm Nhân viên.
insert into NhanVien (staffId, staffName, sex,birthDay, address ) values ('NV01','Nhan Vien 1', 1, '2011-12-18 13:17:17', 'Ha Noi');
insert into NhanVien (staffId, staffName, sex,birthDay, address ) values ('NV02','Nhan Vien 2', 0, '2000-2-15 10:10:10', 'Ha Tinh');
insert into NhanVien (staffId, staffName, sex,birthDay, address ) values ('NV03','Nhan Vien 3', 1, '2001-3-21 10:10:10', 'Hung Yen');
insert into NhanVien (staffId, staffName, sex,birthDay, address ) values ('NV04','Nhan Vien 4', 0, '2001-5-08 10:10:10', 'Bac Giang');
insert into NhanVien (staffId, staffName, sex,birthDay, address ) values ('NV05','Nhan Vien 5', 1, '2003-6-30 10:10:10', 'Vinh Long');
-- thêm nhà cung cấp
insert into NhaCungCap values('NCC01','Trường An', 'Quang Ninh', '012345678','truongan@gmail.com', '');
insert into NhaCungCap values('NCC02','Yokohama', 'Long An', '012345679','yokohama@gmail.com', '');
insert into NhaCungCap values('NCC03','An Hoạch', 'Cần Thơ', '012345654','anhoach@gmail.com', '');
insert into NhaCungCap values('NCC04','Anh Tuấn', 'Nam Định', '012345623','anhtuan@gmail.com', '');
insert into NhaCungCap values('NCC05','Ngọc Linh', 'Quy Nhơn', '012356678','ngoclinh@gmail.com', '');
-- thêm loại sản phẩm
insert into LoaiSP value('GD01','Đồ gia dụng','Đồ gia đình');
insert into LoaiSP value('GD02','Đồ Bếp','Đồ gia đình');
insert into LoaiSP value('GD03','Công Nghệ','Công nghệ mới');
insert into LoaiSP value('GD04','Công Xưởng','Quần áo, giầy');
insert into LoaiSP value('GD05','Thược phẩm chức năng ','Thuốc bổ');
insert into LoaiSP value('GD06','Mỹ phẩm','Mỹ phẩm Nam, Nữ');
-- thêm Sản Phẩm
insert into SanPham value('SP01','GD01','Nồi cơm điện', 'cái', '');
insert into SanPham value('SP02','GD01','Tủ lạnh', 'cái', '');
insert into SanPham value('SP03','GD02','Bếp Ga', 'cái', '');
insert into SanPham value('SP04','GD02','Nồi áp suất', 'cái', '');
insert into SanPham value('SP05','GD03','Sạc Không Dây', 'cái', '');
insert into SanPham value('SP06','GD03','Tai Nghe ', 'cái', '');
insert into SanPham value('SP07','GD04','Quần dài', 'cái', '');
insert into SanPham value('SP08','GD04','Áo chống nắng', 'cái', '');
insert into SanPham value('SP09','GD05','VitaminC', 'Lọ', '');
insert into SanPham value('SP10','GD05','Bổ Gan', 'Lọ', '');
insert into SanPham value('SP11','GD06','Dưỡng trắng', 'Tuýt', '');
insert into SanPham value('SP12','GD06','Trị mụn', 'tuýt', '');
-- thêm phiếu nhập
insert into PhieuNhap value('SP01','NV01','NCC01','2023-9-01 10:10:10','Phiếu nhập 1');
insert into PhieuNhap value('SP05','NV02','NCC04','2023-9-13 10:10:10','Phiếu nhập 2');
insert into PhieuNhap value('SP06','NV03','NCC02','2018-6-13','Phiếu nhập 3');
update PhieuNhap set importBillId = 'PN01' where importBillId = 'SP01';
update PhieuNhap set importBillId = 'PN02' where importBillId = 'SP05';
-- chi tiết phiếu nhập
insert into CtPhieuNhap value('SP02','PN01', 2,10000);
insert into CtPhieuNhap value('SP08','PN02', 2,20000);
-- thêm phiêu xuất 
insert into PhieuXuat value('PX01','NV01', 'KH02','2023-9-10', '');
insert into PhieuXuat value('PX02','NV04', 'KH05','2023-9-11', '');
insert into PhieuXuat value('PX03','NV02', 'KH03','2023-5-11', '');
insert into PhieuXuat value('PX04','NV03', 'KH04','2023-1-11', '');
-- chi tiết phiếu xuất
insert into CtPhieuXuat value('PX01','SP11',2, 30000);
insert into CtPhieuXuat value('PX02','SP09',2, 5000);
insert into CtPhieuXuat value('PX03','SP06',5, 20000);
insert into CtPhieuXuat value('PX04','SP02',4, 15000);
-- xoá nhân viên
delete from NhanVien where staffId = 'NV05';
-- xoá sản phẩm 
delete from SanPham where productId = 'SP12';
-- Bài 6. Dùng Select lấy dữ liệu từ các bảng.
-- 1. liệt kê thông tin nhân viên
select
nv.staffId  as 'Mã NV',
nv.staffName as 'Họ và tên',
nv.sex as 'Giới Tính',
DATE_FORMAT(nv.birthDay,'%Y-%m-%d' ) as ' Ngày Sinh',
timestampdiff(YEAR,nv.birthDay, CURRENT_TIMESTAMP)  as 'Tuổi',
nv.address as 'Địa chỉ',
nv.phone as 'Số ĐT'
from NhanVien nv;
-- Liệt kê các hóa đơn nhập hàng trong tháng 6/2018, gồm thông tin số phiếu
-- nhập, mã nhân viên nhập hàng, họ tên nhân viên, họ tên nhà cung cấp, ngày
-- nhập hàng, ghi chú.
select 
pn.importBillId as 'Số phiếu nhập',
pn. staffId as 'Mã NV',
(select nv.staffName from NhanVien nv where pn. staffId = nv. staffId) as 'Tên Nhân Viên',
(select ncc.providerName from NhaCungCap ncc where pn.providerId = ncc.providerId ) as 'Nhà Cung Cấp',
DATE_FORMAT(pn.importDay,'%Y-%m-%d' ) as 'Ngày Nhập Hàng',
pn.note as 'Ghi Chú'
from PhieuNhap pn
where Year(pn.importDay) = '2018' and Month(pn.importDay) = '6';
-- 6.3. Liệt kê tất cả sản phẩm có đơn vị tính là cái, gồm tất cả thông tin về sản phẩm.
select * 
from SanPham sp
where sp.unit like 'cái';
-- 6.4 Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin: số phiếu
-- nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá
-- nhập, thành tiền.
select 
ctn.importBillId as 'Số Phiếu Nhập',
ctn.productId as 'Mã sản Phẩm',
sp.productName as 'Tên Sản Phẩm',
lsp.producTypeName as 'Loại Sản Phẩm',
ctn.quantity as 'Số lượng',
ctn.importPrice as 'Giá Nhập',
(ctn.quantity * ctn.importPrice) as 'Thành tiền'
from (CtPhieuNhap ctn Inner join SanPham sp on ctn.productId = sp.productId)
Inner join LoaiSP lsp on sp.producTypetId = lsp.producTypetId
where MONTH(CURRENT_TIMESTAMP) = pn.importDay;
-- 6.5 Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm
-- thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại,
-- email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng.
select 
ncc.providerId as 'Mã Nhà CC',
ncc.providerName as 'Tên Nhà cung cấp',
ncc.address as 'Địa Chỉ',
ncc.phone,
ncc.email,
pn.importBillId,
pn.importDay
from NhaCungCap ncc inner join PhieuNhap pn on pn.providerId = ncc.providerId
where MONTH(CURRENT_TIMESTAMP) = MONTH(pn.importDay)
ORDER BY pn.importDay;

-- 6.6 Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2018 gồm thông tin:
-- số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm,
-- đơn vị tính, số lượng, giá bán, doanh thu.
select 
px.billId as 'Số phiếu xuất',
nv.staffName as 'Nhân viên bán hàng',
px.saleDay as 'Ngày bán',
ctpx.productId as 'Mã Sản phẩm',
sp.productId as 'Tên Sản phẩm',
sp.unit as 'đơn vị',
ctpx.quantity as 'số lượng',
ctpx.salePrice as 'Giá bán',
(ctpx.quantity * ctpx.salePrice)as 'Doanh Thu'
from ((PhieuXuat px inner join NhanVien nv on px.staffId = nv.staffId) 
inner join CtPhieuXuat ctpx on ctpx.billId = px.billId)
inner join SanPham sp on sp.productId = ctpx.productId 
where Year(CURRENT_TIMESTAMP) = Year(px.saleDay)
and Month(px.saleDay) BETWEEN '1' and '6'
;
-- 6.7 Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành (gồm
-- tất cả thông tin của khách hàng)
select * from KhachHang kh where Month(kh.brithDay)=month(current_timestamp());
-- 6.8Liệt kê các hóa đơn bán hàng từ ngày 01/01/2023 đến 15/06/2023 gồm các
-- thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên
-- sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
select 
px.billId as 'Số phiếu xuất',
nv.staffName as 'Nhân viên bán hàng',
px.saleDay as 'Ngày bán',
ctpx.productId as 'Mã Sản phẩm',
sp.productId as 'Tên Sản phẩm',
sp.unit as 'đơn vị',
ctpx.quantity as 'số lượng',
ctpx.salePrice as 'Giá bán',
(ctpx.quantity * ctpx.salePrice)as 'Doanh Thu'
from ((PhieuXuat px inner join NhanVien nv on px.staffId = nv.staffId) 
inner join CtPhieuXuat ctpx on ctpx.billId = px.billId)
inner join SanPham sp on sp.productId = ctpx.productId 
where  px.saleDay BETWEEN date('2023-01-01') and date('2023-06-15');
-- 6.9 Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin: số
-- phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá.
select 
px.clientId,
kh.clientName,
px.billId,
px.saleDay,
(ctpx.quantity * ctpx.salePrice) as 'Tổng trị giá'
from (PhieuXuat px inner join CtPhieuXuat ctpx on ctpx.billId = px.billId)
inner join KhachHang kh on px.clientId = kh.clientId;

-- 6.10 Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm
-- 2018. Thông tin hiển thị: tổng số lượng.
select sum(ctpx.quantity) as 'Tổng số lượng'
from CtPhieuXuat ctpx join SanPham sp on sp.productid = ctpx.productid
where sp.productName = 'Tai Nghe';