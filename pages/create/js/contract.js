var dateSend = moment('2000-01-01');
dateSend = dateSend.format('YYYY-MM-DD');

function viewContent(id) {
  var obj = "content_" + id;
  var listType = document.getElementById(obj);
  for (i = 1; i <= 3; i++) {
    let obj1 = "content_" + i;
    document.getElementById(obj1).style.display = "none";
  }
  listType.style.display = "block";
}
function view(id) {
  if (id == 2) {
    document.getElementById("residual").style.display = "none";
    var residual_number = document.getElementById("residual_number");
    residual_number.value = 0;
  } else{
    document.getElementById("residual").style.display = "block";
  }
}

//funcion para sumar un mes a el campo pay_date
function payChangeDate(value) {

  var pay_date = document.getElementById("pay_date");
  var fechaActual = value;
  var fecha_a_sumar = moment(fechaActual);
  fecha_a_sumar.add(1, 'month');
  var fecha_a_un_mes = fecha_a_sumar.format('YYYY-MM-DD');
  pay_date.value = fecha_a_un_mes;
  //var days = workingDays(fechaActual, fecha_a_un_mes);
  //console.log(days);
}

function workingDays(dateFrom, dateTo) {
  var from = moment(dateFrom, 'YYYY/MM/DD'),
    to = moment(dateTo, 'YYYY/MM/DD'),
    days = 0;

  while (!from.isAfter(to)) {
    // Si no es sabado ni domingo
    if (from.isoWeekday() !== 6 && from.isoWeekday() !== 7) {
      days++;
    }
    from.add(1, 'days');
  }
  return days;

}


function viewAntiguo(id) {
  //alert(id);
  if (id == 1) {
    document.getElementById("antiguo").style.display = "block";
  } else
  {
  document.getElementById("antiguo").style.display = "none";
  var initial_value_initial = document.getElementById("initial_value_initial");
  initial_value_initial.value = 0;
  var cuotes_number_initial = document.getElementById("cuotes_number_initial");
  cuotes_number_initial.value = 0;
  var initial_value_initial = document.getElementById("initial_value_format_initial");
  initial_value_format_initial.value = 0;
  var desembolso_date_initial = document.getElementById("desembolso_date_initial");
  desembolso_date_initial.value = dateSend;
  
}
}
