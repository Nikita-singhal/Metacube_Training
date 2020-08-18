//Employee details validation
function nameValidation() {
    var x = document.getElementById("Ename").value;
    var regex = /^[a-zA-Z.]+$/ ;
    if (x.length < 2 || !x.match(regex)) {
      document.getElementById("Ename").style.border = "1px solid red";
      document.getElementById("empErrors").style.display = "block";
      document.getElementById("empErrors").innerHTML = "Enter a valid name.Must not contain any special character or any Number literal";
      return false;
    }
    else {
        showNextEmpField();
    }
}

function genderValidation() {
    var x = document.getElementsByName("gender");
    if (!x[0].checked && !x[1].checked) {
        document.getElementById("empErrors").style.display = "block";
        document.getElementById("empErrors").innerHTML = "Please select a valid gender";
      return false;
    }
    else {
        showNextEmpField();
    }
}

function emailValidation() {
    var x = document.getElementById("Eemail").value;
    var regex = /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/ ;
    if (!x.match(regex)) {
      document.getElementById("Eemail").style.border = "1px solid red";
      document.getElementById("empErrors").style.display = "block";
      document.getElementById("empErrors").innerHTML = "Email must comtain '@' and '.' Ex- abc@gmail.com";
      return false;
    }
    else {
        showNextEmpField();
    }
}

function passwordValidation() {
    var x = document.getElementById("password").value;
    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/ ;
    if (!x.match(regex)) {
      document.getElementById("password").style.border = "1px solid red";
      document.getElementById("empErrors").style.display = "block";
      document.getElementById("empErrors").innerHTML = "Length of password must be equal to or greater than 8.<br>Password must contain an special character Ex-!@#$%^&*()_,<br>a small alphabet (a-z), a capital alphabet(A-Z) and one number(0-9)";
      return false;
    }
    else {
        showNextEmpField();
    }
}

function confirmPasswordValidation() {
    var pass = document.getElementById("password").value;
    var cpass = document.getElementById("confirmPassword").value;
    if (pass != cpass) {
      document.getElementById("confirmPassword").style.border = "1px solid red";
      document.getElementById("empErrors").style.display = "block";
      document.getElementById("empErrors").innerHTML = "Not matches with the password provided";
      return false;
    }
    else {
        showNextEmpField();
    }
}

function contactValidation() {
    var x = document.getElementById("contactNum").value;
    var regex = /[0-9]{10}/;
    if (!x.match(regex)) {
      document.getElementById("contactNum").style.border = "1px solid red";
      document.getElementById("empErrors").style.display = "block";
      document.getElementById("empErrors").innerHTML = "Enter a 10 digit contact number (include numbers only)";
      return false;
    }
    else {
        generateEmpId();
    }
}

// employee details
function showEmpForm() {
    document.getElementById("nameform").style.display = "block";
}

function showNextEmpField() {
    document.getElementById("empErrors").style.display = "none";
    if (document.getElementById("nameform").style.display == "block"){
        document.getElementById("nameform").style.display = "none";
        document.getElementById("genderform").style.display = "block";
    }
    else if(document.getElementById("genderform").style.display == "block"){
        document.getElementById("genderform").style.display = "none";
        document.getElementById("emailform").style.display = "block";
    }
    else if(document.getElementById("emailform").style.display == "block"){
        document.getElementById("emailform").style.display = "none";
        document.getElementById("passwordform").style.display = "block";
    }
    else if(document.getElementById("passwordform").style.display == "block"){
        document.getElementById("passwordform").style.display = "none";
        document.getElementById("cpasswordform").style.display = "block";
    }
    else if(document.getElementById("cpasswordform").style.display == "block"){
        document.getElementById("cpasswordform").style.display = "none";
        document.getElementById("contactform").style.display = "block";
    }
}

function generateEmpId(){
    document.getElementById("empErrors").style.display = "none";
    document.getElementById("contactform").style.display = "none";
    document.getElementById("generatedEmpId").style.display = "block";
    var id = Math.round(Math.random()*100000);
    document.getElementById("generatedEmpId").innerHTML = "Your Employee Id is :  EMP"+ id;
}

//Vehicle details
function showVehicleForm() {
    document.getElementById("vcompanyform").style.display = "block";
}

function showNextVehicleField(){
    if (document.getElementById("vcompanyform").style.display == "block"){
        document.getElementById("vcompanyform").style.display = "none";
        document.getElementById("vmodelform").style.display = "block";
    }
    else if(document.getElementById("vmodelform").style.display == "block"){
        document.getElementById("vmodelform").style.display = "none";
        document.getElementById("vtypeform").style.display = "block";
    }
    else if(document.getElementById("vtypeform").style.display == "block"){
        document.getElementById("vtypeform").style.display = "none";
        document.getElementById("vnumberform").style.display = "block";
    }
    else if(document.getElementById("vnumberform").style.display == "block"){
        document.getElementById("vnumberform").style.display = "none";
        document.getElementById("vempidform").style.display = "block";
    }
    else if(document.getElementById("vempidform").style.display == "block"){
        document.getElementById("vempidform").style.display = "none";
        document.getElementById("videntityform").style.display = "block";
    }
}

//show parking prices
function showParkingPrices() {
    document.getElementById("videntityform").style.display = "none";
    var vtype = document.getElementById("VType").value;
    if (vtype == "cycle") {
        document.getElementById("cycle").style.display = "block";
        document.getElementById("motorcycle").style.display = "none";
        document.getElementById("fourWheeler").style.display = "none";
    }
    else if (vtype == "motorcycle") {
        document.getElementById("cycle").style.display = "none";
        document.getElementById("motorcycle").style.display = "block";
        document.getElementById("fourWheeler").style.display = "none";
    }
    else if (vtype == "fourwheeler") {
        document.getElementById("cycle").style.display = "none";
        document.getElementById("motorcycle").style.display = "none";
        document.getElementById("fourWheeler").style.display = "block";
    }
}

//calculate parking amount
function calculateAmount() {
    var vtype = document.getElementById("VType").value;
    var amount = 0;
    if (vtype == "cycle") {
        var pricetype = document.getElementsByName("cprice");
        if(pricetype[0].checked)
            amount = 5;
        else if(pricetype[1].checked)
            amount = 100;
        else if(pricetype[2].checked)
            amount = 500;
    }
    else if (vtype == "motorcycle") {
        var pricetype = document.getElementsByName("mcprice").value;
        if(pricetype[0].checked)
            amount = 10;
        else if(pricetype[1].checked)
            amount = 200;
        else if(pricetype[2].checked)
            amount = 1000;
    }
    else if (vtype == "fourwheeler") {
        var pricetype = document.getElementsByName("fwprice").value;
        if(pricetype[0].checked)
            amount = 20;
        else if(pricetype[1].checked)
            amount = 500;
        else if(pricetype[2].checked)
            amount = 3500;
    }
    document.getElementById("totalamt").style.display = "block";
    document.getElementById("totalamt").innerHTML = "Total Amount to be paid : $"+amount;
}