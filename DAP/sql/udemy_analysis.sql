/* UDEMY COURSE DATA ANALYSIS*/
-- Learning-based SQL analysis recreated for practice
-- Focus: Revenue, subscribers, course performance

USE portfolio_project;

/* STEP 1: Combine all course tables into one master table */

SELECT *
INTO Udemy_All_Courses
FROM Business_Courses
UNION ALL
SELECT * FROM Graphics_Design_Courses
UNION ALL
SELECT * FROM Music_Courses
UNION ALL
SELECT * FROM Web_Development_Courses;


/* STEP 2: Inspect combined data */

SELECT *
FROM Udemy_All_Courses
ORDER BY Subject;


/* STEP 3: Clean published date */

ALTER TABLE Udemy_All_Courses
ADD Published_Date DATE;

UPDATE Udemy_All_Courses
SET Published_Date = CAST(Date_Published AS DATE);

ALTER TABLE Udemy_All_Courses
DROP COLUMN Date_Published;


/* STEP 4: Create revenue column */

ALTER TABLE Udemy_All_Courses
ADD Revenue DECIMAL(18,2);

UPDATE Udemy_All_Courses
SET Revenue = Price * Num_of_Subscribers;


/* SUMMARY METRICS*/

-- Total courses
SELECT COUNT(*) AS Total_Courses
FROM Udemy_All_Courses;

-- Total subscribers
SELECT SUM(Num_of_Subscribers) AS Total_Subscribers
FROM Udemy_All_Courses;

-- Total revenue
SELECT SUM(Revenue) AS Total_Revenue
FROM Udemy_All_Courses;

-- Number of subjects
SELECT COUNT(DISTINCT Subject) AS Total_Subjects
FROM Udemy_All_Courses;


/*   ANALYTICAL INSIGHTS */

-- Revenue by subject
SELECT
    Subject,
    SUM(Revenue) AS Revenue_By_Subject
FROM Udemy_All_Courses
GROUP BY Subject
ORDER BY Revenue_By_Subject DESC;


-- Average content duration by subject
SELECT
    Subject,
    ROUND(AVG(Content_Duration), 2) AS Avg_Content_Duration
FROM Udemy_All_Courses
GROUP BY Subject
ORDER BY Avg_Content_Duration DESC;


-- Top 5 revenue generating courses
SELECT TOP 5
    Course_Title,
    Subject,
    SUM(Revenue) AS Course_Revenue
FROM Udemy_All_Courses
GROUP BY Course_Title, Subject
ORDER BY Course_Revenue DESC;


-- Subscribers and revenue by course level
SELECT
    Level,
    SUM(Num_of_Subscribers) AS Subscribers,
    SUM(Revenue) AS Revenue
FROM Udemy_All_Courses
GROUP BY Level
ORDER BY Revenue DESC;


-- Course count by level
SELECT
    Level,
    COUNT(*) AS Course_Count
FROM Udemy_All_Courses
GROUP BY Level
ORDER BY Course_Count DESC;


-- Free vs Paid courses
SELECT
    Free_Paid,
    COUNT(*) AS Course_Total
FROM Udemy_All_Courses
GROUP BY Free_Paid;


-- Average rating by subject
SELECT
    Subject,
    ROUND(AVG(Rating), 2) AS Avg_Rating
FROM Udemy_All_Courses
GROUP BY Subject
ORDER BY Avg_Rating DESC;


/*TIME-BASED ANALYSIS*/

-- Revenue by year
SELECT
    YEAR(Published_Date) AS Year,
    SUM(Revenue) AS Yearly_Revenue
FROM Udemy_All_Courses
GROUP BY YEAR(Published_Date)
ORDER BY Year;


-- Revenue by month
SELECT
    DATENAME(MONTH, Published_Date) AS Month,
    SUM(Revenue) AS Monthly_Revenue
FROM Udemy_All_Courses
GROUP BY DATENAME(MONTH, Published_Date), MONTH(Published_Date)
ORDER BY MONTH(Published_Date);
