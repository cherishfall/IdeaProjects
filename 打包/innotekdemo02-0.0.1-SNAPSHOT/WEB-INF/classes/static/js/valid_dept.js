function valid_dept_name(name){
    name = name.trim();
    if(name.length === 0) return false;
    if(name.length < 3 || name.length > 16) return false;
    return true;
}

function valid_dept_code(code){
    code = code.trim();
    if(code.length === 0) return false;
    if(code.length < 4 || code.length > 16) return false;
    return true;
}