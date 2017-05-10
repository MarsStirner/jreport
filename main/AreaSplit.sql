-- 8===D~ --
-- чад кутежа и говнокода
-- 8===D~ --

DELIMITER ;;

DROP FUNCTION IF EXISTS `AreaSplit`;;

CREATE FUNCTION AreaSplit(
	p_area_list	TEXT
)
RETURNS TEXT
DETERMINISTIC

BEGIN
	DECLARE _next VARCHAR (32) DEFAULT NULL;
	DECLARE _nextlen INT DEFAULT NULL;
	DECLARE _value VARCHAR (32) DEFAULT NULL;
	DECLARE _result TEXT DEFAULT NULL;
	
	
	iterator:
	LOOP
		IF LENGTH(TRIM(p_area_list)) = 0 OR p_area_list IS NULL THEN
			LEAVE iterator;
		END IF;
		
		SET _next = SUBSTRING_INDEX(p_area_list,',',1);
		SET _nextlen = LENGTH(_next);
		SET _value = TRIM(_next);
		

		WHILE RIGHT(_value, 3) = '000' DO
			SET _value = LEFT(_value,length(_value)-3) ;
		END WHILE;
		SET _value = CONCAT(_value,'.*');
		SET _result = CONCAT_WS('|',_result,_value);


		SET p_area_list = INSERT(p_area_list,1,_nextlen + 1,'');
	END LOOP;
	
RETURN (_result);
END;;

DELIMITER ;