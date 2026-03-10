-- DataCo Supply Chain Analysis		
-- SQL Data Exploration & KPI Preparation		
-- Dataset: fact_orders		
-- Purpose: Understand shipping performance	delivery delays	
-- and profitability before building the Power BI dashboard		
-- ============================================		
		
		
-- ============================================		
-- 1. DATA OVERVIEW		
-- ============================================		
		
-- Total number of records in the dataset		
select count(*) as total_orders		
from fact_orders;		
		
-- Check date range of orders		
select min(Order_Date)as first_order_date		
max(Order_Date) as last_order_date		
from fact_orders;		
		
-- Check for missing Order IDs		
select count(*) as null_order_ids		
from fact_orders		
where Order_Id is null;		
		
		
-- ============================================		
-- 2. CALCULATED METRICS		
-- ============================================		
		
-- Calculate delivery delay for each order		
select Order_Id		
Days_for_shipping_real - Days_for_shipment_scheduled as Delivery_Delay		
from fact_orders;		
		
-- Calculate profit margin per order		
select Order_Id		
Order_Profit_Per_Order / Sales as Profit_Margin		
from fact_orders;		
		
		
-- ============================================		
-- 3. SHIPPING PERFORMANCE ANALYSIS		
-- ============================================		
		
-- Compare actual vs scheduled shipping days by shipping mode		
select Shipping_Mode		
avg(Days_for_shipping_real) as Avg_Actual_Days		
avg(Days_for_shipment_scheduled) as Avg_Scheduled_Days		
from fact_orders		
group by Shipping_Mode;		
		
		
		
-- ============================================		
-- 4. LATE DELIVERY ANALYSIS		
-- ============================================		
		
		
-- Late delivery risk by region		
select Order_Region		
count(*) as Total_Orders		
sum(Late_delivery_risk) as Late_Orders		
from fact_orders		
group by Order_Region;		
		
		
-- ============================================		
-- 5. PROFITABILITY ANALYSIS		
-- ============================================		
		
		
-- Profit and delay risk relationship by shipping mode		
select Shipping_Mode		
avg(Order_Profit_Per_Order) as Avg_Profit		
avg(Late_delivery_risk) as Late_Risk		
from fact_orders		
group by Shipping_Mode;		
		
		
-- ============================================		
-- 6. FINAL DATA VIEW		
-- ============================================		
		
-- Preview dataset used for Power BI dashboard		
select *		
from fact_orders;		
		
-- KPI Metrics for Dashboard		
SELECT		
COUNT(*) AS total_orders		
SUM(Sales) AS total_sales		
SUM(Order_Profit_Per_Order) AS total_profit		
AVG(Days_for_shipping_real - Days_for_shipment_scheduled) AS avg_shipping_delay		
FROM fact_orders;		
