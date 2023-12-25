/* Есть таблица с заказами orders в виде
city_id
user_id
order_id

Выведите ТОП5% пользователей в каждом городе по количеству заказов
*/

declare @percent decimal(3,2);

set @percent = 0.05

select
	ranked_summary.city_id,
	ranked_summary.user_id
from
	(select
		summary.city_id as city_id,
		summary.user_id as user_id,
		count(summary.user_id) over(partition by summary.city_id) as users_in_city,
		rank() over(partition by summary.city_id order by summary.qty_orders desc) as user_rank
	from
		(select
			orders.city_id as city_id,
			orders.user_id as user_id,
			count(orders.order_id) as qty_orders
		from
			orders
		group by
			orders.city_id,
			orders.user_id)
		as summary)
	as ranked_summary
where ranked_summary.user_rank <= IIF(ranked_summary.users_in_city*@percent > 1, ranked_summary.users_in_city*@percent, 1)