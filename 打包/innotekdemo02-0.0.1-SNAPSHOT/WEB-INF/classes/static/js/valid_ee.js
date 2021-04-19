function valid_ee_name(name) {
    name = name.trim();
    if(name.length===0) return false;
    if(name.length < 2 || name.length >16) return false;
    return true;
}

function valid_ee_tel(tel){
    tel = tel.trim();

    if(tel.length === 0) return true;
    if(tel.length !== 11) return false;
    let exp = /^[1][3,4,5,7,8][0-9]{9}$/;
    if(exp.test(tel)) return true;
    return false;
}


function valida_ee_age(age){
    if(age< 18 || age > 65) return false;
    return true;
}

function valid_ee_account(account) {
    account = account.trim();
    if(account.length === 0) return false;
    if(account.length < 6|| account.length >16) return false;
    return true;
}

function valid_ee_pwd(pwd) {
    pwd = pwd.trim();
    if(pwd.length === 0) return false;
    if(pwd.length <6 || pwd.length >16) return false;
    return true;
}






