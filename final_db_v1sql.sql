CREATE DATABASE project_final_v1
GO

USE project_final_v1
GO

CREATE TABLE ChucVu(
	MaChucVu			INT	
		IDENTITY(1,1) PRIMARY KEY,
	TenChucVu			NVARCHAR(50),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE NhanVien(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
	  MaNhanVien	VARCHAR(10) UNIQUE,
	  HoTen NVARCHAR(255),
    NgaySinh DATE,
    Email VARCHAR(50) UNIQUE,
    CCCD VARCHAR(255),
    SDT VARCHAR(15) UNIQUE,
    Tinh_ThanhPho NVARCHAR(150),
    Quan_Huyen NVARCHAR(150),
    Xa_Phuong NVARCHAR(150),
    So_Nha NVARCHAR(150),
    TrangThai int,
    Matkhau VARCHAR(15),
    MatKhauMaHoa VARCHAR(255),
    ChucVu int,
    CONSTRAINT FK_MaChucVu FOREIGN KEY(ChucVu) REFERENCES ChucVu(MaChucVu),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE KhachHang(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    MaKhachHang	VARCHAR(10) UNIQUE,
    HoTen NVARCHAR(20),
    Email VARCHAR(50) UNIQUE,
    SDT VARCHAR(15) UNIQUE,
    Tinh_ThanhPho NVARCHAR(150),
    Quan_Huyen NVARCHAR(150),
    Xa_Phuong NVARCHAR(150),
    So_Nha NVARCHAR(150),
    TrangThai int,
    Matkhau VARCHAR(15),
    MatKhauMaHoa VARCHAR(255),
    GioiTinh bit,
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE MauSac(
    Id INT	
		IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(50),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE HangXe(
    Id INT	
		IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(50),
    QuocGia VARCHAR(50),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE MauXe(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    Ten NVARCHAR(50),
    NamSanXuat int,
    HopSo NVARCHAR(50),
    DungTichXiLanh FLOAT(1),
    KichThuocTongThe int, /* kích thước tổng thể = Dài * Rộng * Chiều Cao (mm).*/
    NgayTao DATETIME,
    NgaySua DATETIME,
    IdHangXe int,
    IdMauSac int,
    CONSTRAINT FK_HangXe FOREIGN KEY(IdHangXe) REFERENCES HangXe(Id),
    CONSTRAINT FK_MauSac FOREIGN KEY(IdMauSac) REFERENCES MauSac(Id)
)
CREATE TABLE NhaCungCap(
    Id INT	
		IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(50),
    ThanhPho NVARCHAR(50),
    QuocGia NVARCHAR(50),
    DiaChi NVARCHAR(50),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE PhuKien(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    MaPhuKien VARCHAR(10) UNIQUE,
    TenPhuKien NVARCHAR(50),
    Gia MONEY,
    SoLuongTon int,
    NgayTao DATETIME,
    NgaySua DATETIME,
    IdNhaCungCap int,
    CONSTRAINT FK_NhaCungCap FOREIGN KEY(IdNhaCungCap) REFERENCES NhaCungCap(Id)
)
CREATE TABLE ChiTietPhuTung(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    SoLuong int,
    IdPhuKien UNIQUEIDENTIFIER,
    IdMauXe UNIQUEIDENTIFIER,
    CONSTRAINT FK_PhuKien FOREIGN KEY(IdPhuKien) REFERENCES PhuKien(Id),
    CONSTRAINT FK_MauXe FOREIGN KEY(IdMauXe) REFERENCES MauXe(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE LoaiDichVu(
    Id INT	
		IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(50),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE DichVu(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    Ten NVARCHAR(50),
    DonGia Money,
    IdPhuKien UNIQUEIDENTIFIER,
    IdLoaiDichVu int,
    CONSTRAINT FK_PhuKien_DichVu FOREIGN KEY(IdPhuKien) REFERENCES PhuKien(Id),
    CONSTRAINT FK_LoaiDichVu FOREIGN KEY(IdLoaiDichVu) REFERENCES LoaiDichVu(Id),
)
CREATE TABLE XeCuaKhach(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    MaXe VARCHAR(10) UNIQUE,
    BienSoXe VARCHAR(11),
    IdMauXe UNIQUEIDENTIFIER,
    IdKhachHang UNIQUEIDENTIFIER,
    CONSTRAINT FK_MauXe_XeCuaKhach FOREIGN KEY(IdMauXe) REFERENCES MauXe(Id),
    CONSTRAINT FK_KhachHang FOREIGN KEY(IdKhachHang) REFERENCES KhachHang(Id),
)
Alter TABLE DichVu ADD NgayTao DATETIME
ALTER TABLE DichVu ADD NgaySua DATETIME
Alter TABLE XeCuaKhach ADD NgayTao DATETIME
ALTER TABLE XeCuaKhach ADD NgaySua DATETIME
CREATE TABLE LichHen(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    MaLichHen VARCHAR(10) UNIQUE,
    ThoiGianDat DATETIME,
    TrangThai int,
    LoaiLichHen bit,
    ThoiGianDuKien nvarchar(50),
    SDT VARCHAR(15),
    IdKhachHang UNIQUEIDENTIFIER,
    CONSTRAINT FK_KhachHang_LichHen FOREIGN KEY(IdKhachHang) REFERENCES KhachHang(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE LichSuLichHen(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    TrangThai int,
    IdLichHen UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHen FOREIGN KEY(IdLichHen) REFERENCES LichHen(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE LichSuSuDungPhuKien(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    SoPhuKien int,
    IdLichHen UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHen_PhuKien FOREIGN KEY(IdLichHen) REFERENCES LichHen(Id),
    IdPhuKien UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHen_PhuKien_2 FOREIGN KEY(IdPhuKien) REFERENCES PhuKien(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE ChiTietLichHen(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    IdLichHen UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHenChiTiet FOREIGN KEY(IdLichHen) REFERENCES LichHen(Id),
    IdDichVu UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHenChiTiet_DichVu FOREIGN KEY(IdDichVu) REFERENCES DichVu(Id),
    IdXe UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHenChiTiet_Xe FOREIGN KEY(IdXe) REFERENCES XeCuaKhach(Id),
    IdNhanVien UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichHenChiTiet_NhanVien FOREIGN KEY(IdNhanVien) REFERENCES NhanVien(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE HoaDon(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    NgayNhanXe DATE,
    NgayTraXe DATE,
    TrangThai int,
    LoaiHoaDon bit,
    NgayThanhToan DATE,
    IdLichHen UNIQUEIDENTIFIER,
    CONSTRAINT FK_HoaDon_LichHen FOREIGN KEY(IdLichHen) REFERENCES LichHen(Id),
    IdNhanVien UNIQUEIDENTIFIER,
    CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY(IdNhanVien) REFERENCES NhanVien(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE HoaDonChiTiet(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    SoLanSuDungDichVu int,
    IdHoaDon UNIQUEIDENTIFIER,
    CONSTRAINT FK_HoaDonChiTiet FOREIGN KEY(IdHoaDon) REFERENCES HoaDon(Id),
    IdDichVu UNIQUEIDENTIFIER,
    CONSTRAINT FK_HoaDonChiTiet_DichVu FOREIGN KEY(IdDichVu) REFERENCES DichVu(Id),
    NgayTao DATETIME,
    NgaySua DATETIME
)
CREATE TABLE LichSuHoaDon(
    Id UNIQUEIDENTIFIER 
		DEFAULT NEWID() PRIMARY KEY,
    NgayThayDoiTrangThai DATETIME,
    TrangThai int,
    IdHoaDon UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichSuHoaDon FOREIGN KEY(IdHoaDon) REFERENCES HoaDon(Id),
    IdNhanVien UNIQUEIDENTIFIER,
    CONSTRAINT FK_LichSuHoaDon_NhanVien FOREIGN KEY(IdNhanVien) REFERENCES NhanVien(Id),
)
select * from LichHen
select * from KhachHang
select * from ChiTietLichHen
select * from LichSuLichHen

insert into LichHen (MaLichHen,ThoiGianDat,TrangThai,LoaiLichHen,ThoiGianDuKien,NgayTao,IdKhachHang,SDT) values ('LH1','2023-1-1 9:30',1,0,2,GETDATE(),'89f9a39e-738b-41c8-861b-0b268ad87ca7','092816377')
insert into NhanVien (MaNhanVien,HoTen,Email,SDT,TrangThai,ChucVu,NgayTao,MatKhau) values ('NV3','Chu Van Hieu2','hieu2@gmail.com','0359693209',0,2,GETDATE(),'$2a$10$Z8WFqPyBIyRkohGHFy1bYO8.j013BR8kSx2qnpqYCBgLZ07D5g1P6')
insert into ChucVu (TenChucVu,NgayTao) values ('STAFF',GETDATE())
insert into KhachHang (MaKhachHang,Email,SDT,GioiTinh,NgayTao,MatKhau,HoTen) values ('KH21','abaa@gmail.com','098765555',0,GETDATE(),'abc','Nguyen Van Tuan')
insert into ChiTietLichHen(NgayTao,NgaySua,IdLichHen) values (GETDATE(),GETDATE(),'469ed22b-9c5c-4977-87cd-094da2df6e01')
insert into LichSuLichHen(TrangThai,IdLichHen,NgayTao,NgaySua) values (1,'469ed22b-9c5c-4977-87cd-094da2df6e01',GETDATE(),GETDATE())
Alter table NhanVien Add Anh VARCHAR(255)
Alter table KhachHang Add Anh VARCHAR(255)
Alter table LoaiDichVu Add TrangThai bit
Alter table PhuKien Add Anh VARCHAR(255)

