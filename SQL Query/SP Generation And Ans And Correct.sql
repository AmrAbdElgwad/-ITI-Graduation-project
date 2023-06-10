--------------------------------'Generate Exam'------------------------------------------
alter PROCEDURE GenerateExam
    @coursename  varchar(50),
    @numMCQ INT,
    @numTF INT
AS
BEGIN
    CREATE TABLE #ExamTemp (
        question_id INT,
        question_head VARCHAR(300),
        choiceA varchar(255),
		choiceB varchar(255),
		choiceC varchar(255),
		choiceD varchar(255)
	
    );
	 -- Generate MCQ questions
    INSERT INTO #ExamTemp (question_id, question_head,choiceA,choiceB,choiceC,choiceD)
		select  top (@numMCQ)  question_ID,question_head, choiceA,choiceB,choiceC,choiceD 
	from  Question Q inner join  Course  C on Q.question_type = 'MCQ'  and C.course_ID = Q.Course_id 
	  and Q.course_ID IN (select course_id from Course where Course_name =  @coursename )
	   order by newid() 

    -- Generate True/False questions
    INSERT INTO #ExamTemp (question_id, question_head,choiceA,choiceB,choiceC,choiceD)
    SELECT TOP (@numTF)  question_ID, question_head,choiceA,choiceB,choiceC,choiceD
    FROM question Q inner join  Course  C 
	on question_type = 'True or False' and C.course_ID = Q.Course_id  
	                   and  Q.course_ID IN (select course_id from Course where Course_name = @coursename )
    ORDER BY NEWID();

	select * from #ExamTemp
    insert into exam (Duration) values (60)
	insert into Take_exam (exam_id , quest_id)
	select  exam_id , question_id
	from exam,#ExamTemp
	where exam_id=IDENT_CURRENT('exam')
END

execute GenerateExam 'Enterprise Systems', 7,3

--------------------------------'Exam Answers'-------------------------------------------
Alter proc ExamAnswer  

 @Question_id int , 
 @Sid int , 
 @Answer varchar(250)

  as 

update Take_exam
Set stud_id = @Sid , stud_answer = @Answer

where quest_id = @Question_id

Exec ExamAnswer 12,5, 'All of the above.'

--------------------------------'Exam Correction'-----------------------------------------------------
alter proc ExamCorrection  

@Take_exam_id int , 
@questionid int ,
@Studentid int
as 

Declare @Answer varChar (300) = (   
select Model_Answer  from Question
where Question_id = @questionid)

if @Answer = (Select stud_answer from Take_exam where Take_exam_id = @Take_exam_id ) 
Begin 

update Take_exam
Set grade = 1 , exam_correction = @Answer
 where Take_exam_id = @Take_exam_id and stud_id = @Studentid
end 
Else 
Begin
update Take_exam
Set grade = 0 , exam_correction = @Answer
 where [Take_exam_id] = @Take_exam_id and stud_id = @Studentid
End 


Exec ExamCorrection 901,12,5





