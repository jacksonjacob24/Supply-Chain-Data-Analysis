use supply_chain;

select * from supply_chain_data;
SELECT `Revenue generated` FROM supply_chain_data;

-- Revenue
select cast(sum(`Revenue generated`) as decimal(8,2))Revenue from supply_chain_data;

-- Revenue by product type
SELECT `Location`, Revenue
FROM (
    SELECT `Location`, SUM(`Revenue generated`) AS Revenue
    FROM supply_chain_data
    GROUP BY `Location`
) AS Revenue_by_Location
ORDER BY Revenue DESC;

-- Revenue by Location
SELECT `Product Type`, Revenue
FROM (
    SELECT `Product Type`, SUM(`Revenue generated`) AS Revenue
    FROM supply_chain_data
    GROUP BY `Product Type`
) AS ProductRevenue
ORDER BY Revenue DESC;


-- Revenue by Transportation modes
SELECT `Transportation modes`, Revenue
FROM (
    SELECT `Transportation modes`, SUM(`Revenue generated`) AS Revenue
    FROM supply_chain_data
    GROUP BY `Transportation modes`
) AS ProductRevenue
ORDER BY Revenue DESC;

-- Defect rate

select sum(`Defect rates`)/count(*) as Defect_Rate from supply_chain_data;

-- Percentage of production volume by Location 

WITH total_production AS (
    SELECT SUM(`Production volumes`) AS total_volume
    FROM supply_chain_data
)
SELECT 
    Location, 
    SUM(`Production volumes`) AS Production_Volume,
    (SUM(`Production volumes`) * 100 / total_volume) AS ProductionVolume_Percentage
FROM 
    supply_chain_data
CROSS JOIN 
    total_production
GROUP BY 
    Location
ORDER BY 
    Production_Volume DESC;
    
-- Average Price of Products

Select  `product type`, ROUND(Avg(price),2) as Average_Price 
from supply_chain_data 
group by `product type`;
    
-- Top Selling Procucts.

Select `Product type`, sum(`Order quantities`) as Total_sold 
from supply_chain_data
group by `Product type`
order by Total_sold DESC;
    
-- Average Lead Time.

Select `Product type`, Avg(`Lead times`) as Average_Lead_Time 
from supply_chain_data
group by `Product type`
order by Average_Lead_Time DESC;

-- Supplier Performance - Defect Rates

Select `Supplier name`, round(avg(`Defect rates`),2) as Average_Defect_rate
from supply_chain_data
group by `Supplier name`
order by `supplier name`, Average_Defect_rate;

-- Shipping Cost Analysis

select `Shipping carriers`, round(avg(`Shipping costs`),3) as Average_Shipping_cost
from supply_chain_data
group by `Shipping carriers`


-- Customer Denographics Analysis.

Select `Customer demographics`, count(*) as Number_of_Purchases
from supply_chain_data
group by `Customer demographics`;



