{% docs int_production__products %}

This model provides an enriched view for each product, combining data from three sources: stg_production__products, stg_production__categories and stg_production__brands.

Granularity: One row per product.

It enriches product data with the following information:

- **product brand name**: brand name of the product.
- **product category name**: category name of the product.

Note: Stock information is kept separate in stg_production__stocks and should be joined at the mart level when needed.

This model is designed to be reusable across all marts for product analysis.

{% enddocs %}