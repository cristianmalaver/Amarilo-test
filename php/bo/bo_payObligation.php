<?php
#Author: cristian malaver
#Date: 1/6/2022
#Description : Is BO obligation
include "../dto/dto_payObligation.php";
include "../dao/dao_payObligation.php";
header("Content-type: application/json; charset=utf-8");
class BoPayObligation
{
  private $objPayObligation;
  private $objDao;
  private $intValidate;

  public function __construct()
  {
    $this->objPayObligation = new DtoPayObligation();
    $this->objDao = new DaoPayObligation();
  }

  #Description: Function for create a new pay obligation
  public function newPayObligation(
    $pay_obligation_id,
    $obligation_cod, 
    $actual_cuote,
  //  $pay_date,
    $pay_dtf,
    $pay_ibr,
    $pay_FixedRate,
    $pay_value,
    $pay_capital_value,
    $pay_residue,
  //  $Stat_id,
    $pay_interesting_value,
    $pay_observation,
    $pay_date
  ) {
    try {
      $this->objPayObligation->__setPayObligation(
        $pay_obligation_id,
        $obligation_cod,
        $actual_cuote,
    //    $pay_date,
        $pay_dtf,
        $pay_ibr,
        $pay_FixedRate,
        $pay_value,
        $pay_capital_value,
        $pay_residue,
    //    $Stat_id,
        $pay_interesting_value,
        $pay_observation,
        $pay_date
      );
      $intValidate = $this->objDao->newPayObligation($this->objPayObligation);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function for create a provision
  public function postProvison(
    $obligation_cod, 
    $provi_inicialDate,
    $provi_lastDate,
    $provi_interesting,
    $provi_actualMonth,
    $provi_afterMonth,
    $total_provision,
    $pay_Date
  ) {
    try {
      $this->objPayObligation->__setPostProvison(
        $obligation_cod, 
        $provi_inicialDate,
        $provi_lastDate,
        $provi_interesting,
        $provi_actualMonth,
        $provi_afterMonth,
        $total_provision,
        $pay_Date
      );
      $intValidate = $this->objDao->postProvison($this->objPayObligation);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function get pay obligation 
  public function getPayObligation()
  {
    try {
      $intValidate = $this->objDao->getPayObligation();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function get provision 
  public function get_provision()
  {
    try {
      $intValidate = $this->objDao->get_provision();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
   #Description: Function get pay obligation 
   public function getPayObligation_pays()
   {
     try {
       $intValidate = $this->objDao->getPayObligation_pays();
     } catch (Exception $e) {
       echo 'Exception captured: ', $e->getMessage(), "\n";
       $intValidate = 0;
     }
     return $intValidate;
   }
   #Description: Function get pay obligation 
   public function getInterest()
   {
     try {
       $intValidate = $this->objDao->getInterest();
     } catch (Exception $e) {
       echo 'Exception captured: ', $e->getMessage(), "\n";
       $intValidate = 0;
     }
     return $intValidate;
   }
  #Description: Function get obligation 
  public function getObligationSearch($dataSearch)
  {
    try {
      $intValidate = $this->objDao->getObligationSearch($dataSearch);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
 #Description: Function get obligation 
 public function selectObligation($dataCode)
 {
   try {
     $intValidate = $this->objDao->selectObligation($dataCode);
   } catch (Exception $e) {
     echo 'Exception captured: ', $e->getMessage(), "\n";
     $intValidate = 0;
   }
   return $intValidate;
 }
 #Description: Function get obligation 
 public function selectObligationToPay($dataCode)
 {
   try {
     $intValidate = $this->objDao->selectObligationToPay($dataCode);
   } catch (Exception $e) {
     echo 'Exception captured: ', $e->getMessage(), "\n";
     $intValidate = 0;
   }
   return $intValidate;
 }
  #Description: Function get obligation to pay a 5 days started in date now
  public function selectObligationToNotification()
  {
    try {
      $intValidate = $this->objDao->selectObligationToNotification();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function to get date + 1 month provision 
  public function get_data_provision($obligation_cod)
  {
    try {
      $intValidate = $this->objDao->get_data_provision($obligation_cod);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
}


$obj = new BoPayObligation();
/// We get the json sent
$getData = file_get_contents('php://input');
$data = json_decode($getData);

/**********CREATE ************/
if (isset($data->POST)) {
  if ($data->POST == "POST") {
    echo $obj->newPayObligation(
      $data->pay_obligation_id,
      $data->obligation_cod,
      $data->pay_obligation_actual_cuote,
   //   $data->pay_Date,
      $data->pay_Dtf,
      $data->pay_Ibr,
      $data->pay_FixedRate,
      $data->pay_value,
      $data->pay_capital_value,
      $data->pay_residue,
   //   $data->Stat_id,
      $data->pay_interesting_value,
      $data->pay_observation,
      $data->pay_Date
    );
  }
  
  if ($data->POST == "POST_PROVISION") {
    echo $obj->postProvison(
      $data->obligation_cod,
      $data->provi_inicialDate,
      $data->provi_lastDate,
      $data->provi_interesting,
      $data->provi_actualMonth,
      $data->provi_afterMonth,
      $data->total_provision,
      $data->pay_Date
    );
  }

  /*
  if ($data->POST == "POST_DELETE") {
    echo $obj->deleteObligation($data->obligationCod);
  }*/
}

/**********READ AND CONSULT ************/
if (isset($data->GET)) {

  if ($data->GET == "GET_PAY_OBLIGATION") {

    echo $obj->getPayObligation();
  }
  if ($data->GET == "GET_PAY_OBLIGATION_PAYS") {

    echo $obj->getPayObligation_pays();
  }
  if ($data->GET == "GET") {
    echo $obj->selectObligation($data->obligation_cod);
  }
  if ($data->GET == "GET2") {
    echo $obj->selectObligationToPay($data->obligation_cod);
  }
  if ($data->GET == "GETNOT") {
    echo $obj->selectObligationToNotification();
  }
  if ($data->GET == "GET_OBLIGATION_SEARCH") {

    echo $obj->getObligationSearch($data->searchObligation);
  }
  if ($data->GET == "GET_PROVISION") {

    echo $obj->get_provision();
  }
  if ($data->GET == "PROVISION") {

    echo $obj->get_data_provision($data->obligation_cod);
  }
  if ($data->GET == "GET_INTEREST") {

    echo $obj->getInterest();
  }
  

}
/**********************/
//echo $obj->get_data_provision('prueba_provision');
//echo $obj->newPayObligation(22,'prueba1',1,3.5,0.4,0.9,100000,20000,2000000,343222,'esto es una prueba212121','2020-11-11');
//echo $obj->postProvison('prueba1','2020-10-13','2020-11-12',1163045,465218,683963,1149181,'October');
//echo $obj->newPayObligation(0,'28331710-1',1,1.97,1.97,0,1887271,1501295,110361881,385976,'','2020-12-29');
