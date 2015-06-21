function isAtom(sExp) {
  return typeof sExp === 'function' || typeof sExp === 'object' ? false : true;
}

function isNull(list) {
  return list.length === 0;
}

function car(list) {
  return list[0];
}

function cdr(list) {
  return list.slice(1);
}

function cons(a, list) {
  list.unshift(a);
  return list;
}

function eqLists(a, b) {
  // null lists are equal
  if (isNull(a) && isNull(b)) return true;
  // otherwise, check cars and recurse
  return (car(a) === car(b)) ? isEq(cdr(a), cdr(b)) : false;  
}

function eqLambdas(f, g) {
  // ugly, but mostly close enough
  return f.toString() === g.toString();
}

function isEq(a, b) {
  // a list and an atom are not equal
  if (isAtom(a) !== isAtom(b))
    return false;
  // two atoms are equal via ===
  else if (isAtom(a) && isAtom(b))
    return a === b;
  else if (typeof a === 'function' && typeof b === 'function')
    return eqLambdas(a, b);
  else return eqLists(a, b);
}

// Chapter 2
function isLat(l) {
  if (isNull(l)) return true;
  return isAtom(car(l)) ? isLat(cdr(l)) : false;
}

function isMember(a, lat) {
  if (isNull(lat)) return false;
  return (isEq(a, car(lat))) || isMember(a, cdr(lat));
}

