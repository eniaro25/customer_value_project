# Source Schema 

Image attached

## Database Schema: `thelook_ecommerce`

This schema tracks end-to-end operations of an ecommerce platform, from web activity to fulfilment.

---

### `orders`

High-level order records.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `order_id` | INTEGER | **PK** | Unique identifier for the order. |
| `user_id` | INTEGER | **FK → users.id** | Customer who placed the order. |
| `status` | STRING |  | Order state (e.g., Shipped, Complete, Processing). |
| `gender` | STRING |  | Gender of the customer (as stored in source). |
| `created_at` | TIMESTAMP |  | Order placement timestamp. |
| `returned_at` | TIMESTAMP |  | Return timestamp (if applicable). |
| `shipped_at` | TIMESTAMP |  | Departure from distribution centre. |
| `delivered_at` | TIMESTAMP |  | Arrival at customer location. |
| `num_of_item` | INTEGER |  | Total items in this order. |

---

### `order_items`

Granular line-item details for every order.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique identifier for this line item. |
| `order_id` | INTEGER | **FK → orders.order_id** | The order this line item belongs to. |
| `user_id` | INTEGER | **FK → users.id** | Customer who purchased the item. |
| `product_id` | INTEGER | **FK → products.id** | Product purchased. |
| `inventory_item_id` | INTEGER | **FK → inventory_items.id** | Specific inventory unit sold. |
| `status` | STRING |  | Status of this specific item. |
| `sale_price` | FLOAT |  | Final price paid by the customer. |
| `created_at` | TIMESTAMP |  | Line item record creation time. |

---

### `products`

Master product catalogue.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique product ID. |
| `cost` | FLOAT |  | Wholesale cost. |
| `category` | STRING |  | Product category (e.g., Jeans, Suits). |
| `name` | STRING |  | Product title. |
| `brand` | STRING |  | Brand name. |
| `retail_price` | FLOAT |  | Suggested retail price. |
| `department` | STRING |  | Department/demographic (e.g., Men, Women). |
| `sku` | STRING |  | Stock Keeping Unit. |
| `distribution_center_id` | INTEGER | **FK → distribution_centers.id** | Distribution centre for the product. |

---

### `users`

Customer profile data.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique user ID. |
| `first_name` | STRING |  | User’s first name. |
| `last_name` | STRING |  | User’s last name. |
| `email` | STRING |  | Contact email. |
| `age` | INTEGER |  | User’s age. |
| `city` | STRING |  | City of residence. |
| `country` | STRING |  | Country of residence. |
| `traffic_source` | STRING |  | Acquisition channel (e.g., Search, Facebook). |
| `created_at` | TIMESTAMP |  | Account creation timestamp. |

---

### `events`

Web traffic and behaviour logs.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique event ID. |
| `user_id` | INTEGER | **FK → users.id (nullable)** | User associated with the event (NULL if guest). |
| `sequence_number` | INTEGER |  | Step number within the session. |
| `session_id` | STRING |  | Unique session identifier. |
| `event_type` | STRING |  | Action type (e.g., View, Cart, Purchase). |
| `uri` | STRING |  | Page path visited. |
| `created_at` | TIMESTAMP |  | Timestamp of activity. |

---

### `inventory_items`

Individual stock units.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique inventory unit ID. |
| `product_id` | INTEGER | **FK → products.id** | Product for this inventory unit. |
| `created_at` | TIMESTAMP |  | When the unit was added to inventory. |
| `sold_at` | TIMESTAMP |  | When the unit was sold. |
| `cost` | FLOAT |  | Unit wholesale cost. |
| `product_distribution_center_id` | INTEGER | **FK → distribution_centers.id** | Distribution centre holding the unit. |

---

### `distribution_centers`

Warehouse location data.

| Column | Data Type | Key | Description |
| --- | --- | --- | --- |
| `id` | INTEGER | **PK** | Unique distribution centre ID. |
| `name` | STRING |  | Facility name. |
| `latitude` | FLOAT |  | Geo-coordinate. |
| `longitude` | FLOAT |  | Geo-coordinate. |

---

### Relationship Summary (PK → FK)

- `users.id` ← `orders.user_id`, `order_items.user_id`, `events.user_id`
- `orders.order_id` ← `order_items.order_id`
- `products.id` ← `order_items.product_id`, `inventory_items.product_id`
- `inventory_items.id` ← `order_items.inventory_item_id`
- `distribution_centers.id` ← `products.distribution_center_id`, `inventory_items.product_distribution_center_id`