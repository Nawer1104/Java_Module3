use quanlysinhvien;
select *, max(credit) from subject
group by subname
having max(credit) >= All (select max(credit) from subject group by Credit);

select subject.subname, mark.mark
from subject 
join mark on mark.subid = subject.subid
group by subname
having max(mark.mark) >= All (select max(mark.mark) from mark group by mark);

select student.*, AVG(Mark)
from student 
join mark on mark.StudentId = student.studentid
group by studentname
order by avg(mark) desc;
