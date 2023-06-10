---------------------------1----Branch--------------------------------------------
CREATE PROC UpdateTableBranch @branID INT, @branName VARCHAR(20), @location VARCHAR(20)
AS
   begin try
	UPDATE Branch
	SET branch_name = @branName, location = @location
	WHERE branch_id = @branID
   end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch
------------------------------------------------------------------------

CREATE PROC InsertIntoTableBranch  @branID INT, @branName VARCHAR(20), @location VARCHAR(20)
AS
   begin try
	INSERT INTO branch
	VALUES( @branID , @branName, @location )
	  end try
   begin catch
	  select 'ERROR: DUPLICATED Value'
   end catch
------------------------------------------------------------------------

 CREATE PROC DeleteFromTableBranch @branID INT
AS
   begin try
	DELETE FROM branch
	WHERE branch_id = @branID
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch
------------------------------------------------------------------------
   
CREATE PROC selectFromTableBranch @branID INT
AS
   begin try
	select * FROM branch
	WHERE branch_id = @branID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED ID '
   end catch
  
  


------------------------2-------department--------------------------------------------

CREATE PROC UpdateTableDepartment @depID INT, @depName VARCHAR(20), @managerID INT
AS
   begin try
	UPDATE Department
	SET dept_Name = @depName, manger_ID = @managerID
	WHERE dept_id = @depID
  end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch
   
------------------------------------------------------------------------

CREATE PROC InsertIntoTableDepartment @depID INT, @depName VARCHAR(20), @managerID INT
AS
   begin try
	INSERT INTO Department
	VALUES( @depID, @depName, @managerID )
	  end try
   begin catch
	  select 'ERROR: DUPLICATED Value'
   end catch
------------------------------------------------------------------------

CREATE PROC DeleteFromTableDepartment @depID INT
AS
   begin try
	DELETE FROM Department
	WHERE dept_id = @depID
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch
------------------------------------------------------------------------

CREATE PROC selectFromTabledepartment @departmentID INT
AS
   begin try
	select * FROM Department
	WHERE dept_id = @departmentID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED ID '
   end catch
   
   

 ---------------------------3--------course--------------------------------------------

   CREATE PROC UpdateTableCourse @CrsID INT, @CrsName VARCHAR(20), @sessionNO INT
AS
   begin try
	UPDATE Course
	SET Course_name = @CrsName, sessions_No = @sessionNO
	WHERE course_ID = @CrsID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch
------------------------------------------------------------------------

CREATE PROC InsertIntoTableCourse @CrsID INT, @CrsName VARCHAR(20), @sessionNO INT
AS
   begin try
	INSERT INTO Course
	VALUES(@CrsID, @CrsName, @sessionNO)
	  end try
   begin catch
	  select 'ERROR: DUPLICATED Value'
   end catch
------------------------------------------------------------------------

CREATE PROC DeleteFromTableCourse @CrsID INT
AS
   begin try
	DELETE FROM Course
	WHERE course_ID = @CrsID
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch

------------------------------------------------------------------------
CREATE PROC selectFromTablecourse  @courseID INT
AS
   begin try
	select * FROM Course
	WHERE course_ID = @courseID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED ID '
   end catch
   
   
   
 --------------------------4---------Dep_branch--------------------------------------------
 
 ----stored procedure 'select' for Dep_branch table------
create procedure getdeptname  @deptID int
as
begin try
select dept_Name       
from Department D,Branch_Dep BD
where @deptID=BD.Dep_ID and
BD.Dep_ID=D.dept_id
end try
begin catch 
 select 'error'
 end catch
 ------calling-------
 getdeptname 1

-----------procedure 'insert' for dep_branch table------
create proc insertdepID @Deptid int,@branchid int
as 
begin try
if not exists (select branch_id,dep_id from Branch_Dep where @Deptid=Dep_ID and @branchid=branch_ID)
begin
insert into Branch_Dep(Dep_ID,branch_ID)
      values(@Deptid,@branchid)
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
-----------calling------
 insertdepID 1,5

------procedure 'update' for dep_branch table------
create proc updatedepID @Deptid int, @branchid int
as 
begin try
if not exists (select branch_id,dep_id from Branch_Dep where @Deptid=Dep_ID and @branchid=branch_ID)
begin
UPDATE Branch_Dep
    SET branch_id = @branchid
    WHERE dep_id = @Deptid
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
---calling---
updatedepid 1,5
---------procedure 'delete for dep_branch table--------
create procedure deletedepid
  @Deptid INT,
  @branchid INT
AS
BEGIN TRY
  IF EXISTS (SELECT branch_id, dep_id FROM Branch_Dep WHERE Dep_ID = @Deptid AND branch_ID = @branchid)
  BEGIN
    DELETE FROM Branch_Dep
    WHERE dep_id = @Deptid AND branch_id = @branchid
  END
  ELSE
  BEGIN
    SELECT 'Record not found' 
  END
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH
----calling----
deletedepid 20,5



 ---------------------------5-------Exam--------------------------------------------

	--------------stored procedure 'select' for exam table------
create procedure getexamID   @studID int,
                      @examID int output,
					  @studname varchar(50) output,
					  @duration int output
as
begin try 
select @examID =E.exam_id,
       @studname=first_name+''+last_name,
	   @duration=duration
from exam E ,student S ,Take_exam T
where @studID=s.student_id and
T.stud_id=s.student_id
end try
begin catch 
 select 'error'
 end catch
 ---------calling------
 declare @x int, @y varchar(50),@D int
 execute getexamID 10,@x output ,@y output, @D output
 select @x,@y,@D
 ---------------------insert----------------
 create procedure insertexamID  @examid int, @duration int
as 
begin try
if not exists (select exam_id,Duration from Exam where exam_id=@examid and Duration=@duration)
begin
insert into Exam(Duration,exam_id)
      values(@duration,@examid) 
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
-----calling-------
insertexamID 1,60
----------------------------update-----------
create PROCEDURE updatexam
  @examid INT,
  @duration INT
AS
BEGIN TRY
  UPDATE Exam
  SET Duration = @duration
  WHERE exam_id = @examid

 SELECT 'Record updated' 
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH
-------calling-----
updatexam 1,45
----------------delete---------------
CREATE PROCEDURE deletexam
  @examid INT,
  @duration INT
AS
BEGIN TRY
  IF EXISTS (SELECT exam_id, Duration FROM Exam WHERE exam_id = @examid AND Duration = @duration)
  BEGIN
    DELETE FROM Exam
    WHERE exam_id = @examid AND Duration = @duration
    
    SELECT 'Record deleted' 
  END
  ELSE
  BEGIN
    SELECT 'Record not found' 
  END
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH
-------calling------
deletexam 1,1


---------------------------6-------stud_course--------------------------------------------

---stored procedure 'select' for stud_course table------
create procedure getstuddata  @studID int,
                      @studresult varchar(50) output,
					  @studname varchar(50) output
as
begin try
select @studresult=Stud_Result,
       @studname=first_name+''+last_name
from stud_course sc ,student s
where @studID=s.student_id and
sc.student_id=s.student_id
end try
begin catch 
 select 'error'
 end catch
 ---calling---
 declare @x varchar(50),@y varchar(50)
 execute getstuddata 5, @x output,@y output
 select @x,@y
 -----------------insert----------------------
 create proc insertcourse @crsid int, @studresult int
as 
begin try
if not exists (select course_id,stud_result from Stud_course where course_id=@crsid and stud_result=@studresult)
begin
insert into Stud_course(course_id,stud_result)
      values(@crsid,@studresult)
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
----calling----
insertcourse 20,30
-----------------------update-----------------
create PROCEDURE updatecourse
  @crsid INT,
  @studresult INT
AS
BEGIN TRY
  UPDATE Stud_course
  SET stud_result = @studresult
  WHERE course_id = @crsid

  SELECT 'Record updated' 
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH

------------calling------
updatecourse 20,1
-----------------------delete---------------
CREATE PROCEDURE deletecourse
  @crsid INT,
  @studresult INT
AS
BEGIN TRY
  IF EXISTS (SELECT course_id, stud_result FROM Stud_course WHERE course_id = @crsid AND stud_result = @studresult)
  BEGIN
    DELETE FROM Stud_course
    WHERE course_id = @crsid AND stud_result = @studresult
    
    SELECT 'Record deleted' 
  END
  ELSE
  BEGIN
    SELECT 'Record not found' 
  END
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH
---------calling---------
deletecourse 20,60


---------------------------7-------Take_exam--------------------------------------------

------stored procedure 'select' for Take_exam table-----
create proc getexamdetails @studid int, @examid int output,@studname varchar(50) output, @studgrade int output
as 
begin try 
select @examid=exam_id,
       @studname=first_name+''+last_name,
       @studgrade=grade
from take_exam TE,student S
where @studid=TE.stud_id and 
     TE.stud_id=s.student_id
end try
begin catch
select 'error'
end catch
-----calling---
declare @E int, @SN varchar(50),@SG int 
execute getexamdetails 1 ,@E output,@SN output, @SG output
select @E,@SN,@SG

-------------------------insert---------------------

create procedure insertexam @examid int, @quesid int,@studid int,@grade int
as 
begin try
if not exists (select exam_id,quest_id,stud_id,grade from take_exam  
where exam_id= @examid 
and quest_id=@quesid 
and stud_id=@studid 
and grade=@grade)
begin
insert into take_exam ( exam_id,quest_id,stud_id,grade)
      values(@examid,@quesid,@studid,@grade)
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
----calling----
execute insertexam 1,1,1,20

-----------------------update-----------------
create PROCEDURE updatetakeexam
  @examid int, @quesid int,@studid int,@grade int

AS
BEGIN TRY
  UPDATE Take_exam
  SET   grade =@grade
  WHERE exam_id = @examid
    and  quest_id= @quesid
	and stud_id=  @studid

  SELECT 'Record updated' 
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH

------------calling------
updatetakeexam  1,1,1,20
-----------------------delete------------------
CREATE PROCEDURE deletetake_exam
    @examid INT,
    @quesid INT,
    @studid INT,
    @grade INT
AS
BEGIN TRY
    IF EXISTS (
            SELECT exam_id, quest_id, stud_id, grade
            FROM take_exam
            WHERE exam_id = @examid
                AND quest_id = @quesid
                AND stud_id = @studid
                AND grade = @grade
            )
    BEGIN
        DELETE FROM take_exam
        WHERE exam_id = @examid
            AND quest_id = @quesid
            AND stud_id = @studid
            AND grade = @grade;
        
        SELECT 'Record deleted';
    END
    ELSE
    BEGIN
        SELECT 'Record not found';
    END;
END TRY
BEGIN CATCH
    SELECT 'Not allowed for user=' + USER_NAME();
END CATCH;

---------calling---------
deletetake_exam 1,1,1,20

---------------------------8-------Topic--------------------------------------------

--------------stored procedure 'select' for topic table---------
create proc Gettopicdata @crsID int
as 
begin try 
select topic_name,topic_id
from topic
where @crsID=course_id
end try
begin catch
select 'error'
end catch
------calling-----
gettopicdata 20
-------------------------insert---------------------

create procedure inserttopic @topicid int, @topicname varchar(50),@courseid int
as 
begin try
if not exists (select topic_id, topic_name,course_id from topic where topic_id=@topicid and topic_name=@topicname
and course_id=@courseid)
begin
insert into topic (topic_id,topic_name,course_id)
      values(@topicid,@topicname,@courseid)
end
else
begin
	  select 'Duplicate ID'
end
end try
begin catch 
select 'Not allowed for user='+USER_NAME()
end catch
----calling----
execute inserttopic 1, 'Big Data Analytics',5 ;
-----------------------update-----------------
create PROCEDURE updatetopic
  @topicid INT,
  @topicname varchar(50)
AS
BEGIN TRY
  UPDATE topic
  SET topic_name = @topicname
  WHERE topic_id = @topicid

  SELECT 'Record updated' 
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH

------------calling------
updatetopic  10,'sql'
-----------------------delete---------------
create PROCEDURE deletetopic
  @topicid INT,
  @topicname varchar(50)
AS
BEGIN TRY
  IF EXISTS (select topic_id, topic_name from topic where topic_id=@topicid and topic_name=@topicname)
  BEGIN
    DELETE FROM topic
    WHERE  topic_id=@topicid and topic_name=@topicname
    
    SELECT 'Record deleted' 
  END
  ELSE
  BEGIN
    SELECT 'Record not found' 
  END
END TRY
BEGIN CATCH
  SELECT 'Not allowed for user=' + USER_NAME() 
END CATCH
---------calling---------
deletetopic 20, 'sql'



------------------------------9----Certificates--------------------------------------------

  ------ certificates (1)
   create PROC UpdateTablecertificates @CertID INT, @studID int,@newCertID INT, @newstudID int,
   @Cert_name VARCHAR(20),@cert_date varchar(10)
 ,@cert_plateform VARCHAR(20) ,@cert_specialization VARCHAR(20) , @cert_fees int , @cert_exam VARCHAR(20)
 
AS
   begin try
	UPDATE certificates
	SET studID =@newstudID
		,CertID= @newCertID
		,Cert_name= @Cert_name
		,cert_date = @cert_date
		,cert_plateform = @cert_plateform
		,cert_specialization = @cert_specialization
		,cert_fees = @cert_fees
		,cert_exam = @cert_exam
		
	WHERE CertID= @CertID and studID =@studID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch

   EXEC UpdateTablecertificates 222,999,222,999,'test','1.12.2023','udemy','IT',200,'true';

  ------(2)

CREATE PROC InsertIntoTable_Certificates  @CertID INT, @Cert_name VARCHAR(20), @cert_date varchar(10)
   ,@cert_plateform VARCHAR(20) ,@cert_specialization VARCHAR(20) , @cert_fees int , @cert_exam VARCHAR(20),@studID int
AS
   begin try
	INSERT INTO Certificates
	VALUES(@CertID, @Cert_name, @cert_date,@cert_plateform,@cert_specialization,@cert_fees,@cert_exam,@studID)
	  end try
   begin catch
	  select 'ERROR: DUPLICATED Value'
   end catch

-------(3)


create PROC DeleteFromTable_Certificates @CertID int , @studID INT
AS
   begin try
	DELETE FROM certificates
	WHERE CertID = @CertID and studID =@studID
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch
-------(4)
create PROC selectFromTable_Certificates  @CertID INT ,@studID int
AS
   begin try
	select * FROM certificates
	WHERE CertID = @CertID and studID =@studID
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED ID '
   end catch

   EXEC selectFromTable_Certificates 29,48

 ----------------------------10------Freelancing--------------------------------------------

----------- _Freelancing (1)
   
create PROC UpdateTable_Freelancing  @Stud_id int, @newFreelancing_id INT, @newStud_id int ,
 @Freelancing_name VARCHAR(20), @Description varchar(84)
, @price int ,@Date DAte , @platform VARCHAR(20)
AS
   begin try
	UPDATE Freelancing 
	SET 
		Stud_id=@newStud_id,
		Freelancing_name= @Freelancing_name
		, Description = @Description
		, price= @price
		, Date= @Date
		, platform = @platform
		
	WHERE  Stud_id=@Stud_id
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch

   ---
 exec UpdateTable_Freelancing 13,37,13,37,'Web Developer','Manages and executes social media strategies to promote brands and engage audiences',600,'2022-05-28','Upwork'
  
  
  ------(2)

CREATE PROC InsertIntoTable_Freelancing  @Freelancing_id INT, @Stud_id int , @Freelancing_name VARCHAR(20), 
			@Description varchar(84) , @price int ,@Date Date , @platform VARCHAR(20)
AS
   begin try
	INSERT INTO Freelancing
	VALUES(@Freelancing_id,  @Stud_id, @Freelancing_name,@Description,@price,@platform,@Date)
	  end try
   begin catch
	  select 'ERROR: DUPLICATED Value'
   end catch

-------(3)


create PROC DeleteFromTable_Freelancing @Freelancing_id INT ,@Stud_id int
AS
   begin try
	DELETE FROM Freelancing
	WHERE Freelancing_id = @Freelancing_id and Stud_id=@Stud_id
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch

-------(4)
CREATE PROC selectFromTable_Freelancing @Freelancing_id INT
AS
   begin try
	select * FROM Freelancing
	WHERE Freelancing_id = @Freelancing_id
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED ID '
   end catch

 ----------------------------11------Company--------------------------------------------
   
   CREATE PROC UpdateTable_company  @company_id INT, @company_name VARCHAR(20), @location varchar(50) , @type VARCHAR(20)
AS
   begin try
	UPDATE company 
	SET company_name= @company_name
		, location = @location
		, type= @type
		
	WHERE  company_id= @company_id
	  end try
   begin catch
	  select 'ERROR: NOT EXISTED Value'
   end catch

  ------(2)

create PROC InsertIntoTable_Company @company_id INT, @company_name VARCHAR(20), @location varchar(50) , @type VARCHAR(30)
AS
   begin
	INSERT INTO company 
	VALUES( @company_id, @company_name , @location, @type)
	  end 

	  --
EXEC InsertIntoTable_Company 30,'Valeo','cairo','local';

-------(3)


CREATE PROC DeleteFromTable_company  @company_id INT
AS
   begin try
	DELETE FROM company 
	WHERE company_id = @company_id
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch

   --
EXEC DeleteFromTable_company  30;

-------(4)
create PROC selectFromTable_company  @company_id INT
AS
   begin
	select * FROM company
	WHERE company_id = @company_id
	  end

   EXEC selectFromTable_company 20;


 --------------------------12--------Proj_tools--------------------------------------------

create PROC UpdateTable_proj_tools 
@proj_id INT, @tool VARCHAR(20) ,@newprojectid int,   @newtool VARCHAR(20) 
AS
   begin
	UPDATE proj_tools 
	SET tool = @newtool 
	  , proj_id = @newprojectid 
	WHERE  proj_id= @proj_id and tool = @tool
	  end 

EXEC UpdateTable_proj_tools 2,'Java', 2, 'mysql';

  ---------(2)

create PROC InsertIntoTable_proj_tools   @proj_id INT, @tool VARCHAR(max)
AS
   begin
	INSERT INTO proj_tools  
	VALUES( @proj_id , @tool)
	  end 

	  --
EXEC InsertIntoTable_proj_tools 1,'html'

-------(3)


CREATE PROC DeleteFromTable_proj_tools  @proj_id INT, @tool VARCHAR(20)
AS
   begin try
	DELETE FROM proj_tools 
	WHERE proj_id= @proj_id and tool = @tool
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch

   --
EXEC DeleteFromTable_proj_tools 1,'html'
   --

-------(4)
create PROC selectFromTable_proj_tools  @proj_id INT
AS
   begin
	select * FROM proj_tools
	WHERE proj_id= @proj_id 
	  end
---
   EXEC selectFromTable_proj_tools 20;
 
  -------------------------13---------Stud_Company--------------------------------------------

CREATE PROC UpdateTable_Stud_Company  
	@studId INT, @CompanyId int, @position varchar(50), @level VARCHAR(20), 
	@hiring_Date VARCHAR(20), @salary int
AS
BEGIN
   BEGIN TRY
		UPDATE Stud_Company 
		SET CompanyId = @CompanyId,
			position = @position,
			[level] = @level, 
			hiring_Date = @hiring_Date, 
			salary = @salary
		WHERE studId = @studId
   END TRY
   BEGIN CATCH
		SELECT 'ERROR: NOT EXISTED Value'
   END CATCH
END

  ------(2)

create PROC InsertIntoTable_Stud_Company @studId INT, @CompanyId int, @position varchar(50),
@level VARCHAR(20), 
	@hiring_Date VARCHAR(20), @salary int
AS
   begin
	INSERT INTO Stud_Company
	VALUES( @studId, @CompanyId , @position,@level,@hiring_Date,@salary)
	  end 

-------(3)


CREATE PROC DeleteFromTable_Stud_Company  @studId INT
AS
   begin try
	DELETE FROM Stud_Company 
	WHERE studId = @studId
	  end try
   begin catch
	  select 'ERROR:  NOT EXISTED Value '
   end catch


-------(4)
create PROC selectFromTable_Stud_Company   @studId INT
AS
   begin
	select * FROM Stud_Company 
	WHERE studId = @studId
	  end



  -------------------------14---------Instructor--------------------------------------------
  --1) Instructor select sp
create proc instructor_select_sp
as
begin
	select *
	from dbo.Instructor
end

--2) instructor insert sp
CREATE procedure instructor_insert_sp  @ins_fname nvarchar(50),@ins_lname nvarchar(50),@ins_salary int
as 
begin	
	insert into dbo.Instructor(Inst_ID,Inst_Fname,Inst_Lname,salary)
	values((select max(Inst_ID)+1 from Instructor),@ins_fname,@ins_lname,@ins_salary)
END

--3) Inst_course update sp
create proc inst_course_update_sp @ins_id int, @crs_id int
as 
begin
if @ins_id in (select Inst_ID from Instructor)
	begin
			if @crs_id in (select course_ID from Course)
				begin
					if @ins_id not in (select inst_id from dbo.Inst_Course where Course_ID = @crs_id) and @crs_id not in (select Course_ID from dbo.Inst_Course where Inst_ID = @ins_id)
						begin
							insert into dbo.Inst_Course(Inst_ID, Course_ID)
							values (@ins_id, @crs_id)
						end
					else
						update dbo.Inst_Course
						set Inst_ID=@ins_id
						where Course_ID=@crs_id
					end
				 else
		   print 'Course does not exist'
	end
else 
	PRINT 'Instructor does not exist'
END

--4) Instructor delete sp
CREATE PROCEDURE instructor_delete_sp @Ins_ID INT
AS
	BEGIN
		DELETE FROM Instructor WHERE Inst_ID = @Ins_ID
	END


  -------------------------16---------Student--------------------------------------------
  --1)  Student select sp
create proc student_select_sp
as
begin
	select *
	from dbo.Student
end


--2) Student delete sp
CREATE PROCEDURE student_delete_sp @Std_ID INT
AS
BEGIN
DELETE FROM Student WHERE student_id = @Std_ID
END

--3) student update sp
create proc student_update_sp @std_id int, @std_fname nvarchar(50), @std_lname nvarchar(50), @gpa DECIMAL, @dept_id int
as
begin
   if @dept_id in (select dept_id from Department)
	   begin
		if @std_id not in (select student_id from student)
				begin
					insert into student(student_id,first_name,last_name,gpa,dept_id)
					values (@std_id, @std_fname, @std_lname, @gpa, @dept_id)
				END
		ELSE
				BEGIN
					UPDATE student
					SET first_name=@std_fname, last_name=@std_lname, gpa=@gpa, dept_id=@dept_id
					WHERE student_id=@std_id
				END
	   END
	 ELSE
		PRINT 'Department does not exist'
END

--4)student insert sp
create proc student_insert_sp @std_id int, @std_fname nvarchar(50), @std_lname nvarchar(50), @gpa DECIMAL, @dept_id int
as
begin
   if @dept_id in (select dept_id from Department)
	   begin
			insert into student(student_id,first_name,last_name,gpa,dept_id)
			values (@std_id, @std_fname, @std_lname, @gpa, @dept_id)
		END
   
else 
	print 'you try to enter student data for not existing department'
end 




  -------------------------17---------project--------------------------------------------
  --1) project delete sp
CREATE PROCEDURE project_delete_sp @p_ID int
AS
	BEGIN
		DELETE FROM dbo.project WHERE proj_id = @p_ID
	END

--2)project update sp
CREATE proc project_update_sp @proj_id int, @proj_name varchar(49), @dept_id int
as 
begin  
	if @proj_id not in (select proj_id from dbo.project)
		insert into dbo.project(proj_id,proj_name,dept_id)
		values (@proj_id, @proj_name, @dept_id)
	else
		update dbo.project
		set proj_name=@proj_name, dept_id=@dept_id
		where proj_id=@proj_id
END

--3) project select sp
create proc project_select_sp
as
begin
	select * 
	from dbo.project
END

--4) project insert sp
create proc project_insert_sp @proj_id int, @proj_name varchar(49), @dept_id int
as 
begin  
	if @proj_id not in (select proj_id from dbo.project)
		insert into dbo.project(proj_id,proj_name,dept_id)
		values (@proj_id, @proj_name, @dept_id)
END


  -------------------------17---------ins_course--------------------------------------------
--1) ins_course insert sp
create procedure inst_course_insert_sp @ins_id int ,@crs_id int
as
begin
if @ins_id in (select Inst_ID from Instructor)
	begin 
		if @crs_id in (select course_ID from Course)
			begin 
			insert into dbo.Inst_Course(Inst_ID,Course_ID)
			values(@ins_id,@crs_id)
			end
		else
		print 'course you try to enter is not exist'
	end
else 
print 'instructor id you try to enter is not exist'
end 


--2) Inst_course update sp
create proc inst_course_update_sp @ins_id int, @crs_id int
as 
begin
if @ins_id in (select Inst_ID from Instructor)
	begin
			if @crs_id in (select course_ID from Course)
				begin
					if @ins_id not in (select inst_id from dbo.Inst_Course where Course_ID = @crs_id) and @crs_id not in (select Course_ID from dbo.Inst_Course where Inst_ID = @ins_id)
						begin
							insert into dbo.Inst_Course(Inst_ID, Course_ID)
							values (@ins_id, @crs_id)
						end
					else
						update dbo.Inst_Course
						set Inst_ID=@ins_id
						where Course_ID=@crs_id
					end
				 else
		   print 'Course does not exist'
	end
else 
	PRINT 'Instructor does not exist'
END

--3) inst_course select sp

CREATE PROC inst_course_select_sp
AS
begin
	select *
	from dbo.Inst_Course
END

--4) inst_course delete sp
CREATE PROCEDURE Inst_course_delete_sp @Ins_ID INT, @Crs_ID INT
AS
	BEGIN
		DELETE FROM Inst_Course WHERE Course_ID = @Crs_ID AND Inst_ID = @Ins_ID
	END


  -------------------------17------question--------------------------------------------
--1)question insert sp
CREATE PROCEDURE questions_insert_sp @q_id INT ,@question NVARCHAR(200) ,@model_answer NVARCHAR(200) ,@q_type NVARCHAR(50),@crs_id INT
AS 
BEGIN 
	IF @crs_id IN (SELECT course_ID FROM Course)
		BEGIN 
			IF  @question NOT IN (SELECT Question_head FROM dbo.Question)
				BEGIN
				INSERT INTO dbo.Question(Question_id,Question_head,model_answer,Question_type,Course_id)
				VALUES(@q_id,@question,@model_answer,@q_type,@crs_id)
				END
		   ELSE 
		   PRINT 'you try to enter already existing question'
		END
	ELSE 
		PRINT' you try to enter question for not existing course'
END


--2) questions update sp
create proc question_update_sp @q_id int, @question nvarchar(200), @model_answer nvarchar(50), @q_type nvarchar(50), @crs_id int
as
begin
if @crs_id in (select course_ID from Course)
		begin
		       if @q_id not in (select question_ID from dbo.Question)
					begin
						if @question not in (select question_head from dbo.Question)
							insert into dbo.Question(question_ID,question_head,model_answer,question_type,course_id)
							values (@q_id, @question, @model_answer, @q_type, @crs_id)
                        else
							begin
								PRINT 'Question already exists'
							end
					end
				else
					BEGIN
						if @question in (select question_head from dbo.Question where question_ID = @q_id)
							begin
								UPDATE dbo.Question
								SET model_answer=@model_answer, question_type=@q_type, course_id=@crs_id
								WHERE question_ID=@q_id
							end
				end
		end
else 
	PRINT 'Course does not exist'
END

--3) questions delete sp
CREATE PROCEDURE question_delete_sp @Q_ID INT
AS
	BEGIN
		DELETE FROM dbo.Question WHERE question_ID = @Q_ID
	END

--4) question select sp

create proc question_select_sp
as
begin
	select *
	from dbo.Question
end
