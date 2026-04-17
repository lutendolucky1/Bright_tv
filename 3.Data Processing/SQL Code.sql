--First 100 rows
select *
 from `case_study`.`default`.`bright_tv_dataset` limit 100;


--number of users (4386)
select count(userid)
from `bright`.`default`.`bright_tv_dataset_viewership`;

--channels available 
select distinct channel2
from `bright`.`default`.`bright_tv_dataset_viewership`;

--smallest and highest age 
select max(age) , min(age)
FROM `case_study`.`default`.`bright_tv_dataset` 
where age != 0;


--different rases 
select distinct race 
from `case_study`.`default`.`bright_tv_dataset`

--different provinces
select distinct province 
from `case_study`.`default`.`bright_tv_dataset`


--no of emails
select count(email) as no_emails
from `case_study`.`default`.`bright_tv_dataset`


---------------------------------------------------------------------------------------------------------------
-- new columns 
--session date
--month
--dat_name
--age_group
--time_phase
--week_type
---------------------------------------------------------------------------------------------------------------

select A.UserID , B.UserID ,Name , Surname ,Email, Gender , Race , Age , Province ,'Social Media Handle',  Channel2,timestamp(`Duration 2`), 
to_date(RecordDate2, 'M/d/yyyy H:mm') AS session_date , date_format(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'HH:mm') AS 
session_time , monthname(session_date) as month, dayname(session_date) as day_name,
CASE 
    WHEN Age BETWEEN 8 AND 18 THEN 'Adolescents'
    WHEN Age BETWEEN 19 AND 45 THEN 'Early adulthood'
    WHEN Age BETWEEN 46 AND 64 THEN 'Middle adulthood' 
    WHEN Age >= 65 THEN 'Later adulthood'             
END AS age_group ,
CASE 
    WHEN HOUR(session_time) BETWEEN 0 AND 5 THEN 'Early Morning'
    WHEN HOUR(session_time) BETWEEN 6 AND 11 THEN 'Morning Peak'
    WHEN HOUR(session_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS time_phase,
case 
when day(session_date) BETWEEN 1 and 10 THEN 'begining of month'
when day(session_date) BETWEEN 11 AND 20 THEN 'mid month'
when day(session_date) BETWEEN 21 AND 30 THEN 'month end'
END AS week_type
FROM `bright`.`default`.`bright_tv_dataset_viewership` as A
FULL OUTER join `case_study`.`default`.`bright_tv_dataset` as B 
on A.userid = B.userid ;
