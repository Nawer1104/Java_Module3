use quanlysinhvien;
select * from student 
where studentname like 'h%';

select * from class
where month(class.startdate) = 12;

select * from subject 
where subject.Credit between 3 and 5;

update student 
set classid = 2
where studentname = 'Hung' and studentid = 1;

select student.StudentName, subject.subname, mark.mark 
from student 
inner join mark on student.StudentId = mark.StudentId
inner join subject on subject.SubId = mark.SubId
order by mark.mark DESC, student.studentname ASC;

