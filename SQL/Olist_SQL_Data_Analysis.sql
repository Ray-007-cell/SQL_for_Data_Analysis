/*
    PROJECT: Olist E-Commerce SQL Data Analysis
    DATABASE: Olist_Ecommerce_Analysis
    TOOL: Microsoft SQL Server / SSMS

    TABLES USED:
      dbo.olist_customers_dataset
      dbo.olist_orders_dataset

    NOTE:
    The uploaded customer and orders datasets each contain 99,441 rows.
    This project currently analyzes customer and order information only.
    Revenue, payment, product and seller analysis requires their respective
    Olist datasets; those measures are intentionally not fabricated here.
*/

USE Olist_Ecommerce_Analysis;
GO

/* ============================================================
   SECTION 1: DATABASE AND DATA EXPLORATION
   ============================================================ */

-- Query 1: Count all customer records.
-- Output: One row containing the total number of customers.
SELECT COUNT(*) AS Total_Customers
FROM dbo.olist_customers_dataset;
GO

-- Query 2: Preview the first 10 customer records.
-- Output: Up to 10 rows showing all customer columns.
SELECT TOP 10 *
FROM dbo.olist_customers_dataset;
GO

-- Query 3: Count all order records.
-- Output: One row containing the total number of orders.
SELECT COUNT(*) AS Total_Orders
FROM dbo.olist_orders_dataset;
GO

-- Query 4: Preview the first 10 order records.
-- Output: Up to 10 rows showing all order columns.
SELECT TOP 10 *
FROM dbo.olist_orders_dataset;
GO

/* ============================================================
   SECTION 2: FILTERING, SORTING AND GROUPING
   ============================================================ */

-- Query 5: Find customers from Sao Paulo state (SP).
-- Output: Customer records where customer_state is SP.
SELECT *
FROM dbo.olist_customers_dataset
WHERE customer_state = 'SP';
GO

-- Query 6: Find customers from Sao Paulo city.
-- Output: Customer records whose city value is 'sao paulo'.
SELECT *
FROM dbo.olist_customers_dataset
WHERE customer_city = 'sao paulo';
GO

-- Query 7: Sort customer records alphabetically by city.
-- Output: Customer records ordered from city A to Z.
SELECT *
FROM dbo.olist_customers_dataset
ORDER BY customer_city ASC;
GO

-- Query 8: Show the first 20 customers from SP, sorted by city.
-- Output: Up to 20 SP customer records ordered alphabetically by city.
SELECT TOP 20 *
FROM dbo.olist_customers_dataset
WHERE customer_state = 'SP'
ORDER BY customer_city ASC;
GO

-- Query 9: Count customers in each state.
-- Output: One row per state, ordered from highest to lowest customer count.
SELECT
    customer_state,
    COUNT(*) AS Total_Customers
FROM dbo.olist_customers_dataset
GROUP BY customer_state
ORDER BY Total_Customers DESC;
GO

/* ============================================================
   SECTION 3: AGGREGATE FUNCTIONS AND HAVING
   ============================================================ */

-- Query 10: Count all customer records.
-- Output: Total number of customers.
SELECT COUNT(*) AS Total_Customers
FROM dbo.olist_customers_dataset;
GO

-- Query 11: Count distinct customer cities.
-- Output: Number of unique city names in the customer table.
SELECT COUNT(DISTINCT customer_city) AS Unique_Cities
FROM dbo.olist_customers_dataset;
GO

-- Query 12: Find the smallest and largest ZIP code prefix.
-- Output: Minimum and maximum ZIP code prefix values.
SELECT
    MIN(customer_zip_code_prefix) AS Minimum_ZIP_Prefix,
    MAX(customer_zip_code_prefix) AS Maximum_ZIP_Prefix
FROM dbo.olist_customers_dataset;
GO

-- Query 13: Show states having more than 5,000 customers.
-- Output: State-wise customer counts greater than 5,000.
SELECT
    customer_state,
    COUNT(*) AS Total_Customers
FROM dbo.olist_customers_dataset
GROUP BY customer_state
HAVING COUNT(*) > 5000
ORDER BY Total_Customers DESC;
GO

-- Query 14: Show cities having more than 100 customer records.
-- Output: City-wise customer counts greater than 100.
SELECT
    customer_city,
    COUNT(*) AS Total_Customers
FROM dbo.olist_customers_dataset
GROUP BY customer_city
HAVING COUNT(*) > 100
ORDER BY Total_Customers DESC;
GO

/* ============================================================
   SECTION 4: SQL JOINS
   ============================================================ */

-- Query 15: INNER JOIN customers and orders.
-- Output: Only customer/order pairs with a matching customer_id.
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM dbo.olist_customers_dataset AS c
INNER JOIN dbo.olist_orders_dataset AS o
    ON c.customer_id = o.customer_id;
GO

-- Query 16: LEFT JOIN customers and orders.
-- Output: All customers; order columns are NULL when no order matches.
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status
FROM dbo.olist_customers_dataset AS c
LEFT JOIN dbo.olist_orders_dataset AS o
    ON c.customer_id = o.customer_id;
GO

-- Query 17: Find customers who have never placed an order.
-- Output: Customers for whom no matching order exists.
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state
FROM dbo.olist_customers_dataset AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.olist_orders_dataset AS o
    WHERE o.customer_id = c.customer_id
);
GO

-- Query 18: RIGHT JOIN customers and orders.
-- Output: All orders, with matching customer details where available.
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status
FROM dbo.olist_customers_dataset AS c
RIGHT JOIN dbo.olist_orders_dataset AS o
    ON c.customer_id = o.customer_id;
GO

-- Query 19: Count orders placed by customers in each state.
-- Output: State-wise order counts, highest to lowest.
SELECT
    c.customer_state,
    COUNT(o.order_id) AS Total_Orders
FROM dbo.olist_customers_dataset AS c
INNER JOIN dbo.olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY Total_Orders DESC;
GO

/* ============================================================
   SECTION 5: SUBQUERIES
   ============================================================ */

-- Query 20: Find customers who have placed at least one order.
-- Output: Customer records whose customer_id appears in the orders table.
SELECT *
FROM dbo.olist_customers_dataset AS c
WHERE EXISTS
(
    SELECT 1
    FROM dbo.olist_orders_dataset AS o
    WHERE o.customer_id = c.customer_id
);
GO

-- Query 21: Find customers who have never placed an order.
-- Output: Customer records with no matching order.
SELECT *
FROM dbo.olist_customers_dataset AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.olist_orders_dataset AS o
    WHERE o.customer_id = c.customer_id
);
GO

-- Query 22: Find customers from states having more than 5,000 customers.
-- Output: Customer records belonging to qualifying states.
SELECT *
FROM dbo.olist_customers_dataset
WHERE customer_state IN
(
    SELECT customer_state
    FROM dbo.olist_customers_dataset
    GROUP BY customer_state
    HAVING COUNT(*) > 5000
);
GO

-- Query 23: Find customers who placed more than one order.
-- Output: Customer IDs and their order counts, for counts greater than one.
SELECT
    customer_id,
    COUNT(*) AS Total_Orders
FROM dbo.olist_orders_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1;
GO

-- Query 24: Find orders belonging to customers from SP.
-- Output: Order records whose customer is located in SP.
SELECT *
FROM dbo.olist_orders_dataset AS o
WHERE EXISTS
(
    SELECT 1
    FROM dbo.olist_customers_dataset AS c
    WHERE c.customer_id = o.customer_id
      AND c.customer_state = 'SP'
);
GO

/* ============================================================
   SECTION 6: VIEWS
   ============================================================ */

-- Query 25: Create or update a reusable customer-orders view.
-- Output: Creates view vw_Customer_Orders for later querying.
CREATE OR ALTER VIEW dbo.vw_Customer_Orders
AS
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM dbo.olist_customers_dataset AS c
INNER JOIN dbo.olist_orders_dataset AS o
    ON c.customer_id = o.customer_id;
GO

-- Query 26: Retrieve records from the view.
-- Output: Customer and matching order details from the saved view.
SELECT *
FROM dbo.vw_Customer_Orders;
GO

-- Query 27: Count orders by state using the view.
-- Output: State-wise order counts, highest to lowest.
SELECT
    customer_state,
    COUNT(order_id) AS Total_Orders
FROM dbo.vw_Customer_Orders
GROUP BY customer_state
ORDER BY Total_Orders DESC;
GO

-- Query 28: Retrieve delivered orders using the view.
-- Output: Customer/order details where order_status is delivered.
SELECT *
FROM dbo.vw_Customer_Orders
WHERE order_status = 'delivered';
GO

/* ============================================================
   SECTION 7: INDEXES AND QUERY PERFORMANCE
   ============================================================ */

-- Query 29: Inspect existing indexes on the orders table.
-- Output: Existing index names and properties.
EXEC sys.sp_helpindex 'dbo.olist_orders_dataset';
GO

-- Query 30: Create a nonclustered index on customer_id if it does not exist.
-- Output: Creates an index useful for customer_id lookups and joins.
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Orders_CustomerID'
      AND object_id = OBJECT_ID('dbo.olist_orders_dataset')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
    ON dbo.olist_orders_dataset(customer_id);
END;
GO

-- Query 31: Retrieve orders for one valid customer ID.
-- Output: Orders for the selected customer.
-- The variable is populated from the table so no ID needs to be typed manually.
DECLARE @SampleCustomerID NVARCHAR(50);

SELECT TOP 1 @SampleCustomerID = customer_id
FROM dbo.olist_orders_dataset
WHERE customer_id IS NOT NULL
ORDER BY customer_id;

SELECT *
FROM dbo.olist_orders_dataset
WHERE customer_id = @SampleCustomerID;
GO

-- Query 32: Inspect the orders table indexes after index creation.
-- Output: Index information, including IX_Orders_CustomerID.
EXEC sys.sp_helpindex 'dbo.olist_orders_dataset';
GO

-- Query 33: Measure logical reads and execution time for a lookup.
-- Output: Matching order records; SSMS Messages tab reports IO/time statistics.
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

DECLARE @PerformanceCustomerID NVARCHAR(50);

SELECT TOP 1 @PerformanceCustomerID = customer_id
FROM dbo.olist_orders_dataset
WHERE customer_id IS NOT NULL
ORDER BY customer_id;

SELECT *
FROM dbo.olist_orders_dataset
WHERE customer_id = @PerformanceCustomerID;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

/*
    OPTIONAL: To inspect an execution plan in SSMS, select a query and press
    Ctrl+L for the estimated execution plan or Ctrl+M before running it for
    the actual execution plan. The plan appears in the Execution Plan tab.

    IMPORTANT:
    SUM() and AVG() revenue calculations are not included because the two
    imported tables do not contain payment/revenue amounts. Import the Olist
    payments dataset before performing revenue analysis.
*/
