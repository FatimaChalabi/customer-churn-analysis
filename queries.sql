create table customer_churn (
    customer_id varchar2(20) primary key,
    gender varchar2(10),
    senior_citizen number,
    tenure number, 
    monthly_charges number,
    total_charges number,
    churn number
);

insert into customer_churn values ('CUST001', 'Male', 0, 12, 70.50, 846.00, 0);
insert into customer_churn values ('CUST002', 'Female', 0, 1, 29.85, 29.85, 1);
insert into customer_churn values ('CUST003', 'Female', 1, 45, 99.65, 4420.35, 1);
insert into customer_churn values ('CUST004', 'Male', 0, 54, 73.90, 3990.60, 0);
insert into customer_churn values ('CUST005', 'Male', 0, 22, 50.30, 1106.60, 1);
insert into customer_churn values ('CUST006', 'Female', 0, 4, 89.20, 356.80, 0);
insert into customer_churn values ('CUST007', 'Male', 1, 72, 118.75, 8550.00, 0);
insert into customer_churn values ('CUST008', 'Female', 0, 3, 20.25, 60.75, 1);
insert into customer_churn values ('CUST009', 'Female', 0, 18, 65.50, 1179.00, 0);
insert into customer_churn values ('CUST010', 'Male', 1, 60, 105.20, 6312.00, 1);
insert into customer_churn values ('CUST011', 'Male', 0, 5, 45.10, 225.50, 1);
insert into customer_churn values ('CUST012', 'Female', 0, 28, 80.00, 2240.00, 0);
insert into customer_churn values ('CUST013', 'Female', 0, 40, 75.30, 3012.00, 0);
insert into customer_churn values ('CUST014', 'Male', 0, 2, 35.00, 70.00, 1);
insert into customer_churn values ('CUST015', 'Male', 1, 65, 110.00, 7150.00, 0);
insert into customer_churn values ('CUST016', 'Female', 0, 15, 55.20, 828.00, 0);
insert into customer_churn values ('CUST017', 'Female', 1, 30, 95.50, 2865.00, 1);
insert into customer_churn values ('CUST018', 'Male', 0, 10, 60.80, 608.00, 1);
insert into customer_churn values ('CUST019', 'Male', 0, 48, 72.10, 3460.80, 0);
insert into customer_churn values ('CUST020', 'Female', 0, 36, 85.00, 3060.00, 0);
insert into customer_churn values ('CUST021', 'Female', 1, 50, 112.50, 5625.00, 1);
insert into customer_churn values ('CUST022', 'Male', 0, 8, 40.00, 320.00, 1);
insert into customer_churn values ('CUST023', 'Male', 0, 25, 68.40, 1710.00, 0);
insert into customer_churn values ('CUST024', 'Female', 0, 6, 25.50, 153.00, 1);
insert into customer_churn values ('CUST025', 'Female', 0, 52, 88.10, 4581.20, 0);
insert into customer_churn values ('CUST026', 'Male', 1, 22, 98.20, 2160.40, 1);
insert into customer_churn values ('CUST027', 'Male', 0, 14, 58.00, 812.00, 0);
insert into customer_churn values ('CUST028', 'Female', 0, 42, 82.40, 3460.80, 0);
insert into customer_churn values ('CUST029', 'Male', 0, 9, 38.50, 346.50, 1);
insert into customer_churn values ('CUST030', 'Female', 1, 68, 115.00, 7820.00, 0);

commit;

select
    count(*) as total_customers,
    sum(case when churn = 1 then 1 else 0 end) as churned_customers,
    round(sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*), 2) as churn_rate_percentage
from customer_churn;

select
    sum(monthly_charges) as monthly_revenue_loss,
    sum(total_charges) as total_revenue_loss
from customer_churn
where churn = 1;

select 
    case 
        when tenure <= 12 then '0-12 Ay (Yeni)'
        when tenure > 12 and tenure <= 36 then '13-36 Ay (Orta)'
        else '37+ Ay (Sadiq)'
    end as tenure_group,
    count(*) as total_customers_in_group,
    sum(case when churn = 1 then 1 else 0 end) as churned_in_group,
    round(sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*), 2) as group_churn_rate
from customer_churn
group by 
    case 
        when tenure <= 12 then '0-12 Ay (Yeni)'
        when tenure > 12 and tenure <= 36 then '13-36 Ay (Orta)'
        else '37+ Ay (Sadiq)'
    end
order by group_churn_rate desc;

