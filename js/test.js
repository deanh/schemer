/*global QUnit, isEq, isAtom, isNull, car, cdr, cons */
QUnit.module("Chapter 1: Toys");
QUnit.test("Primitives", function testPrimitives(assert) {
  function foo1() { return 1; }
  function foo2() { return 2; }

  assert.ok(isAtom("a"), "a is an atom");
  assert.notOk(isAtom(["a"]), "['a'] is not an atom");
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

  l = [[["hotdogs"]], ["and"], ["pickle"], ["relish"]];
  assert.ok(isEq(car(l), [["hotdogs"]]));

  l = [["b"], ["x", "y"], [["c"]]];
  assert.ok(isEq(cdr(cdr(l)),[[["c"]]]));

});

QUnit.module("Chapter 2: Do it again...");
QUnit.test("isLat", function testIsLat(assert) {
  //(check-true (lat? '(Jack Sprat could eat no chicken fat)))
  assert.ok(isLat(["Jack", "Sprat", "could", "eat", "no", "chicken", "fat"]),
           "array of atoms isLat");
  //(check-false (lat? '((Jack) Sprat could eat no chicken fat)))
  assert.notOk(isLat([["Jack"], "sprat", "could", "eat", "no", "chicken", "fat"]),
               "array with inner array is not a lat");
  //(check-false (lat? '(Jack (Sprat could) eat no chicken fat)))
  assert.notOk(isLat(["Jack", ["sprat", "could"], "eat", "no", "chicken", "fat"]),
               "array with inner array is not a lat");
  //(check-true (lat? '()))
  assert.ok(isLat([]), "empty array isLat");
});

QUnit.test("isMember", function (assert) {
  //(check-true (member? 'tea '(coffee tea or milk)))
  assert.ok(isMember("tea", "coffee tea or milk".split(" ")));
  //(Check-false (member? 'poached '(fried eggs and scrambled eggs)))
  assert.notOk(isMember("poached", "fired eggs and scrambled eggs".split(" ")));
  //(check-false (member? 'liver '(bagels and lox)))
  assert.notOk(isMember("liver", "bagels and lox".split(" ")));
});

QUnit.module("Chapter 3: Cons the Magnificent");
QUnit.test("rember", function(assert) {
  //(check-equal? (rember 'bacon '(bacon lettuce and tomato)) '(lettuce and tomato))
  assert.deepEqual(rember("bacon", "bacon lettuce and tomato".split(" ")),
                   "lettuce and tomato".split(" "));
  //(check-equal? (rember 'and '(bacon lettuce and tomato)) '(bacon lettuce tomato))
  assert.deepEqual(rember("and", "bacon lettuce and tomato".split(" ")),
                   "bacon lettuce tomato".split(" "));
  //(check-equal? (rember 'sauce '(soy sauce and tomato sauce)) '(soy and tomato sauce))
  assert.deepEqual(rember("sauce", "soy sauce and tomato sauce".split(" ")),
                   "soy and tomato sauce".split(" "));
});

QUnit.test("firsts", function(assert) {
  assert.deepEqual(
    firsts([
      "apple peach pumpkin".split(" "),
      "plum pear cherry".split(" "),
      "grape raisin pea".split(" "),
      "bean carrot eggplant".split(" ")
    ]),
    "apple plum grape bean".split(" ")
  );

  assert.deepEqual(
    firsts([
      "a b".split(" "),
      "c d".split(" "),
      "e f".split(" ")
    ]),
    "a c e".split(" ")
  );

  assert.deepEqual(firsts([]), []);

  assert.deepEqual(
    firsts([
      [["five", "plums"], "four"],
      ["eleven", "green", "oranges"],
      [["no"], "more"]
    ]),
    [["five", "plums"], "eleven", ["no"]]
  )
});

QUnit.test("insertR", function(assert) {
  assert.deepEqual(
    insertR("topping", "fudge", "ice cream with fudge for dessert".split(" ")),
    "ice cream with fudge topping for dessert".split(" ")
  );

  assert.deepEqual(
    insertR("jalapeño", "and", "tacos tamales and salsa".split(" ")),
    "tacos tamales and jalapeño salsa".split(" ")
  );

  assert.deepEqual(
    insertR("e", "d", "a b c d f g d h".split(" ")),
    "a b c d e f g d h".split(" ")
  );
});

QUnit.test("insertL", function(assert) {
  assert.deepEqual(
    insertL("topping", "fudge", "ice cream with fudge for dessert".split(" ")),
    "ice cream with topping fudge for dessert".split(" ")
  );

  assert.deepEqual(
    insertL("jalapeño", "and", "tacos tamales and salsa".split(" ")),
    "tacos tamales jalapeño and salsa".split(" ")
  );

  assert.deepEqual(
    insertL("e", "d", "a b c d f g d h".split(" ")),
    "a b c e d f g d h".split(" ")
  );
});

QUnit.test("subst", function(assert) {
  assert.deepEqual(
    subst("topping", "fudge", "ice cream with fudge for dessert".split(" ")),
    "ice cream with topping for dessert".split(" ")
  );

  assert.deepEqual(
    subst("jalapeño", "and", "tacos tamales and salsa".split(" ")),
    "tacos tamales jalapeño salsa".split(" ")
  );

  assert.deepEqual(
    subst("e", "d", "a b c d f g d h".split(" ")),
    "a b c e f g d h".split(" ")
  );
});

QUnit.test("subst2", function(assert) {
  assert.deepEqual(
    subst2("vanilla", "chocolate", "banana",
           "banana ice cream with chocolate topping".split(" ")),
    "vanilla ice cream with chocolate topping".split(" ")
  );
});

QUnit.test("multirember", function(assert) {
  assert.deepEqual(
    multirember("cup", "coffee cup tea cup and hick cup".split(" ")),
    "coffee tea and hick".split(" ")
  );
});

QUnit.test("multiinsertR", function(assert) {
  assert.deepEqual(
    multiinsertR("fried", "fish", "chips and fish or fish and fried".split(" ")),
    "chips and fish fried or fish fried and fried".split(" ")
  )
});

QUnit.test("multiinsertL", function(assert) {
  assert.deepEqual(
    multiinsertL("fried", "fish", "chips and fish or fish and fried".split(" ")),
    "chips and fried fish or fried fish and fried".split(" ")
  )
});

QUnit.test("multisubst", function(assert) {
  assert.deepEqual(
    multisubst("fried", "fish", "chips and fish or fish and fried".split(" ")),
    "chips and fried or fried and fried".split(" ")
  )
})
