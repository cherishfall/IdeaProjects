function valid_ee_name(name) {
    name = name.trim();
    if(name.length==0 || name.length >16) return false;
    return true;
}

function valid_ee_phone(phone){
    phone = phone.trim();
    let exp = /^[1][3,4,5,7,8][0-9]{9}$/;
    if(phone.length==0) return true;
    if(exp.test(phone)) return true;
    return false;
}

function valida_ee_sex(sex){
    sex = sex.trim();
    if(sex.length==0 || sex=="男" || sex=="女") return true;
    return false;
}

function valida_ee_age(age){
    if(age< 18 || age > 65) return false;
    return true;
}

function valid_ee_acount(acount) {
    acount = acount.trim();
    if(acount.length==0 || acount.length >16) return false;
    return true;
}

function valid_ee_pwd(pwd) {
    pwd = pwd.trim();
    if(pwd.length==0 || pwd.length >16) return false;
    return true;
}



