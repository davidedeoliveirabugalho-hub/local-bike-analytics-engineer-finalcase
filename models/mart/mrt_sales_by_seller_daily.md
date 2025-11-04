{% docs mrt_sales_by_seller_daily %}

This model generates a seller daily summary of orders, including the following metrics:

Granularity: seller + date

   - Total daily orders per seller
   - Total unique customers per seller
   - Average items per order
   - Daily revenue
   - Average basket size

Days without orders are also included, enabling the detection of seller operational anomalies.
This enables the analysis of seller performance with full hierarchical context (seller → manager → store), making it easy to identify sales peaks, seasonal patterns, and compare performance across organizational levels.

{% enddocs %}