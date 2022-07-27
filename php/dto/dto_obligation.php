<?php 
#Author: cristian malaver
#Date: 1/6/2022
#Description : Is DTO obligation

class DtoObligation
{
    private $user;
    private $password;

    private $obligation_id;
    private $client_idmax;
    private $client_contract;
    private $category;
    private $credit_type_id;
    private $obligation_cod;
    private $obligation_antigua;

    public function __construct()
    {
        $this->user = "MAXADMIN";
        $this->password = "Renting123*";
    }
    
    public function __setObligation(
    $id,
    $code,
    $client_idmax,
    $client_contract,
    $category,
    $credit_type_id,
    $obligation_antigua
    )
    {
        $this->obligation_id = $id;
        $this->client_idmax = $client_idmax;
        $this->client_contract = $client_contract;
        $this->category = $category;
        $this->credit_type_id = $credit_type_id;
        $this->obligation_cod = $code;
        $this->obligation_antigua = $obligation_antigua;
        
    }

    public function __getObligation()
    {
        $objObligation = new DtoObligation();
        $objObligation->__getPassword();
        $objObligation->__getObligation_id();
        $objObligation->__getClient_idmax();
        $objObligation->__getClient_contract();
        $objObligation->__getcategory();
        $objObligation->__getCredit_type_id();
        $objObligation->__getObligation_cod();
        $objObligation->__getObligation_antigua();
        

        return $objObligation;
    }


    //SET OBLIGATION
    
    public function __setCod($code)
    {
        $this->obligation_cod = $code;
    }
 
    public function __setName($name)
    {
        $this->Bank_name = $name;
    }
    public function __getUser()
    {
        return $this->user;
    }

    public function __getPassword()
    {
        return $this->password;
    }

    /////////////////////////////////////////////////////
    public function __getObligation_id()
    {
        return $this->obligation_id;
    }
    public function __getClient_idmax()
    {
        return $this->client_idmax;
    }
    
    public function __getClient_contract()
    {
        return $this->client_contract;
    }

    public function __getcategory()
    {
        return $this->category;
    }
    public function __getCredit_type_id()
    {
        return $this->credit_type_id;
    }
    public function __getObligation_cod()
    {
        return $this->obligation_cod;
    }
    public function __getObligation_antigua()
    {
        return $this->obligation_antigua;
    }

    
}

