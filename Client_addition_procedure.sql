use products;

CREATE DEFINER=`root`@`localhost` PROCEDURE `products`.`sp_add_customer`( firstname varchar(100), lastname varchar(100), email varchar(100), address_id bigint(20), 
     active tinyint(1), create_date datetime, last_update timestamp, password_hash varchar(100), phone bigint(20),
     out tran_result varchar(200))
begin
	declare `_rollback` bit default 0;
    declare code varchar(100);
    declare error_string varchar(100);
   
    declare continue handler for sqlexception
    begin
	    set `_rollback` = 1;
	    get stacked diagnostics condition 1
	       code = returned_sqlstate, error_string = MESSAGE_TEXT;
	      
	    set tran_result := concat('Error occured. Code:', code, '. Text: ', error_string);
    end;
   
   start transaction;
       insert into customers (firstname, lastname, email, address_id, active, create_date, last_update, password_hash, phone )
          values (firstname, lastname, email, address_id, active, create_date, last_update, password_hash, phone );
       
       insert into additions (customer_id, gender, birthday, home, create_at)
          values (last_insert_id(), gender, birthday, home, create_at);
    
   if `_rollback` then
        rollback;
   else
       set tran_result = 'COMMIT';
       commit;
   end if;
	
END


























