
/* Porcedures of DataBase
BY:cristian malaver
*/


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_login$$
CREATE PROCEDURE sp_login(IN email VARCHAR(200), IN pass VARCHAR(30))
BEGIN
 SET @mail = '';
 SET @password = '';
 SET @mail = (SELECT COUNT(u.User_email) FROM user u WHERE u.User_email LIKE email AND Stat_id=6);
 IF @mail > 0 THEN
      SET @ok = (SELECT COUNT(*) FROM login LO
        INNER JOIN user USU ON LO.User_id=USU.User_id
        WHERE USU.User_email=email AND LO.Login_password=pass);
   IF @ok > 0 THEN
         SELECT U.User_id, U.User_name, U.User_email FROM user U
            INNER JOIN login L ON U.User_id = L.User_id
            WHERE L.Login_password LIKE pass AND U.User_email like email;
   ELSE
       SELECT 0;
   END IF;
 ELSE
   SELECT 0;
 END IF;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_login_insert$$
CREATE PROCEDURE sp_login_insert(IN pass VARCHAR(30), IN user INT)
BEGIN 
  INSERT INTO login(Login_password, User_id) VALUES (pass,user); 
  SELECT ROW_COUNT(); 
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_login_update$$
CREATE PROCEDURE sp_login_update(IN mail VARCHAR(200), IN pass VARCHAR(30))
BEGIN 
  SET @user_id = (SELECT User_id FROM user WHERE User_email LIKE mail); 
  UPDATE login SET Login_password=pass WHERE User_id = @user_id; 
  SELECT ROW_COUNT(); 
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_membership_form_all$$
CREATE PROCEDURE sp_membership_form_all(IN name VARCHAR(100), IN user INT)
BEGIN
  SET @otro = (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id =user AND Bg_name = 'Otro');
  IF @otro != '' THEN
      IF name IS NULL THEN
        SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell, MEM.Stat_id FROM membership MEM 
        WHERE Mem_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id =user) OR Mem_wCompName NOT IN (SELECT Bg_name FROM broadcast_group)
        ORDER BY MEM.Mem_requestDate DESC;        
      ELSE
        SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell, MEM.Stat_id FROM membership MEM 
        WHERE (MEM.Mem_requestDate LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pIdentification LIKE CONCAT('%', name ,'%') OR MEM.Mem_pEmail LIKE CONCAT('%', name ,'%') OR MEM.Mem_pCell LIKE CONCAT('%', name ,'%')) AND (Mem_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id =user) OR Mem_wCompName NOT IN (SELECT Bg_name FROM broadcast_group))
        ORDER BY MEM.Mem_requestDate DESC;
      END IF;
  ELSE
  	IF name IS NULL THEN
       SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell, MEM.Stat_id FROM membership MEM 
            WHERE Mem_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id =user)
        ORDER BY MEM.Mem_requestDate DESC;        
    ELSE
        SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell, MEM.Stat_id FROM membership MEM 
        WHERE (MEM.Mem_requestDate LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pIdentification LIKE CONCAT('%', name ,'%') OR MEM.Mem_pEmail LIKE CONCAT('%', name ,'%') OR MEM.Mem_pCell LIKE CONCAT('%', name ,'%')) AND Mem_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id =user)
        ORDER BY MEM.Mem_requestDate DESC;
  	END IF;
  END IF;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_membership_form_insert$$
CREATE PROCEDURE sp_membership_form_insert(IN servIp VARCHAR(100), IN hostHead VARCHAR(600), IN webHead VARCHAR(600), 
IN requestIp VARCHAR(100), IN requestPort VARCHAR(10), IN hash VARCHAR(600), IN requestType VARCHAR(50), IN requestDate VARCHAR(100), 
IN city VARCHAR(100), IN assoType VARCHAR(100), IN pLastname1 VARCHAR(100), IN pLastname2 VARCHAR(100), IN pName1 VARCHAR(100), 
IN pName2 VARCHAR(100), IN pDocType VARCHAR(10), IN pIdentification VARCHAR(20), IN pExpDate VARCHAR(100), IN pExpPlace VARCHAR(100), 
IN pGender VARCHAR(100), IN pBornDate VARCHAR(100), IN pNacionality VARCHAR(100), IN pTownship VARCHAR(100), IN pDepartment VARCHAR(100), 
IN pCivilStatus VARCHAR(100), IN pLivingplaceType VARCHAR(100), IN pResAddress VARCHAR(300), IN pStratum VARCHAR(30), 
IN pResTel VARCHAR(30), IN pCell VARCHAR(30), IN department VARCHAR(100), IN pResCity VARCHAR(100), IN pCorrespondence VARCHAR(100), 
IN pEmail VARCHAR(300), IN pProfession VARCHAR(300), IN pEducationLevel VARCHAR(100), IN sLastname1 VARCHAR(100), 
IN sLastname2 VARCHAR(100), IN sName1 VARCHAR(100), IN sName2 VARCHAR(100), IN sDocType VARCHAR(10), IN sIdentification VARCHAR(20), 
IN sCell VARCHAR(30), IN wCompName VARCHAR(300), IN wCompTel VARCHAR(30), IN wCompTelExt VARCHAR(30), IN wCompDir VARCHAR(300), 
IN wDepartment VARCHAR(100), IN wCity VARCHAR(100), IN wAdmiDate VARCHAR(100), IN wContractType VARCHAR(100), IN wCharge VARCHAR(100), 
IN wCivilServant VARCHAR(100), IN wPubResourAdmin VARCHAR(10), IN wPubPerson VARCHAR(10), IN lRPubPerson VARCHAR(10), 
IN wCompFax VARCHAR(30), IN wEmail VARCHAR(300), IN wCIIUDesc VARCHAR(300), IN wCIIUCode VARCHAR(20), IN monthlyInc VARCHAR(10), 
IN monthlyEgr VARCHAR(10), IN immovabAssets VARCHAR(10), IN othersInc VARCHAR(10), IN descEgr VARCHAR(300), IN vehiclesAssets VARCHAR(10), 
IN othersDescInc VARCHAR(300), IN totalEgr VARCHAR(10), IN othersAssets VARCHAR(10), IN totalInc VARCHAR(10), IN totalAssets VARCHAR(10), 
IN totalLiabilities VARCHAR(10), IN totalHeritage VARCHAR(10), IN fctransactions VARCHAR(10), IN fcWhich VARCHAR(300), 
IN fcAccount VARCHAR(10), IN fcAccountNumber VARCHAR(100), IN fcBank VARCHAR(300), IN fcCurrency VARCHAR(100), IN fcCity VARCHAR(100), 
IN fcCountry VARCHAR(100), IN fcTransactionType VARCHAR(100), IN fcWichTransac VARCHAR(300))
BEGIN
  INSERT INTO membership(Mem_servIp, Mem_hostHead, Mem_webHead, Mem_requestIp, Mem_requestPort, Mem_hash, Mem_requestType, Mem_requestDate, 
  Mem_city, Mem_assoType, Mem_pLastname1, Mem_pLastname2, Mem_pName1, Mem_pName2, Mem_pDocType, Mem_pIdentification, Mem_pExpDate, 
  Mem_pExpPlace, Mem_pGender, Mem_pBornDate, Mem_pNacionality, Mem_pTownship, Mem_pDepartment, Mem_pCivilStatus, Mem_pLivingplaceType, 
  Mem_pResAddress, Mem_pStratum, Mem_pResTel, Mem_pCell, Mem_department, Mem_pResCity, Mem_pCorrespondence, Mem_pEmail, Mem_pProfession, 
  Mem_pEducationLevel, Mem_sLastname1, Mem_sLastname2, Mem_sName1, Mem_sName2, Mem_sDocType, Mem_sIdentification, Mem_sCell, Mem_wCompName, 
  Mem_wCompTel, Mem_wCompTelExt, Mem_wCompDir, Mem_wDepartment, Mem_wCity, Mem_wAdmiDate, Mem_wContractType, Mem_wCharge, 
  Mem_wCivilServant, Mem_wPubResourAdmin, Mem_wPubPerson, Mem_lRPubPerson, Mem_wCompFax, Mem_wEmail, Mem_wCIIUDesc, Mem_wCIIUCode, 
  Mem_monthlyInc, Mem_monthlyEgr, Mem_immovabAssets, Mem_othersInc, Mem_descEgr, Mem_vehiclesAssets, Mem_othersDescInc, Mem_totalEgr, 
  Mem_othersAssets, Mem_totalInc, Mem_totalAssets, Mem_totalLiabilities, Mem_totalHeritage, Mem_fctransactions, Mem_fcWhich, 
  Mem_fcAccount, Mem_fcAccountNumber, Mem_fcBank, Mem_fcCurrency, Mem_fcCity, Mem_fcCountry, Mem_fcTransactionType, Mem_fcWichTransac, Stat_id) 
  VALUES (servIp, hostHead, webHead, requestIp, requestPort, hash, requestType, requestDate, city, assoType, pLastname1, pLastname2, 
  pName1, pName2, pDocType, pIdentification, pExpDate, pExpPlace, pGender, pBornDate, pNacionality, pTownship, pDepartment, pCivilStatus, 
  pLivingplaceType, pResAddress, pStratum, pResTel, pCell, department, pResCity, pCorrespondence, pEmail, pProfession, pEducationLevel, 
  sLastname1, sLastname2, sName1, sName2, sDocType, sIdentification, sCell, wCompName, wCompTel, wCompTelExt, wCompDir, wDepartment, 
  wCity, wAdmiDate, wContractType, wCharge, wCivilServant, wPubResourAdmin, wPubPerson, lRPubPerson, wCompFax, wEmail, wCIIUDesc, 
  wCIIUCode, monthlyInc, monthlyEgr, immovabAssets, othersInc, descEgr, vehiclesAssets, othersDescInc, totalEgr, othersAssets, totalInc, 
  totalAssets, totalLiabilities, totalHeritage, fctransactions, fcWhich, fcAccount, fcAccountNumber, fcBank, fcCurrency, fcCity, 
  fcCountry, fcTransactionType, fcWichTransac, 10);  
  SET @id = (SELECT LAST_INSERT_ID());
  UPDATE membership SET Mem_consecutive =  CONCAT('Afiliación_',@id) WHERE Mem_id = @id;
  SELECT @id AS Mem_id;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_membership_form_security$$
CREATE PROCEDURE sp_membership_form_security(IN id INT)
BEGIN
	SELECT Mem_servIp, Mem_servDate, Mem_hostHead, Mem_webHead, Mem_requestIp, Mem_requestPort, Mem_hash
    FROM membership
    WHERE Mem_id = id;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_membership_form_view$$
CREATE PROCEDURE sp_membership_form_view(IN id INT) 
BEGIN 
	SELECT Mem_id, Mem_consecutive, Mem_requestType, Mem_requestDate, Mem_city, Mem_assoType, Mem_pLastname1, Mem_pLastname2, Mem_pName1, Mem_pName2, 
  Mem_pDocType, Mem_pIdentification, Mem_pExpDate, Mem_pExpPlace, Mem_pGender, Mem_pBornDate, Mem_pNacionality, Mem_pTownship, 
  Mem_pDepartment, Mem_pCivilStatus, Mem_pLivingplaceType, Mem_pResAddress, Mem_pStratum, Mem_pResTel, Mem_pCell, Mem_department, 
  Mem_pResCity, Mem_pCorrespondence, Mem_pEmail, Mem_pProfession, Mem_pEducationLevel, Mem_sLastname1, Mem_sLastname2, Mem_sName1, 
  Mem_sName2, Mem_sDocType, Mem_sIdentification, Mem_sCell, Mem_wCompName, Mem_wCompTel, Mem_wCompTelExt, Mem_wCompDir, Mem_wDepartment, 
  Mem_wCity, Mem_wAdmiDate, Mem_wContractType, Mem_wCharge, Mem_wCivilServant, Mem_wPubResourAdmin, Mem_wPubPerson, Mem_lRPubPerson,
   Mem_wCompFax, Mem_wEmail, Mem_wCIIUDesc, Mem_wCIIUCode, Mem_monthlyInc, Mem_monthlyEgr, Mem_immovabAssets, Mem_othersInc, Mem_descEgr, 
   Mem_vehiclesAssets, Mem_othersDescInc, Mem_totalEgr, Mem_othersAssets, Mem_totalInc, Mem_totalAssets, Mem_totalLiabilities, 
   Mem_totalHeritage, Mem_fctransactions, Mem_fcWhich, Mem_fcAccount, Mem_fcAccountNumber, Mem_fcBank, Mem_fcCurrency, Mem_fcCity, 
   Mem_fcCountry, Mem_fcTransactionType, Mem_fcWichTransac, Stat_id 
   FROM membership 
   WHERE Mem_id = id;   
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_membership_update_status$$
CREATE PROCEDURE sp_membership_update_status(IN id INT, IN stat INT)
BEGIN
	UPDATE membership SET Stat_id = stat
  WHERE Mem_id = id;
  SELECT ROW_COUNT();
  DELETE FROM notification
  WHERE Form_consecutive IN (SELECT Mem_consecutive FROM membership WHERE Mem_id = id); 
END$$
DELIMITER ;

/*
Author: Cristian malaver
Date: 6/01/2022
Description : SP update login 
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_login_update$$
CREATE PROCEDURE sp_login_update(IN id SMALLINT, IN pass VARCHAR(600))
BEGIN 
  UPDATE login SET Login_password=pass WHERE User_id = id; 
  DELETE FROM recovery_password WHERE User_id=id;
  SELECT ROW_COUNT() AS Id_row;
END$$
DELIMITER ;
/*
Author: Cristian malaver
Date: 6/01/2022
Description : SP update login 
*/


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_new_user_insert_update$$
CREATE PROCEDURE sp_new_user_insert_update(IN us_id INT(11), IN n_date VARCHAR(100), IN n_hash VARCHAR(600), IN n_status INT) 
BEGIN 
	SET @count = (SELECT COUNT(User_id) FROM new_user WHERE User_id = us_id);
    IF @count = 0 THEN
    	INSERT INTO new_user (Nuser_id, User_id, Nuser_date, Nuser_hash, Nuser_state) VALUES (NULL, us_id, n_date, n_hash, n_status);
    ELSE
    	UPDATE new_user SET Nuser_date = n_date, Nuser_hash = n_hash, Nuser_state = n_status WHERE User_id = us_id;
    END IF;
    SELECT ROW_COUNT();
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_new_user_active$$
CREATE PROCEDURE sp_new_user_active(IN n_hash VARCHAR(600))
BEGIN 
SET @valid =(SELECT TIMESTAMPDIFF(MINUTE,NOW() ,DATE_ADD(Nuser_date,INTERVAL 24 HOUR)) AS Recover_difference FROM new_user WHERE Nuser_hash = n_hash);
IF @valid >= 0 THEN 
  SET @idUser = (SELECT User_id FROM new_user WHERE Nuser_hash = n_hash);
  UPDATE user SET Stat_id = 6 WHERE User_id = @idUser;
  DELETE FROM new_user WHERE User_id = @idUser;
  SELECT ROW_COUNT();
  ELSE
  SELECT "expire" AS Error_id;
 END IF; 
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_new_user_clean$$
CREATE PROCEDURE sp_new_user_clean() 
BEGIN
	 DELETE FROM new_user WHERE TIMESTAMPDIFF(MINUTE, NOW(), DATE_ADD(Nuser_date, INTERVAL 24 HOUR)) < 0;
   SELECT ROW_COUNT();
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_notification_credit$$
CREATE PROCEDURE sp_notification_credit() 
BEGIN
	INSERT INTO notification(Form_consecutive, Not_message) 
	SELECT cre.Cre_consecutive, 'Formulario pendiente por revisar' FROM credit cre 
	WHERE cre.Stat_id = 10 AND cre.Cre_consecutive NOT IN(SELECT Form_consecutive FROM notification);
  SELECT ROW_COUNT();
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_notification_membership$$
CREATE PROCEDURE sp_notification_membership() 
BEGIN
	INSERT INTO notification(Form_consecutive, Not_message) 
	SELECT mem.Mem_consecutive, 'Formulario pendiente por revisar' FROM membership mem 
	WHERE mem.Stat_id = 10 AND mem.Mem_consecutive NOT IN(SELECT Form_consecutive FROM notification);
  SELECT ROW_COUNT();
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_notification_select_all$$
CREATE PROCEDURE sp_notification_select_all(IN id INT) 
BEGIN
  CREATE TEMPORARY TABLE IF NOT EXISTS alerts(Consecutive VARCHAR(100), Message VARCHAR(100));
  INSERT INTO alerts (Consecutive, Message) 
  SELECT Form_Consecutive, Not_message FROM notification WHERE Form_consecutive IN (SELECT Cre_consecutive FROM credit WHERE Cre_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id = id));
  INSERT INTO alerts (Consecutive, Message)
  SELECT Form_Consecutive, Not_message FROM notification WHERE Form_consecutive IN (SELECT Mem_consecutive FROM membership WHERE Mem_wCompName = ANY (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id = id));
  SET @otro1 = (SELECT Bg_name FROM broadcast_group bg INNER JOIN broadcast_gxu bgu ON bg.Bg_id = bgu.Bg_id WHERE bgu.User_id = id AND Bg_name = 'Otro');
  IF @otro1 != '' THEN
  	INSERT INTO alerts (Consecutive, Message) 
  	SELECT Form_Consecutive, Not_message FROM notification WHERE Form_consecutive IN (SELECT Cre_consecutive 
    FROM credit WHERE Cre_wCompName NOT IN (SELECT Bg_name FROM broadcast_group));
    INSERT INTO alerts (Consecutive, Message) 
  	SELECT Form_Consecutive, Not_message FROM notification WHERE Form_consecutive IN (SELECT Mem_consecutive 
    FROM membership WHERE Mem_wCompName NOT IN (SELECT Bg_name FROM broadcast_group));
  END IF;
  SELECT Consecutive, Message FROM alerts ORDER BY Consecutive ASC;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pending_emails$$
CREATE PROCEDURE sp_pending_emails(IN form_id VARCHAR(100)) 
BEGIN
	SET @consecutive = (SELECT SUBSTRING_INDEX(form_id,'_',1));
    IF @consecutive = 'Afiliación' THEN    
    	SET @otro = (SELECT Bg_name FROM broadcast_group
      WHERE Bg_name = (SELECT Mem_wCompName FROM membership WHERE Mem_consecutive = form_id));
    	IF @otro != '' THEN
        SELECT u.User_email FROM broadcast_group bg 
        INNER JOIN broadcast_gxu bgxu ON bg.Bg_id = bgxu.Bg_id
        INNER JOIN user u ON bgxu.User_id = u.User_id
        WHERE bg.Bg_name = (SELECT Mem_wCompName FROM membership WHERE Mem_consecutive = form_id) AND u.Stat_id = 6;
      ELSE
        SELECT u.User_email FROM broadcast_group bg 
        INNER JOIN broadcast_gxu bgxu ON bg.Bg_id = bgxu.Bg_id
        INNER JOIN user u ON bgxu.User_id = u.User_id
        WHERE bg.Bg_name = 'Otro' AND u.Stat_id = 6;
      END IF;
    ELSEIF @consecutive = 'Crédito' THEN
      SET @otro1 = (SELECT Bg_name FROM broadcast_group
      WHERE Bg_name = (SELECT Cre_wCompName FROM credit WHERE Cre_consecutive = form_id));
    	IF @otro1 != '' THEN
        SELECT u.User_email FROM broadcast_group bg 
        INNER JOIN broadcast_gxu bgxu ON bg.Bg_id = bgxu.Bg_id
        INNER JOIN user u ON bgxu.User_id = u.User_id
        WHERE bg.Bg_name = (SELECT Cre_wCompName FROM credit WHERE Cre_consecutive = form_id) AND u.Stat_id = 6;
      ELSE
        SELECT u.User_email FROM broadcast_group bg 
        INNER JOIN broadcast_gxu bgxu ON bg.Bg_id = bgxu.Bg_id
        INNER JOIN user u ON bgxu.User_id = u.User_id
        WHERE bg.Bg_name = 'Otro' AND u.Stat_id = 6;
      END IF;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pending_forms$$
CREATE PROCEDURE sp_pending_forms() 
BEGIN
	SELECT Form_consecutive FROM notification;
END$$
DELIMITER ;

CREATE EVENT IF NOT EXISTS new_user_clean ON SCHEDULE EVERY 1 DAY 
STARTS '2020-03-01 00:00:01' 
ON COMPLETION NOT PRESERVE ENABLE 
DO 
DELETE FROM new_user WHERE TIMESTAMPDIFF(MINUTE, NOW(), DATE_ADD(Nuser_date, INTERVAL 24 HOUR)) < 0;

CREATE EVENT IF NOT EXISTS notification_credit_update ON SCHEDULE EVERY 2 HOUR 
STARTS '2020-08-01 16:35:16' 
ON COMPLETION NOT PRESERVE ENABLE 
DO 
INSERT INTO notification(Form_consecutive, Not_message) 
SELECT cre.Cre_consecutive, 'Formulario pendiente por revisar' FROM credit cre 
WHERE cre.Stat_id = 10 AND cre.Cre_consecutive NOT IN(SELECT Form_consecutive FROM notification);

CREATE EVENT IF NOT EXISTS notification_membership_update ON SCHEDULE EVERY 2 HOUR 
STARTS '2020-08-01 16:35:16' 
ON COMPLETION NOT PRESERVE ENABLE 
DO 
INSERT INTO notification(Form_consecutive, Not_message) 
SELECT mem.Mem_consecutive, 'Formulario pendiente por revisar' FROM membership mem 
WHERE mem.Stat_id = 10 AND mem.Mem_consecutive NOT IN(SELECT Form_consecutive FROM notification)$$


/*
Author: Cristian malaver
Date: 1/6/2022
Description : SP insert update obligations  
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_obligation_insert_update$$
CREATE PROCEDURE sp_obligation_insert_update(IN id_ INT, IN client_idmax_ VARCHAR(25), IN client_contract_ VARCHAR(25), IN category_ INT, IN credit_type_id_ INT,  IN obligation_cod_	 VARCHAR(80), IN obligation_antigua_ VARCHAR(10) )
BEGIN
    SET @exist = id_ ;  
    IF @exist = 0 THEN 
    INSERT INTO create_product (name,reference,price,weight,category,stock) VALUES (obligation_cod_,client_idmax_,client_contract_,obligation_antigua_,category_,credit_type_id_);
    ELSE
    UPDATE create_product SET reference=client_idmax_,price=client_contract_,category=category_,stock=credit_type_id_,name=obligation_cod_,weight=obligation_antigua_ WHERE obligation_id=id_;
    END IF;
    SELECT ROW_COUNT();
     
END$$
DELIMITER ;


/*
Author: Cristian malaver
Date: 02/12/2020
Description : SP insert select obligations  
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_obligation_select_update$$
CREATE PROCEDURE sp_obligation_select_update(IN obligation_cod_	 VARCHAR(80) )
BEGIN
    SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, dtf, dtf_points, ibr, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format', obligation_antigua, FORMAT(initial_value_initial,2,'de_DE') AS 'initial_value_format_initial',desembolso_date_initial,cuotes_number_initial FROM obligation 
    WHERE obligation_cod=obligation_cod_ AND Stat_id=3; 
END$$
DELIMITER ;


/*
Author: Cristian malaver
Date: 01/6/2022
Description : SP select obligations  
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_obligation_select$$
CREATE PROCEDURE sp_obligation_select()
BEGIN
    SELECT name,reference,price,weight,category,stock,date_create
    	FROM create_product
        ORDER BY date_create ASC;
    END$$
DELIMITER ;

 /*
Author: Cristian malaver
Date: 02/12/2020
Description : SP select obligations search  
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_obligation_search$$
CREATE PROCEDURE sp_obligation_search(IN data_	VARCHAR(80))
BEGIN
        SELECT obligation_cod,client_idmax,client_name,client_contract,OB.Bank_id,BA.Bank_name,
obligation_id,OB.Stat_id,ST.Stat_name
        FROM obligation OB
        INNER JOIN bank BA
        ON OB.Bank_id=BA.Bank_id 
        INNER JOIN status ST
        ON OB.Stat_id=ST.Stat_id
        WHERE client_name 
        LIKE CONCAT('%', data_ , '%') OR client_idmax 
        LIKE CONCAT('%', data_ , '%') OR obligation_cod 
        LIKE CONCAT('%', data_ , '%') OR Stat_name 
        LIKE CONCAT('%', data_ , '%')
        ORDER BY desembolso_date ASC;
    END$$
DELIMITER ;


 /*
Author: Cristian malaver
Date: 07/12/2020
Description : SP select pay obligations  
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pay_obligation$$
CREATE PROCEDURE sp_pay_obligation()
BEGIN
SELECT O.obligation_cod,O.client_name,BA.Bank_name,initial_value,O.cuotes_number, pay_obligation_actual_cuote, pay_date_notif, pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,PO.Stat_id 
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 9 
 ORDER BY pay_date_notif ASC;
    END$$
DELIMITER ;


 /*
Author: Cristian malaver
Date: 07/12/2020
Description : SP select pay obligations  that is aready pays for the payobligation.php
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pay_obligation_pays$$
CREATE PROCEDURE sp_pay_obligation_pays()
BEGIN
      SELECT PO.pay_date_notif,O.obligation_cod,O.client_name,BA.Bank_name,initial_value,O.cuotes_number, pay_obligation_actual_cuote, PO.pay_Date, pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,PO.Stat_id 
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 8 
 ORDER BY pay_date_notif ASC;
    END$$
DELIMITER ;


/*
Author: cristian malaver
Date: 7/12/2020
Description : SP insert update pay obligations 
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pay_obligation_insert_update$$
CREATE PROCEDURE sp_pay_obligation_insert_update(IN id_ INT, IN obligation_cod_ VARCHAR(80), IN pay_obligation_actual_cuote_ INT,  IN pay_Dtf_ FLOAT, IN pay_Ibr_ FLOAT, IN pay_FixedRate_ DOUBLE, IN pay_value_ DOUBLE, IN pay_capital_value_ DOUBLE, IN pay_residue_ DOUBLE, IN pay_interesting_value_ DOUBLE, IN pay_observation_ VARCHAR(500), IN pay_Date_ VARCHAR(80) )
BEGIN
    SET @exist = id_ ;
    SET @porPagar = 9;
    SET @countCode = (SELECT COUNT(obligation_cod) FROM pay_obligation WHERE obligation_cod = obligation_cod_ AND Stat_id = @porPagar);  
    SET @date = pay_Date_;
    /*DIFERENCIA DE FECHAS (se puede optimizar)*/
    SET @days = DATEDIFF(DATE_ADD(@date,INTERVAL 1 MONTH),@date); 
    
    /*Aca empieza la logica para calcular los 31 del mes y la funcion last_day me trae siempre el ultimo dia*/
    SET @treintauno = DATE_ADD(@date,INTERVAL 1 MONTH);
    SET @ultDia = LAST_DAY(@treintauno);

    /*consulta pra traer la fecha de desembolso y el dia para comprarlo con los IF de mas adelante*/
    SET @dayOfMonth = DAYOFMONTH(@date);
    SET @fechaDesembolso = (SELECT desembolso_date FROM obligation WHERE obligation_cod = obligation_cod_);
    SET @dayOfMonthDateDesembolso = DAYOFMONTH(@fechaDesembolso);
    
    SET @fechaPago = DATE_ADD(@date,INTERVAL 1 MONTH);
    SET @mesPago = MONTH(@fechaPago);
    SET @diaproxPago = DAYOFMONTH(@fechaPago);
    SET @mesProxPago = MONTH(@fechaPago);
    SET @anoProxPago = YEAR(@fechaPago);
    SET @concatenacion = CONCAT(@dayOfMonthDateDesembolso,',',@mesProxPago,',',@anoProxPago);
    SET @fechaFinal = IF(@dayOfMonthDateDesembolso > @diaproxPago,STR_TO_DATE(@concatenacion, '%d,%m,%Y'),@fechaPago);

    IF @exist = 0 THEN 
      IF @countCode = 0 THEN
      INSERT INTO pay_obligation (obligation_cod, pay_obligation_actual_cuote, pay_Dtf, pay_Ibr,pay_FixedRate, pay_value, pay_capital_value, pay_residue,  Stat_id, pay_interesting_value,pay_observation,pay_date_notif ) VALUES (obligation_cod_, pay_obligation_actual_cuote_, pay_Dtf_, pay_Ibr_,pay_FixedRate_, pay_value_, pay_capital_value_, pay_residue_, 9, pay_interesting_value_,pay_observation_,pay_Date_);
      END IF;
    ELSE
      IF @dayOfMonthDateDesembolso = 31 THEN
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = @ultDia WHERE obligation_cod=obligation_cod_;
      ELSEIF @dayOfMonth = 30 OR @dayOfMonth = 29 OR @dayOfMonth = 28 THEN 
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = @fechaFinal WHERE obligation_cod=obligation_cod_;
      ELSE 
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = DATE_ADD(pay_Date_,INTERVAL @days DAY) WHERE obligation_cod=obligation_cod_;
      END IF;
    END IF;
    SELECT ROW_COUNT();
     
END$$
DELIMITER ;

/*
Author: Cristian malaver
Date: 02/12/2020
Description : SP select Pay-obligations for table amortization  ESTE ES 1
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_pay_obligation_select_amortization$$
CREATE PROCEDURE sp_pay_obligation_select_amortization(IN obligation_cod_	VARCHAR(80))
BEGIN
    SET @cuote = (SELECT COUNT(pay_obligation_actual_cuote)+1 FROM pay_obligation WHERE obligation_cod = obligation_cod_);
  SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
  SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, IT.interest_dtf AS 'dtf', IT.interest_ibr AS 'ibr', dtf_points, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' , @cuote AS 'pay_obligation_actual_cuote' FROM obligation OB 
  CROSS JOIN interest IT 
  WHERE obligation_cod = obligation_cod_ and IT.interest_date = DATE_SUB(@date,INTERVAL 1 MONTH);
END$$
DELIMITER ;


