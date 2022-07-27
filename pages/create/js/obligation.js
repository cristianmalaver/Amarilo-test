//**Function add Obligation **/
//Author: Cristoian malaver para konecta
//Date: 1/6/2022
//Description : send data create obligation
function setDataObligation(dataSetObligation) {
    try {
        loadPageView();
        dataSetObligation = '{"POST":"POST",' + dataSetObligation + '}';
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                //debugger
                console.log(xhttp.responseText);
                if (xhttp.responseText != 0) {
                    
                    enableScroll();
                    viewModal("customerModal", 1);
                    createModalAlert("Operación realizada con éxito", 1, 3000);
                    loadView();
                } else {
                    enableScroll();
                    createModalAlert("Valide la información", 3, 4000);
                   // debugger;
                }
            }
        }
        xhttp.send(dataSetObligation);
    } catch (error) {
        enableScroll();
        console.error(error);

    }
}
//Description : send data get table  obligation
function getDataObligation(table, dataSetObligation, typeSend) {
    try {
        loadPageView();
        var xhttp = new XMLHttpRequest();
        var arrayCell = new Array("Nombre", "apellido","roles", "estado civil","tiene hermanos","fecha nacimiento","Acciones");
        var JsonData;
        var tableAmortization;

        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                if (xhttp.responseText != "") {
                    var jsonObj = JSON.parse(xhttp.responseText);

                    if (jsonObj.length != 0) {
                        enableScroll();
                        if (typeSend == 2 || typeSend == 1) {
                            tableObligation = new Table(table, arrayCell, jsonObj);
                            tableObligation.createTableObligations();
                            //console.log(jsonObj);
                        } else if (typeSend == 0) {
                            setDataForm(jsonObj);
                            viewModal('customerModal', 0);
                        } else if (typeSend == 3) {
                            tableAmortization = new TableAmortization(table, jsonObj,0);
                            tableAmortization.getdatajson();
                            viewModal('AmortizationModal', 0);
                            //console.log(tableAmortization.getdatajson());
                        }
                        else if (typeSend == 4 ) {
                           
                            getDataObligation("tableObligation", "", 2);
                            
                           
                        }
                        else if (typeSend == 5 ) {
                           
                            getDataObligation("tableObligation", "", 2);
                            
                           
                        }
                    } else {
                        enableScroll();
                    }
                }
            }
        };
        if (typeSend == 0) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
        }
        if (typeSend == 1) {
            JsonData = '{"GET":"GET_OBLIGATION_SEARCH","searchObligation":"' + dataSetObligation + '"}';
        }

        if (typeSend == 2) {
            JsonData = '{"GET":"GET_OBLIGATION"}';
            

        }
        if (typeSend == 3) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
            //console.log(JsonData);
            
        }
        if (typeSend == 4) {
            JsonData = '{"POST":"POST_CHANGE_STATUS","obligation_cod":"' + dataSetObligation + '"}';
        }
        
        if (typeSend == 5) {
            JsonData = '{"POST":"POST_DELETE","obligation_cod":"' + dataSetObligation + '"}';
        }
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
        enableScroll();
    }
}
//**********************GED EDIT****************************//
function getDataEdit(code) {
    //getListBank("Bank_id");
    getListTypeCredit("credit_type_id");
    getListTypeInteres("interesting_type_id");
    getListMethodAmortization("amortization_type_id");
    getDataObligation("", code, 0);

}
//**********************END CLIENT****************************//

//**********************GED DELETE****************************//
function getDelete(code) {
    let r = confirm("Desea borrar el registro con CODIGO :  " + code);
    if (r == true) {
        getDataObligation("", code, 5);
      }   
        }
    
    //**********************END CLIENT****************************//
    

//Description : function load view page 
function loadView() {
   
    loadPageView();
    getDataObligation("tableObligation", "", 2);
    getActionStorage();
}
//************ LOAD VIEW STORAGE ******************/
function getActionStorage() {
    let obj = new StoragePage();
    let json = JSON.parse(obj.getStorageLogin());
    0
    if (json !== null) {
        getDataUserId(json[0]["User_id"]);
    } else {
        locationLogin();
    }
}
//************GET DATA FORM**************//
function sendData(idForm, e) {
    let jSon = "";

    if (validatorForm(idForm)) {
        jSon = getDataForm(idForm);
        console.log(jSon);
        //debugger;
        setDataObligation(jSon);
    } else {
        createModalAlert("Error al realizar el registro", 4, 4000);
    }
    e.preventDefault();
}

function newObligation() {
    document.getElementById('obligation_id').value = "0";
  
}

