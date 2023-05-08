use clients_meetings_db;

-- view for determining proper strategy for M&A firm to take based upon business type.
create view proper_strategy as
select 
	cb.business_name,
    cb.annual_revenue,
    case 
		when annual_revenue > 500000 then 'type_4'
        when annual_revenue > 10000000 then 'type_3'
        when annual_revenue > 50000000 then 'type_2'
		else 'type_1'
	end as business_type
from clients_businesses cb
join clients c using (client_id) 
join bookings b using (client_id)

