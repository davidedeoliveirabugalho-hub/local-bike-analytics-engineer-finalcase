{% docs mrt_sales_by_store_daily %}

This model generates a store daily summary of orders, including the following metrics:

Granularity: store + date

   - Total daily orders per store
   - Total unique customers per store
   - Average items per order
   - Daily revenue
   - Average basket size

Days without orders are also included, enabling the detection of store closures or operational anomalies.
This enables the analysis of store performance, making it easy to identify sales peaks, the busiest days, and seasonal patterns.

{% enddocs %}