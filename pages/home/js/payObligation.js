//Description : function load view page 
function loadView() {

    loadPageView();
    getLocationCode();;
    getActionStorage();
}

function getLocationCode() {
    var getUrl = window.location.href;
    var getCode = getUrl.indexOf("?");
    var arrayJson = getUrl.substring(getCode + 1, getUrl.length).split(":");

   
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
function closeSession() {
    let obj = new StoragePage();
    obj.removeStorageUser();
    window.location.assign("../login/login.html");

}

