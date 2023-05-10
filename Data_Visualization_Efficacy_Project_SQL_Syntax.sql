/*SY 22-23 Snap Metrics TEMP TABLE*/
CREATE TEMP TABLE Viz AS
SELECT 
  EXTRACT(MONTH FROM Last_Viewed) AS Month,
  EXTRACT(YEAR FROM Last_Viewed) AS Year,
  Times_Viewed, 
  View_Name,
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2223_Viz_Metrics`
ORDER BY Year, Month;

/*Views Total*/
SELECT 
  SUM(Viz.Times_Viewed) AS Total_Views
FROM Viz;

/*Views Total Testing*/
SELECT 
  SUM(Viz.Times_Viewed) AS Testing_Total_Views
FROM Viz
WHERE Viz.Month IN (9,1,4);-- Months in which diagnostic was administered


/*Views MoM*/
SELECT 
  sub1.Month,
  sub1.Year,
  sub1.Month_Viz_Views,
  sub1.MoM_Views_Change,
  ROUND(AVG(sub1.MoM_Views_Change) OVER ()) AS Avg_MoM_Views_Change,
  CONCAT(sub1.MoM_Views_Percent_Change,'%') AS MoM_Views_Percentage_Change,
  CONCAT(ROUND(AVG(sub1.MoM_Views_Percent_Change) OVER (),2),'%') AS Avg_MoM_Views_Percent_Change
FROM
(SELECT  
  DISTINCT sub.month,
  sub.year, 
  sub.month_viz_views,
  COALESCE(sub.Month_viz_views - LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month),0) AS MoM_Views_Change,
  COALESCE(ROUND((sub.Month_viz_views - LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month))/ (LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month)) * 100,2),0) AS MoM_Views_Percent_Change, -- MoM Views Changed/ Month Viz Views
FROM
  (
  SELECT
    DISTINCT Viz.Month,
    Viz.Year,
  SUM(Viz.Times_Viewed) OVER (PARTITION BY Viz.Month,Viz.Year) AS Month_Viz_Views
FROM Viz
ORDER BY Viz.Year, Viz.Month) AS sub
ORDER BY sub.year,sub.month) AS sub1
ORDER BY sub1.year, sub1.month;

/*Views MoM Testing*/
SELECT 
  sub1.Month,
  sub1.Year,
  sub1.Month_Viz_Views,
  sub1.MoM_Views_Change,
  ROUND(AVG(sub1.MoM_Views_Change) OVER ()) AS Avg_MoM_Views_Change,
  CONCAT(sub1.MoM_Views_Percent_Change,'%') AS MoM_Views_Percentage_Change,
  CONCAT(ROUND(AVG(sub1.MoM_Views_Percent_Change) OVER (),2),'%') AS Avg_MoM_Views_Percent_Change
FROM
(SELECT  
  DISTINCT sub.month,
  sub.year, 
  sub.month_viz_views,
  COALESCE(sub.Month_viz_views - LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month),0) AS MoM_Views_Change,
  COALESCE(ROUND((sub.Month_viz_views - LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month))/ (LAG(sub.month_viz_views,1) OVER (ORDER BY sub.year, sub.month)) * 100,2),0) AS MoM_Views_Percent_Change, -- MoM Views Changed/ Month Viz Views
FROM
  (
  SELECT
    DISTINCT Viz.Month,
    Viz.Year,
  SUM(Viz.Times_Viewed) OVER (PARTITION BY Viz.Month,Viz.Year) AS Month_Viz_Views
FROM Viz
WHERE Viz.Month IN (9,1,4) -- Months in which diagnostic was administered
ORDER BY Viz.Year, Viz.Month) AS sub
ORDER BY sub.year,sub.month) AS sub1
ORDER BY sub1.year, sub1.month;

/*Most Viewed Viz*/
SELECT
  DISTINCT Viz.View_Name,
  SUM(Viz.Times_Viewed) OVER (PARTITION BY Viz.View_Name) AS Total_Viz_Views,
  ROUND(SUM(Viz.Times_Viewed) OVER (PARTITION BY Viz.View_Name)/ SUM(Viz.Times_Viewed) OVER (),2) AS Total_Viz_Views_Percentage
FROM Viz
ORDER BY Total_Viz_Views DESC;
--Principal Viz most viewed viz

/*Anonymized Data Visualization Set SY2223 */
SELECT 
  RPAD(LEFT(Username,2),10,'#') AS Username,
  View_ID,
  View_Name,
  Last_Viewed,
  Times_Viewed
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2223_Viz_Metrics` ;


/*Anonymized Snapshots SY2122 */
SELECT 
  RPAD(LEFT(Username,2),10,'#') AS Username,
  View_ID,
  View_Name,
  Last_Viewed,
  Times_Viewed
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2122_Data_Snapshot_Metrics`;

SELECT 
  ROUND(1062/588,2);-- SY 2223 Viz Total Views /  SY 2122 Viz Total Views 

/*Data Snapshots SY 2122 Table*/
CREATE TEMP TABLE Snap AS
SELECT 
  EXTRACT(MONTH FROM Last_Viewed) AS Month,
  EXTRACT(YEAR FROM Last_Viewed) AS Year,
  Times_Viewed, 
  View_Name,
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2122_Data_Snapshot_Metrics`
--WHERE Username NOT IN ('bzjawin@foundationacademy.org', 'togarro@foundationacademy.org','sokoya@foundationacademy.org') --Filtering out Data Team
ORDER BY Year, Month;

/*SY 2122 Snapshots Views Total*/
SELECT 
  SUM(Times_Viewed) AS Total_Views
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2122_Data_Snapshot_Metrics`;
-- 588 views for '21-'22 for data snaphsots

/*Data Snapshots MoM Metrics*/
SELECT 
  sub1.Month,
  sub1.Year,
  sub1.Month_Snap_Views,
  sub1.MoM_Views_Change,
  ROUND(AVG(sub1.MoM_Views_Change) OVER ()) AS Avg_MoM_Views_Change,
  CONCAT(sub1.MoM_Views_Percent_Change,'%') AS MoM_Views_Percentage_Change,
  CONCAT(ROUND(AVG(sub1.MoM_Views_Percent_Change) OVER (),2),'%') AS Avg_MoM_Views_Percent_Change
FROM
(SELECT  
  DISTINCT sub.month,
  sub.year, 
  sub.Month_Snap_Views,
  COALESCE(sub.Month_Snap_Views - LAG(sub.Month_Snap_Views,1) OVER (ORDER BY sub.year, sub.month),0) AS MoM_Views_Change,
  COALESCE(ROUND((sub.Month_Snap_Views - LAG(sub.Month_Snap_Views,1) OVER (ORDER BY sub.year, sub.month))/ (LAG(sub.Month_Snap_Views,1) OVER (ORDER BY sub.year, sub.month)) * 100,2),0) AS MoM_Views_Percent_Change, -- MoM Views Changed/ Month Viz Views
FROM
  (
  SELECT
    DISTINCT Snap.Month,
    Snap.Year,
  SUM(Snap.Times_Viewed) OVER (PARTITION BY Snap.Month,Snap.Year) AS Month_Snap_Views
FROM Snap
ORDER BY Snap.Year, Snap.Month) AS sub
ORDER BY sub.year,sub.month) AS sub1
ORDER BY sub1.year, sub1.month;


/*Combining Tables Calculating Views By School Year*/
CREATE TEMP TABLE Agg AS -- Using Union All Function to join tables
SELECT 
  Username, View_Name, Last_Viewed, Times_Viewed
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2223_Viz_Metrics`
UNION ALL
SELECT Username, View_Name, Last_Viewed, Times_Viewed
FROM `single-being-353600.Data_Snapshot_SY_Comparison.SY_2122_Data_Snapshot_Metrics`;

/*Calculating Views By School Year and finding difference YoY*/
SELECT 
  sub1.school_year, 
  sub1.SY_Data_Visualization_Views,
  COALESCE(sub1.SY_Data_Visualization_Views - LAG(sub1.SY_Data_Visualization_Views,1) OVER (ORDER BY sub1.SY_Data_Visualization_Views),0) AS YoY_Diff,
  CONCAT(ROUND(COALESCE((sub1.SY_Data_Visualization_Views - LAG(sub1.SY_Data_Visualization_Views,1) OVER (ORDER BY sub1.SY_Data_Visualization_Views)) / (LAG(sub1.SY_Data_Visualization_Views,1) OVER (ORDER BY sub1.SY_Data_Visualization_Views)),0) * 100),'%') AS YoY_Diff_Percentage
FROM 
(SELECT
  DISTINCT sub.School_Year,
  SUM(sub.times_viewed) OVER (PARTITION BY sub.school_year) AS SY_Data_Visualization_Views
FROM 
(SELECT
  Username, 
  View_Name, 
  Last_Viewed, 
  Times_Viewed,
  CASE
    WHEN View_Name IN ('Attendance', 'Culture Snapshot', 'Academic Snapshot', 'June Academic Data', 'Attendance Without Record', 'Student Academic Snapshot') THEN 'SY 21_22' -- if then statement to calculate total views by school year
    ELSE 'SY 22_23' 
    END AS School_Year
FROM Agg) AS sub
ORDER BY SY_Data_Visualization_Views) AS sub1
ORDER BY sub1.SY_Data_Visualization_Views

