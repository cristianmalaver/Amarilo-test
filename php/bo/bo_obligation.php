<?php
#Author: cristian malaver
#Date: 1/6/2022
#Description : Is BO obligation
include "../dto/dto_obligation.php";
include "../dao/dao_obligation.php";
header("Content-type: application/json; charset=utf-8");
class BoObligation
{
  private $objObligation;
  private $objDao;
  private $intValidate;

  public function __construct()
  {
    $this->objObligation = new DtoObligation();
    $this->objDao = new DaoObligation();
  }

  #Description: Function for create a new obligation
  public function newObligation(
    $id,
    $code,
    $client_idmax,
    $client_contract,
    $category,
    $credit_type_id,
    $obligation_antigua
  ) {
    try {
      $this->objObligation->__setObligation(
      $id,
      $code,
      $client_idmax,
      $client_contract,
      $category,
      $credit_type_id,
      $obligation_antigua
      );
      $intValidate = $this->objDao->newObligation($this->objObligation);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function for update to susp a new obligation
  public function changeStatusObligation($obligationCod)
  {
    try {
      $this->objObligation->__setCod($obligationCod);
      $intValidate = $this->objDao->changeStatusObligation($this->objObligation);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function for delete a new obligation
  public function deleteObligation($obligationCod)
  {
    try {
      $this->objObligation->__setCod($obligationCod);
      $intValidate = $this->objDao->deleteObligation($this->objObligation);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function list Bank
  public function selectBank()
  {
    try {
      $intValidate = $this->objDao->selectBank();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function list type obligation
  public function getTypeObligation()
  {
    try {
      $intValidate = $this->objDao->selectTypeObligation();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function list type interes
  public function getTypeInteres()
  {
    try {
      $intValidate = $this->objDao->selectTypeInteres();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function list method of amortization
  public function getMethodAmortization()
  {
    try {
      $intValidate = $this->objDao->selectMethodAmortization();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }

  #Description: Function select client to maximo
  public function selectClientMaximo()
  {
    try {
      $user = $this->objObligation->__getUser();
      $password = $this->objObligation->__getPassword();
      $intValidate = $this->objDao->selectClientMaximo($user, $password);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function select client to maximo
  public function selectContractMaximo($nit)
  {
    try {
      $user = $this->objObligation->__getUser();
      $password = $this->objObligation->__getPassword();
      $intValidate = $this->objDao->selectContractMaximo($user, $password, $nit);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }


  #Description: Function get obligation 
  public function getObligation()
  {
    try {
      $intValidate = $this->objDao->getObligation();
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
}


$obj = new BoObligation();
/// We get the json sent
$getData = file_get_contents('php://input');
$data = json_decode($getData);

/**********CREATE ************/
if (isset($data->POST)) {
  if ($data->POST == "POST") {
    echo $obj->newObligation(
      $data->obligation_id,
      $data->obligation_cod,
      $data->client_idmax,
      $data->client_contract,
      $data->category,
      $data->credit_type_id,
      $data->obligation_antigua
    );
  }
  if ($data->POST == "POST_CHANGE_STATUS") {
    echo $obj->changeStatusObligation($data->obligation_cod);
  }
  if ($data->POST == "POST_DELETE") {
    echo $obj->deleteObligation($data->obligation_cod);
  }
}

/**********READ AND CONSULT ************/
if (isset($data->GET)) {
  if ($data->GET == "GET") {
    echo $obj->selectObligation($data->obligation_cod);
  }
  if ($data->GET == "GET_LIST_BANK") {
    echo $obj->selectBank();
  }
  if ($data->GET == "GET_CLIENT_MAXIMO") {
    echo $obj->selectClientMaximo();
  }
  if ($data->GET == "GET_CLIENT_CONTRACT_MAXIMO") {
    echo $obj->selectContractMaximo($data->nit);
  }
  if ($data->GET == "GET_OBLIGATION") {

    echo $obj->getObligation();
  }
  if ($data->GET == "GET_OBLIGATION_SEARCH") {

    echo $obj->getObligationSearch($data->searchObligation);
  }
  if ($data->GET == "GET_TYPE_OBLIGATION") {
    echo $obj->getTypeObligation();
  }
  if ($data->GET == "GET_TYPE_INTERES") {
    echo $obj->getTypeInteres();
  }
  if ($data->GET == "GET_METHOD_AMORTIZATION") {
    echo $obj->getMethodAmortization();
  }

}
/**********************/
//echo $obj->newObligation(0,'prueba2','PRU-1',120000,3,'Aceites',3); 
//echo $obj->selectObligation('28331710-1'); 
//echo $obj->deleteObligation('sdfsdf'); 
//echo $obj->updateObligation('11141346111', 'Holas6456asa', 'CCP1dfsd1111', 'Holdfsa', '2', '2', '2', '2', '2020-08-15', '111121121', '41', '711928700', '0', '0',"3" ,"2", "0", 3,'WDQWD34'); 
//echo $obj->changeStatusObligation('0028005401'); 
