[![Build Status](https:secure.travis-ci.org/kmalakoff/_.m.png)](http:travis-ci.org/kmalakoff/_.m)

````
_.m
````
_.m is a port of Underscore.js to Objective-C


Global Changes
------------

Other Changes
------------
_()
_Wrapper* __(id); -> two underscores

Arrays
------------

first
_.first = _.head = _.take = function(array, n, guard)
+ (id(^)(A* array, I n))first;  // mandatory second parameter: -1 replaces missing paramter
+ (id(^)(A* array, ... /* KEY, LIST */))firstIterator; // CHANGE


initial
_.initial = function(array, n, guard)
+ (A*(^)(A* array, I n))initial; // mandatory second parameter: -1 replaces missing paramter
+ (A*(^)(A* array, ... /* KEY, LIST */))initialIterator; // CHANGE

last
_.last = function(array, n, guard)
+ (id(^)(A* array, I n))last; // mandatory second parameter: -1 replaces missing paramter
+ (A*(^)(A* array, ... /* KEY, LIST */))lastIterator; // CHANGE

rest
_.rest = _.tail = function(array, index, guard)
+ (A*(^)(A* array, I index))rest; // mandatory second parameter: -1 replaces missing paramter
+ (A*(^)(A* array, ... /* KEY, LIST */))restIterator; // CHANGE

compact
_.compact = function(array)
+ (A*(^)(A* array))compact;

flatten
_.flatten = function(array, shallow)
+ (A*(^)(A* array, B shallow))flatten;
// CHANGE: shallow is mandatory or should have two versions? (N* used for compatiblity with map not as an index)

without
_.without = function(array, ...)
+ (A*(^)(A* array, id value1, ... /* NIL_TERMINATED*/))without;

union
_.union = function(...)
+ (A*(^)(A* array, ... /* NIL_TERMINATED*/))union;

intersection
_.intersection = function(...)
+ (A*(^)(A* array, ... /* NIL_TERMINATED*/))intersection;

difference
_.difference = function(array)
+ (A*(^)(A* array, A* array1, ... /* NIL_TERMINATED*/))difference;

uniq
_.uniq = _.unique = function(array, isSorted, iterator)
+ (id(^)(A* array, array))uniq;
+ (id(^)(A* array, array, B isSorted, _MapBlock iterator))uniqAdvanced;

zip
_.zip = function(...)
+ (A*(^)(A* array, A* array1, ... /* NIL_TERMINATED*/))zip;

_.zipObject = function(keys, values)
+ (O*(^)(NSA* keys, NSA* values))zipObject //ADDED

indexOf
_.indexOf = function(array, item, isSorted)
+ (I (^)(A* array, id value, B isSorted))indexOf;
+ (I(^)(NSA* array, id value))indexOf;
+ (I(^)(NSA* array, id value))indexOfSorted; // SPECIALIZED: sorted method

lastIndexOf
_.lastIndexOf = function(array, item)
+ (I (^)(A* array, id value))lastIndexOf;

range
_.range = function(start, stop, step)
+ (I (^)(I start, I stop, I step))range;

Chaining
------------

chain
value

Collections
------------

each
  var each = _.each = _.forEach = function(obj, iterator, context)
+ (void(^)(id obj, _EachBlock iterator))each;
CHANGE: no collection (was used for guard, but removed due to variable arguments not possible). Context is a JS language feature

map
_.map = _.collect = function(obj, iterator, context)
+ (id(^)(id obj, _MapBlock iterator))map;
CHANGE: no collection (was used for guard, but removed due to variable arguments not possible). Context is a JS language feature

reduce
reduceRight
find

filter
  _.filter = _.select = function(obj, iterator, context) {
+ (A*(^)(id obj, _ItemTestBlock iterator))filter;
CHANGE: Context is a JS language feature

reject
all
any

include



invoke
pluck

max
CHANGE: Context is a JS language feature

min
sortBy
groupBy
sortedIndex
shuffle
toArray
size


Functions
------------

bind
bindAll
memoize
delay
+ (void(^)(_DelayBlock func, I waitNS))delay; /* REMOVED: ARGUMENTS -> too rare use case and can capture in block
+ (void(^)(_DelayBlock func, I waitNS))delayBackground; /* ADDED: BACKGROUND QUEUE */

+ (void(^)(_DeferBlock func))defer;
+ (void(^)(_DeferBlock func))deferBackground; /* ADDED: BACKGROUND QUEUE */
defer
throttle
debounce
once
after
wrap
compose

Objects
------------

keys
values
functions
extend
pick
defaults
clone
tap
has
isEqual
isEmpty
isElement

isArray
_.isArray = function(obj)
+ (B(^)(id obj))isArray;

isObject
_.isObject = function(obj)
+ (B(^)(id obj))isObject;

isArguments
isFunction
isString
isNumber
isFinite
isBoolean
isDate
_.isDate = function(obj)
+ (B(^)(id obj))isDate;

isRegExp
isNaN

isNull
_.isNull = function(obj)
+ (B(^)(id obj))isNull;

isUndefined

// ADDED
+ (B(^)(id obj))isDictionary
+ (B(^)(id obj))isTruthy
+ (B(^)(id obj))isFalsy

Utility
------------

noConflict

identity
identityTruthy /* SPECIALIZED */

times
mixin
uniqueId
escape
result
template


Arguments
------------
Added new category


***************
SS:

delete obj.key or delete obj['key'] -> obj.delete_(@"key") -> what is the delete resevered word for..can it be used?