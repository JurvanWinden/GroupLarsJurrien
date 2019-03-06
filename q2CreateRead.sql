-- Our views
-- approx 1 minute
CREATE MATERIALIZED VIEW PassedCoursesPerStudent AS (
    SELECT StudentId, C.CourseId, Grade, ECTS FROM Courses AS C, CourseOffers AS CO, CourseRegistrations AS CR, StudentRegistrationsToDegrees AS SD
    WHERE CO.CourseOfferId = CR.CourseOfferId
    AND SD.StudentRegistrationId = CR.StudentRegistrationId
    AND CO.CourseId = C.CourseId
    AND Grade >= 5
    AND Grade IS NOT NULL
);

-- approx 1 minute
CREATE MATERIALIZED VIEW StudentGPA AS (
    SELECT StudentId, SUM(ECTS * Grade) / CAST (SUM(ECTS) AS DECIMAL) AS GPA FROM PassedCoursesPerStudent
    GROUP BY StudentId
);