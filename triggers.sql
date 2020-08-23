use products;

 -- trigger update date of birth in past tense, not in future
CREATE DEFINER=`root`@`localhost` TRIGGER `check_customer_age_before_update` BEFORE UPDATE ON `additions` FOR EACH ROW begin 
	if new.birthday >= current_date() then 
	      signal sqlstate '45000' set message_text = 'Update Canceled. Birthday must be in the past!';
	     end if;
end;


-- present time birthday insertion trigger
CREATE DEFINER=`root`@`localhost` TRIGGER `check_customer_age_before_insert` BEFORE INSERT ON `additions` FOR EACH ROW begin 
	if new.birthday > current_date() then 
	      set new.birthday = current_date(); 
	     end if;
end;














