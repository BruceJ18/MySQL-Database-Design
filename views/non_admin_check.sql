use clients_meetings_db;

-- view for maintaining privacy of clients more personal information
-- and having simple contact and business info (annual revenue).

create view non_admin_check as
select * from clients_businesses cb
join clients c using (client_id)
where cb.annual_revenue = cb.annual_revenue
and c.email = c.email
and c.phone_number = c.phone_number;
