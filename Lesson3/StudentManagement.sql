Create database studentManagement;
use studentManagement;

create table subject (
subjectId int(4) primary key,
subjectName nvarchar(50)
);

create table classes (
classId int(4) primary key,
className nvarchar(50)
);

create table marks (
mark int(4),
subjectId int(4),
studentId int(4)
);

create table students (
studentId int(4) primary key,
studentName nvarchar(50),
age int(4),
email varchar(100)
);

create table classStudent (
studentId int(4),
classId int(4)
);

alter table marks add Constraint marksForeignSubject foreign key (subjectId) references subject(subjectId);

alter table marks add Constraint marksForeignStudent foreign key (studentId) references students(studentId);


alter table classStudent add Constraint classStudentsForeignStudent foreign key (studentId) references students(studentId);

alter table classStudent add Constraint classStudentsForeignClass foreign key (classId) references classes(classId);

insert into students 
values (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
(3, 'Nguyen Van Quyen', 19, 'quyen@yahoo.com'),
(4, 'NPham Thanh Binh', 25, 'binh@com'),
(5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');

insert into classes 
values (1, 'C0706L'), (2, 'C0708G');

insert into classStudent 
values (1, 1),
(2,1),
(3,2),
(4,2),
(5,2);

insert into subject
values (1, 'SQL'),
(2, 'Java'),
(3, 'C'),
(4, 'Visual Basic');

insert into marks 
value (8, 1, 1),
(4, 2 , 1),
(9, 1 , 1),
(7, 1 , 3),
(3, 1 , 4),
(5, 2 , 5),
(8, 3 , 3),
(1, 3 , 5),
(3, 2 , 4);

-- Hien thi danh sach tat ca cac hoc vien 
select * from students;

-- Hien thi danh sach tat ca cac mon hoc
select * from subject;

-- Tinh diem trung binh 
select students.studentId, students.studentName, AVG(mark)
from students join marks on marks.studentId = students.studentId
group by students.studentId;

-- Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select students.studentName, subject.subjectName, marks.mark
from students 
join marks on marks.studentId = students.studentId
join subject on marks.subjectId = subject.subjectId
where mark >= All (select MAX(mark) from marks group by mark)
group by subject.subjectName;

-- Danh so thu tu cua diem theo chieu giam
select row_number() over (order by mark DESC) as STT, marks.mark, marks.subjectId, marks.studentId 
from marks;

-- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
ALTER TABLE subject 
CHANGE COLUMN subjectName subjectName VARCHAR(255) NULL DEFAULT NULL ;

-- Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subject 
set subjectName = 'Day la mon hoc SQL' 
where subjectID = 1;

update subject 
set subjectName = 'Day la mon hoc Java' 
where subjectID = 2;

update subject 
set subjectName = 'Day la mon hoc C' 
where subjectID = 3;

update subject 
set subjectName = 'Day la mon hoc Visual Basic' 
where subjectID = 4;

-- Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table students 
add constraint checkAge check(age between 16 and 51);

-- Loai bo tat ca quan he giua cac bang
alter table marks drop constraint marksForeignSubject;
alter table marks drop constraint marksForeignStudent;
alter table classStudent drop constraint classStudentsForeignStudent;
alter table classStudent drop constraint classStudentsForeignClass;

-- Xoa hoc vien co StudentID la 1
delete from students 
where students.studentId = 1;

-- Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students 
add Status bit default 1;

-- Cap nhap gia tri Status trong bang Student thanh 0
SET SQL_SAFE_UPDATES = 0;
update students
set status = 0;
SET SQL_SAFE_UPDATES = 1;