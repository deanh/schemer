/*global QUnit, isEq, isAtom, isNull, car, cdr, cons */
QUnit.module("Chapter 1: Toys");

QUnit.test("Primitives", function testPrimitives(assert) {
  function foo1() { return 1; }
  function foo2() { return 2; }

  assert.ok(isAtom('a'), "'a' is an atom");
  assert.notOk(isAtom(['a']), "['a'] is not an atom");
  assert.ok(isNull([]), "Empty array isNull");
  assert.notOk(isNull([1]), "Non-empty array is not null");
  assert.equal(1, car([1,2,3]), "car([1,2,3]) is 1");
  assert.deepEqual([2,3], cdr([1,2,3]), "cdr([1,2,3]) is [2,3]");
  assert.deepEqual([1], cons(1, []), "cons(1, []) is [1]");
  assert.ok(isEq(1,1), "isEq() between like atoms is true");
  assert.notOk(isEq(1,2), "isEq() between unlike atoms is false");
  assert.ok(isEq([1],[1]), "isEq() between like lists is true");
  assert.notOk(isEq([1],[2,3]), "isEq() between unlike lists is false");
  assert.ok(isEq(foo1, foo1), "isEq() between the same fn is true");
  assert.notOk(isEq(foo1, foo2), "isEq() between different functions is false");
});

QUnit.test("Let's play", function testLetsPlay(assert) {
  // this is much harder to deal with in js than racket
  var l, a, s, a1, a2;

  l = [[['hotdogs']], ['and'], ['pickle'], ['relish']];
  assert.ok(isEq(car(l), [['hotdogs']]));

  l = [['b'], ['x', 'y'], [['c']]];
  assert.ok(isEq(cdr(cdr(l)),[[['c']]]));

});
