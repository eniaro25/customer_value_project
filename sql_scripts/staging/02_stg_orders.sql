/* Goal: Refine order category to obtain true representation of orders
Logic:
*/
CASE 
    WHEN status IN ('Cancelled', 'Returned') THEN 'Incomplete'
    ELSE 'Complete' 
END AS order_category