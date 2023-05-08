use clients_meetings_db;

-- view for maintaining privacy of clients more personal information
-- and having simple contact and business info (annual revenue).

create view non_admin_check as
select 
	cb.annual_revenue, 
  c.email,
  c.phone_number
from clients_businesses cb
join clients c using (client_id);

