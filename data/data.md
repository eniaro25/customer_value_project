# Source Schema 

***INSERT IMAGE OF SOURCE SCHEMA 

# Details of source fields 
1. users

## Information about registered customers

id: Unique identifier for each user.
first_name / last_name: User's name.
email: User's contact email.
age / gender: Demographic data.
state / city / country / postal_code: Geographic location.
latitude / longitude: Precise coordinates of the user.
traffic_source: How the user found the site (e.g., Search, Facebook).
created_at: Account creation timestamp.

1.1. orders

## Contains high-level information about customer orders.

order_id: Unique identifier for each order.
user_id: Identifier for the user who placed the order.
status: Current status of the order (e.g., Shipped, Complete, Returned).
gender: Gender information of the user.
created_at: Timestamp when the order was created.
returned_at: Timestamp when the order was returned.
shipped_at: Timestamp when the order was shipped.
delivered_at: Timestamp when the order was delivered.
num_of_item: Total number of items in the order.

1.2. events

## Log of user activity and web traffic on the platform.

id: Unique identifier for each event.
user_id: ID of the user (if logged in).
sequence_number: Order of the event within a session.
session_id: Unique identifier for the browsing session.
created_at: Timestamp of the activity.
ip_address / city / state / postal_code: Location data derived from IP.
browser: Web browser used.
traffic_source: Source of the traffic.
uri: The specific page URL visited.
event_type: Action taken (e.g., Page View, Add to Cart, Purchase).

1.1.1 order_items

## Detailed line-item data for every order.

id: Unique identifier for each order item.
order_id: Link to the orders table.
user_id: Link to the users table.
product_id: Link to the products table.
inventory_item_id: Link to the inventory_items table.
status: Status of the specific item.
created_at / shipped_at / delivered_at / returned_at: Timestamps for item lifecycle.
sale_price: The price at which the item was sold.

1.1.2. products

## The master catalog of items available for sale.

id: Unique identifier for each product.
cost: Wholesale cost of the product.
category: Product category (e.g., Jeans, Tops & Tees).
name: Full name of the product.
brand: Brand name of the product.
retail_price: Suggested retail price.
department: Target department (e.g., Men, Women).
sku: Stock Keeping Unit identifier.
distribution_center_id: ID of the center where the product is stocked.

1.1.3. inventory_items

## Tracks individual items available in stock.

id: Unique identifier for each specific stock item.
product_id: Link to the products catalog.
created_at: When the item entered inventory.
sold_at: When the item was purchased.
cost / product_retail_price: Financial data for the item.
product_category / product_name / product_brand: Denormalized product info.
product_distribution_center_id: Where the item is physically located.

1.1.4 distribution_centers

id: Unique identifier for the center.
name: Name of the facility.
latitude / longitude: Geographic coordinates of the center.