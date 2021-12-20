CREATE DATABASE Examination;
USE Examination;

CREATE TABLE Students (
MaSv int primary key,
HoTen varchar(50),
GioiTinh varchar(50),
NgaySinh date,
MaLop int,
HocBong varchar(50),
DiaChi varchar(50)
);

CREATE TABLE Course (
MaKhoa int primary key,
TenKhoa varchar(50),
SoCBGD int
);

CREATE TABLE Class (
MaLop int primary key,
TenLop varchar(50),
MaKhoa int
);

CREATE TABLE Subjects (
MaMH int primary key,
TenMH varchar(50),
SoTiet int
);

CREATE TABLE Result (
MaSV int,
MaMH int,
DiemThi int
);

ALTER TABLE Result ADD constraint cont_MaSV foreign key (MaSV) references Students (MaSV);
ALTER TABLE Result ADD constraint cont_MaMH foreign key (MaMH) references Subjects (MaMH);
ALTER TABLE Class ADD constraint cont_MaKhoa foreign key (MaKhoa) references Course (Makhoa);
ALTER TABLE Students ADD constraint cont_MaLop foreign key (MaLop) references Class (MaLop);

INSERT INTO Result VALUES (1, 4, 10),
(2, 4, 7),
(3, 3, 9),
(4, 3, 7),
(5, 2, 5),
(6, 2, 4),
(1, 1, 3),
(2, 1, 9),
(3, 2, 2),
(4, 1, 4),
(5, 4, 6);

-- Liệt kê danh sách các lớp của khoa, thông tin cần Malop, TenLop, MaKhoa
Select Course.TenKhoa, Class.MaLop, Class.TenLop, Course.MaKhoa
FROM Class Join 
Course on Class.MaKhoa = Course.MaKhoa
Group by Course.TenKhoa;

-- Lập danh sách sinh viên gồm: MaSV, HoTen, HocBong
Select MaSv, HoTen, HocBong From Students;

-- Lập danh sách sinh viên có học bổng. Danh sách cần MaSV, Nu, HocBong
Select MaSv, GioiTinh, HocBong From Students;

--  Lập danh sách sinh viên có họ ‘Trần’
Select * From Students
Where HoTen Like 'Tran%';

-- Lập danh sách sinh viên nữ có học bổng
Select * From Students
Where GioiTinh = 'Nu' AND HocBong IS NOT Null;

-- Lập danh sách sinh viên nữ hoặc danh sách sinh viên có học bổng
Select * From Students
Where GioiTinh = 'Nu';

-- Lập danh sách sinh viên có năm sinh từ 1978 đến 1985. 
-- Danh sách cần các thuộc tính của quan hệ SinhVien
Select * From Students
Where YEAR(NgaySinh) Between 1978 AND 1985;

-- Liệt kê danh sách sinh viên được sắp xếp tăng dần theo MaSV
Select * From Students
Order by MaSv;

-- Liệt kê danh sách sinh viên được sắp xếp giảm dần theo HocBong
Select * From Students
Order by HocBong DESC;

-- Lập danh sách sinh viên có học bổng của khoa Java. Thông tin cần: MaSV, 
Select * From Students
Where HocBong = 'Java';

-- Cho biết số sinh viên của mỗi lớp
Select Class.TenLop, count(Students.MaLop)As NumberOfStudent From Students 
Join Class on Students.Malop = Class.Malop
Group By Class.TenLop;

--  Cho biết số lượng sinh viên của mỗi khoa.
Create View NumberOfStudents AS
Select Course.TenKhoa, Course.MaKhoa, count(Class.MaKhoa) as NumberOfStudent 
From Course
 Join Class on Course.MaKhoa = Class.MaKhoa
 Join Students on Class.Malop = Students.Malop
Group By Course.TenKhoa; 

Select * From NumberOfStudents;

-- Cho biết số lượng sinh viên nữ của mỗi khoa.
Create View NumberOfFemaleStudents As
Select Course.TenKhoa, Course.MaKhoa, count(Class.MaKhoa) as NumberOfFemaleStudent 
From Course
 Join Class on Course.MaKhoa = Class.MaKhoa
 Join Students on Class.Malop = Students.Malop
Where Students.GioiTinh = 'Nu' 
Group By Course.TenKhoa; 

Select * From NumberOfFemaleStudents;

--  Cho biết tổng tiền học bổng của mỗi lớp?
-- Cho biết tổng số tiền học bổng của mỗi khoa?
-- Lập danh sách sinh viên có học bổng cao nhất?
-- Lập danh sánh những khoa có nhiều hơn 100 sinh viên. Danh sách cần: MaKhoa, TenKhoa, Soluong
Select * From NumberOfStudents 
Where NumberOfStudent > 100;

-- Lập danh sánh những khoa có nhiều hơn 50 sinh viên nữ. Danh sách cần: MaKhoa, TenKhoa, Soluong
Select * From NumberOfFemaleStudents
Where NumberOfFemaleStudent > 50;


-- Lập danh sách sinh viên có điểm thi môn CSDL cao nhất
Create View HighestScore AS
Select Students.Hoten, Subjects.TenMH, Result.DiemThi
From Students 
Join Result on Students.MaSv = Result.Masv
Join Subjects on Result.MaMH = Subjects.MaMH
Where Subjects.TenMH = 'MySQL' 
Group by Students.HoTen;

select * from HighestScore;

Select Students.Hoten, Subjects.TenMH, Result.DiemThi
From Students 
Join Result on Students.MaSv = Result.Masv
Join Subjects on Result.MaMH = Subjects.MaMH
Where Subjects.TenMH = 'MySQL'
And Result.DiemThi = (select max(DiemThi) From HighestScore)
Group by Students.HoTen;

--  Cho biết những khoa nào có nhiều sinh viên nhất
Select TenKhoa, MaKhoa, NumberOfStudent From NumberOfStudents
Where NumberOfStudent = (select max(NumberOfStudent) From NumberOfStudents);