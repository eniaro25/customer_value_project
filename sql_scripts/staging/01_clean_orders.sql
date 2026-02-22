/* Goal: Understand the scale of Losses
Logic: Identifies the percentage of the different order statuses
*/
SELECT 
  status, 
  COUNT(*) as record_count,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) as percentage
FROM `cbf-project-488219.customer_value_project.Orders`
GROUP BY 1
ORDER BY record_count DESC
/* Row	status	record_count	percentage
1	Shipped	37654	30.14
2	Complete	31028	24.84
3	Processing	24948	19.97
4	Cancelled	18723	14.99
5	Returned	12570	10.06
*/
