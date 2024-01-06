--select *from road_accident
--CY casualties
Select SUM(number_of_casualties) As CY_casualties from road_accident 
where YEAR(accident_date) = '2022'

--CY accident
Select count(accident_index) As CY_accidents from road_accident 
where YEAR(accident_date) = '2022'

--CY fatal,serious,slight casualties
select distinct accident_severity from road_accident
select SUM(number_of_casualties) as CY_Fatal_Casualties from road_accident 
where accident_severity = 'Fatal' and  YEAR(accident_date)= '2022'

select SUM(number_of_casualties) as CY_serious_Casualties from road_accident 
where accident_severity = 'Serious' and  YEAR(accident_date)= '2022'

select SUM(number_of_casualties) as CY_Slight_Casualties from road_accident 
where accident_severity = 'Slight' and  YEAR(accident_date)= '2022'

--CY casualties by vehicle type
select distinct vehicle_type from road_accident
select 
    case  
	    when vehicle_type IN ('Motorcycle over 125cc and up to 500cc', 'Pedal cycle' ,'Motorcycle 125cc and under',
		'Motorcycle 50cc and under','Motorcycle over 500cc') then 'Bike'
		when vehicle_type IN ('Car','Taxi/Private hire car') then 'Cars'
		when vehicle_type IN ('Minibus (8 - 16 passenger seats','Bus or coach (17 or more pass seats') then 'Bus'
		when vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t') then 'Truck'
		when vehicle_type IN ('Agricultural vehicle') then 'Agricultural'
		else 'others'
		end As vehicle_group,
		SUM(number_of_casualties) as CY_casulaties from road_accident where YEAR(accident_date) = '2022'
		group by
		case  
	    when vehicle_type IN ('Motorcycle over 125cc and up to 500cc', 'Pedal cycle' ,'Motorcycle 125cc and under',
		'Motorcycle 50cc and under','Motorcycle over 500cc') then 'Bike'
		when vehicle_type IN ('Car','Taxi/Private hire car') then 'Cars'
		when vehicle_type IN ('Minibus (8 - 16 passenger seats','Bus or coach (17 or more pass seats') then 'Bus'
		when vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t') then 'Truck'
		when vehicle_type IN ('Agricultural vehicle') then 'Agricultural'
		else 'others'
		end
--CY casualties by Month
select DATENAME(month, accident_date) as Month, SUM(number_of_casualties) as total_Casualties
from road_accident
where YEAR(accident_date) = '2022'
group by DATENAME(month, accident_date)

--CY casualties by road type
select road_type, SUM(number_of_casualties) from road_accident
where YEAR(accident_date)= '2022'
group by road_type

--CY casualties by urban or rular type 
select urban_or_rural_area, SUM(number_of_casualties) AS total_no_casualties, CAST(SUM(number_of_casualties) as decimal(10,2)) * 100 / 
(select CAST(Sum(number_of_casualties) as decimal(10,2)) from road_accident where YEAR(accident_date) = '2022') as percentage 
from road_accident
where YEAR(accident_date) = '2022' 
 group by urban_or_rural_area

 --CY casualties by ligth condition
select distinct light_conditions from road_accident
select 
    CASE
	   when  light_conditions IN ('Darkness - no lighting','Darkness - lights unlit','Darkness - lights lit','Darkness - lighting unknown') then 'Night'
	   when light_conditions IN ('Daylight') then 'Day'
	   end as ligth_condition,
	   cast(cast(sum(number_of_casualties) as decimal (10,2)) * 100/
	   (select CAST(sum(number_of_casualties) as decimal (10,2)) from road_accident where YEAR(accident_date) ='2022') as decimal (10,2))
	   as CY_casualties_PCT 
	   from road_accident
	   where year(accident_date) = '2022'
	   group by
	    case
	      when light_conditions IN ('Darkness - no lighting','Darkness - lights unlit','Darkness - lights lit','Darkness - lighting unknown') then 'Night'
	      when light_conditions IN ('Daylight') then 'Day'
    end 
--top 10 citys casualties
select top 10 local_authority, SUM(number_of_casualties) as Total_area_casualties from road_accident 
group by local_authority
order by Total_area_casualties desc