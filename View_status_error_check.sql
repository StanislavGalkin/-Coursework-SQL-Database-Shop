 use products;

-- Checking status errors with order status "waiting pay"
 create view status_error_check
  as 
  select c.firstname as 'Фамилия', 
        c.lastname as 'Имя', 
        c.phone as 'Телефон', 
        a.order_id as 'Номер заказа', 
        a.customer_id as 'ID Клиента',
        a.status as 'Статус оплаты',
        a.updated_at as 'Дата изменения оплаты',
        o.status as 'Статус заказа',
        o.updated_at as 'Дата изменения заказа'
  from products.accounts a 
	
    join products.orders o
	   on o.id = a.order_id
	join products.customers c
	   on c.customer_id = a.customer_id
   where a.status = 'waiting pay' and o.status in ('new','canceled','completed')
   order by firstname
;   




















