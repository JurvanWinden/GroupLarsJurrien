-- queries to run after loading + preparing database

SELECT CourseOffers.CourseOfferId, CourseOffers.CourseId, Year, Quartile, CourseName, CourseDescription, Degrees.DegreeId, Dept, DegreeDescription, TotalECTS, Teachers.TeacherId, TeacherName, Address, BirthyearTeacher, Gender  FROM CourseOffers, Courses, Degrees, TeacherAssignmentsToCourses, Teachers
WHERE CourseOffers.CourseOfferId = 1
AND CourseOffers.CourseId = Courses.CourseId
AND CourseOffers.CourseOfferId = TeacherAssignmentsToCourses.CourseOfferId
AND TeacherAssignmentsToCourses.TeacherId = Teachers.TeacherId
AND Courses.DegreeId = Degrees.DegreeId;

SELECT StudentAssistants.CourseOfferId, CourseId, Year, Quartile, Students.StudentId, StudentName, Address, BirthYearStudent, Gender, Degrees.DegreeId, Dept, DegreeDescription, TotalECTS FROM StudentAssistants, CourseOffers, Students, Degrees, StudentRegistrationsToDegrees
WHERE StudentAssistants.StudentRegistrationId = 3
AND StudentAssistants.CourseOfferId = CourseOffers.CourseOfferId
AND Students.StudentId = StudentRegistrationsToDegrees.StudentId
AND StudentRegistrationsToDegrees.StudentRegistrationId = StudentAssistants.StudentRegistrationId
AND StudentRegistrationsToDegrees.DegreeId = Degrees.DegreeId;

SELECT AVG(Grade) FROM CourseRegistrations WHERE CourseRegistrations.StudentRegistrationId=3;
