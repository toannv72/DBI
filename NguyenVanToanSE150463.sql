use FUH_COMPANY;

--cau 1:Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu:
--mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban

select e.empSSN,e.empName,d.depNum,d.depName 
from tblDepartment d join tblEmployee e on depName = N'Phòng Nghiên cứu và phát triển' and d.mgrSSN = e.empSSN

--cau 2:Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào. Thông tin
--yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý

select p.proNum,p.proName,d.depName
from tblDepartment d join tblProject p on d.depName =  N'Phòng Nghiên cứu và phát triển' and d.depNum = p.depNum

--cau 3: Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. Thông tin yêu cầu: -----mã số dụ án, tên dự án, tên phòng ban quản lý

select p.proNum,p.proName,d.depName
from tblDepartment d join tblProject p on p.proName = 'ProjectB' and p.depNum = d.depNum

--cau 4: Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An. Thông tin yêu ---cầu: mã số nhân viên, họ tên nhân viên
select e.empSSN, e.empName
from (select empSSN from tblEmployee where empName = N'Mai Duy An') s join tblEmployee e
on s.empSSN = e.supervisorSSN

--cau 5: Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát.

select e.empSSN, e.empName
from (select supervisorSSN from tblEmployee where empName = N'Mai Duy An') s join tblEmployee e
on s.supervisorSSN = e.empSSN

--cau 6: Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu. Thông tin yêu cầu: mã số, tên vị trí làm việc.
select l.locNum,l.locName
from tblProject p join tblLocation l on p.proName = 'ProjectA' and p.locNum = l.locNum

--cau 7: Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. Thông tin yêu cầu: mã số, tên dự án

select p.proNum, p.proName
from tblProject p join tblLocation l on l.locName = N'TP Hồ Chí Minh' and p.locNum = l.locNum

--cau 8: Cho biết những người phụ thuộc trên 18 tuổi .Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.

select d.depName, d.depBirthdate, e.empName 
from (select * from tblDependent where year(getdate()) - year(depBirthdate) >= 18) d join tblEmployee e on d.empSSN = e.empSSN 

--cau 9: . Cho biết những người phụ thuộc là nam giới. Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào

select d.depName, d.depBirthdate, e.empName
from (select * from tblDependent where depSex = 'M') d join tblEmployee e on d.empSSN = e.empSSN

--cau 10: Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.

select m.depNum, m.depName, l.locName
from (select d.depNum, d.depName, dl.locNum from (tblDepartment d join tblDepLocation dl
on d.depName = N'Phòng nghiên cứu và phát triển' and d.depNum = dl.depNum)) m
join tblLocation l on l.locNum = m.locNum

--cau 11: Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
select  m.proNum,m.proName,dep.depName
from 
(select p.proNum,p.proName,p.depNum from (select * from tblLocation where locName = N'TP Hồ Chí Minh') l join tblProject p
on l.locNum = p.locNum) m join tblDepartment dep on m.depNum = dep.depNum

--cau 12: Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển . Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên

select e.empName, de.depName, de.depRelationship
from
(select empSSN,empName
from (select depNum from tblDepartment where depName = N'Phòng nghiên cứu và phát triển') d
join tblEmployee e on d.depNum = e.depNum) e
join tblDependent de
on e.empSSN = de.empSSN
where depSex = 'F'

--cau 13: Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
select e.empName, de.depName, de.depRelationship
from
(select empSSN,empName
from (select depNum from tblDepartment where depName = N'Phòng nghiên cứu và phát triển') d
join tblEmployee e on d.depNum = e.depNum) e
join tblDependent de
on e.empSSN = de.empSSN
where year(getdate()) - year(de.depBirthdate) >= 18

--cau 14: Cho biết số lượng người phụ thuộc theo giới tính. Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
select m.depSex, count(m.depSex) as 'Number' from (select depSex from tblDependent) m
group by m.depSex

--cau 15: Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc

select depRelationship, count(depRelationship) as 'Number' from tblDependent
group by depRelationship

--cau 16: Cho biết số lượng người phụ thuộc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc

select d.depNum, d.depName, count(de.empSSN) as 'Number of dependents'
from tblDepartment d join tblEmployee e on d.depNum = e.depNum
join
tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName

--cau 17: Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc

select top 1 with ties *
from
(
select d.depNum, d.depName, count(*) as 'Number of dependents'
from tblDepartment d join tblEmployee e on d.depNum = e.depNum
join
tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName) a
order by a.[Number of dependents] asc

--cau 18: Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc

select top 1 with ties *
from
(
select d.depNum, d.depName, count(*) as 'Number of dependents'
from tblDepartment d join tblEmployee e on d.depNum = e.depNum
join
tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName) a
order by a.[Number of dependents] desc

--cau 19: Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên

select e.empSSN, e.empName, d.depName, a.[Sum of hours]
from (
select empSSN, sum(workHours) as 'Sum of hours'
from tblWorksOn
group by empSSN) a
join tblEmployee e 
on a.empSSN = e.empSSN
join tblDepartment d
on e.depNum = d.depNum

--cau 20: . Cho biết tổng số giờ làm dự án của mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, tổng số giờ

select d.depNum, d.depName, sum(a.[Sum of hours]) as 'Sum of hours each deparment' from
(select empSSN, sum(workHours) as 'Sum of hours'
from 
tblWorksOn
group by empSSN) a
join 
tblEmployee e
on a.empSSN = e.empSSN
join 
tblDepartment d
on d.depNum = e.depNum
group by d.depNum, d.depName
--------------------
select d.depNum, d.depName, sum(workHours) as 'Sum of hours'
from 
tblEmployee e
join 
tblDepartment d
on e.depNum = d.depNum
join 
tblWorksOn w
on e.empSSN = w.empSSN
group by d.depNum, d.depName

--cau 21: Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án

select top 1 with ties
w.empSSN, e.empName, sum(workHours) as 'Number of hours'
from 
tblEmployee e 
join
tblWorksOn w
on e.empSSN = w.empSSN
group by w.empSSN, e.empName
order by [Number of hours] asc

--cau 22: Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án

select top 1 with ties
w.empSSN, e.empName, sum(workHours) as 'Number of hours'
from 
tblEmployee e 
join
tblWorksOn w
on e.empSSN = w.empSSN
group by w.empSSN, e.empName
order by [Number of hours] desc

--cau 23: Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
select e.empSSN, e.empName, d.depName from
(
select empSSN from
(select empSSN, count(*) as 'Number' from tblWorksOn group by empSSN) a
where a.Number = 1
) b
join 
tblEmployee e
on b.empSSN = e.empSSN
join 
tblDepartment d
on e.depNum = d.depNum

--cau 24: Cho biết những nhân viên nào lần thứ hai tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên

select e.empSSN, e.empName, d.depName from
(
select empSSN from
(select empSSN, count(*) as 'Number' from tblWorksOn group by empSSN) a
where a.Number = 2
) b
join 
tblEmployee e
on b.empSSN = e.empSSN
join 
tblDepartment d
on e.depNum = d.depNum

--cau 25: Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên

select e.empSSN, e.empName, d.depName from
(
select empSSN from
(select empSSN, count(*) as 'Number' from tblWorksOn group by empSSN) a
where a.Number >= 2
) b
join 
tblEmployee e
on b.empSSN = e.empSSN
join 
tblDepartment d
on e.depNum = d.depNum

--cau 26: Cho biết số lượng thành viên của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên

select w.proNum, p.proName, count(*) as 'Number of member'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName

--cau 27: Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
select w.proNum, p.proName, sum(w.workHours) as 'Sum of hours each project'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName

--cau 28: Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
select top 1 with ties
w.proNum, p.proName, count(w.empSSN) as 'Number of member'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName
order by [Number of member] asc

--cau 29: Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
select top 1 with ties
w.proNum, p.proName, count(w.empSSN) as 'Number of member'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName
order by [Number of member] desc

--cau 30: Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm

select top 1 with ties
w.proNum, p.proName, sum(w.workHours) as 'Sum of hours each project'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName
order by [Sum of hours each project] asc

--cau 31: Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
select top 1 with ties
w.proNum, p.proName, sum(w.workHours) as 'Sum of hours each project'
from 
tblWorksOn w
join 
tblProject p
on w.proNum = p.proNum 
group by w.proNum, p.proName
order by [Sum of hours each project] desc

--cau 32: Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban

select l.locName, count(*) as 'Number of departments'
from 
tblDepLocation dl
join
tblLocation l
on dl.locNum = l.locNum
group by l.locNum, l.locName

--cau 33: Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc

select d.depNum, d.depName, count(*) as 'Number of locations'
from 
tblDepLocation dl
join
tblDepartment d
on dl.depNum = d.depNum
group by d.depNum, d.depName

--cau 34: Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc

select top 1 with ties
d.depNum, d.depName, count(*) as 'Number of locations'
from 
tblDepLocation dl
join
tblDepartment d
on dl.depNum = d.depNum
group by d.depNum, d.depName
order by [Number of locations] desc

--cau 35: Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc

select top 1 with ties
d.depNum, d.depName, count(*) as 'Number of locations'
from 
tblDepLocation dl
join
tblDepartment d
on dl.depNum = d.depNum
group by d.depNum, d.depName
order by [Number of locations] asc

--cau 36: Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban

select top 1 with ties
l.locName, count(*) as 'Number of departments'
from 
tblDepLocation dl
join
tblLocation l
on dl.locNum = l.locNum
group by l.locNum, l.locName
order by [Number of departments] desc

-- cau 37: Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban

select top 1 with ties
l.locName, count(*) as 'Number of departments'
from 
tblDepLocation dl
join
tblLocation l
on dl.locNum = l.locNum
group by l.locNum, l.locName
order by [Number of departments] asc

--cau 38: Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc

select top 1 with ties
e.empSSN, e.empName, count(de.depName) as 'Number of dependents'
from
tblDependent de
right outer join
tblEmployee e
on e.empSSN = de.empSSN
group by e.empSSN, e.empName
order by [Number of dependents] desc

--cau 39: Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc

select top 1 with ties
e.empSSN, e.empName, count(de.depName) as 'Number of dependents'
from
tblDependent de
right outer join
tblEmployee e
on e.empSSN = de.empSSN
group by e.empSSN, e.empName
order by [Number of dependents] asc

--cau 40: Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên

select top 1 with ties
e.empSSN, e.empName, count(de.depName) as 'Number of dependents'
from
tblDependent de
right outer join
tblEmployee e
on e.empSSN = de.empSSN
group by e.empSSN, e.empName
order by [Number of dependents] asc

--cau 41: Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên phòng ban

select d.depNum, d.depName from
(
select empSSN from tblEmployee
except
select empSSN from tblDependent
) a
join 
tblEmployee e
on a.empSSN = e.empSSN
join tblDepartment d
on e.depNum = d.depNum
group by d.depNum, d.depName

--cau 42: Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên

select e.empSSN, e.empName, d.depName 
from
(
select empSSN from tblEmployee
except
select empSSN from tblWorksOn group by empSSN
) a
join tblEmployee e
on a.empSSN = e.empSSN
join tblDepartment d
on d.depNum = e.depNum

--cau 43: Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số phòng ban, tên phòng ban

select d.depNum, d.depName
from
(
select depNum from tblDepartment
except
select depNum from tblProject
) a
join 
tblDepartment d
on a.depNum = d.depNum

--cau 44: Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu cầu: mã số phòng ban, tên phòng ban

select d.depNum, d.depName
from
(
select depNum from tblDepartment
except
select depNum from tblProject where proName = 'ProjectA'
) a
join 
tblDepartment d
on a.depNum = d.depNum

--cau 45: Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

select d.depNum, d.depName, count(proNum) as 'Number of projects' from 
tblProject p
right outer join
tblDepartment d
on p.depNum = d.depNum
group by d.depNum, d.depName

--cau 46: Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

select top 1 with ties
d.depNum, d.depName, count(proNum) as 'Number of projects' from 
tblProject p
right outer join
tblDepartment d
on p.depNum = d.depNum
group by d.depNum, d.depName
order by [Number of projects]

--cau 47: Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án

select top 1 with ties
d.depNum, d.depName, count(proNum) as 'Number of projects' from 
tblProject p
right outer join
tblDepartment d
on p.depNum = d.depNum
group by d.depNum, d.depName
order by [Number of projects] desc

--cau 48: Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý

select a.depNum, a.depName, a.[Number of member], a.proName
from 
(
select e.depNum, d.depName, count(w.empSSN) as 'Number of member', p.proName from 
tblWorksOn w
join 
tblEmployee e
on w.empSSN = e.empSSN
join tblDepartment d
on e.depNum = d.depNum
join tblProject p
on w.proNum = p.proNum
group by e.depNum, w.proNum, d.depName, p.proName
) a
where [Number of member] >= 5

--cau 49: Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên

select e.empSSN, e.empName
from (
select empSSN from tblEmployee
except
select empSSN from tblDependent
) a
join 
tblEmployee e
on a.empSSN = e.empSSN
join 
tblDepartment d
on e.depNum = d.depNum
where d.depName like N'Phòng nghiên cứu%'

--cau 50: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm

select a.empSSN, e.empName, sum(w.workHours) as 'Sum of work hours'
from (
select empSSN from tblEmployee
except
select empSSN from tblDependent
) a
join 
tblWorksOn w
on a.empSSN = w.empSSN
join 
tblEmployee e
on a.empSSN = e.empSSN
group by a.empSSN, e.empName 

--cau 51: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm

select a.empSSN, e.empName, a.Num, sum(w.workHours) as 'Sum of work hours' from
(
select a.empSSN, a.Num
from
(select empSSN, count(*) as 'Num' from tblDependent
group by empSSN
) a
where a.Num >= 3
) a
join tblWorksOn w
on a.empSSN = w.empSSN
join tblEmployee e
on e.empSSN = w.empSSN
group by a.empSSN, e.empName, a.Num

--cau 52: Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) của nhân viên Mai Duy An. Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm

select a.empSSN, a.empName, sum( w.workHours) as 'Sum of work hours'
from
(
select e.empSSN, e.empName 
from
(select empSSN from tblEmployee where empName = N'Mai Duy An') sup
join 
tblEmployee e
on e.supervisorSSN = sup.empSSN
) a
join tblWorksOn w
on a.empSSN = w.empSSN
group by a.empSSN, a.empName

