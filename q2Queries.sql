--The 8 queries to be answered
-- Q1
SELECT CourseName, Grade
FROM CourseRegistrations as cr, StudentRegistrationToDegrees as sd, CourseOffers as co, Courses as c
WHERE 	StudentId = %1% AND DegreeId = %2% AND
		sd.StudentRegistrationId = cr.StudentRegistrationId AND
		cr.CourseOfferId = co.CourseOfferId AND
		co.CourseId = c.CourseId AND
		cr.Grade > 5
GROUP BY (co.Year, co.Quartile, co.CourseOfferId);

-- Q2
-- Select all students that have completed a degree
SELECT StudentRegistrationsToDegrees.StudentRegistrationID, Degrees.DegreeId FROM StudentRegistrationsToDegrees, Students, Degrees, Courses, CourseOffers, CourseRegistrations
WHERE StudentRegistrationsToDegrees.StudentId = Students.StudentId
AND Degrees.DegreeId = StudentRegistrationsToDegrees.DegreeId
AND TotalECTS = 200
AND Courses.DegreeId = StudentRegistrationsToDegrees.DegreeId
AND CourseOffers.CourseId = Courses.CourseId
AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
AND CourseRegistrations.Grade >= 5;

SELECT StudentRegistrationsToDegrees.StudentRegistrationId, CourseOffers.CourseOfferId, Grade FROM StudentRegistrationsToDegrees, CourseRegistrations, Courses, Degrees, CourseOffers
WHERE StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId
AND Courses.CourseId = CourseOffers.CourseId
AND CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
AND StudentRegistrationsToDegrees.DegreeId = Courses.DegreeId
AND Degrees.DegreeId = Courses.DegreeId
AND Degrees.TotalECTS = 200
AND NOT EGrade < 5

-- Q3
-- needed: all active students, percentage female

--Q4 Give percentage of female students for all degrees of a department
WITH StudentCount AS (
    SELECT COUNT(Students.StudentId) AS SC FROM Degrees, StudentRegistrationsToDegrees, Students
    WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId
    AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId
    AND Dept = 'be to thin'
    GROUP BY Degrees.Dept
),
FemaleStudentCount AS (
    SELECT COUNT(Students.StudentId) AS FSC FROM Degrees, StudentRegistrationsToDegrees, Students
    WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId
    AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId
    AND Gender = 'F'
    AND Degrees.Dept = 'be to thin' -- replace this with %1%
    GROUP BY Degrees.Dept
)
SELECT (FSC / CAST(SC AS DECIMAL) * 100) AS Percentage FROM FemaleStudentCount, StudentCount;

-- Q5
-- needed: passing per course offer, total number of students, without course drop outs

--Q6

-- Q7
SELECT DegreeId, BirthYearStudent, Gender, AVG(Grade)
FROM CourseRegistrations as cr, CourseOffers as co, Courses as c, Students as s, StudentRegistrationToDegrees as sd
WHERE 	cr.CourseOfferId = co.CourseOfferId AND
		co.CourseId = c.CourseId AND
		cr.StudentRegistrationId = sd.StudentRegistrationId AND
		s.StudentId = sd.StudentId
GROUP BY CUBE(DegreeId, BirthYearStudent, Gender);

-- Q8
-- Count Students for each CourseOffer
SELECT CourseRegistrations.CourseOfferId, COUNT(CourseRegistrations.StudentRegistrationId) as StudentCount FROM CourseRegistrations
GROUP BY CourseRegistrations.CourseOfferId;
-- Count StudentAssistants for each CourseOffer
SELECT CourseOfferId, COUNT(StudentAssistants.StudentRegistrationId) as StudentAssistantCount FROM StudentAssistants
GROUP BY StudentAssistants.CourseOfferId;
