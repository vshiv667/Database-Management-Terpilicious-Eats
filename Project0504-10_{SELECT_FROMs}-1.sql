-- 1) What are the names of the restaurants ranked by their average rating?  
SELECT r.restaurantName, AVG(v.reviewRating) AS "Average Rating", COUNT(v.reviewId) "Number of Reviews"
FROM [TerpEats.Restaurant] r, [TerpEats.Review] v, [TerpEats.Write] w
WHERE r.restaurantId = w.restaurantId AND
	v.reviewId = w.reviewId
GROUP BY r.restaurantId, r.restaurantName
ORDER BY "Average Rating" DESC

-- 2) Which locations offers the restaurants with the highest average ratings?
SELECT l.locationName as 'Location Name', AVG(v.reviewRating) AS 'Average Rating', COUNT(v.reviewId) AS 'Number of Reviews'
FROM [TerpEats.Location] l, [TerpEats.Restaurant] r, [TerpEats.Review] v, [TerpEats.Write] w
WHERE r.restaurantId = w.restaurantId 
  AND v.reviewId = w.reviewId 
  AND r.locationId = l.locationId
GROUP BY l.locationName
ORDER BY "Average Rating" DESC, "Number of Reviews" DESC

-- 3) What is the average salary of employees by employee position?
SELECT e.employeePosition AS 'Employee Position', AVG(e.employeeSalary) AS 'Average Salary'
FROM [TerpEats.Employee] e
GROUP BY e.employeePosition
ORDER BY "Average Salary" ASC

-- 4) Which customers have written the most reviews?
SELECT customerLastName AS "Customer First Name", customerFirstName AS "Customer Last Name", COUNT(w.reviewId) AS 'Number of reviews'
FROM  [TerpEats.Write] w, [TerpEats.Customer] c, [TerpEats.Review] r
WHERE w.customerId = c.customerId
and w.reviewId = r.reviewId
GROUP BY customerLastName, customerFirstName
HAVING COUNT(w.reviewId) = (select MAX(a.count_Reviews) as 'Max_reviews'
FROM (SELECT c.customerLastName, c.customerFirstName, COUNT(w.reviewId) AS 'count_Reviews'
FROM  [TerpEats.Write] w, [TerpEats.Customer] c,[TerpEats.Review] r
WHERE w.customerId = c.customerId
and w.reviewId = r.reviewId
group by c.customerLastName, c.customerFirstName
)a)

-- 5) What is the average salary of Chefs at restaurants which have average ratings greater than 4?
SELECT  r.restaurantName as 'Restaurant',AVG(e.employeeSalary) AS 'Average Salary'
FROM [TerpEats.Employee] e,[TerpEats.Restaurant] r, [TerpEats.Review] v, [TerpEats.Write] w
WHERE e.employeePosition = 'Chef' 
AND e.restaurantId = r.restaurantId
AND r.restaurantId = w.restaurantId 
AND v.reviewId = w.reviewId
GROUP BY r.restaurantName
HAVING avg(v.reviewRating)>4


--6)What are the number of employees and the average rating of restaurants, ordered alphabetically by restaurant name?
SELECT r.restaurantName AS 'Restaurant Name', count(DISTINCT e.employeeId) AS 'Number of Employees', avg(v.reviewRating) AS 'Average Rating'
FROM [TerpEats.Employee] e, [TerpEats.Restaurant] r, [TerpEats.Review] v, [TerpEats.Write] w
WHERE e.restaurantId = r.restaurantId AND v.reviewId = w.reviewId 
		AND w.restaurantId = r.restaurantId
GROUP BY r.restaurantName
ORDER BY r.restaurantName

 






