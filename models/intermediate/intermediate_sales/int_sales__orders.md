{% docs int_sales__orders %}

This model provides an enriched view of orders at item level, combining data from two sources: stg_sales__order_items and stg_sales__orders.

Granularity: One row per order item.

It enriches item data with the following calculated amounts:

- **Item gross amount**: List price multiplied by quantity.
- **Item discount amount**: List price multiplied by discount multiplied by quantity.
- **Item net amount**: Item gross amount minus item discount amount.

This model is designed to be reusable across all marts for order analysis.

{% enddocs %}