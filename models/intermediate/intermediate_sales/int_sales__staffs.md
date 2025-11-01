{% docs int_sales__staffs %}

This model provides a comprehensive overview of personnel, combining data from two sources: 
    stg_sales__staffs and stg_sales__orders.
This model will allow for role-based analysis.

It enriches employee data with the following information:

Role within the company:

- **general_manager**: manager_id IS NULL AND staff_id appears in other employees' manager_id column.
- **store_manager**: manager_id IS NOT NULL AND staff_id appears in other employees' manager_id column.
- **seller**: manager_id IS NOT NULL AND staff_id does NOT appear in other employees' manager_id column.

"Is_salesperson" is TRUE if this employee has at least one customer order to their credit, regardless of their role. 
    Even a general_manager who has a customer order will be marked as TRUE.
    This ensures consistency in future analyses.

{% enddocs %}