SELECT CourseName, Grade FROM PassedCoursesPerStudent AS P, Courses AS C WHERE P.StudentId = %1% AND P.DegreeId = %2% AND P.CourseId = C.CourseId;
SELECT StudentId FROM StudentGPA WHERE GPA >= %1%;
SELECT 0;
WITH StudentCount AS (SELECT COUNT(Students.StudentId) AS SC FROM Degrees, StudentRegistrationsToDegrees, Students WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Dept = %1% GROUP BY Degrees.Dept ), FemaleStudentCount AS ( SELECT COUNT(Students.StudentId) AS FSC FROM Degrees, StudentRegistrationsToDegrees, Students WHERE Students.StudentId = StudentRegistrationsToDegrees.StudentId AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId AND Gender = 'F' AND Degrees.Dept = %1% GROUP BY Degrees.Dept) SELECT (FSC / CAST (SC AS DECIMAL) ) AS Percentage FROM FemaleStudentCount, StudentCount;
SELECT 0;
SELECT 0;
SELECT 0;
WITH SC AS (SELECT CourseRegistrations.CourseOfferId, COUNT(CourseRegistrations.StudentRegistrationId) as StudentCount FROM CourseRegistrations GROUP BY CourseRegistrations.CourseOfferId ), AC AS (SELECT CourseOfferId, COUNT(StudentAssistants.StudentRegistrationId) as StudentAssistantCount FROM StudentAssistants GROUP BY StudentAssistants.CourseOfferId) SELECT Courses.CourseName, CourseOffers.Year, CourseOffers.Quartile FROM Courses, CourseOffers, SC, AC WHERE SC.CourseOfferId = AC.CourseOfferId AND AC.CourseOfferId = CourseOffers.CourseOfferId AND CourseOffers.CourseId = Courses.CourseId AND (AC.StudentAssistantCount * 50 >= SC.StudentCount);