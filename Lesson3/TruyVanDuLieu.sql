use quanlysinhvien;
select * from student;

select * from student 
where status = true;

select * from subject 
where Credit < 10;

select student.studentid , student.StudentName, class.CLASSNAME
from class join student on student.classid = class.classid
where class.CLASSNAME = 'A1';

select student.StudentId, student.StudentName, subject.subname, mark.Mark
from student join mark on student.StudentId = mark.studentid join subject on Mark.subid = subject.SubId
where subject.subname = 'CF';
