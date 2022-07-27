//**************************//
//Author: Cristian malaver
//Date: 24/11/2020
//Description : Class Table for amortization method
//************CLASS TABLE**************//

class TableAmortization {
    Bank_id;
    amortization_type_id;
    credit_type_id;
    cuotes_number;
    desembolso_date;
    dtf;
    dtf_points;
    fixed_rate;
    ibr;
    ibr_points;
    initial_value;
    interesting_type_id;
    residual_number;
    stoper;
    ABONO_A_CUOTA;
    ABONO_A_CAPITAL;


    constructor(id, jSon, stoper) {
        this.id = id;
        this.jSon = jSon;
        this.stoper = stoper;
        this.ABONO_A_CUOTA = 1;
        this.ABONO_A_CAPITAL = 2;
    }


    getdatajson() {


        this.Bank_id = this.jSon[0].Bank_id;
        this.amortization_type_id = this.jSon[0].amortization_type_id;
        this.credit_type_id = this.jSon[0].credit_type_id;
        this.cuotes_number = this.jSon[0].cuotes_number;
        this.desembolso_date = this.jSon[0].desembolso_date;
        this.dtf = this.jSon[0].dtf;
        this.dtf_points = this.jSon[0].dtf_points;
        this.fixed_rate = this.jSon[0].fixed_rate;
        this.ibr = this.jSon[0].ibr;
        this.ibr_points = this.jSon[0].ibr_points;
        this.initial_value = this.jSon[0].initial_value;
        this.interesting_type_id = this.jSon[0].interesting_type_id;
        this.residual_number = this.jSon[0].residual_number;


        var txtMonto = this.initial_value;
        var txtTiempo = this.cuotes_number;
        var txtDTF = this.dtf;
        var txtIBR = this.ibr;
        var txtPuntosDTF = this.dtf_points;
        var txtTasaFija = this.fixed_rate;
        var txtPuntosIBR = this.ibr_points;
        var txtOpcion = this.residual_number;
        var fechaDesembolso = this.desembolso_date;
        var amortization = this.amortization_type_id;
        var ListaInteres = this.interesting_type_id;

        if (ListaInteres == 1) {
            this.calcularCuotaDtf(txtMonto, txtTiempo, txtDTF, txtPuntosDTF, txtOpcion, amortization, fechaDesembolso);

        } else if (ListaInteres == 2) {

            this.calcularCuotaIbr(txtMonto, txtTiempo, txtIBR, txtPuntosIBR, txtOpcion, amortization, fechaDesembolso);



        } else if (ListaInteres == 3) {
            this.calcularCuotaFija(txtMonto, txtTiempo, txtOpcion, amortization, fechaDesembolso, txtTasaFija);

        }

    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ValidarNumeros(valor, nombreVariable) {
        if (isNaN(valor)) {
            alert("Valor no valido para : " + nombreVariable);
            return false;
        }
        else {
            return true;
        }
    }

    ValidarCampos(monto, tiempo, dtf, ibr, puntosDtf, puntosIbr, opcion) {


        /*console.log("monto:"+monto);
        console.log("tiempo:"+tiempo);
        console.log("dtf:"+dtf);
        console.log("ibr:"+ibr);
        console.log("puntosDtf:"+puntosDtf);
        console.log("puntosIbr:"+puntosIbr);
        console.log("Opcion:"+opcion);
    */

        let valoresValidosMonto = this.ValidarNumeros(monto, "monto");
        let valoresValidosTiempo = this.ValidarNumeros(tiempo, "tiempo");
        let valoresValidosDTF = this.ValidarNumeros(dtf, "DTF");
        let valoresValidosIBR = this.ValidarNumeros(ibr, "IBR");
        let valoresValidospuntosDtf = this.ValidarNumeros(puntosDtf, "puntosDtf");
        let valoresValidospuntosIbr = this.ValidarNumeros(puntosIbr, "puntosIbr");
        let valoresValidosopcion = this.ValidarNumeros(opcion, "opcion");
        if (Number(monto) < Number(opcion)) {
            alert("no se hace calculo por que la opcion es mayor al monto");
            valoresValidosopcion = false;
        }
        if (valoresValidosTiempo) {
            if (tiempo >= 200) {
                alert("no se hace calculo por que el tiempo supero 200 meses");
                valoresValidosTiempo = false;
            }
        }
        if (valoresValidosMonto && valoresValidosTiempo && valoresValidosDTF && valoresValidosIBR && valoresValidospuntosDtf && valoresValidospuntosIbr && valoresValidosopcion) {

            return true;
        }
        else {
            return false;
        }



    }

    CalcularPagoCuotaDtf(dtfmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + dtfmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / dtfmensual);
        //calculo de B
        let vfutu = 1 + dtfmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    CalcularPagoCuotaIbr(ibrmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + ibrmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / ibrmensual);
        //calculo de B
        let vfutu = 1 + ibrmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    CalcularPagoCuotaFijo(dtfmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + dtfmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / dtfmensual);
        //calculo de B
        let vfutu = 1 + dtfmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    DividirPor100(numero) {
        return numero / 100;
    }
    CalculoTasaEfctivaAnual(tasa, puntos) {
        // return (1 + tasa) * (1 + puntos) - 1;  //tasa.efectiva     
        return tasa + puntos;               //tasa nominal 
    }

    calcularCuotaDtf(monto, tiempo, dtf, puntosDtf, opcion, metodo, fechaDesembolso) {
        let validationTable = false;
        if (this.stoper == 0) {
            var TXTvalorinicial = document.getElementById("ValorInicial");
            TXTvalorinicial.value = (formatNumber.new(monto + "", "$ "));
            TXTvalorinicial.disabled = true;

            var Datetiempo = document.getElementById("fechaD");
            Datetiempo.value = fechaDesembolso;
            Datetiempo.disabled = true;

            var TXTtotalcuotas = document.getElementById("TotalC");
            TXTtotalcuotas.value = tiempo + " Meses";
            TXTtotalcuotas.disabled = true;

            var intereses = document.getElementById("intereses");
            intereses.value = dtf + " %";
            intereses.disabled = true;

            var Pinteres = document.getElementById("Pinteres");
            Pinteres.value = puntosDtf + " %";
            Pinteres.disabled = true;

            var Tipointeres = document.getElementById("Tipointeres");
            Tipointeres.value = "DTF";
            Tipointeres.disabled = true;
            validationTable = true;
            this.stoper = tiempo;

        }



        let camposValidos = true;//ValidarCampos(monto, tiempo, dtf, ibr, puntosDtf, puntosIbr, opcion);
        if (camposValidos) {
            let fechas = [];
            let fechaActual = fechaDesembolso;
            let mes_actual = moment(fechaActual);
            mes_actual.add(1, 'month');

            dtf = this.DividirPor100(dtf);
            puntosDtf = this.DividirPor100(puntosDtf);
            //ibr = DividirPor100(ibr);
            //puntosIbr = DividirPor100(puntosIbr);

            let pagoInteres = 0, pagoCapital = 0, cuota = 0;

            let dtf1 = this.CalculoTasaEfctivaAnual(dtf, puntosDtf);
            //let ibr1 = CalculoTasaEfctivaAnual(ibr, puntosIbr);
            let meses = 12;
            //let dtfmensual = Math.pow(1 + dtf1, 1 / meses) - 1; //efectiva
            let dtfmensual = Math.pow(1 + dtf1, 1 / meses) - 1; //nominal
            if (metodo == this.ABONO_A_CUOTA) {
                cuota = this.CalcularPagoCuotaDtf(dtfmensual, tiempo, opcion, monto);

            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoCapital = (monto - opcion) / tiempo;


            }
            let jsonData = '[';

            for (let i = 1; i <= this.stoper; i++) {


                //Formato fechas
                fechas[i] = mes_actual.format('DD-MM-YYYY');
                mes_actual.add(1, 'month');
                if (metodo == this.ABONO_A_CUOTA) {
                    pagoInteres = parseFloat(monto * (dtfmensual));
                    pagoCapital = cuota - pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                } else if (metodo == this.ABONO_A_CAPITAL) {
                    pagoInteres = parseFloat(monto * (dtfmensual));
                    cuota = pagoCapital + pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                }
                jsonData += '{"number":' + '"' + i + '",';
                jsonData += '"fechas":' + '"' + fechas[i] + '",';
                jsonData += '"cuota":' + '"' + (formatNumber.new(Math.round(cuota) + "", "$ ")) + '",';
                jsonData += '"pagoCapital":' + '"' + (formatNumber.new(Math.round(pagoCapital) + "", "$ ")) + '",';
                jsonData += '"pagoInteres":' + '"' + (formatNumber.new(Math.round(pagoInteres) + "", "$ ")) + '",';
                jsonData += '"monto":' + '"' + (formatNumber.new(Math.round(monto) + "", "$ ")) + '"},';


            }
            jsonData = jsonData.substring(0, jsonData.length - 1) + ']';
            var jsonObj = JSON.parse(jsonData);
            //console.log(jsonObj[1].pagoCapital);
            if (validationTable) {

                var cabezera = new Array("#", "Fecha", "Cuota", "Capital", "Interés", "Saldo");
                var newTable = new Table("lista-tabla", cabezera, jsonObj);
                newTable.createTableAmortization();

            } else {
                console.log(jsonObj);
                console.log(dtf);
                var cabezera = new Array("Fecha", "Cuota", "Capital", "Interés", "Saldo");
                var newTable = new Table("lista-tabla", cabezera, jsonObj);
                newTable.createPayTable();
                //return jsonObj;

            }
        } else {
            alert("No se pueden realizar calculos");
        }

    }
    calcularCuotaIbr(monto, tiempo, ibr, puntosIbr, opcion, metodo, fechaDesembolso) {

        let validationTable = false;
        if (this.stoper == 0) {
            var TXTvalorinicial = document.getElementById("ValorInicial");
            TXTvalorinicial.value = (formatNumber.new(monto + "", "$ "));
            TXTvalorinicial.disabled = true;

            var Datetiempo = document.getElementById("fechaD");
            Datetiempo.value = fechaDesembolso;
            Datetiempo.disabled = true;

            var TXTtotalcuotas = document.getElementById("TotalC");
            TXTtotalcuotas.value = tiempo + " Meses";
            TXTtotalcuotas.disabled = true;

            var intereses = document.getElementById("intereses");
            intereses.value = ibr + " %";
            intereses.disabled = true;

            var Pinteres = document.getElementById("Pinteres");
            Pinteres.value = puntosIbr + " %";
            Pinteres.disabled = true;

            var Tipointeres = document.getElementById("Tipointeres");
            Tipointeres.value = "IBR";
            Tipointeres.disabled = true;

            validationTable = true;
            this.stoper = tiempo;

        }


        let camposValidos = true;// ValidarCampos(monto, tiempo, dtf, ibr, puntosDtf, puntosIbr, opcion);
        if (camposValidos) {
            let fechas = [];
            let fechaActual = fechaDesembolso;
            let mes_actual = moment(fechaActual);
            mes_actual.add(1, 'month');

            ibr = this.DividirPor100(ibr);
            puntosIbr = this.DividirPor100(puntosIbr);

            let pagoInteres = 0, pagoCapital = 0, cuota = 0;

            let ibr1 = this.CalculoTasaEfctivaAnual(ibr, puntosIbr);
            let meses = 12;

            let ibrmensual = Math.pow(1 + ibr1, 1 / meses) - 1; //nominal
            if (metodo == this.ABONO_A_CUOTA) {
                cuota = this.CalcularPagoCuotaIbr(ibrmensual, tiempo, opcion, monto);

            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoCapital = (monto - opcion) / tiempo;


            }
            let jsonData = '[';

            for (let i = 1; i <= this.stoper; i++) {


                //Formato fechas
                fechas[i] = mes_actual.format('DD-MM-YYYY');
                mes_actual.add(1, 'month');
                if (metodo == this.ABONO_A_CUOTA) {
                    pagoInteres = parseFloat(monto * (ibrmensual));
                    pagoCapital = cuota - pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                } else if (metodo == this.ABONO_A_CAPITAL) {
                    pagoInteres = parseFloat(monto * (ibrmensual));
                    cuota = pagoCapital + pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                }
                jsonData += '{"number":' + '"' + i + '",';
                jsonData += '"fechas":' + '"' + fechas[i] + '",';
                jsonData += '"cuota":' + '"' + (formatNumber.new(Math.round(cuota) + "", "$ ")) + '",';
                jsonData += '"pagoCapital":' + '"' + (formatNumber.new(Math.round(pagoCapital) + "", "$ ")) + '",';
                jsonData += '"pagoInteres":' + '"' + (formatNumber.new(Math.round(pagoInteres) + "", "$ ")) + '",';
                jsonData += '"monto":' + '"' + (formatNumber.new(Math.round(monto) + "", "$ ")) + '"},';


            }
            jsonData = jsonData.substring(0, jsonData.length - 1) + ']';
            var jsonObj = JSON.parse(jsonData);
            //alert(jsonObj[1].pagoCapital);
            if (validationTable) {

                var cabezera = new Array("#", "Fecha", "Cuota", "Capital", "Interés", "Saldo");
                var newTable = new Table("lista-tabla", cabezera, jsonObj);
                newTable.createTableAmortization();

            } else {
                console.log(this.ibr);
                //return jsonObj;

            }
        } else {
            alert("No se pueden realizar calculos");
        }

    }
    calcularCuotaFija(monto, tiempo, opcion, metodo, fechaDesembolso1, InteresFijo) {

        let validationTable = false;
        if (this.stoper == 0) {
            var TXTvalorinicial = document.getElementById("ValorInicial");
            TXTvalorinicial.value = (formatNumber.new(monto + "", "$ "));
            TXTvalorinicial.disabled = true;

            var Datetiempo = document.getElementById("fechaD");
            Datetiempo.value = fechaDesembolso1;
            Datetiempo.disabled = true;

            var TXTtotalcuotas = document.getElementById("TotalC");
            TXTtotalcuotas.value = tiempo + " Meses";
            TXTtotalcuotas.disabled = true;

            var intereses = document.getElementById("intereses");
            intereses.value = InteresFijo + " %";
            intereses.disabled = true;

            var Pinteres = document.getElementById("Pinteres");
            Pinteres.value = "Sin puntos";
            Pinteres.disabled = true;

            var Tipointeres = document.getElementById("Tipointeres");
            Tipointeres.value = "Interes Fijo";
            Tipointeres.disabled = true;

            validationTable = true;
            this.stoper = tiempo;

        }


        let camposValidos = true;//ValidarCampos(monto, tiempo, dtf, ibr, puntosDtf, puntosIbr, opcion);
        if (camposValidos) {
            let fechas = [];
            let fechaActual = fechaDesembolso1;
            let mes_actual = moment(fechaActual);
            mes_actual.add(1, 'month');

            InteresFijo = this.DividirPor100(InteresFijo);

            let pagoInteres = 0, pagoCapital = 0, cuota = 0;
            let meses = 12;
            let InteresFijo1 = InteresFijo / meses;

            if (metodo == this.ABONO_A_CUOTA) {
                cuota = this.CalcularPagoCuotaFijo(InteresFijo1, tiempo, opcion, monto);

            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoCapital = (monto - opcion) / tiempo;


            }
            let jsonData = '[';

            for (let i = 1; i <= this.stoper; i++) {


                //Formato fechas
                fechas[i] = mes_actual.format('DD-MM-YYYY');
                mes_actual.add(1, 'month');
                if (metodo == this.ABONO_A_CUOTA) {
                    pagoInteres = parseFloat(monto * (InteresFijo1));
                    pagoCapital = cuota - pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                } else if (metodo == this.ABONO_A_CAPITAL) {
                    pagoInteres = parseFloat(monto * (InteresFijo1));
                    cuota = pagoCapital + pagoInteres;
                    monto = parseFloat(monto - pagoCapital);
                }
                jsonData += '{"number":' + '"' + i + '",';
                jsonData += '"fechas":' + '"' + fechas[i] + '",';
                jsonData += '"cuota":' + '"' + (formatNumber.new(Math.round(cuota) + "", "$ ")) + '",';
                jsonData += '"pagoCapital":' + '"' + (formatNumber.new(Math.round(pagoCapital) + "", "$ ")) + '",';
                jsonData += '"pagoInteres":' + '"' + (formatNumber.new(Math.round(pagoInteres) + "", "$ ")) + '",';
                jsonData += '"monto":' + '"' + (formatNumber.new(Math.round(monto) + "", "$ ")) + '"},';


            }
            jsonData = jsonData.substring(0, jsonData.length - 1) + ']';
            var jsonObj = JSON.parse(jsonData);
            //alert(jsonObj[1].pagoCapital);
            if (validationTable) {

                var cabezera = new Array("#", "Fecha", "Cuota", "Capital", "Interés", "Saldo");
                var newTable = new Table("lista-tabla", cabezera, jsonObj);
                newTable.createTableAmortization();

            } else {
                //return jsonObj;

            }
        } else {
            alert("No se pueden realizar calculos");
        }

    }

}



//**************************//
//Author: Cristian malaver
//Date: 14/12/2020
//Description : Class Table for amortization method for pay
//************CLASS TABLE**************//

class payAmortization {
    Bank_id;
    amortization_type_id;
    credit_type_id;
    cuotes_number;
    desembolso_date;
    dtf;
    dtf_points;
    fixed_rate;
    ibr;
    ibr_points;
    initial_value;
    interesting_type_id;
    residual_number;
    pay_obligation_actual_cuote;
    ABONO_A_CUOTA;
    ABONO_A_CAPITAL;
    pay_date;
    obligation_cod;
    pay_Dtf;
    pay_Ibr;
    pay_FixedRate;
    pay_obligation_id;

    constructor(jSon) {
        this.jSon = jSon;
        this.ABONO_A_CUOTA = 1;
        this.ABONO_A_CAPITAL = 2;
    }

    getPayObligation() {

        
        this.pay_obligation_id = 0;
        this.obligation_cod = this.jSon[0].obligation_cod;
        this.pay_Dtf = this.jSon[0].pay_Dtf;
        this.pay_Ibr = this.jSon[0].pay_Ibr;
        this.pay_FixedRate = this.jSon[0].pay_FixedRate;
        this.pay_date = this.jSon[0].pay_date;
        this.pay_obligation_actual_cuote = this.jSon[0].pay_obligation_actual_cuote;
        this.Bank_id = this.jSon[0].Bank_id;
        this.amortization_type_id = this.jSon[0].amortization_type_id;
        this.credit_type_id = this.jSon[0].credit_type_id;
        this.cuotes_number = this.jSon[0].cuotes_number;
        this.desembolso_date = this.jSon[0].desembolso_date;
        this.dtf = this.jSon[0].dtf;
        this.dtf_points = this.jSon[0].dtf_points;
        this.fixed_rate = this.jSon[0].fixed_rate;
        this.ibr = this.jSon[0].ibr;
        this.ibr_points = this.jSon[0].ibr_points;
        this.initial_value = this.jSon[0].initial_value;
        this.interesting_type_id = this.jSon[0].interesting_type_id;
        this.residual_number = this.jSon[0].residual_number;


        var txtMonto = this.initial_value;
        var txtTiempo = this.cuotes_number;
        var txtDTF = this.dtf;
        var txtIBR = this.ibr;
        var txtPuntosDTF = this.dtf_points;
        var txtTasaFija = this.fixed_rate;
        var txtPuntosIBR = this.ibr_points;
        var txtOpcion = this.residual_number;
        var fechaDesembolso = this.desembolso_date;
        var amortization = this.amortization_type_id;
        var ListaInteres = this.interesting_type_id;
        var result;

        if (ListaInteres == 1) {
            result = this.calcularCuotaDtf(txtMonto, txtTiempo, txtDTF, txtPuntosDTF, txtOpcion, amortization, fechaDesembolso);

        } else if (ListaInteres == 2) {

            result = this.calcularCuotaIbr(txtMonto, txtTiempo, txtIBR, txtPuntosIBR, txtOpcion, amortization, fechaDesembolso);



        } else if (ListaInteres == 3) {
            result = this.calcularCuotaFija(txtMonto, txtTiempo, txtOpcion, amortization, fechaDesembolso, txtTasaFija);

        }
        return result;

    }



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ValidarNumeros(valor, nombreVariable) {
        if (isNaN(valor)) {
            alert("Valor no valido para : " + nombreVariable);
            return false;
        }
        else {
            return true;
        }
    }

    ValidarCampos(monto, tiempo, dtf, ibr, puntosDtf, puntosIbr, opcion) {


        /*console.log("monto:"+monto);
        console.log("tiempo:"+tiempo);
        console.log("dtf:"+dtf);
        console.log("ibr:"+ibr);
        console.log("puntosDtf:"+puntosDtf);
        console.log("puntosIbr:"+puntosIbr);
        console.log("Opcion:"+opcion);
    */

        let valoresValidosMonto = this.ValidarNumeros(monto, "monto");
        let valoresValidosTiempo = this.ValidarNumeros(tiempo, "tiempo");
        let valoresValidosDTF = this.ValidarNumeros(dtf, "DTF");
        let valoresValidosIBR = this.ValidarNumeros(ibr, "IBR");
        let valoresValidospuntosDtf = this.ValidarNumeros(puntosDtf, "puntosDtf");
        let valoresValidospuntosIbr = this.ValidarNumeros(puntosIbr, "puntosIbr");
        let valoresValidosopcion = this.ValidarNumeros(opcion, "opcion");
        if (Number(monto) < Number(opcion)) {
            alert("no se hace calculo por que la opcion es mayor al monto");
            valoresValidosopcion = false;
        }
        if (valoresValidosTiempo) {
            if (tiempo >= 200) {
                alert("no se hace calculo por que el tiempo supero 200 meses");
                valoresValidosTiempo = false;
            }
        }
        if (valoresValidosMonto && valoresValidosTiempo && valoresValidosDTF && valoresValidosIBR && valoresValidospuntosDtf && valoresValidospuntosIbr && valoresValidosopcion) {

            return true;
        }
        else {
            return false;
        }



    }

    CalcularPagoCuotaDtf(dtfmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + dtfmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / dtfmensual);
        //calculo de B
        let vfutu = 1 + dtfmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    CalcularPagoCuotaIbr(ibrmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + ibrmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / ibrmensual);
        //calculo de B
        let vfutu = 1 + ibrmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    CalcularPagoCuotaFijo(dtfmensual, tiempo, opcion, monto) {
        //formula de pago
        //calculo de A 
        let nuevoa = (1 + dtfmensual);
        //console.log(nuevoa);
        let nuevoa1 = Math.pow(nuevoa, -tiempo);
        let nuevoa2 = 1 - nuevoa1;
        let A = (nuevoa2 / dtfmensual);
        //calculo de B
        let vfutu = 1 + dtfmensual;
        // console.log(vfutu);
        let vfutur = Math.pow(vfutu, -tiempo);
        let B = (opcion * vfutur);
        //Calculo de componente financiero 
        let comp = monto - B;
        return comp / A;
    }
    DividirPor100(numero) {
        return numero / 100;
    }
    CalculoTasaEfctivaAnual(tasa, puntos) {
        // return (1 + tasa) * (1 + puntos) - 1;  //tasa.efectiva     
        return tasa + puntos;               //tasa nominal 
    }

    calcularCuotaDtf(monto, tiempo, dtf, puntosDtf, opcion, metodo, fechaDesembolso) {


        let fechas = [];
        let fechaActual = fechaDesembolso;
        let mes_actual = moment(fechaActual);
        mes_actual.add(1, 'month');

        dtf = this.DividirPor100(dtf);
        puntosDtf = this.DividirPor100(puntosDtf);
        //ibr = DividirPor100(ibr);
        //puntosIbr = DividirPor100(puntosIbr);

        let pagoInteres = 0, pagoCapital = 0, cuota = 0;

        let dtf1 = this.CalculoTasaEfctivaAnual(dtf, puntosDtf);
        //let ibr1 = CalculoTasaEfctivaAnual(ibr, puntosIbr);
        let meses = 12;
        //let dtfmensual = Math.pow(1 + dtf1, 1 / meses) - 1; //efectiva
        let dtfmensual = Math.pow(1 + dtf1, 1 / meses) - 1; //nominal
        if (metodo == this.ABONO_A_CUOTA) {
            cuota = this.CalcularPagoCuotaDtf(dtfmensual, tiempo, opcion, monto);

        } else if (metodo == this.ABONO_A_CAPITAL) {
            pagoCapital = (monto - opcion) / tiempo;


        }
        let jsonData = '';

        for (let i = 1; i <= this.pay_obligation_actual_cuote; i++) {


            //Formato fechas
            fechas[i] = mes_actual.format('DD-MM-YYYY');
            mes_actual.add(1, 'month');
            if (metodo == this.ABONO_A_CUOTA) {
                pagoInteres = parseFloat(monto * (dtfmensual));
                pagoCapital = cuota - pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoInteres = parseFloat(monto * (dtfmensual));
                cuota = pagoCapital + pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            }
            if (i == this.pay_obligation_actual_cuote) {

                
                jsonData += '"pay_obligation_id":' + '"' + this.pay_obligation_id + '",';
                jsonData += '"obligation_cod":' + '"' + this.obligation_cod + '",';
                jsonData += '"pay_obligation_actual_cuote":' + '"' + this.pay_obligation_actual_cuote + '",';
                jsonData += '"pay_Dtf":' + '"' + this.dtf + '",';
                jsonData += '"pay_Ibr":' + '"' + this.ibr + '",';
                jsonData += '"pay_FixedRate":' + '"' + this.fixed_rate + '",';
                jsonData += '"pay_value":' + '"' + Math.round(cuota) + '",';
                jsonData += '"pay_capital_value":' + '"' + Math.round(pagoCapital) + '",';
                jsonData += '"pay_residue":' + '"' + Math.round(monto) +  '",';
                jsonData += '"pay_interesting_value":' + '"' + Math.round(pagoInteres)  + '",';
                jsonData += '"pay_observation":' + '"' + "" + '",';
                jsonData += '"pay_Date":' + '"' + this.pay_date + '",';
            }
        }

        jsonData = jsonData.substring(0, jsonData.length - 1) + '';
        //console.log(jsonData);
        //var jsonObj = JSON.parse(jsonData);
        //console.log(jsonObj);
        return jsonData;




    }
    calcularCuotaIbr(monto, tiempo, ibr, puntosIbr, opcion, metodo, fechaDesembolso) {


        /*    var TXTvalorinicial = document.getElementById("ValorInicial");
            TXTvalorinicial.value = (formatNumber.new(monto + "", "$ "));
            TXTvalorinicial.disabled = true;

            var Datetiempo = document.getElementById("fechaD");
            Datetiempo.value = fechaDesembolso;
            Datetiempo.disabled = true;

            var TXTtotalcuotas = document.getElementById("TotalC");
            TXTtotalcuotas.value = tiempo + " Meses";
            TXTtotalcuotas.disabled = true;

            var intereses = document.getElementById("intereses");
            intereses.value = ibr + " %";
            intereses.disabled = true;

            var Pinteres = document.getElementById("Pinteres");
            Pinteres.value = puntosIbr + " %";
            Pinteres.disabled = true;

            var Tipointeres = document.getElementById("Tipointeres");
            Tipointeres.value = "IBR";
            Tipointeres.disabled = true;

            validationTable = true;
            this.stoper = tiempo;*/


        let fechas = [];
        let fechaActual = fechaDesembolso;
        let mes_actual = moment(fechaActual);
        mes_actual.add(1, 'month');

        ibr = this.DividirPor100(ibr);
        puntosIbr = this.DividirPor100(puntosIbr);

        let pagoInteres = 0, pagoCapital = 0, cuota = 0;

        let ibr1 = this.CalculoTasaEfctivaAnual(ibr, puntosIbr);
        let meses = 12;

        let ibrmensual = Math.pow(1 + ibr1, 1 / meses) - 1; //nominal
        if (metodo == this.ABONO_A_CUOTA) {
            cuota = this.CalcularPagoCuotaIbr(ibrmensual, tiempo, opcion, monto);

        } else if (metodo == this.ABONO_A_CAPITAL) {
            pagoCapital = (monto - opcion) / tiempo;


        }
        let jsonData = '';

        for (let i = 1; i <= this.pay_obligation_actual_cuote; i++) {


            //Formato fechas
            fechas[i] = mes_actual.format('DD-MM-YYYY');
            mes_actual.add(1, 'month');
            if (metodo == this.ABONO_A_CUOTA) {
                pagoInteres = parseFloat(monto * (ibrmensual));
                pagoCapital = cuota - pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoInteres = parseFloat(monto * (ibrmensual));
                cuota = pagoCapital + pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            }
            if (i == this.pay_obligation_actual_cuote) {

                jsonData += '"pay_obligation_id":' + '"' + this.pay_obligation_id + '",';
                jsonData += '"obligation_cod":' + '"' + this.obligation_cod + '",';
                jsonData += '"pay_obligation_actual_cuote":' + '"' + this.pay_obligation_actual_cuote + '",';
                jsonData += '"pay_Dtf":' + '"' + this.dtf + '",';
                jsonData += '"pay_Ibr":' + '"' + this.ibr + '",';
                jsonData += '"pay_FixedRate":' + '"' + this.fixed_rate + '",';
                jsonData += '"pay_value":' + '"' + Math.round(cuota) + '",';
                jsonData += '"pay_capital_value":' + '"' + Math.round(pagoCapital) + '",';
                jsonData += '"pay_residue":' + '"' + Math.round(monto) +  '",';
                jsonData += '"pay_interesting_value":' + '"' + Math.round(pagoInteres)  + '",';
                jsonData += '"pay_observation":' + '"' + "" + '",';
                jsonData += '"pay_Date":' + '"' + this.pay_date + '",';
            }
        }

        jsonData = jsonData.substring(0, jsonData.length - 1) + '';
       // console.log(jsonData);
        //var jsonObj = JSON.parse(jsonData);
        //console.log(jsonObj);
        return jsonData;





    }
    calcularCuotaFija(monto, tiempo, opcion, metodo, fechaDesembolso1, InteresFijo) {

        /*       var TXTvalorinicial = document.getElementById("ValorInicial");
               TXTvalorinicial.value = (formatNumber.new(monto + "", "$ "));
               TXTvalorinicial.disabled = true;
   
               var Datetiempo = document.getElementById("fechaD");
               Datetiempo.value = fechaDesembolso1;
               Datetiempo.disabled = true;
   
               var TXTtotalcuotas = document.getElementById("TotalC");
               TXTtotalcuotas.value = tiempo + " Meses";
               TXTtotalcuotas.disabled = true;
   
               var intereses = document.getElementById("intereses");
               intereses.value = InteresFijo + " %";
               intereses.disabled = true;
   
               var Pinteres = document.getElementById("Pinteres");
               Pinteres.value = "Sin puntos";
               Pinteres.disabled = true;
   
               var Tipointeres = document.getElementById("Tipointeres");
               Tipointeres.value = "Interes Fijo";
               Tipointeres.disabled = true;
   
               validationTable = true;
               this.stoper = tiempo; */

        let fechas = [];
        let fechaActual = fechaDesembolso1;
        let mes_actual = moment(fechaActual);
        mes_actual.add(1, 'month');

        InteresFijo = this.DividirPor100(InteresFijo);

        let pagoInteres = 0, pagoCapital = 0, cuota = 0;
        let meses = 12;
        let InteresFijo1 = InteresFijo / meses;

        if (metodo == this.ABONO_A_CUOTA) {
            cuota = this.CalcularPagoCuotaFijo(InteresFijo1, tiempo, opcion, monto);

        } else if (metodo == this.ABONO_A_CAPITAL) {
            pagoCapital = (monto - opcion) / tiempo;


        }
        let jsonData = '';

        for (let i = 1; i <= this.pay_obligation_actual_cuote; i++) {


            //Formato fechas
            fechas[i] = mes_actual.format('DD-MM-YYYY');
            mes_actual.add(1, 'month');
            if (metodo == this.ABONO_A_CUOTA) {
                pagoInteres = parseFloat(monto * (InteresFijo1));
                pagoCapital = cuota - pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            } else if (metodo == this.ABONO_A_CAPITAL) {
                pagoInteres = parseFloat(monto * (InteresFijo1));
                cuota = pagoCapital + pagoInteres;
                monto = parseFloat(monto - pagoCapital);
            }
            if (i == this.pay_obligation_actual_cuote) {

                jsonData += '"pay_obligation_id":' + '"' + this.pay_obligation_id + '",';
                jsonData += '"obligation_cod":' + '"' + this.obligation_cod + '",';
                jsonData += '"pay_obligation_actual_cuote":' + '"' + this.pay_obligation_actual_cuote + '",';
                jsonData += '"pay_Dtf":' + '"' + this.dtf + '",';
                jsonData += '"pay_Ibr":' + '"' + this.ibr + '",';
                jsonData += '"pay_FixedRate":' + '"' + this.fixed_rate + '",';
                jsonData += '"pay_value":' + '"' + Math.round(cuota) + '",';
                jsonData += '"pay_capital_value":' + '"' + Math.round(pagoCapital) + '",';
                jsonData += '"pay_residue":' + '"' + Math.round(monto) +  '",';
                jsonData += '"pay_interesting_value":' + '"' + Math.round(pagoInteres)  + '",';
                jsonData += '"pay_observation":' + '"' + "" + '",';
                jsonData += '"pay_Date":' + '"' + this.pay_date + '",';
            }
        }

        jsonData = jsonData.substring(0, jsonData.length - 1) + '';
        //console.log(jsonData);
        //var jsonObj = JSON.parse(jsonData);
        //console.log(jsonObj);
        return jsonData;





    }

}



