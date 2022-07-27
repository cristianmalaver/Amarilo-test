<?php 
#Author: ristian Malaver
#Date: 30/10/2020
#Description : Is DAO compra de productos
include "../class/connectionDB.php";
class DaoPayObligation


{
  private $objConntion;
  private $arrayResult;
  private $intValidatio;

  public function __construct()
  {
    $this->objConntion = new Connection();
    $this->arrayResult = array();
    $this->intValidatio;
  }
 
  public function getPayObligation()
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_pay_obligation()")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }
  public function get_provision()
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_provision()")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }

  public function getPayObligation_pays()
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_pay_obligation_pays()")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }
  public function getObligationSearch($data)
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("SELECT PA.obligation_cod,client_name,BA.Bank_name,OB.initial_value,OB.cuotes_number,PA.pay_obligation_actual_cuote,OB.pay_date AS pay_Date,PA.pay_value,St.Stat_name
        FROM pay_obligation PA
        INNER JOIN status ST
        ON PA.Stat_id = ST.Stat_id
        INNER JOIN obligation OB
        ON PA.obligation_cod = OB.obligation_cod
        INNER JOIN bank BA
        ON OB.Bank_id=BA.Bank_id 
        WHERE client_name LIKE '%$data%' OR PA.obligation_cod LIKE '%$data%' OR OB.pay_date LIKE '%$data%' AND PA.Stat_id = 9
        ORDER BY OB.pay_date ASC;")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }
  #Description: Function for create a new pay obligation
  public function newPayObligation($objPayObligation)
  {
    try {
   
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
      if ($con != null) {
        $dataPayObligation = "" .
          $objPayObligation->__getPay_payObligation_id() . ",'" .
          $objPayObligation->__getPay_obligation_cod() . "'," .
          $objPayObligation->__getPay_obligation_actual_cuote() . "," .
//          $objPayObligation->__getPay_Date() . "," .
          $objPayObligation->__getPay_Dtf() . "," .
          $objPayObligation->__getPay_Ibr() . "," .
          $objPayObligation->__getPay_FixedRate() . "," .
          $objPayObligation->__getPay_value() . "," .
          $objPayObligation->__getPay_capital_value() . "," .
          $objPayObligation->__getPay_residue() . "," .
//          $objPayObligation->__getPay_Stat_id() . "," .
          $objPayObligation->__getPay_interesting_value() . ",'" .
          $objPayObligation->__getPay_pay_observation() . "','" .
          $objPayObligation->__getPay_Date() . "'";
          //echo ('CALL sp_pay_obligation_insert_update('. $dataPayObligation .')');
         if ($con->query('CALL sp_pay_obligation_insert_update('. $dataPayObligation .')')) {
          $this->intValidatio = 1;
        } else {
          $this->intValidatio = 0;
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }
  #Description: Function for update obligation
  public function updateObligation($objObligation)
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
      if ($con != null) {
        $dataObligation = "client_idmax='".$objObligation->__getClient_idmax() ."',
        client_name='" .$objObligation->__getClient_name() ."',
        client_contract='".$objObligation->__getClient_contract()."',
        client_contract_name='".$objObligation->__getClient_contract_name()."',
        Bank_id='".$objObligation->__getBank_id()."',
        credit_type_id='".$objObligation->__getCredit_type_id()."',
        interesting_type_id='".$objObligation->__getInteresting_type_id()."',
        amortization_type_id='".$objObligation->__getAmortization_type_id()."',
        desembolso_date='".$objObligation->__getDesembolso_date()."',
        initial_value='".$objObligation->__getInitial_value()."',
        cuotes_number='".$objObligation->__getCuotes_number()."',
        residual_number='".$objObligation->__getResidual_number()."',
        dtf='".$objObligation->__getDtf()."',
        dtf_points='".$objObligation->__getDtf_points()."',
        ibr='".$objObligation->__getIbr()."',
        ibr_points='".$objObligation->__getIbr_points()."',
        tasafija='".$objObligation->__getTasafija()."',
        Stat_id='".$objObligation->__getStat_id(). "'
        WHERE obligation_cod ='".$objObligation->__getObligation_cod();

        if ($con->query(  "UPDATE obligation SET ".$dataObligation."'" )) 
         
         { $this->intValidatio = 1;
        } else {
          $this->intValidatio = 0;
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }
  public function selectObligation($code)
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_pay_obligation_select_amortization ('$code')")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }

  public function selectObligationToPay($code)
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_pay_obligation_to_pay ('$code')")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }

  public function selectObligationToNotification()
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_pay_obligation_to_notification ()")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }

  public function get_data_provision($obligation_cod)
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_data_provision('$obligation_cod')")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }
  #Description: Function for create a new pay obligation
  public function postProvison($objPayObligation)
  {
    try {
   
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
      if ($con != null) {
        $dataPostProvision = "'" .
          $objPayObligation->__getPay_obligation_cod() . "','" .
          $objPayObligation->__getProvi_inicialDate() . "','" .
          $objPayObligation->__getProvi_lastDate() . "'," .
          $objPayObligation->__getProvi_interesting() . "," .
          $objPayObligation->__getProvi_actualMonth() . "," .
          $objPayObligation->__getProvi_afterMonth() . "," .
          $objPayObligation->__getTotal_provision() . ",'" .
          $objPayObligation->__getProvi_month() . "'";
          //echo ('CALL sp_provision_insert_update('. $dataPostProvision .')');
         if ($con->query('CALL sp_provision_insert_update('. $dataPostProvision .')')) {
          $this->intValidatio = 1;
        } else {
          $this->intValidatio = 0;
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return $this->intValidatio;
  }

  public function getInterest()
  {
    try {
      $con = $this->objConntion->connect();
      $con->query("SET NAMES 'utf8'");
    
      if ($con != null) {
        if ($result = $con->query("CALL sp_getInterest()")) {

          while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $this->arrayResult[] = $row;
          };
          mysqli_free_result($result);
        }
      }
      $con->close();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $this->intValidatio = 0;
    }
    return json_encode($this->arrayResult);
  }

}