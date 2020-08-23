 use products;

-- Checking status errors with order status "waiting pay"
 create view status_error_check
  as 
  select c.firstname as '�������', 
        c.lastname as '���', 
        c.phone as '�������', 
        a.order_id as '����� ������', 
        a.customer_id as 'ID �������',
        a.status as '������ ������',
        a.updated_at as '���� ��������� ������',
        o.status as '������ ������',
        o.updated_at as '���� ��������� ������'
  from products.accounts a 
	
    join products.orders o
	   on o.id = a.order_id
	join products.customers c
	   on c.customer_id = a.customer_id
   where a.status = 'waiting pay' and o.status in ('new','canceled','completed')
   order by firstname
;   




















