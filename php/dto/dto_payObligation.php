<?php 
#Author: cristian malaver
#Date: 30/10/2020
#Description : Is DTO obligation

class DtoPayObligation
{
    private $Bank_name;
    private $user;
    private $password;

    private $pay_obligation_id;
    private $obligation_cod;
    private $pay_obligation_actual_cuote;
    private $pay_Date;
    private $pay_Dtf;
    private $pay_Ibr;
    private $pay_FixedRate;
    private $pay_value;
    private $pay_capital_value;
    private $pay_residue;
    private $Stat_id;
    private $pay_interesting_value;
    private $pay_observation;

    //private $obligation_cod;
    private $provi_inicialDate;
    private $provi_lastDate;
    private $provi_interesting;
    private $provi_actualMonth;
    private $provi_afterMonth;
    private $total_provision;
    private $provi_month;


    public function __construct()
    {
        $this->user = "MAXADMIN";
        $this->password = "Renting123*";
    }
    
    public function __setpayObligation(

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
    $pay_Date
    )
    {   
        
        $this->pay_obligation_id = $pay_obligation_id;
        $this->obligation_cod = $obligation_cod;
        $this->pay_obligation_actual_cuote = $actual_cuote;
    //    $this->pay_Date = $pay_date;
        $this->pay_Dtf = $pay_dtf;
        $this->pay_Ibr = $pay_ibr;
        $this->pay_FixedRate = $pay_FixedRate;
        $this->pay_value = $pay_value;
        $this->pay_capital_value = $pay_capital_value;
        $this->pay_residue = $pay_residue;
      //  $this->Stat_id = $Stat_id;
        $this->pay_interesting_value = $pay_interesting_value;
        $this->pay_observation = $pay_observation;
        $this->pay_Date = $pay_Date;
    }


    public function __setPostProvison(
   
        $obligation_cod,
        $provi_inicialDate,
        $provi_lastDate,
        $provi_interesting,
        $provi_actualMonth,
        $provi_afterMonth,
        $total_provision,
        $provi_month
        
        )
        {   
            
            $this->obligation_cod = $obligation_cod;
            $this->provi_inicialDate = $provi_inicialDate;
            $this->provi_lastDate = $provi_lastDate;
            $this->provi_interesting = $provi_interesting;
            $this->provi_actualMonth = $provi_actualMonth;
            $this->provi_afterMonth = $provi_afterMonth;
            $this->total_provision = $total_provision;
            $this->provi_month = $provi_month;
    
       
        }

        public function __getProvison()
        {
            $objPayObligation = new DtoPayObligation();
               
            $objPayObligation->__getPay_obligation_cod();
            $objPayObligation->__getProvi_inicialDate();
            $objPayObligation->__getProvi_lastDate();
            $objPayObligation->__getProvi_interesting();
            $objPayObligation->__getProvi_actualMonth();
            $objPayObligation->__getProvi_afterMonth();
            $objPayObligation->__getTotal_provision();
            $objPayObligation->__getProvi_month();      
            
    
            return $objPayObligation;
        }

    public function __getPayObligation()
    {
        $objPayObligation = new DtoPayObligation();
           
        $objPayObligation->__getPay_payObligation_id();
        $objPayObligation->__getPay_obligation_cod();
        $objPayObligation->__getPay_obligation_actual_cuote();
        $objPayObligation->__getPay_Date();
        $objPayObligation->__getPay_Dtf();
        $objPayObligation->__getPay_Ibr();
        $objPayObligation->__getPay_FixedRate();
        $objPayObligation->__getPay_value();
        $objPayObligation->__getPay_capital_value();
        $objPayObligation->__getPay_residue();
        $objPayObligation->__getPay_Stat_id();
        $objPayObligation->__getPay_interesting_value();
        $objPayObligation->__getPay_pay_observation();
        
        

        return $objPayObligation;
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
    //GET OBLIGATION
    public function __getPay_payObligation_id()
    {
        return $this->pay_obligation_id;
    } 
    public function __getPay_obligation_cod()
    {
        return $this->obligation_cod;
    } 
    public function __getPay_obligation_actual_cuote()
    {
        return $this->pay_obligation_actual_cuote;
    } 
    public function __getPay_Date()
    {
        return $this->pay_Date;
    } 
    public function __getPay_Dtf()
    {
        return $this->pay_Dtf;
    }
     public function __getPay_Ibr()
    {
        return $this->pay_Ibr;
    } 
    public function __getPay_FixedRate()
    {
        return $this->pay_FixedRate;
    } 
    public function __getPay_value()
    {
        return $this->pay_value;
    }
     public function __getPay_capital_value()
    {
        return $this->pay_capital_value;
    } 
    public function __getPay_residue()
    {
        return $this->pay_residue;
    } 
    public function __getPay_Stat_id()
    {
        return $this->Stat_id;
    }
    public function __getPay_interesting_value()
    {
        return $this->pay_interesting_value;
    }
    public function __getPay_pay_observation()
    {
        return $this->pay_observation;
    }
    public function __getUser()
    {
        return $this->user;
    }
    public function __getBankName()
    {
        return $this->Bank_name;
    }
    public function __getPassword()
    {
        return $this->password;
    }
    //dto provisoin
    public function __getProvi_inicialDate()
    {
        return $this->provi_inicialDate;
    } 
    public function __getProvi_lastDate()
    {
        return $this->provi_lastDate;
    } 
    public function __getProvi_interesting()
    {
        return $this->provi_interesting;
    }
     public function __getProvi_actualMonth()
    {
        return $this->provi_actualMonth;
    } 
    public function __getProvi_afterMonth()
    {
        return $this->provi_afterMonth;
    } 
    public function __getTotal_provision()
    {
        return $this->total_provision;
    }
     public function __getProvi_month()
    {
        return $this->provi_month;
    } 

}

