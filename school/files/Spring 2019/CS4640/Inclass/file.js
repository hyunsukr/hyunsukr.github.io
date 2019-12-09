document.write('content from file.js');

function setFocus(ele) {
    document.getElementById(ele).focus();
} //focus is put cursor here

var focusVar = setFocus('firstName');
