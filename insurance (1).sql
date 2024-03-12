use insurancedb;
select * from brokerage;
select * from fees;
select * from individual_budget;
select * from invoice;
select * from meeting;
select * from opportunity;

alter table invoice change `account executive` account_executive varchar(30);

select income_class, sum(amount) as amount from invoice 
group by income_class
order by income_class;

--  1. Number of invoice by  Account Executive.

select Account_Executive,count(*) as invoice_number
from invoice 
group by Account_Executive
order by invoice_number desc;

-- 2. Yearly meeting count
select year(meeting_date) as meeting_year, count(meeting_date) as meeting_count 
from meeting
group by meeting_year
order by meeting_count desc;

select year(meeting_date) from meeting;

-- 3. cross sell, new, renewal = {Target, Achieve, Invoice} 
-- Target(cross sell, new, renewal)

select sum(`cross sell bugdet`) as  cross_sell_target, sum(`new budget`) as new_target, sum(`renewal budget`) as renewal_target
from individual_budget;

 -- Achieved(cross sell, new, renewal)
 select income_class, round(sum(amount)) as Achieved
 from brokerage
 group by income_class
order by achieved desc; 

-- invoice(cross sell, new, renewal)
select income_class, sum(amount) as invoice
from invoice
group by income_class
order by invoice desc;

-- 4. Revenue by stage
select stage, sum(revenue_amount) as revenue 
from opportunity
group by stage
order by revenue desc;

-- 5.  Number of meeting by account executive
select `account executive`, count(*) as number_of_meetings
from meeting
group by `account executive`
order by number_of_meetings desc;

-- 6. Top 4 open oppertunity
select opportunity_name, sum(revenue_amount) as amount
from opportunity
group by opportunity_name
order by amount desc
limit 4;