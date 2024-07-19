create database activity;
use activity;

-- 01
select * 
from carsales;

-- 02
select Make,Model,SalePrice
from carsales;

-- 03
select * 
from carsales
where CountryName = "United Kingdom";

-- 04
select * 
from carsales
where CountryName = "United Kingdom" and SalePrice > 90000;

-- 05
select * 
from carsales
where Make in ("Rolls Royce","Aston Martin");

-- 06
select * 
from carsales
order by SalePrice desc;

-- 07
select distinct(Make)
from carsales ;

-- 08
select * 
from carsales
where Model like "silver%";

-- 09
select * 
from carsales
where Region In ("East Midlands","Greater London Authority");

-- 10
select * 
from carsales
where SalePrice between 80000 and 100000;

-- 11
select * 
from carsales
where IsDealer ="";

-- 12
select * 
from carsales
where TotalDiscount != "";

-- 13
select Make,Model,(`SalePrice` - `CostPrice`) as "Profit" 
from carsales;

-- 14
select sum(SalePrice)
from carsales;

-- 15
select avg(SalePrice)
from carsales;

-- 16
select Make,count(Make) as "count of cars sold per Make"
from carsales
group by Make;

-- 17
select Make,Round(avg(SalePrice),2)
from carsales
group by Make
having Round(avg(SalePrice),2) > 90000 ;

-- 19
select Make,Model,count(Make)
from carsales
group by Make,Model;

-- 20
select *
from carsales
where SalePrice > (select avg(salePrice) from carsales);

-- Intermeediate

-- 01
select * 
from carsales
where SalePrice > CostPrice;

-- 02
select * 
from carsales
where countryName = "United Kingdom" and SalePrice > 80000;

-- 03
select * 
from carsales
where color = "Red" or make = "Rolls Royce";

-- 04
select *
from carsales
order by CountryName,SalePrice Desc;

-- 05
select distinct(color)
from carsales;

-- 06
select * 
from carsales
where make like "%Royce%";

-- 07
select * 
from carsales
where Make in ("Rolls Royce","Aston Martin");

-- 08
select *
from carsales 
where InvoiceDate between '2012-01-01' and '2012-12-31';

-- 09
select * 
from carsales
where IsDealer ="";

-- 10
select * 
from carsales
where TotalDiscount != "";

-- 11
select Make,Model,(SalePrice + DeliveryCharge) as "TotalCost"
from carsales ;

-- 12
select Make,Model,SalePrice
from carsales
order by salePrice desc
limit 10;

-- 13
select * 
from carsales
where Model like "%Ghost";

-- 14
select * 
from carsales
where length(Region) > 10;

-- 15
select * 
from carsales
where (SalePrice - CostPrice) > 10000;

-- 16
select * 
from carsales
where CountryName != "United Kingdom";
-- 17
select Make, Model,(SalePrice - CostPrice) as Profit
from carsales;

-- 18
select * 
from carsales
where Year(InvoiceDate) = 2012;

-- 19
select * 
from carsales 
where CountryName = "United Kingdom" and (SalePrice > 80000 or Color = "Red");

-- 20
select upper(Make) as MAKE,upper(Model) as MODEL 
from carsales;

-- Advanced

-- 01
select * 
from carsales
where SalePrice > CostPrice and TotalDiscount > 500 and color != "Red";

-- 02
select * 
from carsales 
where (make = "Rolls Royce" and SalePrice > 90000) or (make = 'Aston Martin'and SalePrice < 100000);

-- 03
Select make,model,SalePrice
from carsales
where (SalePrice - costprice) >= 20000 and  TotalDiscount <= 1000;

-- 04
select Make,Model,upper(Color)
from carsales
where Model like "Silver%";

-- 05
select * 
from carsales
where year(InvoiceDate) = 2012 and DeliveryCharge between 500 and 1500;

-- 06
select * 
from carsales
order by CountryName, Make,SalePrice desc;

-- 07
select Make,Model,
(
Case 
when SalePrice > 100000 then "High"
when SalePrice between 50000 and 100000 then "Medium"
when SalePrice < 50000 then "Low"
End) as PriceCategory
from carsales;

-- 08
select *
from carsales
where length(Make) > 5 and Color like "%yellow%";

-- 09
select Make,Model, (SalePrice - CostPrice - DeliveryCharge) as NetProfit
from carsales
where (SalePrice - CostPrice - DeliveryCharge) >= 0;

-- 10
select * 
from carsales
where Make != "Rolls Royce" and SalePrice between 80000 and 100000;

-- 11
select * 
from carsales
where IsDealer = "" and  (SalePrice - TotalDiscount) > 85000;

-- 12
select make,Model,round(SalePrice,0)
from carsales;

-- 13
select make,concat(lower(model),"_model")
from carsales;

-- 14
select *
from carsales
where InvoiceNumber like "[0-9][a-zA-Z]";

-- 15
select	* 
from carsales
where  (SalePrice > CostPrice) and (Make in ("Aston Martin","Rolls Royce")) and (Color != "Blue");

-- 16
select * 
from carsales
where ( SalePrice + DeliveryCharge) < 100000 and (CountryName = "United Kingdom");

-- 17
select * ,
 (
Case 
when SalePrice > 90000 then "Expensive"
when SalePrice between 50000 and 90000 then "Affordable"
when SalePrice < 50000 then "Cheap"
End) as Categories
from carsales;

-- 18
select * 
from carsales
where month(InvoiceDate) = 01 and model like "%s%";

-- 19
select * from 
carsales
order by 
case
when SalePrice = "'Aston Martin" then SalePrice End Desc ,
case
when SalePrice = "Rolls Royce" then SalePrice End Asc;

-- 20
select Make,Model,(SalePrice - coalesce(TotalDiscount,0)) as DiscountedPrice
from carsales;
