/**
 * Pollute one object with another
 */
function pollute(ctx, obj) {
  for (var prop in obj) {
    if (obj.hasOwnProperty(prop)) {
      ctx[prop] = obj[prop];
    }
  }
}

/**
 * Core Functions
 */
var Little = (function _LittleIIFE(global) {
  function isAtom(x) {
    // this catches functions, arrays, and other objects
    return !(typeof x === 'function' || typeof x === 'object');
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
    if (isNull(a) && isNull(b))
      return true;
    else
      return isEq(car(a), car(b)) && isEq(cdr(a), cdr(b));
  }

  function eqLambdas(f, g) {
    // ugly, but mostly close enough
    return f.toString() === g.toString();
  }

  // this does more than eq? which may not be a great idea.
  function isEq(a, b) {
    // an atom and a non-atom are not equal
    if (isAtom(a) !== isAtom(b))
      return false;
    // two atoms are equal via ===
    else if (isAtom(a) && isAtom(b))
      return a === b;
    // check lambdas
    else if (typeof a === 'function' && typeof b === 'function')
      return eqLambdas(a, b);
    // else assume a list
    else return eqLists(a, b);
  }

  /**
   * Chapter 2
   */
  var Chapter2 = (function _Chapter2IIFE(global) {
    function isLat(l) {
      if (isNull(l)) return true;
      return isAtom(car(l)) ? isLat(cdr(l)) : false;
    }

    function isMember(a, lat) {
      if (isNull(lat)) return false;
      return (isEq(a, car(lat))) || isMember(a, cdr(lat));
    }

    return {
      isLat: isLat,
      isMember: isMember
    };
  })(global);

  /**
   * Chapter 3
   */
  var Chapter3 = (function _Chapter3IIFE(global) {

  })(global);

  return {
    isAtom: isAtom,
    isNull: isNull,
    car: car,
    cdr: cdr,
    cons: cons,
    isEq: isEq,
    Chapter2: Chapter2
  };
})(this);
