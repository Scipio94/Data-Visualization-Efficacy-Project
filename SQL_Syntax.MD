~~~ SQL
/*SY 22-23 Snap Metrics TEMP TABLE*/
CREATE TEMP TABLE Viz AS
SELECT 
  EXTRACT(MONTH FROM Last_Viewed) AS Month,
  EXTRACT(YEAR FROM Last_Viewed) AS Year,
  Times_Viewed, 
  View_Name,
FROM SY_22_23_Data_Viz_Views -- SY 22-23 Dataset
ORDER BY Year, Month;
~~~

~~~ SQL
/*Views Total*/
SELECT 
  SUM(Viz.Times_Viewed) AS Total_Views
FROM Viz;
~~~
**Result**
