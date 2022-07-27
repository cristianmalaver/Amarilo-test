var formatNumber = {
    separador: ".", // separador para los miles
    sepDecimal: ',', // separador para los decimales
    formatear: function (num) {
        num += '';
        var splitStr = num.split('.');
        var splitLeft = splitStr[0];
        var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
        var regx = /(\d+)(\d{3})/;
        while (regx.test(splitLeft)) {
            splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
        }
        return this.simbol + splitLeft + splitRight;
    },
    new: function (num, simbol) {
        this.simbol = simbol || '';
        return this.formatear(num);
    }
}
function formatt(g) {
    var num = g.value.replace(/\./g, '');
    if (!isNaN(num)) {
        num = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g, '$1.');
        num = num.split('').reverse().join('').replace(/^[\.]/, '');
        g.value = num;
        Inputnum = num;
        

    }

    else {
        alert('Solo se permiten numeros');
        g.value = g.value.replace(/[^\d\.]*/g, '');
    }
}

function format(g) {
    var num = g.value.replace(/\./g, '');
    if (!isNaN(num)) {
        num = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g, '$1.');
        num = num.split('').reverse().join('').replace(/^[\.]/, '');
        g.value = num;
    }

    else {
        alert('Solo se permiten numeros');
        g.value = g.value.replace(/[^\d\.]*/g, '');
    }
}

function passValue(id,value){

    document.getElementById(id).value = value.replace(/[. ]+/g, "").trim();

}