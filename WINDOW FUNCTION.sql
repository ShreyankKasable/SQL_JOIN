--                                                  WINDOW FUNCTION

USE FIRST;
SELECT * FROM EMPLOYEES_DETAIL;

SELECT MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES_DETAIL; 

SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES_DETAIL
GROUP BY DEPARTMENT_ID; 

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
MAX(SALARY) OVER() AS MAX_SALARY
FROM EMPLOYEES_DETAIL E;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, 
MAX(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS MAX_SALARY
FROM EMPLOYEES_DETAIL E;

-- WINDOW FUNCTION :-
				-- ROW_NUMBER
                -- RANK
                -- DENSE_RANK
                -- LEAD
                -- LAG
                
-- 1) ROW_NUMBER WINDOW FUNCTION :-

-- USING THIS WE ARE GIVING ROW NUMBER TO EACH INSTANCES
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
ROW_NUMBER() OVER() AS RN
FROM EMPLOYEES_DETAIL E;                

-- USING THIS WE WILL GIVE THE ROW NUMBER TO INSTANCES WITH RESPECT TO THERE DEPARTMENT_ID
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID) AS RN
FROM EMPLOYEES_DETAIL E;     

-- FETCH THE FIRST 2 EMPLOYEE FROM EACH DEPARTMENT TO JOIN THE COMPANY :-
   -- SUBQUERY :-
		SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
		ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID) AS RN
		FROM EMPLOYEES_DETAIL E;  
        
   -- FINAL RESULT :-
	   SELECT * FROM (SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
					  ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID) AS RN
					  FROM EMPLOYEES_DETAIL E) SUB
	   WHERE SUB.RN <3;               


-- 2) RANK WINDOW FUNCTION :-   

-- FETCH THE TOP 3 EMPLOYEES IN EACH DEPARTMENT EARNING THE MAX SALARY
   -- SUBQUERY
	   SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
	   RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RN
	   FROM EMPLOYEES_DETAIL E;
       
   -- FINAL RESULT :-
   SELECT * FROM (SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
				  RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RN
	              FROM EMPLOYEES_DETAIL E) SUB
                  WHERE SUB.RN <=3;
                  
-- 3) DENSE_RANK WINDOW FUNCTION:-
/*
				dense_rank is very similar to rank, in rank if there is any duplicate value then it will skip rank 
                but in dense_rank it will not skip any value
*/
   -- FINAL RESULT :-
   SELECT * FROM (SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
				  RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RN
	              FROM EMPLOYEES_DETAIL E) SUB
                  WHERE SUB.RN <=3;
                  
                  
-- 4) LAG WINDOW FUNCTION :-
	SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID,
	LAG(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS PREV_EMP_SALARY
	FROM EMPLOYEES_DETAIL;
                  
-- 5) LEAD WINDOW FUNCTION :-
	SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID,
	LEAD(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS PREV_EMP_SALARY
	FROM EMPLOYEES_DETAIL;


-- FETCH A QUERY TO DISPLAY IF THE SALARY OF AN EMPLOYEE IS HIGHER, LOWER OR EQUAL TO THE PREVIOUS EMPLOYEE.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
LAG(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS PREV_EMP_SALARY,
CASE WHEN E.SALARY < LAG(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) THEN "LESSER THEN PREVIOUS SALARY"
	 WHEN E.SALARY > LAG(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) THEN "GREATER THEN PREVIOUS SALARY"
     WHEN E.SALARY = LAG(SALARY, 1, 0) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) THEN "SAME AS PREVIOUS SALARY"
     ELSE "NULL"
     END SAL_REVIEW
FROM EMPLOYEES_DETAIL E;     

CREATE TABLE PRODUCT
(
	PRODUCT_CATEFORY VARCHAR(255), 
    BRAND VARCHAR(255),
    PRODUCT_NAME VARCHAR(255),
    PRICE INT
);

INSERT INTO PRODUCT
VALUES ('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
	   ('Phone', 'Apple', 'iPhone 12 Pro', 1100),
       ('Phone', 'Apple', 'iPhone 12', 1000),
       ('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
       ('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
       ('Phone', 'Samsung', 'Galaxy Note 20', 1200),
       ('Phone', 'Samsung', 'Galaxy S21', 1000),
       ('Phone', 'OnePlus', 'OnePlus Nord', 300),
       ('Phone', 'OnePlus', 'OnePlus 9', 800),
       ('Phone', 'Google', 'Pixel 5', 600),
       ('Laptop', 'Apple', 'MacBook Pro 13', 2000),
       ('Laptop', 'Apple', 'MacBook Air', 1200),
       ('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
       ('Laptop', 'Dell', 'XPS 13', 2000),
       ('Laptop', 'Dell', 'XPS 15', 2300),
       ('Laptop', 'Dell', 'XPS 17', 2500),
       
       ('Earphone', 'Apple', 'AirPods Pro', 280),
       ('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
       ('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
       ('Earphone', 'Sony', 'WF-1000XM4', 250),
       
       ('Headphone', 'Sony', 'WH-1000XM4', 250),
       ('Headphone', 'Apple', 'AirPods Max', 550),
       ('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
       
       ('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
       ('Smartwatch', 'Apple', 'Apple Watch SE', 400),
       ('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
       ('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
       
	
       
-- 4) FIRST VALUE WINDOW FUNCTION :- 

		-- WRITE QUERY TO DISPLAY THE MOST EXPENSIVE PRODUCT UNDER EACH CATEGORY (CORRESPONDING TO EACH RECORD :-
			SELECT * ,
			FIRST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME)) OVER(PARTITION BY PRODUCT_CATEFORY ORDER BY PRICE DESC) AS FIRSTVALUE
			FROM PRODUCT;
        
        
-- 4) LAST VALUE WINDOW FUNCTION :- 

		-- WRITE QUERY TO DISPLAY THE LEAST EXPENSIVE PRODUCT UNDER EACH CATEGORY (CORRESPONDING TO EACH RECORD :-
			SELECT * ,
			LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME)) OVER(PARTITION BY PRODUCT_CATEFORY ORDER BY PRICE) AS FIRSTVALUE
			FROM PRODUCT; -- USING THIS QUERY WE ARE NOT GETTING THE RESULT THAT WE ARE EXPECTED THIS IS BECAUSE OF FRAME CLAUSE
            
            
-- DEFAULT FRAME CLAUSE:-
			SELECT * ,
			LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER(
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- THIS IS THE DEFAULT FRAME CLAUSE
                ) AS FIRSTVALUE
			FROM PRODUCT;      
            
            
            SELECT * ,
			LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER(
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING  -- THIS IS THE FRAME CLAUSE WHICH IS GIVING EXPECTED RESULT
                ) AS FIRSTVALUE
			FROM PRODUCT;  
            
            
            SELECT * ,
			LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER(
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- THIS IS THE FRAME CLAUSE WHICH IS GIVING EXPECTED RESULT
                ) AS FIRSTVALUE1,
            LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER(
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- THIS IS THE FRAME CLAUSE WHICH IS GIVING EXPECTED RESULT
                ) AS FIRSTVALUE2    
			FROM PRODUCT WHERE PRODUCT_CATEFORY = 'PHONE';
/*
CONCLUSION:- when we are using ROWS with CURRENT ROW then it will process iteratively that means when it is processing it will have data about current instance and
			 and its previous instances, while when we are using RANGE it have all the data instance lies in that particular categories.
*/             

-- If we wants to consider instance from range CURRENT-2 to CURRENT+2 then we can use below method:-
            SELECT * ,
			LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER(
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING  -- THIS IS THE FRAME CLAUSE WHICH IS GIVING EXPECTED RESULT
                ) AS FIRSTVALUE
			FROM PRODUCT; 	
/* CONCLUSION :- From the observation we can see that it is just considering element from range CURRENT-2 to CURRENT+2 and calsulating result based on available data
				 and as we are using range so it there is any duplicate then it is using data of last duplicate element.
*/
                 
 
-- ALTERNATE WAY OF WRITING SQL QUERY USING WINDOW FUNCTION:-

			SELECT * ,
			FIRST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER WIND AS MOST_EXPENSIVE_PREDUCT,
            LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER WIND AS LEAST_EXPENSIVE_PRODUCT    
			FROM PRODUCT 
            WINDOW WIND AS (
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                );
	

-- NTH VALUE WINDOW FUNCTION :-
-- WRITE A QUERY TO DISPLAY THE SECOND MOST EXPENSIVE PRODUCT UNDER EACH CATEGORY
			SELECT * ,
			FIRST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER WIND AS MOST_EXPENSIVE_PREDUCT,
            LAST_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME))
            OVER WIND AS LEAST_EXPENSIVE_PRODUCT,
            NTH_VALUE(CONCAT(BRAND,' - ',PRODUCT_NAME), 2)
            OVER WIND AS NTH_EXPENSIVE_PRODUCT
			FROM PRODUCT 
            WINDOW WIND AS (
				PARTITION BY PRODUCT_CATEFORY 
                ORDER BY PRICE DESC
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                );
                
          -- REQUIRRE RESULT :-      
			  SELECT DISTINCT PRODUCT_CATEFORY , 
			  NTH_VALUE(CONCAT(BRAND," - ", PRODUCT_NAME), 2)
			  OVER WIND AS NTH_EXPENSIVE_PRODUCT
			  FROM PRODUCT
			  WINDOW WIND AS ( PARTITION BY PRODUCT_CATEFORY ORDER BY PRICE DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);

-- NTILE WINDOW FUNCTION :-
	-- WRITE A QUERY TO SEGREGGATE ALL THE EXPENSIVE PHONE, MID RANGE PHONE, AND THE CHEAPER PHONE.
    
		SELECT *, 
        NTILE (3) OVER (ORDER BY PRICE DESC) AS BUCKET
        FROM PRODUCT
        WHERE PRODUCT_CATEFORY = 'Phone';
        
        -- FINAL RESULT :-
        
        SELECT CONCAT(BRAND,' - ', PRODUCT_NAME),
        CASE WHEN X.BUCKET = 1 THEN 'Expensive Phone'
			 WHEN X.BUCKET = 2 THEN 'Mid Range Phone'
			 WHEN X.BUCKET = 3 THEN 'Cheaper Phone' END PHONE_CATEGORY
        FROM (SELECT *, 
        NTILE (3) OVER (ORDER BY PRICE DESC) AS BUCKET
        FROM PRODUCT
        WHERE PRODUCT_CATEFORY = 'Phone') X;     
                  
                  
-- CUME_DIST (Cumulative distribution) :
							-- Value --> 1 <= CUME_DIST > 0
                            -- Current Row no (or Row No with value same as current row)/Total no of row 
	
	-- QUERY TO FETCH ll products which are constituting the first 30% of the data in products table on price.
		
        SELECT *, 
		CUME_DIST() OVER (ORDER BY PRICE DESC) AS CUME_DISTRIBUTION,
		ROUND(CUME_DIST() OVER (ORDER BY PRICE DESC) * 100, 2) AS CUME_DIST_PERCENTAGE
		FROM PRODUCT;
        
        -- FINAL QUERY:-
        
        SELECT PRODUCT_NAME, CONCAT(CUME_DIST_PERCENTAGE, "%") AS CUME_DIST_PERCENT
		FROM(SELECT *, 
			 CUME_DIST() OVER (ORDER BY PRICE DESC) AS CUME_DISTRIBUTION,
			 ROUND(CUME_DIST() OVER (ORDER BY PRICE DESC) * 100, 2) AS CUME_DIST_PERCENTAGE
			 FROM PRODUCT) X
        WHERE X.CUME_DIST_PERCENTAGE <=30;     
        

-- PERCENT_RANK (Relative rank of the current row / Percentage Ranking):-
					-- value --> <<= PERCENT_RANK > 0
                    -- formula :- Current Row No - 1 / Total no od rows -1
                    
	-- QUERY TO INDENTIFY HOW MUCH PERCENTAGE MORE EXPENSIVE IS 'GALAXY Z FOLD 3' WHEN COMPARED TO ALL PRODUCTS.
    
			SELECT *,
				PERCENT_RANK() OVER(ORDER BY PRICE) AS PERCENTAGE_RANK,
				ROUND(PERCENT_RANK() OVER (ORDER BY PRICE) * 100, 2) AS PER_RANK
				FROM PRODUCT;
        
        -- FINAL RESULT :-
        SELECT PRODUCT_NAME, PER_RANK
        FROM (SELECT *,
				PERCENT_RANK() OVER(ORDER BY PRICE) AS PERCENTAGE_RANK,
				ROUND(PERCENT_RANK() OVER (ORDER BY PRICE) * 100, 2) AS PER_RANK
				FROM PRODUCT
			  ) X
        WHERE X.PRODUCT_NAME = 'GAlaxy Z Fold 3' ;     
			