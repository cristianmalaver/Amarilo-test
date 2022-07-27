-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-06-2022 a las 02:28:46
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdkonecta`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pre_quote` (IN `client_id` INT, IN `pre_quo_consec` VARCHAR(100), IN `pre_quo_height` VARCHAR(20), IN `pre_quo_width` VARCHAR(20), IN `pre_quo_quantity` VARCHAR(11), IN `pre_quo_project` VARCHAR(100), IN `pre_quo_inserts` VARCHAR(40), IN `pre_quo_bw` VARCHAR(100), IN `pre_quo_plast` VARCHAR(40), IN `pre_quo_coverFinish` VARCHAR(40), IN `pre_quo_top` VARCHAR(40), IN `stat_id` INT, IN `pre_quo_color` VARCHAR(100), IN `pre_quo_format` VARCHAR(40), IN `quo_observ` VARCHAR(400), IN `pre_quo_delivPlace` VARCHAR(200))   BEGIN
	INSERT INTO pre_quote(Pre_client_id,Pre_quo_consec,Pre_quo_top,Pre_quo_coverFinish,Pre_quo_plast,Pre_quo_bw,Pre_quo_color, Pre_quo_inserts, Pre_quo_project,Pre_quo_quantity,Pre_quo_width,Pre_quo_height,Stat_id,Pre_quo_date, Pre_quo_delivPlace) VALUES (client_id,pre_quo_consec,pre_quo_top,pre_quo_coverFinish,pre_quo_plast,pre_quo_bw,pre_quo_color,pre_quo_inserts,pre_quo_project,pre_quo_quantity,pre_quo_width,pre_quo_height,stat_id,CURRENT_DATE(),pre_quo_delivPlace);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_beneficiary_insert` (IN `identification` VARCHAR(20), IN `lastName1` VARCHAR(100), IN `lastName2` VARCHAR(100), IN `name1` VARCHAR(100), IN `name2` VARCHAR(100), IN `relationship` VARCHAR(300), IN `percent` VARCHAR(3), IN `Mem_id` INT)   BEGIN 
  INSERT INTO beneficiary(Ben_identification, Ben_lastName1, Ben_lastName2, Ben_name1, Ben_name2, Ben_relationship, Ben_percent, Mem_id) 
  VALUES (identification, lastName1, lastName2, name1, name2, relationship, percent, Mem_id); 
  SELECT ROW_COUNT(); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_beneficiary_view` (IN `id` INT)   BEGIN 
SELECT Ben_id, Ben_identification, Ben_lastName1, Ben_lastName2, Ben_name1, Ben_name2, Ben_relationship, Ben_percent, Mem_id 
   FROM beneficiary 
   WHERE Mem_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_broadcast_group_all` (`company` INT)   BEGIN
	SELECT Bg_id, Bg_name FROM broadcast_group
    WHERE Comp_id = company;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_active` (IN `name` VARCHAR(100))   BEGIN
    IF name IS NULL THEN
        SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client
       WHERE Stat_id = 8;
   ELSE
       SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client WHERE (Client_name LIKE CONCAT('%', name ,'%') OR Client_identification LIKE CONCAT('%', name ,'%')) AND Stat_id = 8;
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_insert` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `title` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320))   BEGIN
    INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail) VALUES (name, identification, address, tel, email, contactName, title, contactTel, contactCel, contactEmail);
SELECT Client_id FROM client WHERE Client_identification=identification;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_insert_update` (IN `id` INT, IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `contactTitle` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320), IN `stat` INT)   BEGIN
    SET @exist = (SELECT COUNT(Client_id)FROM client WHERE Client_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, contactEmail, stat);
    ELSE
    	UPDATE client SET Client_identification = identification, Client_name = name, Client_address = address, Client_tel = tel, Client_email = email, Client_contactName = contactName, Client_contactTitle = contactTitle, Client_contactTel = contactTel, Client_contactCel = contactCel, Client_contactEmail = contactEmail, Stat_id = stat
        WHERE Client_id = id;
    END IF;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_all` ()   BEGIN
SELECT Client_id, Client_name, Client_identification, Client_tel, Client_contactName, Client_contactCel, Client_contactEmail, Stat_id FROM client;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_identification` (IN `identification` VARCHAR(15))   BEGIN    
    SELECT Client_id, Client_name, Client_identification FROM client WHERE Client_identification = identification;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_one` (IN `id` INT)   BEGIN
    SELECT Client_id, Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id FROM client WHERE Client_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_search` (IN `name` VARCHAR(100))  NO SQL BEGIN
    IF name IS NULL THEN
        SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client;
   ELSE
       SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client WHERE Client_name LIKE CONCAT('%', name ,'%') OR Client_identification LIKE CONCAT('%', name ,'%');
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_update_status` (IN `id` INT, IN `stat` INT)  NO SQL BEGIN
	UPDATE client SET Stat_id = stat
    WHERE Client_id = id;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_clone_client_quote` (IN `id` INT, IN `user` INT, IN `pre_id` INT)  NO SQL BEGIN
INSERT INTO client(Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) SELECT Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, 8 FROM pre_client WHERE Pre_client_id=id;
SET @client_id = (SELECT LAST_INSERT_ID());
SET @consec = (SELECT CONCAT('COT_',COUNT(*)+1) AS Quo_consec FROM quote ORDER BY Quo_id DESC LIMIT 0, 1);
INSERT INTO quote(Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper,  Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, Pro_id, Stat_id, Quo_pageTotal, Quo_inser, Quo_inserPaper, Quo_inserWeight)SELECT @client_id, @consec, Pre_quo_calendar, Pre_quo_date, Pre_quo_project, Pre_quo_year, Pre_quo_version, Pre_quo_students, Pre_quo_quantity, Pre_quo_width, Pre_quo_height, Pre_quo_format, Pre_quo_color, Pre_quo_colorPaper, Pre_quo_colorWeight, Pre_quo_bw, Pre_quo_bwPaper, Pre_quo_bwWeight, Pre_quo_inserts, Pre_quo_guards, Pre_quo_guardsPaper, Pre_quo_guardsWeight, Pre_quo_cover, Pre_quo_coverPaper, Pre_quo_coverWeight, Pre_quo_top, Pre_quo_coverFinish, Pre_quo_plast, Pre_quo_correction, Pre_quo_issn, Pre_quo_observ, Pre_quo_delivDate, Pre_quo_delivPlace, user, 1, 1, Pre_quo_pageTotal, Pre_quo_inser, Pre_quo_inserPaper, Pre_quo_inserWeight FROM pre_quote WHERE Pre_quo_id = pre_id;
DELETE FROM pre_quote WHERE Pre_quo_id = pre_id;
DELETE FROM pre_client WHERE Pre_client_id=id;
SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_insert` (IN `costing_id` INT, IN `elem_id` INT, IN `quantity` INT, IN `Cvalue` DECIMAL(14,4))   BEGIN
	INSERT INTO costing_detail (Cost_id, Elem_id, Costd_quantity, Costd_value) VALUES (costing_id, elem_id, quantity, Cvalue);
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_select_one` (IN `id` INT)   BEGIN
	SELECT Costd_id, Elem_id, Costd_quantity, Costd_value 
    FROM costing_detail
    WHERE Cost_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_update` (IN `id` INT, IN `elem_id` INT, IN `quantity` INT, IN `Cvalue` DECIMAL(14,4))  NO SQL BEGIN
	UPDATE costing_detail SET Elem_id = elem_id, Costd_quantity = quantity, Costd_value = Cvalue
    WHERE Costd_id = id;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_insert_update` (IN `id` INT, IN `total` DECIMAL(14,2), IN `attach` BLOB, IN `pagValue` DECIMAL(14,2), IN `impQuantity` DECIMAL(5,2), IN `impValue` DECIMAL(14,2), IN `phoQuantity` DECIMAL(5,2), IN `phoValue` DECIMAL(14,2), IN `issnQuantity` DECIMAL(5,2), IN `issnValue` DECIMAL(14,2), IN `sendQuantity` DECIMAL(5,2), IN `sendValue` DECIMAL(14,2), IN `stuValue` DECIMAL(14,2), IN `admin` DECIMAL(5,2), IN `utility` DECIMAL(5,2), IN `incid` DECIMAL(5,2), IN `perQuantity` DECIMAL(5,2), IN `perValue` DECIMAL(14,2), IN `finalValue` DECIMAL(14,2), IN `daysQuantity` DECIMAL(5,2), IN `daysValue` DECIMAL(14,2), IN `description` VARCHAR(1000), IN `stuValue1` DECIMAL(14,2))   BEGIN
	SET @exist = (SELECT COUNT(Quo_id) FROM costing WHERE Quo_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO costing (Quo_id, Cost_totalValue, Cost_pagValue, Cost_impQuantity, Cost_impValue, Cost_phoQuantity, Cost_phoValue, Cost_issnQuantity, Cost_issnValue, Cost_sendQuantity, Cost_sendValue, Cost_stuValue, Cost_perQuantity, Cost_perValue, Cost_daysQuantity, Cost_daysValue, Cost_admin, Cost_incid, Cost_utili, Cost_finalValue, Cost_attach, Cost_description, Cost_stuValue1) 
    VALUES (id, total, pagValue, impQuantity, impValue, phoQuantity, phoValue, issnQuantity, issnValue, sendQuantity, sendValue, stuValue, perQuantity, perValue, daysQuantity, daysValue, admin, incid, utility, finalValue, attach, description, stuValue1);
    ELSE 
    	UPDATE costing SET Cost_totalValue = total, Cost_pagValue = pagValue, Cost_impQuantity = impQuantity, Cost_impValue = impValue, Cost_phoQuantity = phoQuantity, Cost_phoValue = phoValue, Cost_issnQuantity = issnQuantity, Cost_issnValue = issnValue, Cost_sendQuantity = sendQuantity, Cost_sendValue = sendValue, Cost_stuValue = stuValue, Cost_perQuantity = perQuantity, Cost_perValue = perValue, Cost_daysQuantity = daysQuantity, Cost_daysValue = daysValue, Cost_admin = admin, Cost_incid = incid, Cost_utili = utility, Cost_finalValue = finalValue, Cost_attach = attach, Cost_description = description, Cost_stuValue1 = stuValue1
        WHERE Quo_id = id;
    END IF;
    UPDATE quote SET Stat_id = 3 WHERE Quo_id = id;
    SELECT ROW_COUNT(); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_select_one` (IN `id` INT)   BEGIN
	SET @exist = (SELECT COUNT(Quo_id) FROM costing WHERE Quo_id = id);
    IF @exist = 0 THEN    
    SET @pag = (SELECT Elem_cost FROM element WHERE Elem_id = 1);
    SET @print = (SELECT Elem_cost FROM element WHERE Elem_id = 2);
    SET @phot = (SELECT Elem_cost FROM element WHERE Elem_id = 3);
    SET @issn = (SELECT Elem_cost FROM element WHERE Elem_id = 4);
    SET @send = (SELECT Elem_cost FROM element WHERE Elem_id = 5);
    SET @stu = (SELECT Elem_cost FROM element WHERE Elem_id = 6);
    SET @per = (SELECT Elem_cost FROM element WHERE Elem_id = 7);
    SET @days = (SELECT Elem_cost FROM element WHERE Elem_id = 9);
    INSERT INTO costing (Quo_id, Cost_pagValue, Cost_impQuantity, Cost_impValue, Cost_phoValue,Cost_issnValue, Cost_sendValue, Cost_stuValue, Cost_perValue, Cost_daysValue) VALUES (id, @pag,3,@print,@phot,@issn,@send,@stu,@per,@days);
    END IF;	
    	SELECT Q.Quo_id, Q.Quo_consec, Q.Quo_date, P.Pro_name, C.Cost_totalValue, Q.Quo_pageTotal, C.Cost_pagValue, C.Cost_impQuantity, C.Cost_impValue, C.Cost_phoQuantity, C.Cost_phoValue, Q.Quo_issn, C.Cost_issnQuantity, C.Cost_issnValue, C.Cost_sendQuantity, C.Cost_sendValue, Q.Quo_students, C.Cost_stuValue, C.Cost_perQuantity, C.Cost_perValue, C.Cost_daysQuantity, C.Cost_daysValue, C.Cost_admin, C.Cost_incid, C.Cost_utili, Q.Quo_quantity, C.Cost_finalValue, C.Cost_attach, C.Cost_description, C.Cost_stuValue1, Q.Stat_id 
        FROM costing C
        LEFT JOIN quote Q ON Q.Quo_id = C.Quo_id
        INNER JOIN provider P ON Q.Pro_id = P.Pro_id
        WHERE Q.Quo_id = id;    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_update` (IN `id` INT, IN `priting` VARCHAR(100), IN `total` DECIMAL(14,4), IN `admin` DECIMAL(5,2), IN `incid` DECIMAL(5,2), IN `utility` DECIMAL(5,2), IN `attach` BLOB)  NO SQL BEGIN
	UPDATE costing  SET Cost_priting = priting, Cost_totalValue = total, Cost_admin = admin, Cost_incid = incid, Cost_utili = utility, Cost_attach = attach
    WHERE Cost_id = id;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_all` (IN `name` VARCHAR(100))   BEGIN
	IF name IS NULL THEN
		SELECT CR.Cre_id, CR.Cre_consecutive, CR.Cre_requestDate, CR.Cre_pIdentification, CONCAT(CR.Cre_pLastname1, " ", CR.Cre_pLastname2, " ", CR.Cre_pName1, " ", CR.Cre_pName2) AS Cre_pName, CR.Cre_pEmail, CR.Cre_pCell FROM credit CR 
    WHERE Stat_id = 10
    ORDER BY CR.Cre_requestDate DESC;        
  ELSE
    SELECT CR.Cre_id, CR.Cre_consecutive, CR.Cre_requestDate, CR.Cre_pIdentification, CONCAT(CR.Cre_pLastname1, " ", CR.Cre_pLastname2, " ", CR.Cre_pName1, " ", CR.Cre_pName2) AS Cre_pName, CR.Cre_pEmail, CR.Cre_pCell FROM credit CR 
    WHERE (CR.Cre_requestDate LIKE CONCAT('%', name ,'%') OR CR.Cre_pLastname1 LIKE CONCAT('%', name ,'%') OR CR.Cre_pLastname2 LIKE CONCAT('%', name ,'%') OR CR.Cre_pName1 LIKE CONCAT('%', name ,'%') OR CR.Cre_pName2 LIKE CONCAT('%', name ,'%') OR CR.Cre_pIdentification LIKE CONCAT('%', name ,'%') OR CR.Cre_pEmail LIKE CONCAT('%', name ,'%') OR CR.Cre_pCell LIKE CONCAT('%', name ,'%')) AND Stat_id = 10
    ORDER BY CR.Cre_requestDate DESC;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_insert` (IN `servIp` VARCHAR(100), IN `hostHead` VARCHAR(600), IN `webHead` VARCHAR(600), IN `requestIp` VARCHAR(100), IN `requestPort` VARCHAR(10), IN `hash` VARCHAR(600), IN `requestDate` VARCHAR(100), IN `city` VARCHAR(100), IN `requestType` VARCHAR(50), IN `creditProduct` VARCHAR(50), IN `amount` VARCHAR(10), IN `creditLine` VARCHAR(100), IN `pickUp` VARCHAR(10), IN `term` VARCHAR(10), IN `pLastname1` VARCHAR(100), IN `pLastname2` VARCHAR(100), IN `pName1` VARCHAR(100), IN `pName2` VARCHAR(100), IN `pDocType` VARCHAR(10), IN `pIdentification` VARCHAR(20), IN `pExpDate` VARCHAR(100), IN `pExpPlace` VARCHAR(100), IN `pBornDate` VARCHAR(100), IN `pTownship` VARCHAR(100), IN `pDepartment` VARCHAR(100), IN `pNacionality` VARCHAR(100), IN `pCivilStatus` VARCHAR(100), IN `pGender` VARCHAR(100), IN `pDependents` VARCHAR(2), IN `pProfession` VARCHAR(300), IN `pEducationLevel` VARCHAR(100), IN `pLivingplaceType` VARCHAR(100), IN `pResAddress` VARCHAR(300), IN `pResTel` VARCHAR(30), IN `pCell` VARCHAR(30), IN `department` VARCHAR(100), IN `pResCity` VARCHAR(100), IN `pCorrespondence` VARCHAR(100), IN `pCellNotify` VARCHAR(100), IN `pEmail` VARCHAR(300), IN `sLastname1` VARCHAR(100), IN `sLastname2` VARCHAR(100), IN `sName1` VARCHAR(100), IN `sName2` VARCHAR(100), IN `sDocType` VARCHAR(10), IN `sIdentification` VARCHAR(20), IN `sCell` VARCHAR(30), IN `wCompName` VARCHAR(300), IN `wCompTel` VARCHAR(30), IN `wCompTelExt` VARCHAR(30), IN `wCompFax` VARCHAR(30), IN `wDepartment` VARCHAR(100), IN `wCity` VARCHAR(100), IN `wCompDir` VARCHAR(300), IN `wAdmiDate` VARCHAR(100), IN `wContractType` VARCHAR(100), IN `wCharge` VARCHAR(100), IN `wCivilServant` VARCHAR(100), IN `wPubResourAdmin` VARCHAR(10), IN `wPubPerson` VARCHAR(10), IN `wCIIUDesc` VARCHAR(300), IN `wCIIUCode` VARCHAR(20), IN `monthlyInc` VARCHAR(10), IN `monthlyEgr` VARCHAR(10), IN `immovabAssets` VARCHAR(10), IN `othersInc` VARCHAR(10), IN `descEgr` VARCHAR(300), IN `vehiclesAssets` VARCHAR(10), IN `othersDescInc` VARCHAR(300), IN `totalEgr` VARCHAR(10), IN `othersAssets` VARCHAR(10), IN `totalInc` VARCHAR(10), IN `totalAssets` VARCHAR(10), IN `totalLiabilities` VARCHAR(10), IN `totalHeritage` VARCHAR(10), IN `lpType` VARCHAR(100), IN `lpOwner` VARCHAR(100), IN `lpValue` VARCHAR(15), IN `lpMortgage` VARCHAR(10), IN `lpInFavorOf` VARCHAR(100), IN `vehicle` VARCHAR(10), IN `vBrand` VARCHAR(100), IN `vModel` VARCHAR(100), IN `vPlate` VARCHAR(30), IN `vType` VARCHAR(100), IN `vGarment` VARCHAR(10), IN `vFavorOf` VARCHAR(100), IN `vComercialValue` VARCHAR(15), IN `frName` VARCHAR(100), IN `frCity` VARCHAR(100), IN `frPhone` VARCHAR(30), IN `frRelationship` VARCHAR(100), IN `prName` VARCHAR(100), IN `prCity` VARCHAR(100), IN `prTel` VARCHAR(30), IN `prCel` VARCHAR(30), IN `fctransactions` VARCHAR(100), IN `fcWhich` VARCHAR(300), IN `fcAccount` VARCHAR(10), IN `fcAccountNumber` VARCHAR(100), IN `fcBank` VARCHAR(300), IN `fcCurrency` VARCHAR(100), IN `fcCity` VARCHAR(100), IN `fcCountry` VARCHAR(100), IN `fcTransactionType` VARCHAR(100), IN `fcWichTransac` VARCHAR(300), IN `oName` VARCHAR(100), IN `oAccount` VARCHAR(10), IN `oEntity` VARCHAR(100), IN `oAccountNumber` VARCHAR(100), IN `oCheckFor` VARCHAR(100), IN `oIdentification` VARCHAR(20), IN `oValue` VARCHAR(15))   BEGIN
  INSERT INTO credit(Cre_servIp, Cre_hostHead, Cre_webHead, Cre_requestIp, Cre_requestPort, Cre_hash, Cre_requestDate, Cre_city, Cre_requestType,
  Cre_creditProduct, Cre_amount, Cre_creditLine, Cre_pickUp, Cre_term, Cre_pLastname1, Cre_pLastname2, Cre_pName1, Cre_pName2, Cre_pDocType,
  Cre_pIdentification, Cre_pExpDate, Cre_pExpPlace, Cre_pBornDate, Cre_pTownship, Cre_pDepartment, Cre_pNacionality, Cre_pCivilStatus, Cre_pGender,
  Cre_pDependents, Cre_pProfession, Cre_pEducationLevel, Cre_pLivingplaceType, Cre_pResAddress, Cre_pResTel, Cre_pCell, Cre_department, Cre_pResCity,
  Cre_pCorrespondence, Cre_pCellNotify, Cre_pEmail, Cre_sLastname1, Cre_sLastname2, Cre_sName1, Cre_sName2, Cre_sDocType, Cre_sIdentification,
  Cre_sCell, Cre_wCompName, Cre_wCompTel, Cre_wCompTelExt, Cre_wCompFax, Cre_wDepartment, Cre_wCity, Cre_wCompDir, Cre_wAdmiDate, Cre_wContractType,
  Cre_wCharge, Cre_wCivilServant, Cre_wPubResourAdmin, Cre_wPubPerson, Cre_wCIIUDesc, Cre_wCIIUCode, Cre_monthlyInc, Cre_monthlyEgr, Cre_immovabAssets,
  Cre_othersInc, Cre_descEgr, Cre_vehiclesAssets, Cre_othersDescInc, Cre_totalEgr, Cre_othersAssets, Cre_totalInc, Cre_totalAssets, Cre_totalLiabilities,
  Cre_totalHeritage, Cre_lpType, Cre_lpOwner, Cre_lpValue, Cre_lpMortgage, Cre_lpInFavorOf, Cre_vehicle, Cre_vBrand, Cre_vModel, Cre_vPlate,
  Cre_vType, Cre_vGarment, Cre_vFavorOf, Cre_vComercialValue, Cre_frName, Cre_frCity, Cre_frPhone, Cre_frRelationship, Cre_prName, Cre_prCity,
  Cre_prTel, Cre_prCel, Cre_fctransactions, Cre_fcWhich, Cre_fcAccount, Cre_fcAccountNumber, Cre_fcBank, Cre_fcCurrency, Cre_fcCity, Cre_fcCountry,
  Cre_fcTransactionType, Cre_fcWichTransac, Cre_oName, Cre_oAccount, Cre_oEntity, Cre_oAccountNumber, Cre_oCheckFor, Cre_oIdentification, Cre_oValue, Stat_id) 
  VALUES (servIp, hostHead, webHead, requestIp, requestPort, hash, requestDate, city, requestType, creditProduct, amount, creditLine, pickUp, term, 
  pLastname1, pLastname2, pName1, pName2, pDocType, pIdentification, pExpDate, pExpPlace, pBornDate, pTownship, pDepartment, pNacionality, 
  pCivilStatus, pGender, pDependents, pProfession, pEducationLevel, pLivingplaceType, pResAddress, pResTel, pCell, department, pResCity, 
  pCorrespondence, pCellNotify, pEmail, sLastname1, sLastname2, sName1, sName2, sDocType, sIdentification, sCell, wCompName, wCompTel, 
  wCompTelExt, wCompFax, wDepartment, wCity, wCompDir, wAdmiDate, wContractType, wCharge, wCivilServant, wPubResourAdmin, wPubPerson, 
  wCIIUDesc, wCIIUCode, monthlyInc, monthlyEgr, immovabAssets, othersInc, descEgr, vehiclesAssets, othersDescInc, totalEgr, othersAssets, 
  totalInc, totalAssets, totalLiabilities, totalHeritage, lpType, lpOwner, lpValue, lpMortgage, lpInFavorOf, vehicle, vBrand, vModel, vPlate, 
  vType, vGarment, vFavorOf, vComercialValue, frName, frCity, frPhone, frRelationship, prName, prCity, prTel, prCel, fctransactions, 
  fcWhich, fcAccount, fcAccountNumber, fcBank, fcCurrency, fcCity, fcCountry, fcTransactionType, fcWichTransac, oName, oAccount, oEntity, 
  oAccountNumber, oCheckFor, oIdentification, oValue, 10);
  SET @id = (SELECT LAST_INSERT_ID());
  UPDATE credit SET Cre_consecutive =  CONCAT('Crédito_',@id) WHERE Cre_id = @id;
  SELECT @id AS Cre_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_security` (IN `id` INT)   BEGIN
	SELECT Cre_servIp, Cre_servDate, Cre_hostHead, Cre_webHead, Cre_requestIp, Cre_requestPort, Cre_hash
    FROM credit
    WHERE Cre_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_view` (IN `id` INT)   BEGIN 
	SELECT Cre_id, Cre_consecutive, Cre_requestDate, Cre_city, Cre_requestType, Cre_creditProduct, Cre_amount, Cre_creditLine, Cre_pickUp, Cre_term, 
  Cre_pLastname1, Cre_pLastname2, Cre_pName1, Cre_pName2, Cre_pDocType, Cre_pIdentification, Cre_pExpDate, Cre_pExpPlace, Cre_pBornDate, 
  Cre_pTownship, Cre_pDepartment, Cre_pNacionality, Cre_pCivilStatus, Cre_pGender, Cre_pDependents, Cre_pProfession, Cre_pEducationLevel, 
  Cre_pLivingplaceType, Cre_pResAddress, Cre_pResTel, Cre_pCell, Cre_department, Cre_pResCity, Cre_pCorrespondence, Cre_pCellNotify, 
  Cre_pEmail, Cre_sLastname1, Cre_sLastname2, Cre_sName1, Cre_sName2, Cre_sDocType, Cre_sIdentification, Cre_sCell, Cre_wCompName, 
  Cre_wCompTel, Cre_wCompTelExt, Cre_wCompFax, Cre_wDepartment, Cre_wCity, Cre_wCompDir, Cre_wAdmiDate, Cre_wContractType, Cre_wCharge, 
  Cre_wCivilServant, Cre_wPubResourAdmin, Cre_wPubPerson, Cre_wCIIUDesc, Cre_wCIIUCode, Cre_monthlyInc, Cre_monthlyEgr, Cre_immovabAssets, 
  Cre_othersInc, Cre_descEgr, Cre_vehiclesAssets, Cre_othersDescInc, Cre_totalEgr, Cre_othersAssets, Cre_totalInc, Cre_totalAssets, 
  Cre_totalLiabilities, Cre_totalHeritage, Cre_lpType, Cre_lpOwner, Cre_lpValue, Cre_lpMortgage, Cre_lpInFavorOf, Cre_vehicle, Cre_vBrand, 
  Cre_vModel, Cre_vPlate, Cre_vType, Cre_vGarment, Cre_vFavorOf, Cre_vComercialValue, Cre_frName, Cre_frCity, Cre_frPhone, Cre_frRelationship, 
  Cre_prName, Cre_prCity, Cre_prTel, Cre_prCel, Cre_fctransactions, Cre_fcWhich, Cre_fcAccount, Cre_fcAccountNumber, Cre_fcBank, 
  Cre_fcCurrency, Cre_fcCity, Cre_fcCountry, Cre_fcTransactionType, Cre_fcWichTransac, Cre_oName, Cre_oAccount, Cre_oEntity, 
  Cre_oAccountNumber, Cre_oCheckFor, Cre_oIdentification, Cre_oValue, Stat_id 
    FROM credit 
    WHERE Cre_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_data_provision` (IN `obligation_cod_` VARCHAR(80))   BEGIN
SET @cuote = (SELECT COUNT(pay_obligation_actual_cuote)+1 FROM pay_obligation WHERE obligation_cod = obligation_cod_);
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT obligation_id, client_idmax, client_name, client_contract, BA.Bank_name, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, IT.interest_dtf AS 'dtf', IT.interest_ibr AS 'ibr', dtf_points, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' , @cuote AS 'pay_obligation_actual_cuote' FROM obligation OB 
CROSS JOIN interest IT 
INNER JOIN bank BA
ON BA.Bank_id = OB.Bank_id
WHERE obligation_cod = obligation_cod_ and IT.interest_date = DATE_SUB(@date,INTERVAL 1 MONTH);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_date_provision` (IN `obligation_cod_` VARCHAR(80), IN `pay_date_notif_` DATE)   BEGIN
SELECT pay_obligation_id,PO.obligation_cod,PO.pay_date_notif, pay_interesting_value
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 WHERE PO.Stat_id = 8 AND PO.obligation_cod = obligation_cod_ AND PO.pay_date_notif = pay_date_notif_
 ORDER BY PO.pay_obligation_id ASC;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_client_quote` (IN `id_cli` INT, IN `id_quo` INT)  NO SQL BEGIN
DELETE FROM pre_quote WHERE Pre_quo_id = id_quo;
DELETE FROM pre_client WHERE Pre_client_id = id_cli;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_element_insert` (IN `name` VARCHAR(100), IN `cost` DECIMAL(14,4))  NO SQL BEGIN
	INSERT INTO element(Elem_name, Elem_cost) VALUES (name, cost);
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_element_update` (IN `id` INT, IN `name` VARCHAR(100), IN `cost` DECIMAL(14,4))  NO SQL BEGIN
	UPDATE element SET Elem_name = name, Elem_cost = cost
    WHERE Elem_id = id;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_code_quote` ()   BEGIN
	SET @consec = (SELECT CAST(SUBSTRING(Quo_consec, 5) AS UNSIGNED) AS Number FROM quote ORDER BY Number DESC LIMIT 1);
    IF @consec IS NULL THEN
    	SET @consec = 0;
    END IF;
	SELECT CONCAT('COT_',@consec+1) AS Quo_consec;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_pre_code_quote` ()   BEGIN
	SET @consec = (SELECT CAST(SUBSTRING(Pre_quo_consec, 5) AS UNSIGNED) AS Number FROM pre_quote ORDER BY Number DESC LIMIT 1);
    IF @consec IS NULL THEN
    	SET @consec = 0;
    END IF;
	SELECT CONCAT('PRE_',@consec+1) AS Pre_quo_consec;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_update_obligation` ()   BEGIN
    SET @exist = (SELECT COUNT(Client_id)FROM client WHERE Client_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, contactEmail, stat);
    ELSE
    	UPDATE client SET Client_identification = identification, Client_name = name, Client_address = address, Client_tel = tel, Client_email = email, Client_contactName = contactName, Client_contactTitle = contactTitle, Client_contactTel = contactTel, Client_contactCel = contactCel, Client_contactEmail = contactEmail, Stat_id = stat
        WHERE Client_id = id;
    END IF;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login` (IN `email` VARCHAR(200), IN `pass` VARCHAR(30))   BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_insert` (IN `pass` VARCHAR(30), IN `user` INT)   BEGIN 
  INSERT INTO login(Login_password, User_id) VALUES (pass,user); 
  SELECT ROW_COUNT(); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_update` (IN `id` SMALLINT, IN `pass` VARCHAR(600))   BEGIN 
  UPDATE login SET Login_password=pass WHERE User_id = id; 
  DELETE FROM recovery_password WHERE User_id=id;
  SELECT ROW_COUNT() AS Id_row;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_all` (IN `name` VARCHAR(100))   BEGIN
	IF name IS NULL THEN
		SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell FROM membership MEM 
    WHERE Stat_id = 10
    ORDER BY MEM.Mem_requestDate DESC;        
  ELSE
    SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell FROM membership MEM 
    WHERE (MEM.Mem_requestDate LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pIdentification LIKE CONCAT('%', name ,'%') OR MEM.Mem_pEmail LIKE CONCAT('%', name ,'%') OR MEM.Mem_pCell LIKE CONCAT('%', name ,'%')) AND Stat_id = 10
    ORDER BY MEM.Mem_requestDate DESC;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_insert` (IN `servIp` VARCHAR(100), IN `hostHead` VARCHAR(600), IN `webHead` VARCHAR(600), IN `requestIp` VARCHAR(100), IN `requestPort` VARCHAR(10), IN `hash` VARCHAR(600), IN `requestType` VARCHAR(50), IN `requestDate` VARCHAR(100), IN `city` VARCHAR(100), IN `assoType` VARCHAR(100), IN `pLastname1` VARCHAR(100), IN `pLastname2` VARCHAR(100), IN `pName1` VARCHAR(100), IN `pName2` VARCHAR(100), IN `pDocType` VARCHAR(10), IN `pIdentification` VARCHAR(20), IN `pExpDate` VARCHAR(100), IN `pExpPlace` VARCHAR(100), IN `pGender` VARCHAR(100), IN `pBornDate` VARCHAR(100), IN `pNacionality` VARCHAR(100), IN `pTownship` VARCHAR(100), IN `pDepartment` VARCHAR(100), IN `pCivilStatus` VARCHAR(100), IN `pLivingplaceType` VARCHAR(100), IN `pResAddress` VARCHAR(300), IN `pStratum` VARCHAR(30), IN `pResTel` VARCHAR(30), IN `pCell` VARCHAR(30), IN `department` VARCHAR(100), IN `pResCity` VARCHAR(100), IN `pCorrespondence` VARCHAR(100), IN `pEmail` VARCHAR(300), IN `pProfession` VARCHAR(300), IN `pEducationLevel` VARCHAR(100), IN `sLastname1` VARCHAR(100), IN `sLastname2` VARCHAR(100), IN `sName1` VARCHAR(100), IN `sName2` VARCHAR(100), IN `sDocType` VARCHAR(10), IN `sIdentification` VARCHAR(20), IN `sCell` VARCHAR(30), IN `wCompName` VARCHAR(300), IN `wCompTel` VARCHAR(30), IN `wCompTelExt` VARCHAR(30), IN `wCompDir` VARCHAR(300), IN `wDepartment` VARCHAR(100), IN `wCity` VARCHAR(100), IN `wAdmiDate` VARCHAR(100), IN `wContractType` VARCHAR(100), IN `wCharge` VARCHAR(100), IN `wCivilServant` VARCHAR(100), IN `wPubResourAdmin` VARCHAR(10), IN `wPubPerson` VARCHAR(10), IN `lRPubPerson` VARCHAR(10), IN `wCompFax` VARCHAR(30), IN `wEmail` VARCHAR(300), IN `wCIIUDesc` VARCHAR(300), IN `wCIIUCode` VARCHAR(20), IN `monthlyInc` VARCHAR(10), IN `monthlyEgr` VARCHAR(10), IN `immovabAssets` VARCHAR(10), IN `othersInc` VARCHAR(10), IN `descEgr` VARCHAR(300), IN `vehiclesAssets` VARCHAR(10), IN `othersDescInc` VARCHAR(300), IN `totalEgr` VARCHAR(10), IN `othersAssets` VARCHAR(10), IN `totalInc` VARCHAR(10), IN `totalAssets` VARCHAR(10), IN `totalLiabilities` VARCHAR(10), IN `totalHeritage` VARCHAR(10), IN `fctransactions` VARCHAR(10), IN `fcWhich` VARCHAR(300), IN `fcAccount` VARCHAR(10), IN `fcAccountNumber` VARCHAR(100), IN `fcBank` VARCHAR(300), IN `fcCurrency` VARCHAR(100), IN `fcCity` VARCHAR(100), IN `fcCountry` VARCHAR(100), IN `fcTransactionType` VARCHAR(100), IN `fcWichTransac` VARCHAR(300))   BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_security` (IN `id` INT)   BEGIN
	SELECT Mem_servIp, Mem_servDate, Mem_hostHead, Mem_webHead, Mem_requestIp, Mem_requestPort, Mem_hash
    FROM membership
    WHERE Mem_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_view` (IN `id` INT)   BEGIN 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_user_active` (IN `n_hash` VARCHAR(600))   BEGIN 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_user_insert_update` (IN `us_id` INT(11), IN `n_date` VARCHAR(100), IN `n_hash` VARCHAR(600), IN `n_status` INT)   BEGIN 
	SET @count = (SELECT COUNT(User_id) FROM new_user WHERE User_id = us_id);
    IF @count = 0 THEN
    	INSERT INTO new_user (Nuser_id, User_id, Nuser_date, Nuser_hash, Nuser_state) VALUES (NULL, us_id, n_date, n_hash, n_status);
    ELSE
    	UPDATE new_user SET Nuser_date = n_date, Nuser_hash = n_hash, Nuser_state = n_status WHERE User_id = us_id;
    END IF;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_insert_update` (IN `id_` INT, IN `client_idmax_` VARCHAR(25), IN `client_contract_` VARCHAR(25), IN `category_` INT, IN `credit_type_id_` INT, IN `obligation_cod_` VARCHAR(80), IN `obligation_antigua_` VARCHAR(10))   BEGIN
    SET @exist = id_ ;  
    IF @exist = 0 THEN 
    INSERT INTO create_product (name,reference,price,weight,category,stock) VALUES (obligation_cod_,client_idmax_,client_contract_,obligation_antigua_,category_,credit_type_id_);
    ELSE
    UPDATE create_product SET reference=client_idmax_,price=client_contract_,category=category_,stock=credit_type_id_,name=obligation_cod_,weight=obligation_antigua_ WHERE obligation_id=id_;
    END IF;
    SELECT ROW_COUNT();
     
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_search` (IN `data_` VARCHAR(80))   BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_select` ()   BEGIN
    SELECT name,reference,price,weight,category,stock,date_create
    	FROM create_product
        ORDER BY date_create ASC;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_select_update` (IN `obligation_cod_` VARCHAR(80))   BEGIN
    SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, dtf, dtf_points, ibr, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' FROM obligation 
    WHERE obligation_cod=obligation_cod_ AND Stat_id=3; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_for_provision` ()   BEGIN
SELECT pay_obligation_id,PO.obligation_cod,O.client_name,PO.pay_date_notif, pay_interesting_value
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 8 
 ORDER BY PO.pay_Date ASC;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation` ()   BEGIN
SELECT O.obligation_cod,O.client_name,BA.Bank_name,initial_value,O.cuotes_number, pay_obligation_actual_cuote, pay_date_notif,pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,PO.Stat_id 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_insert_update` (IN `id_` INT, IN `obligation_cod_` VARCHAR(80), IN `pay_obligation_actual_cuote_` INT, IN `pay_Dtf_` FLOAT, IN `pay_Ibr_` FLOAT, IN `pay_FixedRate_` DOUBLE, IN `pay_value_` DOUBLE, IN `pay_capital_value_` DOUBLE, IN `pay_residue_` DOUBLE, IN `pay_interesting_value_` DOUBLE, IN `pay_observation_` VARCHAR(500), IN `pay_Date_` VARCHAR(80))   BEGIN
    SET @exist = id_ ;
    SET @porPagar = 9;
    SET @countCode = (SELECT COUNT(obligation_cod) FROM pay_obligation WHERE obligation_cod = obligation_cod_ AND Stat_id = @porPagar);  
    SET @date = pay_Date_;

    SET @days = DATEDIFF(DATE_ADD(@date,INTERVAL 1 MONTH),@date); 
    
    SET @treintauno = DATE_ADD(@date,INTERVAL 1 MONTH);
    SET @ultDia = LAST_DAY(@treintauno);

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_pays` ()   BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_select_amortization` (IN `obligation_cod_` VARCHAR(80))   BEGIN
  SET @cuote = (SELECT COUNT(pay_obligation_actual_cuote)+1 FROM pay_obligation WHERE obligation_cod = obligation_cod_);
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, IT.interest_dtf AS 'dtf', IT.interest_ibr AS 'ibr', dtf_points, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' , @cuote AS 'pay_obligation_actual_cuote' FROM obligation OB 
CROSS JOIN interest IT 
WHERE obligation_cod = obligation_cod_ and IT.interest_date = DATE_SUB(@date,INTERVAL 30 DAY);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_to_notification` ()   BEGIN
SET @activo = 3;
SELECT obligation_cod
 FROM obligation  
 WHERE pay_date <= DATE_ADD(CURRENT_DATE(),INTERVAL 5 DAY) AND Stat_id = @activo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_to_pay` (IN `obligation_cod_` VARCHAR(80))   BEGIN
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT pay_obligation_id,O.obligation_cod,O.client_name,BA.Bank_name, pay_obligation_actual_cuote, O.pay_Date, pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,pay_Dtf,pay_Ibr,pay_FixedRate
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 CROSS JOIN interest IT 
 WHERE PO.obligation_cod = obligation_cod_ AND IT.interest_date = DATE_SUB(@date,INTERVAL 30 DAY) AND PO.Stat_id = 9
 ORDER BY pay_Date ASC;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_client_insert_update` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `contactTitle` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320), IN `stat` INT)   BEGIN
        SET @exist = (SELECT COUNT(Pre_client_identification)FROM pre_client WHERE Pre_client_email = email ); 
        IF @exist = 0 THEN 
            INSERT INTO pre_client (Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, email, stat);

        ELSE
            UPDATE Pre_client SET Pre_client_name = name, Pre_client_address = address, Pre_client_tel = tel, Pre_client_email = email, Pre_client_contactName = contactName, Pre_client_contactTitle = contactTitle, Pre_client_contactTel = contactTel, Pre_client_contactCel = contactCel, Pre_client_contactEmail = contactEmail, Stat_id = stat
            WHERE Pre_client_email = email;
        END IF;
        SELECT ROW_COUNT();
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pre_client_select` (IN `email` VARCHAR(320))   BEGIN
    SELECT Pre_client_id FROM pre_client WHERE Pre_client_email = email; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_select_all` (IN `name` VARCHAR(100))   BEGIN
    IF name IS NULL THEN
        SELECT Pre_quo_id,Pre_quo_consec, Pre_quo_project, Pre_quo_date, PQU.Stat_id AS "stat_id", PCLI.Pre_client_name AS "Pre_client_name"
        FROM pre_quote PQU INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id
        ORDER BY PCLI.Pre_client_name ASC;
    ELSE
        SELECT Pre_quo_id,Pre_quo_consec, Pre_quo_project, Pre_quo_date, PQU.Stat_id AS stat_id, PCLI.Pre_client_name AS Pre_client_name
        FROM pre_quote PQU INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id
        WHERE Pre_quo_consec LIKE CONCAT('%', name ,'%') 
        OR PCLI.Pre_client_name LIKE CONCAT('%', name ,'%') 
        OR Pre_quo_project LIKE CONCAT('%', name ,'%') ORDER BY PCLI.Pre_client_name ASC;
	END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_select_one` (IN `id` INT)   BEGIN
SELECT Pre_quo_id, PQU.Pre_client_id, Pre_quo_consec, Pre_quo_calendar, Pre_quo_date, Pre_quo_project, Pre_quo_year, Pre_quo_version, Pre_quo_students, Pre_quo_quantity, Pre_quo_width, Pre_quo_height, Pre_quo_format, Pre_quo_color, Pre_quo_colorPaper, Pre_quo_colorWeight, Pre_quo_bw, Pre_quo_bwPaper, Pre_quo_bwWeight, Pre_quo_inserts, Pre_quo_guards, Pre_quo_guardsPaper, Pre_quo_guardsWeight, Pre_quo_cover, Pre_quo_coverPaper, Pre_quo_coverWeight, Pre_quo_top, Pre_quo_coverFinish, Pre_quo_plast, Pre_quo_correction, Pre_quo_issn, Pre_quo_observ, Pre_quo_delivDate, Pre_quo_delivPlace, PQU.Stat_id, Pre_quo_pageTotal, Pre_quo_inser, Pre_quo_inserPaper, Pre_quo_inserWeight,
Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, PCLI.Stat_id AS "Stat_cli_id"
FROM pre_quote PQU 
INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id 
WHERE Pre_quo_id= id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_update` (IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` VARCHAR(4), IN `version` VARCHAR(11), IN `students` VARCHAR(11), IN `quantity` VARCHAR(11), IN `width` VARCHAR(20), IN `height` VARCHAR(20), IN `format` VARCHAR(40), IN `color` VARCHAR(100), IN `colorPaper` VARCHAR(100), IN `colorWeight` VARCHAR(100), IN `bw` VARCHAR(100), IN `bwPaper` VARCHAR(100), IN `bwWeight` VARCHAR(100), IN `inserts` VARCHAR(40), IN `guards` VARCHAR(100), IN `guardsPaper` VARCHAR(100), IN `guardsWeight` VARCHAR(100), IN `cover` VARCHAR(100), IN `coverPaper` VARCHAR(100), IN `coverWeight` VARCHAR(100), IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `stat` INT, IN `pageTotal` VARCHAR(100), IN `inser` VARCHAR(100), IN `inserPaper` VARCHAR(100), IN `inserWeight` INT, IN `client_identification` VARCHAR(15), IN `client_name` VARCHAR(100), IN `client_address` VARCHAR(200), IN `client_tel` VARCHAR(10), IN `client_email` VARCHAR(320), IN `client_contactName` VARCHAR(100), IN `client_contactTitle` VARCHAR(100), IN `client_contactTel` VARCHAR(10), IN `client_contactCel` VARCHAR(15), IN `client_contactEmail` VARCHAR(320))   BEGIN
UPDATE pre_client SET Pre_client_identification = client_identification, Pre_client_name = client_name, Pre_client_address = client_address, Pre_client_tel = client_tel, Pre_client_email = client_email,Pre_client_contactName = client_contactName,Pre_client_contactTitle = client_contactTitle, Pre_client_contactTel = client_contactTel, Pre_client_contactCel = client_contactCel, Pre_client_contactEmail = client_contactEmail
WHERE Pre_client_id = client;
UPDATE pre_quote SET Pre_quo_calendar=calendar,Pre_quo_date=quoteDate,Pre_quo_project=project,
Pre_quo_year=quoteYear,Pre_quo_version=version,Pre_quo_students=students,
Pre_quo_quantity=quantity,Pre_quo_width=width,Pre_quo_height=height,
Pre_quo_format=format,Pre_quo_color=color,Pre_quo_colorPaper=colorPaper,
Pre_quo_colorWeight=colorWeight,Pre_quo_bw=bw,Pre_quo_bwPaper=bwPaper,
Pre_quo_bwWeight=bwWeight,Pre_quo_inserts=inserts,Pre_quo_guards=guards,
Pre_quo_guardsPaper=guardsPaper,Pre_quo_guardsWeight=guardsWeight,Pre_quo_cover=cover,
Pre_quo_coverPaper=coverPaper,Pre_quo_coverWeight=coverWeight,Pre_quo_top=top,
Pre_quo_coverFinish=coverFinish,Pre_quo_plast=plast,Pre_quo_correction=correction,
Pre_quo_issn=issn,Pre_quo_observ=observ,Pre_quo_delivDate=delivDate,
Pre_quo_delivPlace=delivPlace,Stat_id=Stat_id,Pre_quo_pageTotal=pageTotal, Pre_quo_inser = inser,Pre_quo_inserPaper = inserPaper,Pre_quo_inserWeight = inserWeight 
WHERE Pre_quo_consec=consec;
SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_active` (IN `name` VARCHAR(100))   BEGIN
    IF name IS NULL THEN
        SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider
       WHERE Stat_id = 8;
   ELSE
       SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider WHERE (Pro_name LIKE CONCAT('%', name ,'%') OR Pro_identification LIKE CONCAT('%', name ,'%'))  AND Stat_id = 8;
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_insert` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB)   BEGIN
INSERT INTO provider (Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach) VALUES (name, identification, tel, address, contactName, contactEmail, attach);
  SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_insert_update` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB, IN `stat` INT)  NO SQL BEGIN
	SET @exist = (SELECT COUNT(Pro_identification) FROM provider WHERE Pro_identification = identification); 
    IF @exist = 0 THEN 
		INSERT INTO provider (Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach, Stat_id) VALUES (name, identification, tel, address, contactName, contactEmail, attach, stat);
    ELSE
    	UPDATE provider SET Pro_name = name, Pro_tel = tel, Pro_address = address, Pro_contactName = contactName, Pro_contactEmail = contactEmail, Pro_attach = attach, Stat_id = stat
        WHERE Pro_identification = identification;
    END IF;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_all` ()   BEGIN
SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail, Stat_id  FROM provider;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_identification` (IN `identification` VARCHAR(15))   BEGIN
    SELECT Pro_id, Pro_name, Pro_identification FROM provider WHERE Pro_identification = identification;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_one` (IN `id` VARCHAR(15))   BEGIN
SELECT Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach, Stat_id FROM provider
WHERE Pro_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_prov` ()   BEGIN
SELECT Pro_id, Pro_name FROM provider;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_search` (IN `name` VARCHAR(100))  NO SQL BEGIN
    IF name IS NULL THEN
        SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider;
   ELSE
       SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider WHERE Pro_name LIKE CONCAT('%', name ,'%') OR Pro_identification LIKE CONCAT('%', name ,'%');
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_update` (IN `id` VARCHAR(15), IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB)   BEGIN
UPDATE provider SET Pro_name = name, Pro_identification = identification, Pro_tel = tel, Pro_address = address, Pro_contactName = contactName, Pro_contactEmail = contactEmail, Pro_attach = attach
WHERE Pro_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_update_status` (IN `id` INT, IN `stat` INT)  NO SQL BEGIN
	UPDATE provider SET Stat_id = stat
    WHERE Pro_id = id;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provision` ()   BEGIN
SELECT PR.obligation_cod,OB.client_name,BA.Bank_name,PR.provi_inicialDate,PR.provi_lastDate, PR.provi_interesting,PR.provi_actualMonth,PR.provi_afterMonth, PR.total_provision,PR.provi_month
FROM provision PR 
INNER JOIN obligation OB 
ON PR.obligation_cod=OB.obligation_cod
INNER JOIN bank BA 
ON BA.Bank_id=OB.Bank_id
ORDER BY PR.provi_inicialDate ASC;
     END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provision_insert_update` (IN `obligation_cod_` VARCHAR(80), IN `provi_inicialDate_` DATE, IN `provi_lastDate_` DATE, IN `provi_interesting_` DOUBLE, IN `provi_actualMonth_` DOUBLE, IN `provi_afterMonth_` DOUBLE, IN `total_provision_` DOUBLE, IN `provi_month_` VARCHAR(80))   BEGIN
      INSERT INTO provision (obligation_cod, provi_inicialDate, provi_lastDate, provi_interesting , provi_actualMonth, provi_afterMonth, total_provision, provi_month) VALUES (obligation_cod_, provi_inicialDate_, provi_lastDate_, provi_interesting_,provi_actualMonth_, provi_afterMonth_, total_provision_, provi_month_);
SELECT ROW_COUNT();
     
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_create_pdf` (IN `consec` VARCHAR(15), IN `entry` INT(1))   BEGIN
	IF entry = 1 THEN
	SELECT P.Pro_name, P.Pro_contactName, Q.Quo_consec, Q.Quo_date, Q.Quo_project, Q.Quo_year, Q.Quo_version, Q.Quo_quantity, Q.Quo_width, Q.Quo_height, Q.Quo_format, Q.Quo_color, Q.Quo_colorPaper, Q.Quo_colorWeight, Q.Quo_bw, Q.Quo_bwPaper, Q.Quo_bwWeight, Q.Quo_inserts, Q.Quo_guards, Q.Quo_guardsPaper, Q.Quo_guardsWeight, Q.Quo_cover, Q.Quo_coverPaper, Q.Quo_coverWeight, Q.Quo_pageTotal, Q.Quo_top, Q.Quo_coverFinish, Q.Quo_plast, Q.Quo_correction, Q.Quo_issn, Q.Quo_observ, Q.Quo_delivDate, Q.Quo_delivPlace, U.User_name, U.User_title, U.User_telephone, Q.Quo_inser, Q.Quo_inserPaper, Q.Quo_inserWeight FROM  quote Q
    LEFT JOIN provider P ON Q.Pro_id = P.Pro_id
    LEFT JOIN user U ON Q.User_id = U.User_id
    WHERE Q.Quo_consec = consec;
    ELSEIF entry = 2 THEN
        SELECT CL.Client_name, CL.Client_contactName, CL.Client_contactTitle, Q.Quo_consec, Q.Quo_date, Q.Quo_project, Q.Quo_year, Q.Quo_version, Q.Quo_quantity, Q.Quo_width, Q.Quo_height, Q.Quo_format, Q.Quo_color, Q.Quo_colorPaper, Q.Quo_colorWeight, Q.Quo_bw, Q.Quo_bwPaper, Q.Quo_bwWeight, Q.Quo_inserts, Q.Quo_guards, Q.Quo_guardsPaper, Q.Quo_guardsWeight, Q.Quo_cover, Q.Quo_coverPaper, Q.Quo_coverWeight, Q.Quo_pageTotal, Q.Quo_top, Q.Quo_coverFinish, Q.Quo_plast, Q.Quo_correction, Q.Quo_issn, Q.Quo_observ, Q.Quo_inser, Q.Quo_inserPaper, Q.Quo_inserWeight, Q.Quo_delivDate, Q.Quo_calendar, C.Cost_finalValue, C.Cost_description, Q.Quo_delivPlace, U.User_name, U.User_title, U.User_telephone 
        FROM quote Q 
        LEFT JOIN user U ON Q.User_id = U.User_id 
        LEFT JOIN costing C ON Q.Quo_id = C.Quo_id 
        LEFT JOIN client CL ON CL.Client_id = Q.Client_id 
        WHERE Q.Quo_consec = consec;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_insert_upate` (IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` VARCHAR(4), IN `version` VARCHAR(11), IN `students` VARCHAR(11), IN `quality` VARCHAR(11), IN `width` VARCHAR(20), IN `height` VARCHAR(20), IN `format` VARCHAR(40), IN `color` VARCHAR(100), IN `colorPaper` VARCHAR(100), IN `colorWeight` VARCHAR(100), IN `bw` VARCHAR(100), IN `bwPaper` VARCHAR(100), IN `bwWeight` VARCHAR(100), IN `inserts` VARCHAR(40), IN `guards` VARCHAR(100), IN `guardsPaper` VARCHAR(100), IN `guardsWeight` VARCHAR(100), IN `cover` VARCHAR(100), IN `coverPaper` VARCHAR(100), IN `coverWeight` VARCHAR(100), IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `user_id` INT, IN `prov` INT, IN `stat` INT, IN `pageTotal` VARCHAR(100), IN `inser` VARCHAR(100), IN `inserPaper` VARCHAR(100), IN `inserWeight` VARCHAR(100))   BEGIN
  SET @exist = (SELECT COUNT(Quo_consec)
  FROM quote
  WHERE Quo_consec = consec);
  IF @exist = 0 THEN
  INSERT INTO quote
    (Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper, Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, Pro_id, Stat_id, Quo_pageTotal,Quo_inser, Quo_inserPaper, Quo_inserWeight)
  VALUES
    (client, consec, calendar, quoteDate, project, quoteYear, version, students, quality, width, height, format, color, colorPaper, colorWeight, bw, bwPaper, bwWeight, inserts, guards, guardsPaper, guardsWeight, cover, coverPaper, coverWeight, top, coverFinish, plast, correction, issn, observ, delivDate, delivPlace, user_id, prov, stat, pageTotal, inser, inserPaper, inserWeight);
  ELSE
  UPDATE quote SET Client_id = client,  Quo_calendar = calendar, Quo_date = quoteDate, Quo_project = project, Quo_year = quoteYear, Quo_version = version, Quo_students = students, Quo_quantity = quality, Quo_width = width, Quo_height = height, Quo_format = format, Quo_color = color, Quo_colorPaper = colorPaper, Quo_colorWeight = colorWeight, Quo_bw = bw, Quo_bwPaper = bwPaper, Quo_bwWeight = bwWeight, Quo_inserts = inserts, Quo_guards = guards, Quo_guardsPaper = guardsPaper, Quo_guardsWeight = guardsWeight, Quo_cover = cover, Quo_coverPaper = coverPaper, Quo_coverWeight = coverWeight, Quo_top = top, Quo_coverFinish = coverFinish, Quo_plast = plast, Quo_correction = correction, Quo_issn = issn, Quo_observ = observ, Quo_delivDate = delivDate, Quo_delivPlace = delivPlace, User_id = user_id, Pro_id = prov, Stat_id = stat, Quo_pageTotal = pageTotal, Quo_inser = inser, Quo_inserPaper = inserPaper, Quo_inserWeight = inserWeight WHERE Quo_consec=consec;
END
IF;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_all` (IN `name` VARCHAR(100))   BEGIN
	IF name IS NULL THEN
		SELECT Quo_id,CLI.Client_name AS "Client_name" ,Quo_consec,Quo_project,Quo_date,QU.stat_id FROM quote QU 
INNER JOIN client CLI ON QU.Client_id=CLI.Client_id ORDER BY Quo_id DESC;
        
    ELSE
       SELECT Quo_id,CLI.Client_name,Quo_consec,Quo_project,Quo_date,QU.stat_id FROM quote QU 
INNER JOIN client CLI ON QU.Client_id=CLI.Client_id  WHERE Quo_consec LIKE CONCAT('%', name ,'%') OR CLI.Client_name LIKE CONCAT('%', name ,'%') OR Quo_project LIKE CONCAT('%', name ,'%') ORDER BY Quo_id DESC;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_one` (IN `id` INT)   BEGIN
SELECT Pro_identification,Pro_name,Client_identification,Client_name, Quo_id, QU.Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper, Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, QU.Pro_id, QU.Stat_id, Quo_pageTotal, Quo_inser, Quo_inserPaper, Quo_inserWeight FROM quote QU INNER JOIN client CLI ON QU.Client_id=CLI.Client_id INNER JOIN provider PRO ON QU.Pro_id=PRO.Pro_id WHERE Quo_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_status` (IN `stat` INT)   BEGIN
    SELECT Q.Quo_id, C.Client_name, Q.Quo_date, Q.Quo_project, Q.Stat_id 
    FROM quote Q 
    INNER JOIN client C ON C.Client_id = Q.Client_id
    WHERE Q.Stat_id = stat
    ORDER BY Q.Quo_date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_update` (IN `id` INT, IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` INT(4), IN `version` INT, IN `students` INT, IN `quality` INT, IN `width` DECIMAL(6,2), IN `height` DECIMAL(6,2), IN `format` VARCHAR(40), IN `color` INT, IN `colorPaper` INT, IN `colorWeight` INT, IN `bw` INT, IN `bwPaper` INT, IN `bwWeight` INT, IN `inserts` INT, IN `guards` INT, IN `guardsPaper` INT, IN `guardsWeight` INT, IN `cover` INT, IN `coverPaper` INT, IN `coverWeight` INT, IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `user_id` INT, IN `prov` INT, IN `stat` INT)   BEGIN
	UPDATE quote SET Client_id = client, Quo_consec = consec, Quo_calendar = calendar, Quo_date = quoteDate, Quo_project = project, Quo_year = quoteYear, Quo_version = version, Quo_students = students, Quo_quantity = quality, Quo_width = width, Quo_height = height, Quo_format = format, Quo_color = color, Quo_colorPaper = colorPaper, Quo_colorWeight = colorWeight, Quo_bw = bw, Quo_bwPaper = bwPaper, Quo_bwWeight = bwWeight, Quo_inserts = inserts, Quo_guards = guards, Quo_guardsPaper = guardsPaper, Quo_guardsWeight = guardsWeight, Quo_cover = cover, Quo_coverPaper = coverPaper, Quo_coverWeight = coverWeight, Quo_top = top, Quo_coverFinish = coverFinish, Quo_plast = plast, Quo_correction = correction, Quo_issn = issn, Quo_observ = observ, Quo_delivDate = delivDate, Quo_delivPlace = delivPlace, User_id = user_id, Pro_id = prov, Stat_id = stat
  WHERE Quo_id = id;
  SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_update_status` (IN `consec` VARCHAR(15), IN `stat` INT)   BEGIN
	UPDATE quote SET Stat_id = stat
    WHERE Quo_consec = consec;
    SELECT ROW_COUNT();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recovery_password_insert` (IN `user_id` INT, IN `pass_date` VARCHAR(100), IN `pass_hash` VARCHAR(600), IN `pass_state` INT)   BEGIN 
	SET @count = (SELECT COUNT(*) FROM recovery_password WHERE User_id = user_id);
    IF @count = 0 THEN
  		INSERT INTO recovery_password (Recover_pass_id, User_id, Recover_pass_date, Recover_pass_hash, Recover_pass_state) VALUES (NULL, user_id,pass_date, pass_hash,pass_state);
  	ELSE
    	UPDATE recovery_password SET Recover_pass_date = pass_date, Recover_pass_hash = pass_hash, Recover_pass_state = pass_state WHERE User_id = user_id;
    END IF;
    SELECT ROW_COUNT(); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recovery_password_select` (IN `pass_hash` VARCHAR(600))   BEGIN 
SET @valid =(SELECT TIMESTAMPDIFF(MINUTE,NOW() ,DATE_ADD(Recover_pass_date,INTERVAL 24 HOUR)) AS Recover_difference FROM recovery_password WHERE Recover_pass_hash=pass_hash);
IF @valid >= 0 THEN 
  SELECT User_id FROM recovery_password WHERE Recover_pass_hash=pass_hash;
  ELSE
  SELECT "expire" AS Error_id;
 END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_pay_obligation_for_pay` (IN `data_` VARCHAR(80))   BEGIN
SELECT PA.obligation_cod,client_name,BA.Bank_name,OB.cuotes_number,PA.pay_obligation_actual_cuote,OB.pay_date,PA.pay_value,St.Stat_name
        FROM pay_obligation PA
        INNER JOIN status ST
        ON PA.Stat_id = ST.Stat_id
        INNER JOIN obligation OB
        ON PA.obligation_cod = OB.obligation_cod
        INNER JOIN bank BA
        ON OB.Bank_id=BA.Bank_id 
        WHERE client_name LIKE '%data_%' OR PA.obligation_cod LIKE '%data_%' OR OB.pay_date LIKE '%data_%' AND PA.Stat_id = 9
        ORDER BY OB.pay_date ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_role` ()   BEGIN
    SELECT * FROM role;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_security_group` ()   BEGIN
    SELECT * FROM security_group;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_status` (IN `stat` INT)   BEGIN
    SELECT * FROM status WHERE Type_id = stat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_get_email` (IN `email` VARCHAR(320))   BEGIN
    SET @valid =(SELECT User_id FROM user WHERE User_email=email AND Stat_id = 6);
    IF @valid != 0 THEN 
    SELECT User_id, User_name FROM user WHERE User_email=email;
    ELSE
    SELECT "0" AS User_id;
    END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_insert_update` (IN `name` VARCHAR(80), IN `identification` VARCHAR(15), IN `email` VARCHAR(320), IN `title` VARCHAR(30), IN `stat` INT, IN `pass` VARCHAR(30), IN `tel` VARCHAR(15), IN `id` INT, IN `role` INT, IN `securityGroup` INT, IN `company` INT)   BEGIN
    SET @exist =(SELECT COUNT(*)
    FROM user
    WHERE User_email = email AND User_identification = identification);
    SET @id = (SELECT User_id
    FROM user
    WHERE User_email = email);

    IF @exist = 0 AND id = 0 THEN
        INSERT INTO user (User_name, User_identification, User_email, User_title, Stat_id, User_telephone,Role_id,Sgroup_id, Comp_id) VALUES (name, identification, email, title, stat, tel, role, securityGroup, company);
        SET @user_id = LAST_INSERT_ID();
        INSERT INTO login(Login_password, User_id)VALUES(pass, @user_id);
        SET @return = @user_id;
    ELSE
        IF (SELECT COUNT(User_id) FROM new_user WHERE User_id = @id) =1 THEN
            SET @return = 'Inactive';
        ELSEIF id != 0 AND @exist = 1  THEN
            UPDATE user SET User_name = name, User_title = title, Stat_id = stat, User_telephone = tel, Role_id = role, Sgroup_id = securityGroup WHERE User_id = @id;
            SET @return = 'Update';
        ELSE
            SET @return = 'Registered';
        END IF;
    END IF;
    SELECT @return AS "return_value";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_active` (IN `name` VARCHAR(320))  NO SQL BEGIN
    IF name IS NULL THEN
        SELECT User_id, User_name, User_email, User_title FROM user
       WHERE Stat_id = 6;
   ELSE
       SELECT User_id, User_name, User_email, User_title FROM user WHERE (User_name LIKE CONCAT('%', name ,'%') OR User_email LIKE CONCAT('%', name ,'%') OR User_title LIKE CONCAT('%', name ,'%')) AND Stat_id = 6;
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_one` (IN `id` INT)   BEGIN
SELECT User_id, User_name, User_identification, User_email, User_title, Stat_id, User_telephone,Role_id ,Sgroup_id, Comp_id FROM user  WHERE User_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_validation` (IN `id` INT)   BEGIN
   SELECT User_name, User_email FROM user
   WHERE User_id = id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `create_product`
--

CREATE TABLE `create_product` (
  `product_id` int(11) NOT NULL,
  `name` varchar(90) NOT NULL,
  `reference` varchar(90) NOT NULL,
  `price` float NOT NULL,
  `weight` float DEFAULT NULL,
  `category` varchar(90) NOT NULL,
  `stock` float NOT NULL,
  `date_create` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `create_product`
--

INSERT INTO `create_product` (`product_id`, `name`, `reference`, `price`, `weight`, `category`, `stock`, `date_create`) VALUES
(1, 'Aceite', 'ace-1', 20000, 1, '1', 100, '2022-06-01'),
(2, 'Salchichon', 'SAL-1', 5000, 2, '2', 95, '2022-06-01'),
(4, 'Papas', 'PA-1', 15000, 5, '3', 1000, '2022-06-01'),
(5, 'Carne de res', 'CARRES-1', 25000, 1, '2', 195, '2022-06-01'),
(6, 'Zanahoria', 'ZAH-1', 4000, 2, '3', 35, '2022-06-01'),
(7, 'Pollo', 'POLL-1', 15000, 1, '2', 195, '2022-06-01'),
(8, 'Mantequilla', 'MAT-1', 5000, 1, '1', 120, '2022-06-01'),
(9, 'Harina', 'HAR-1', 15000, 10, '4', 1020, '2022-06-01'),
(19, 'productobien', 'hvb', 876, 78, '2', 545, '2022-06-02'),
(20, 'Patatas', 'PPT-1', 213123, 23, '1', 213, '2022-06-02'),
(21, 'Todorico', 'TOD-01', 3500, 1, '4', 100, '2022-06-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `Login_id` int(11) NOT NULL,
  `Login_password` varchar(30) NOT NULL,
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`Login_id`, `Login_password`, `User_id`) VALUES
(1, '26dfeed238d61d520668fbc0884699', 1),
(3, '3526a6ca88b91bb2bcfc0487b3c050', 3),
(4, 'desarollo123', 4),
(5, 'desarollo123', 6),
(7, '25f9e794323b453885f5181f1b624d', 7),
(40, '0192023a7bbd73250516f069df18b5', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `new_user`
--

CREATE TABLE `new_user` (
  `Nuser_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  `Nuser_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Nuser_hash` varchar(600) NOT NULL,
  `Nuser_state` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `new_user`
--

INSERT INTO `new_user` (`Nuser_id`, `User_id`, `Nuser_date`, `Nuser_hash`, `Nuser_state`) VALUES
(1, 38, '2021-01-04 23:18:20', 'd52c6fdbfd4add62539c8a60943cf5f8', 1),
(2, 39, '2021-01-04 23:35:43', 'cc93914e7224f7ef07adb81b8822594e', 1),
(3, 40, '2021-01-04 23:46:18', '0309d289b1f6efcc66efb1657ab35a0a', 1),
(4, 41, '2021-01-04 23:48:10', '70f970f1b0d087f6902047ef7488f8e9', 1),
(5, 42, '2021-01-04 23:49:40', 'c5073d0707f5ac6a2c036cad8d916599', 1),
(6, 43, '2021-01-04 23:57:54', '6b6eeb0abd711a5acbc85e866858603d', 1),
(7, 44, '2021-01-05 00:01:20', '81e08fedc25654b64d78f729fd66251f', 1),
(8, 0, '2022-06-03 06:23:27', '21bc0d93c831035f2e8a0c309b39c0c7', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notification`
--

CREATE TABLE `notification` (
  `Not_id` int(11) NOT NULL,
  `Form_consecutive` varchar(100) NOT NULL,
  `Not_message` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obligation`
--

CREATE TABLE `obligation` (
  `obligation_id` int(11) NOT NULL,
  `client_idmax` varchar(25) NOT NULL,
  `client_name` varchar(25) NOT NULL,
  `client_contract` varchar(25) NOT NULL,
  `Bank_id` int(11) NOT NULL,
  `credit_type_id` int(11) NOT NULL,
  `interesting_type_id` int(11) NOT NULL,
  `amortization_type_id` int(11) NOT NULL,
  `desembolso_date` date NOT NULL,
  `initial_value` double NOT NULL,
  `cuotes_number` int(5) NOT NULL,
  `residual_number` double NOT NULL DEFAULT 0,
  `dtf` float DEFAULT 0,
  `dtf_points` float DEFAULT 0,
  `ibr` float DEFAULT 0,
  `ibr_points` float DEFAULT 0,
  `fixed_rate` float DEFAULT 0,
  `Stat_id` int(11) NOT NULL,
  `obligation_cod` varchar(80) NOT NULL,
  `pay_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `obligation`
--

INSERT INTO `obligation` (`obligation_id`, `client_idmax`, `client_name`, `client_contract`, `Bank_id`, `credit_type_id`, `interesting_type_id`, `amortization_type_id`, `desembolso_date`, `initial_value`, `cuotes_number`, `residual_number`, `dtf`, `dtf_points`, `ibr`, `ibr_points`, `fixed_rate`, `Stat_id`, `obligation_cod`, `pay_date`) VALUES
(97, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 1, '2020-12-31', 10000000, 10, 10000, 5, 5, 0, 0, 0, 4, 'prueba1', '2020-12-06'),
(99, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 1, '2020-12-31', 464868, 88, 484, 8, 0, 0, 0, 0, 4, 'prueba2', '2020-12-24'),
(107, '805020457', ' CENTRO NET S.A.S', 'CCP0251', 1, 1, 1, 2, '2020-11-23', 111863176, 36, 57816550, 1.97, 2.25, 0, 0, 0, 3, '28331710-1', '2021-02-06'),
(111, '830100710', ' AKAMON S.A', 'CA000117', 1, 1, 1, 2, '2020-01-30', 987654321, 48, 123456789, 5, 5, 0, 0, 0, 3, 'Prueba-10', '2020-07-30'),
(114, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 2, '2019-01-29', 987654321, 54, 123456789, 8, 8, 0, 0, 0, 3, 'prueba-28', '2019-07-29'),
(115, '830102841', ' SEPTIC AND SANITARY SERV', 'CA006220', 1, 1, 1, 2, '2019-01-28', 987654321, 45, 78946554, 5, 5, 0, 0, 0, 2, 'prueba-27', '2019-05-28'),
(117, '900809713', ' LICUAS SUCURSAL COLOMBIA', 'CA011021', 1, 1, 1, 2, '2020-01-31', 987654321, 45, 45645646, 5, 5, 0, 0, 0, 3, 'prueba-31', '2020-05-31'),
(118, '900939798', ' RENTING AUTOMAYOR', 'CA000000', 1, 1, 1, 2, '2020-06-12', 200000000, 48, 20000000, 5, 5, 0, 0, 0, 3, 'prueba_provision', '2021-01-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pay_obligation`
--

CREATE TABLE `pay_obligation` (
  `pay_obligation_id` int(11) NOT NULL,
  `obligation_cod` varchar(80) NOT NULL,
  `pay_obligation_actual_cuote` int(11) NOT NULL,
  `pay_Date` date DEFAULT NULL,
  `pay_Dtf` float NOT NULL DEFAULT 0,
  `pay_Ibr` float NOT NULL DEFAULT 0,
  `pay_FixedRate` double NOT NULL DEFAULT 0,
  `pay_value` double NOT NULL,
  `pay_capital_value` double NOT NULL,
  `pay_residue` double NOT NULL,
  `Stat_id` int(11) NOT NULL,
  `pay_interesting_value` double NOT NULL,
  `pay_observation` varchar(500) NOT NULL,
  `pay_date_notif` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pay_obligation`
--

INSERT INTO `pay_obligation` (`pay_obligation_id`, `obligation_cod`, `pay_obligation_actual_cuote`, `pay_Date`, `pay_Dtf`, `pay_Ibr`, `pay_FixedRate`, `pay_value`, `pay_capital_value`, `pay_residue`, `Stat_id`, `pay_interesting_value`, `pay_observation`, `pay_date_notif`) VALUES
(185, 'prueba-1', 1, '2021-01-04', 1.97, 1.97, 0, 9289947, 8805562, 91194438, 8, 484385, 'pago 1 de 10', '2020-12-30'),
(187, '28331710-1', 1, '2020-12-30', 1.97, 1.97, 0, 1887271, 1501295, 110361881, 8, 385976, 'pago 1 de 10', '2020-12-30'),
(188, '28331710-1', 2, '2021-01-04', 1.97, 1.97, 0, 1882091, 1501295, 108860586, 8, 380796, 'asdfasdfasdf', '2020-12-30'),
(189, '28331710-1', 3, '2021-02-17', 2.01, 2.01, 0, 1880404, 1501295, 107359290, 8, 379109, '', '2021-01-06'),
(191, 'prueba-1', 2, NULL, 2.01, 2.01, 0, 9291850, 8847230, 82348465, 9, 444620, '', '2021-01-06'),
(211, 'prueba-28', 1, '2021-02-01', 4.62, 4.62, 0, 25834080, 16003658, 971650663, 8, 9830422, 'sadasdsadasdasd', '2019-02-28'),
(212, 'prueba-28', 2, '2021-02-01', 4.45, 4.45, 0, 25551263, 16003658, 955647005, 8, 9547605, 'gdhdfhgh', '2019-03-29'),
(213, 'prueba-28', 3, '2021-02-01', 4.59, 4.59, 0, 25494074, 16003658, 939643347, 8, 9490416, 'dfghdfh', '2019-04-29'),
(214, 'prueba-28', 4, '2021-02-18', 4.66, 4.66, 0, 25384296, 16003658, 923639689, 8, 9380638, '', '2019-05-29'),
(215, 'prueba-27', 1, '2021-02-01', 4.62, 4.62, 0, 27782153, 20193506, 967460815, 8, 7588648, 'sadfasdfasdfasdf', '2019-02-28'),
(216, 'prueba-27', 2, '2021-02-01', 4.45, 4.45, 0, 27500917, 20193506, 947267309, 8, 7307411, '', '2019-03-28'),
(217, 'prueba-27', 3, '2021-02-18', 4.5, 4.5, 0, 27384718, 20193506, 927073803, 8, 7191212, 'asdasdadadas', '2019-04-28'),
(224, 'prueba_provision', 1, '2021-02-10', 3.95, 3.95, 0, 5183763, 3750000, 196250000, 8, 2050000, 'hola linodo', '2020-07-12'),
(225, 'prueba_provision', 2, '2021-02-10', 3.46, 3.46, 0, 5082647, 3750000, 192500000, 8, 2000000, '123213123123', '2020-08-12'),
(226, 'Prueba-10', 1, '2021-02-18', 4.25, 4.25, 0, 25312392, 18004115, 969650206, 8, 7308277, '', '2020-06-30'),
(227, 'prueba_provision', 3, '2021-02-18', 3.1, 3.1, 0, 5003493, 3750000, 188750000, 8, 1253493, '', '2020-09-12'),
(228, 'prueba-31', 1, NULL, 4.66, 4.66, 0, 28552432, 20933526, 966720795, 9, 7618906, '', '2020-05-31'),
(229, 'prueba-28', 5, '2021-02-18', 4.25, 4.25, 0, 24941145, 16003658, 907636031, 8, 8937487, 'asdfasdf', '2019-06-29'),
(230, 'Prueba-10', 2, NULL, 3.71, 3.71, 0, 24775900, 18004115, 951646091, 9, 6771785, '', '2020-07-30'),
(231, 'prueba-28', 6, NULL, 3.71, 3.71, 0, 24418091, 16003658, 891632373, 9, 8414433, '', '2019-07-29'),
(232, 'prueba_provision', 4, '2021-02-22', 2.65, 2.65, 0, 4913045, 3750000, 185000000, 8, 1163045, 'prueba1', '2020-10-12'),
(233, 'prueba_provision', 5, '2021-02-22', 2.09, 2.09, 0, 4809052, 3750000, 181250000, 8, 1059052, 'dddsdsds', '2020-11-12'),
(234, 'prueba_provision', 6, '2021-02-22', 1.97, 1.97, 0, 4770555, 3750000, 177500000, 8, 1020555, '', '2020-12-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recovery_password`
--

CREATE TABLE `recovery_password` (
  `Recover_pass_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  `Recover_pass_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Recover_pass_hash` varchar(600) NOT NULL,
  `Recover_pass_state` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recovery_password`
--

INSERT INTO `recovery_password` (`Recover_pass_id`, `User_id`, `Recover_pass_date`, `Recover_pass_hash`, `Recover_pass_state`) VALUES
(1, 1, '2022-06-02 08:16:25', 'deb2993d0ca224b0ea6d02d64b76cc3c', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `Role_id` int(11) NOT NULL,
  `Role_name` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`Role_id`, `Role_name`) VALUES
(1, 'Root');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_group`
--

CREATE TABLE `security_group` (
  `Sgroup_id` int(11) NOT NULL,
  `Sgroup_name` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `security_group`
--

INSERT INTO `security_group` (`Sgroup_id`, `Sgroup_name`) VALUES
(1, 'Grupo1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_gxmxa`
--

CREATE TABLE `security_gxmxa` (
  `Sgxmxa_id` int(11) NOT NULL,
  `Sgxm_id` int(11) NOT NULL,
  `App_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_gxmxaxp`
--

CREATE TABLE `security_gxmxaxp` (
  `Sgxmxaxp_id` int(11) NOT NULL,
  `Sgxmxa_id` int(11) NOT NULL,
  `Per_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sell_product`
--

CREATE TABLE `sell_product` (
  `sell_product_id` int(11) NOT NULL,
  `sell_product_fk` int(11) NOT NULL,
  `sell_product_howmany` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sell_product`
--

INSERT INTO `sell_product` (`sell_product_id`, `sell_product_fk`, `sell_product_howmany`) VALUES
(1, 1, 2),
(2, 8, 2),
(3, 2, 100),
(4, 20, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

CREATE TABLE `status` (
  `Stat_id` int(11) NOT NULL,
  `Stat_name` varchar(30) NOT NULL,
  `Type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `status`
--

INSERT INTO `status` (`Stat_id`, `Stat_name`, `Type_id`) VALUES
(1, 'Desembolsado', 2),
(2, 'Borrador', 2),
(3, 'Activo', 2),
(4, 'Suspendido', 2),
(5, 'Anulado', 2),
(6, 'Activo', 1),
(7, 'Inactivo', 1),
(8, 'Pagado', 3),
(9, 'Por pagar', 3),
(10, 'No Pagado', 3),
(11, 'Revisado', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_type`
--

CREATE TABLE `status_type` (
  `Type_id` int(11) NOT NULL,
  `Type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `status_type`
--

INSERT INTO `status_type` (`Type_id`, `Type_name`) VALUES
(1, 'Usuario'),
(2, 'Obligación'),
(3, 'Pago Obligación'),
(4, 'Formularios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `User_id` int(11) NOT NULL,
  `User_name` varchar(80) NOT NULL,
  `User_identification` varchar(15) NOT NULL,
  `User_email` varchar(320) NOT NULL,
  `User_title` varchar(30) NOT NULL,
  `User_telephone` varchar(15) NOT NULL,
  `Stat_id` int(11) NOT NULL,
  `Role_id` int(11) NOT NULL,
  `Sgroup_id` int(11) NOT NULL,
  `Comp_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`User_id`, `User_name`, `User_identification`, `User_email`, `User_title`, `User_telephone`, `Stat_id`, `Role_id`, `Sgroup_id`, `Comp_id`) VALUES
(1, 'cristian malaver', '11111111111', 'cristianmalaver95@gmail.com', 'TI DESARROLLO 1', '3052344577', 6, 1, 1, NULL),
(2, 'Cristian Malaver', '1000000000', 'c.malaver@rentingautomayor.com', 'Diseñadora', '1234567', 6, 1, 1, NULL),
(3, 'Laura Grisales', '1030654234', 'd.casallas@sinapsistechnologies.com.co', 'Ingeniero de Software', '3054752261', 6, 1, 1, NULL),
(4, 'Desarrollo Sinapsis', '9005222222', 'developer.sinapsist123@gmail.com', 'Desarrollador', '1234567', 6, 1, 1, NULL),
(6, 'Desarrollo Sinapsis', '9005222252', 'developer.sinapsist2@gmail.com', 'Desarrollador', '1234567', 6, 1, 1, NULL),
(7, 'admin', '1111111', 'admin@admin.com', 'desarrolador', '12346578', 6, 1, 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `create_product`
--
ALTER TABLE `create_product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`Login_id`),
  ADD KEY `user_login` (`User_id`);

--
-- Indices de la tabla `new_user`
--
ALTER TABLE `new_user`
  ADD PRIMARY KEY (`Nuser_id`),
  ADD KEY `User_id` (`User_id`);

--
-- Indices de la tabla `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`Not_id`);

--
-- Indices de la tabla `obligation`
--
ALTER TABLE `obligation`
  ADD PRIMARY KEY (`obligation_id`),
  ADD UNIQUE KEY `obligation_cod` (`obligation_cod`),
  ADD KEY `obligation_bank` (`Bank_id`),
  ADD KEY `obligation_credit_type` (`credit_type_id`),
  ADD KEY `obligation_interesting_type` (`interesting_type_id`),
  ADD KEY `obligation_amortization_type` (`amortization_type_id`),
  ADD KEY `obligation_status_id` (`Stat_id`);

--
-- Indices de la tabla `pay_obligation`
--
ALTER TABLE `pay_obligation`
  ADD PRIMARY KEY (`pay_obligation_id`),
  ADD KEY `obligation_id` (`obligation_cod`),
  ADD KEY `pay_obligation_status` (`Stat_id`);

--
-- Indices de la tabla `recovery_password`
--
ALTER TABLE `recovery_password`
  ADD PRIMARY KEY (`Recover_pass_id`),
  ADD KEY `recovery_password_user` (`User_id`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`Role_id`);

--
-- Indices de la tabla `security_group`
--
ALTER TABLE `security_group`
  ADD PRIMARY KEY (`Sgroup_id`);

--
-- Indices de la tabla `security_gxmxa`
--
ALTER TABLE `security_gxmxa`
  ADD PRIMARY KEY (`Sgxmxa_id`),
  ADD KEY `Sgxm_id` (`Sgxm_id`),
  ADD KEY `App_id` (`App_id`);

--
-- Indices de la tabla `security_gxmxaxp`
--
ALTER TABLE `security_gxmxaxp`
  ADD PRIMARY KEY (`Sgxmxaxp_id`),
  ADD KEY `Sgxmxa_id` (`Sgxmxa_id`),
  ADD KEY `Per_id` (`Per_id`);

--
-- Indices de la tabla `sell_product`
--
ALTER TABLE `sell_product`
  ADD PRIMARY KEY (`sell_product_id`),
  ADD KEY `sell_product_fk` (`sell_product_fk`);

--
-- Indices de la tabla `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`Stat_id`),
  ADD KEY `type_status` (`Type_id`);

--
-- Indices de la tabla `status_type`
--
ALTER TABLE `status_type`
  ADD PRIMARY KEY (`Type_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`User_id`),
  ADD KEY `user_status` (`Stat_id`),
  ADD KEY `Role_id` (`Role_id`),
  ADD KEY `Sgroup_id` (`Sgroup_id`),
  ADD KEY `Comp_id` (`Comp_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `create_product`
--
ALTER TABLE `create_product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `Login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `new_user`
--
ALTER TABLE `new_user`
  MODIFY `Nuser_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `notification`
--
ALTER TABLE `notification`
  MODIFY `Not_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `obligation`
--
ALTER TABLE `obligation`
  MODIFY `obligation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `pay_obligation`
--
ALTER TABLE `pay_obligation`
  MODIFY `pay_obligation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT de la tabla `sell_product`
--
ALTER TABLE `sell_product`
  MODIFY `sell_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sell_product`
--
ALTER TABLE `sell_product`
  ADD CONSTRAINT `sell_product_ibfk_1` FOREIGN KEY (`sell_product_fk`) REFERENCES `create_product` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
