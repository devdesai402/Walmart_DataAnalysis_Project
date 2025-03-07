use walmart_db;

show tables;

select * from walmart;


-- Q1. Find different payment method and number of transaction, number of qty sold.

select payment_method, count(*) as no_of_transactions, sum(quantity) as no_qty_sold from walmart group by payment_method;


-- Q2. Identify the highest category in each branch, displaying the branch, category.

select Branch, category, avg(rating) as avg_rating from walmart group by branch, category order by branch, avg(rating) desc ; 


-- Q3. Identify the busiest day for each branch on the number of transactions.

select branch, dayname(date) as day, count(*) as no_transaction from walmart group by branch, day order by branch, no_transaction desc;


-- Q4. Calculate total Quantity of items sold per payment method. List payment_method and total quantity.

select payment_method, sum(quantity) as total_qty  from walmart group by payment_method order by total_qty desc  ;


-- Q5.  Determine the average, minimum, and maximum rating of products for each city. List the city, category, average_rating, min_rating, and max_rating.

select city, category, avg(rating) as avg_rating, max(rating) as max_rating, min(rating) as min_rating from walmart group by city, category; 

-- Q6.  Calculate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin). List category and total_profit, ordered from highest to lowest profit.

select category, sum(unit_price * quantity * profit_margin) as total_profit from walmart group by category order by total_profit desc ;

-- Q7.  Determine the most common payment method for each branch. Display branch and the preferrred_payment_method.

select branch, payment_method, count(invoice_id) as total_transaction from walmart group by branch, payment_method order by total_transaction desc;

-- Q8.  Categorize sales into 3 groups morning, afternoon, evening. Find out which of the shifts and number of invoices.

SELECT 
       CASE 
        WHEN TIME(time) BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN TIME(time) BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        WHEN TIME(time) BETWEEN '18:00:00' AND '23:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_period, count(invoice_id) 
FROM walmart group by time_period;

-- Q9.  Identify 5 branch with highest decrease ratios in revenue compare to last year (current year 2023 and last year 2022)

select branch, sum(total) as revenue, year(date) as year from walmart group by branch,year order by revenue desc limit 5;
