
## ES6(ECMA2015) 관련

https://github.com/lukehoban/es6features#destructuring

* arrow function

일반 함수와 함수 축약형으로 설정시 가장 큰 차이점은 this(Lexical this)부분이며, 콜백에서 많이 사용, this부분을 사용할 경우 유의 필요

화살표 함수의 경우 생성자(constructor)를 사용 할 수 없다.


* classes
  - https://jsdev.kr/t/es6/294
  - https://poiemaweb.com/es6-class

생성자를 사용할 수 있다. 상속을 받을 수 있으며, super.xxx()를 사용하여 부모 메소드를 호출
클래스는 선언전에 사용 할 수 없다.
클래스의 필드는 생성자(constructor) 에서만 가능

```javascript
// 클래스 선언문
class Person {
  // constructor(생성자)
  constructor(name) {
    this._name = name;
  }

  sayHi() {
    console.log(`Hi! ${this._name}`);
  }
}

// 인스턴스 생성
const me = new Person('Lee');
me.sayHi(); // Hi! Lee

console.log(me instanceof Person); // true
```

```javascript
class Foo {
  constructor(prop) {
    this.prop = prop;
  }

  static staticMethod() {
    /*
    정적 메소드는 this를 사용할 수 없다.
    정적 메소드 내부에서 this는 클래스의 인스턴스가 아닌 클래스 자신을 가리킨다.
    */
    return 'staticMethod';
  }

  prototypeMethod() {
    return this.prop;
  }
}

// 정적 메소드는 클래스 이름으로 호출한다.
console.log(Foo.staticMethod());

const foo = new Foo(123);
// 정적 메소드는 인스턴스로 호출할 수 없다.
console.log(foo.staticMethod()); // Uncaught TypeError: foo.staticMethod is not a function
```

```javascript
var Foo = (function () {
  // 생성자 함수
  function Foo(prop) {
    this.prop = prop;
  }

  Foo.staticMethod = function () {
    return 'staticMethod';
  };

  Foo.prototype.prototypeMethod = function () {
    return this.prop;
  };

  return Foo;
}());

var foo = new Foo(123);
console.log(foo.prototypeMethod()); // 123
console.log(Foo.staticMethod()); // staticMethod
console.log(foo.staticMethod()); // Uncaught TypeError: foo.staticMethod is not a function
```

* enhanced object literals

enhanced(인핸스트)
객체 설정은 간단하고 편리하게, 프로퍼티 값을 변수로 사용할 경우 변수 명으로 항목이 생성 됨.

```javascript
// 프로퍼티를 변수로 사용 할 경우 변수명으로 자동 설정
let x = 1, y = 2;

const obj = { x, y };

console.log(obj); // { x: 1, y: 2 }

// 함수명으로 자동 프로퍼티명 설정
const obj = {
  name: 'Lee',
  // 메소드 축약 표현
  sayHi() {
    console.log('Hi! ' + this.name);
  }
};

obj.sayHi(); // Hi! Lee
```

es5에서는 부모 설정을 하기 위해서는 `var child = Object.create(parent);` 로 시작했어야 하나
```javascript
const parent = {
  name: 'parent',
  sayHi() {
    console.log('Hi! ' + this.name);
  }
};

const child = {
  // child 객체의 프로토타입 객체에 parent 객체를 바인딩하여 상속을 구현한다.
  __proto__: parent,
  name: 'child'
};

parent.sayHi(); // Hi! parent
child.sayHi();  // Hi! child
```



* template literal 

백택(\`) 으로 정의. 일반적인 문자열에서는 줄바꿈이 허용되지 않으므로 백슬러시로 시작하는 `이스케이프시퀀스` 사용 + 연산자를 사용하지 않고도 문자열을 만들 수 있는 문자열 인터폴레이션(String interpolation) `${...}` 표현


* destructuring(디스트럭처링) 


구조화된 배열 또는 개체를 비구조화, 파괴하여 개별적 변수에 할당, 배열 또는 객체에 필요한 값만 추출하여 변수에 할당

```javascript
[x, y, z] = [1,2,3] // x=1, y=2, z=3
[x,  , z] = [1,2,3] // x = 1, z = 3
[x, y, z=1] = [1,2] // x=1, y=2, z=1


// 프로퍼티 키가 prop1인 프로퍼티의 값을 변수 p1에 할당
// 프로퍼티 키가 prop2인 프로퍼티의 값을 변수 p2에 할당
const { prop1: p1, prop2: p2 } = { prop1: 'a', prop2: 'b' };
console.log(p1, p2); // 'a' 'b'
console.log({ prop1: p1, prop2: p2 }); // { prop1: 'a', prop2: 'b' }

// 아래는 위의 축약형이다
const { prop1, prop2 } = { prop1: 'a', prop2: 'b' };
console.log({ prop1, prop2 }); // { prop1: 'a', prop2: 'b' }

// default value
const { prop1, prop2, prop3 = 'c' } = { prop1: 'a', prop2: 'b' };
console.log({ prop1, prop2, prop3 }); // { prop1: 'a', prop2: 'b', prop3: 'c' }

```

* default + rest + spread(스프레드)

default 인자값이 없는 경우 기본 값을 설정 할 수 있다.
```javascript
function sum(x = 0, y = 0) {

  console.log(arguments); // default 값으로 설정된 것은 length 에 포함되지 않음.
  // arguments 는 유사 배열로 사용할 경우 Array.prototype.slice.call(arguments) 를 사용하여 array 객체로 인지

  return x+y;
}

console.log(sum()); // 0 x =0, y = 0으로 설정.
console.log(sum(5)); // 5 x =5, y = 0으로 설정.
```

rest parameter 는 파라메터의 나머지 매개변수를 `...` 붙여 정의한 매개변수 배열로 받는것.
rest 파라메터는 반드시 마지막에만 사용 가능, 매개변수를 설정하고 남은 것에 대해서 할당
```javascript
function foo(...rest) {
  console.log(Array.isArray(rest)); // true
  console.log(rest); // [ 1, 2, 3, 4, 5 ]
}

foo(1, 2, 3, 4, 5);

function bar(param1, param2, ...rest) {
  console.log(param1); // 1
  console.log(param2); // 2
  console.log(rest);   // [ 3, 4, 5 ]
}

bar(1, 2, 3, 4, 5);
```

spread(스프레드) 문법의 경우 리터럴 객체를 요소를 분리한다. spread 대상은 이터러블 객체

```javascript

// ...[1, 2, 3]는 [1, 2, 3]을 개별 요소로 분리한다(→ 1, 2, 3)
console.log(...[1, 2, 3]) // 1, 2, 3

// 문자열은 이터러블이다.
console.log(...'Hello');  // H e l l o

// Map과 Set은 이터러블이다.
console.log(...new Map([['a', '1'], ['b', '2']]));  // [ 'a', '1' ] [ 'b', '2' ]
console.log(...new Set([1, 2, 3]));  // 1 2 3

// 이터러블이 아닌 일반 객체는 Spread 문법의 대상이 될 수 없다.
console.log(...{ a: 1, b: 2 });
// TypeError: Found non-callable @@iterator
```

`Rest 파라미터는 Spread 문법을 사용하여 파라미터를 정의한 것을 의미한다. 형태가 동일하여 혼동할 수 있으므로 주의가 필요하다.`

spread 로 배열 복사를 할 경우 앝은 복사로 이루어짐. (객체는 새로운 것이지만 내용은 같은 것)
```javascript
const todos = [
  { id: 1, content: 'HTML', completed: false },
  { id: 2, content: 'CSS', completed: true },
  { id: 3, content: 'Javascript', completed: false }
];

// shallow copy
// const _todos = todos.slice();
const _todos = [...todos];
console.log(_todos === todos); // false

// 배열의 요소는 같다. 즉, 얕은 복사되었다.
console.log(_todos[0] === todos[0]); // true
```

객체의 병합
```javascript
// 객체의 병합
const merged = { ...{ x: 1, y: 2 }, ...{ y: 10, z: 3 } };
console.log(merged); // { x: 1, y: 10, z: 3 }

// 특정 프로퍼티 변경
const changed = { ...{ x: 1, y: 2 }, y: 100 };
// changed = { ...{ x: 1, y: 2 }, ...{ y: 100 } }
console.log(changed); // { x: 1, y: 100 }

// 프로퍼티 추가
const added = { ...{ x: 1, y: 2 }, z: 0 };
// added = { ...{ x: 1, y: 2 }, ...{ z: 0 } }
console.log(added); // { x: 1, y: 2, z: 0 }
```

* let + const -- const 상수, 오브젝트 변환 추가 필요

let 블록레벨 스코프
const 상수 - 재할당 금지
객체의 경우 내부 값은 변경해도 오류가 나지 않음


* iterators + for…of

이터러블 프로토콜을 준수한 객체는 for…of 문으로 순회할 수 있고 Spread 문법의 피연산자가 될 수 있다.
이터러블 프로토콜에는 `Symbol.iterator 이터레이터 심볼 매소드를 구현하였거나 상속`되어야 한다.

이터레이터 프로토콜은 `next 메소드 소유` 이터러블을 순환하며 value, done 값을 돌려준다.

이터레이터를 이용하여 디스트럭처링(변수 분활), spread, for ... of, map/set 생성자 에서 사용

for ... in 은 속성을 반복하며, 
hasOwnProperty 나의 속성인지 판단

**이터러블**
```javascript
const array = [1, 2, 3];

// 배열은 Symbol.iterator 메소드를 소유한다.
// 따라서 배열은 이터러블 프로토콜을 준수한 이터러블이다.
console.log(Symbol.iterator in array); // true

// 이터러블 프로토콜을 준수한 배열은 for...of 문에서 순회 가능하다.
for (const item of array) {
  console.log(item);
}
```
**이터레이터**
> 이터레이터 프로토콜은 next 메소드를 소유하며 next 메소드를 호출하면 이터러블을 순회하며 value, done 프로퍼티를 갖는 이터레이터 리절트 객체를 반환하는 것이다. 이 규약을 준수한 객체가 이터레이터이다.   
이터러블 프로토콜을 준수한 이터러블은 Symbol.iterator 메소드를 소유한다. 이 메소드를 호출하면 이터레이터를 반환한다. 이터레이터 프로토콜을 준수한 이터레이터는 next 메소드를 갖는다.

```javascript
// 배열은 이터러블 프로토콜을 준수한 이터러블이다.
const array = [1, 2, 3];

// Symbol.iterator 메소드는 이터레이터를 반환한다.
const iterator = array[Symbol.iterator]();

// 이터레이터 프로토콜을 준수한 이터레이터는 next 메소드를 갖는다.
console.log('next' in iterator); // true

// 이터레이터의 next 메소드를 호출하면 value, done 프로퍼티를 갖는 이터레이터 리절트 객체를 반환한다.
// next 메소드를 호출할 때 마다 이터러블을 순회하며 이터레이터 리절트 객체를 반환한다.
console.log(iterator.next()); // {value: 1, done: false}
console.log(iterator.next()); // {value: 2, done: false}
console.log(iterator.next()); // {value: 3, done: false}
console.log(iterator.next()); // {value: undefined, done: true}
```

(https://poiemaweb.com/es6-iteration-for-of)

* generator

ES6에서 도입된 제너레이터(Generator) 함수는 이터러블을 생성하는 함수이다. 제너레이터 함수를 사용하면 이터레이션 프로토콜을 준수해 이터러블을 생성하는 방식보다 간편하게 이터러블을 구현할 수 있다. 또한 제너레이터 함수는 비동기 처리에 유용하게 사용된다
`제너레이터 함수는 일반 함수와는 다른 독특한 동작을 한다. 제너레이터 함수는 일반 함수와 같이 함수의 코드 블록을 한 번에 실행하지 않고 함수 코드 블록의 실행을 일시 중지했다가 필요한 시점에 재시작할 수 있는 특수한 함수이다`

**제너레이터 함수는 function\* 키워드로 선언한다. 그리고 하나 이상의 yield([jiːld]) 문을 포함한다.**

```javascript
// 제너레이터 함수 정의
function* counter() {
  for (const v of [1, 2, 3]) yield v;
  // => yield* [1, 2, 3];
}

// 제너레이터 함수를 호출하면 제너레이터를 반환한다.
let generatorObj = counter();

// 제너레이터는 이터러블이다.
console.log(Symbol.iterator in generatorObj); // true

for (const i of generatorObj) {
  console.log(i); // 1 2 3
}

generatorObj = counter();

// 제너레이터는 이터레이터이다.
console.log('next' in generatorObj); // true

console.log(generatorObj.next()); // {value: 1, done: false}
console.log(generatorObj.next()); // {value: 2, done: false}
console.log(generatorObj.next()); // {value: 3, done: false}
console.log(generatorObj.next()); // {value: undefined, done: true}
```

```javascript
function* gen(n) {
  let res;
  res = yield n;    // n: 0 ⟸ gen 함수에 전달한 인수

  console.log(res); // res: 1 ⟸ 두번째 next 호출 시 전달한 데이터
  res = yield res;

  console.log(res); // res: 2 ⟸ 세번째 next 호출 시 전달한 데이터
  res = yield res;

  console.log(res); // res: 3 ⟸ 네번째 next 호출 시 전달한 데이터
  return res;
}
const generatorObj = gen(0);

console.log(generatorObj.next());  // 제너레이터 함수 시작
console.log(generatorObj.next(1)); // 제너레이터 객체에 1 전달
console.log(generatorObj.next(2)); // 제너레이터 객체에 2 전달
console.log(generatorObj.next(3)); // 제너레이터 객체에 3 전달
/*
{ value: 0, done: false }
{ value: 1, done: false }
{ value: 2, done: false }
{ value: 3, done: true }
*/
```

**ES7 async/await 추가**

```javascript
const fetch = require('node-fetch');

// Promise를 반환하는 함수 정의
function getUser(username) {
  return fetch(`https://api.github.com/users/${username}`)
    .then(res => res.json())
    .then(user => user.name);
}

async function getUserAll() {
  let user;
  user = await getUser('jeresig');
  console.log(user);

  user = await getUser('ahejlsberg');
  console.log(user);

  user = await getUser('ungmo2');
  console.log(user);
}

getUserAll();
```
* module loaders

CommonJS방식으로 모듈 로더.
export keyword로 해당 변수 공개
모듈에서 하나만 export 할 경우 default 키워드를 사용.
default 키워드와 함께 모듈로의 경우 {} 없이 임의의 이름으로 import

```javascript
// lib.mjs
// 라이브러리
const pi = Math.PI;

function square(x) {
  return x * x;
}

class Person {
  constructor(name) {
    this.name = name;
  }
}

// 변수, 함수 클래스를 하나의 객체로 구성하여 공개
export { pi, square, Person };
```

```javascript
// app.mjs
// 같은 폴더 내의 lib.mjs 모듈을 로드.
// lib.mjs 모듈이 export한 식별자로 import한다.
// ES6 모듈의 파일 확장자를 생략할 수 없다.
import { pi, square, Person } from './lib.mjs';  // 사용하려는 곳

console.log(pi);         // 3.141592653589793
console.log(square(10)); // 100
console.log(new Person('Lee')); // Person { name: 'Lee' }
```

```javascript
// app.mjs
import * as lib from './lib.mjs'; // 전체를 로딩하며 하나의 식별자로 판단하려면,

console.log(lib.pi);         // 3.141592653589793
console.log(lib.square(10)); // 100
console.log(new lib.Person('Lee')); // Person { name: 'Lee' }
```


```javascript
//이름을 변경하여 import할 수도 있다
// app.mjs
import { pi as PI, square as sq, Person as P } from './lib.mjs';

console.log(PI);    // 3.141592653589793
console.log(sq(2)); // 4
console.log(new P('Kim')); // Person { name: 'Kim' }
```

* map + set + weakmap + weakset

* * Sets
> 자료형에 관계 없이 원시 값과 객체 참조 모두 유일한 값을 저장  
var s = new Set();  
s.add('hello').add('goodbye').add('hello');  
s.size === 2   
s.has('hello') === true;  
s.clear() ; // 모든 요소 제거  
s.delete(value); // 해당 요소 제거  
s.entries(); // 삽입순으로 [value, value] 로 되는 iterator 객체 반환  
s.forEach();  
s.keys();  
s.values();


* * Map
> 키-값을 기억하며, 삽입 순서도 기억.(Object는 삽입 순서 아님)  
> new Map([iterable]) // 요소가 Key-value 으로 구성된것은 Map에 초기화.  
> Object에서는 키에 String, symbol을 사용할 수 있지만, Map은 함수, 객체, 원시 자료형 등 어떤 값도 사용 가능  
> Map은 size로 쉽게 크기 판단.  
var m = new Map();    
m.set('hello', 42);  
m.set(s, 34);  
m.set(s) == 34;  
m.keys(); // Key itrate  
m.values(); // value itertor  
m.size // length  
m.delete(key);  
m.clear();  
m.has(key);  
for(let [key, val] of m.entries()) { // [key, value] 로 반환  
  ...  
}  
m.forEach(callbackfn)

* * WeakMap 
> 키가 약하게 참조되는 키/값 컬렉션. - 키는 객체여야 함(오직 Object) 원시 데이터를 key로 허용하지 않음.  
> weakMap 내 키는 약하게 유지, 다른 강한 키 참조가 없는 경우 , 모든 항목은 가비지 컬렉터에 의해 weakmap에서 제거  
> 열거불가, 키 목록을 제공하는 메서드가 없음.  

var wm = new WeakMap();

wm.length   
wm.delete(key)  
wm.get(key);   
wm.has(key); // 존재 여부.  
// wm.clear(); 없음.  

`http://chanlee.github.io/2016/08/15/hello-es6-part-3/`
`https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/WeakMap`

* proxies 

프록시(Proxy)를 사용하면 호스트 객체에 다양한 기능을 추가하여 객체를 생성할 수 있습니다. interception, 객체 추상화, 로깅/수집, 값 검증 등에 사용될 수 있습니다.

* symbol

기존 JS는 6개 타입만 존재 원시타입(String, Number, boolean, null, undefined) + 객체(Object)  
Symbol(`변경 불가능한 원시타입`)  추가  
심볼은 이름 충돌이 없는 유일한 객체의 프러퍼티를 만둘기 위함  
심볼 생성은 new Symbol() 하지 않음.  


```javascript
let mySymbol = Symbol();

console.log(mySymbol);        // Symbol()
console.log(typeof mySymbol); // symbol
```

```javascript
let symbolWithDesc = Symbol('ungmo2'); // 심볼의 이름은 symbol 생성에는 관계가 없으며 디버깅시 용의 - 심볼 디스크립션

console.log(symbolWithDesc); // Symbol(ungmo2)
console.log(symbolWithDesc === Symbol('ungmo2')); // false
```

```javascript
const obj = {};

const mySymbol = Symbol('mySymbol');
obj[mySymbol] = 123;

console.log(obj); // { [Symbol(mySymbol)]: 123 }
console.log(obj[mySymbol]); // 123
```

> - Symbol.iterator
Well-Known Symbol은 자바스크립트 엔진에 상수로 존재하며 자바스크립트 엔진은 Well-Known Symbol을 참조하여 일정한 처리를 한다. 예를 들어 어떤 객체가 Symbol.iterator를 프로퍼티 key로 사용한 메소드 가지고 있으면 자바스크립트 엔진은 이 객체가 이터레이션 프로토콜을 따르는 것으로 간주하고 이터레이터로 동작하도록 한다.  
Array, String, Map, Set, DOM data, arguments

> - Symbol.for
Symbol.for 메소드는 인자로 전달받은 문자열을 키로 사용하여 Symbol 값들이 저장되어 있는 전역 Symbol 레지스트리에서 해당 키와 일치하는 저장된 Symbol 값을 검색한다. 이때 검색에 성공하면 검색된 Symbol 값을 반환하고, 검색에 실패하면 새로운 Symbol 값을 생성하여 해당 키로 전역 Symbol 레지스트리에 저장한 후, Symbol 값을 반환한다.
``` javascript
// 전역 Symbol 레지스트리에 foo라는 키로 저장된 Symbol이 없으면 새로운 Symbol 생성
const s1 = Symbol.for('foo');
// 전역 Symbol 레지스트리에 foo라는 키로 저장된 Symbol이 있으면 해당 Symbol을 반환
const s2 = Symbol.for('foo');

console.log(s1 === s2); // true
```



* subclassable built-ins
* promises -- 동기화 then, 확인 필요

자바스크립트의 비동기 방식으로 처리 하기 위한 패턴으로 콜백 함수 사용
예외 처리의 한계
Promise는 resolve 와 reject 을 매개변수로 받음

```javascript
// Promise 객체의 생성
const promise = new Promise((resolve, reject) => {
  // 비동기 작업을 수행한다.

  if (/* 비동기 작업 수행 성공 */) {
    resolve('result');
  }
  else { /* 비동기 작업 수행 실패 */
    reject('failure reason');
  }
});

```

```javascript
promiseAjax('GET', 'http://jsonplaceholder.typicode.com/posts/1')
  .then(JSON.parse) // 성공
  .then(render) // 실패
  .catch(console.error); //오류
  ```

> Promise  상태
> - pending : 대기 => resolve, reject 호출 전
> - fulfilled : 비동기 처리가 수행된 상태 => resolve 호출
> - rejected : 비동기 처리 실패 => reject
> - settled(세틀드) : 비동기 처리가 수행된 상태 -> resolve 또는 reject 호출

`Promise.all 메소드는 프로미스가 담겨 있는 배열 등의 이터러블을 인자로 전달 받는다. 병렬 처리. 하나만 실패해도 실패, 전체 성공이 성공`
`Promise.race 메소드는 Promise.all 메소드와 동일하게 프로미스가 담겨 있는 배열 등의 이터러블을 인자로 전달 받는다. 그리고 Promise.race 메소드는 Promise.all 메소드처럼 모든 프로미스를 병렬 처리하는 것이 아니라 가장 먼저 처리된 프로미스가 resolve한 처리 결과를 resolve하는 새로운 프로미스를 반환한다.`


* math + number + string + array + object APIs

iterator.includes('ab'); // true  
'abcdef'.includes('ab'); // true  

* binary and octal literals
* reflect api
* tail calls


### Old
* concat 배열 붙이기
* slice 배열 복제
* splice 배열 자르기(항목 추가)
* fn.call(null, arg) 함수 호출 - 매개변수 하나
* fn.apply(null, arr args) 함수 호출 - 매개변수 여러개.
* push 항목 추가
* pop 항목 빼기
* shift 앞에 항목 빼기
* unshift 앞에 항목을 한칸씩 밀고 앞에 추가
* 



## Javascript
### 스코프 https://poiemaweb.com/js-scope
> 자바스크립트에서 스코프는 함수레벨 스코프를 따름, 함수 내에서 선언된 변수는 함수 외부에서 사용하지 못함, es6에서 도입된 let을 사용할 경우 블록 레벨 스코프를 사용
> 자바스크립트에서 변수를 찾는 방식은 렉시컬 스코프 방식을 통하여, 실행 환경이 아닌 선언 환경에 따라 상위 스코프를 결정, (실행 환경에 따르는 것을 동적 스코프, 선언 환경을 따르는 것을 적정 스코프, 렉시컬 스코프라고 함)

### 렉시컬 스코프

> 프로그램은 함수를 어디서 호출했는지에 따라서 상위 스코프가 결정되던지(동적 스코프), 어디에서 선언되었는지에 따라서 상위 스코프(`렉시컬 스코프`, 정적 스코프)를 결정한다. 


### this

자바스크립트에서 this는 함수를 어떻게 호출했는지에 따라 결정.

> new 로 선언시 this는 빈객체로 생성 할당 됨
> 호출 시점에 this 객체를 변경하기 위해 call, apply, bind 가 있음

### 실행 컨텍스트
* 실행컨텍스트 (실행가능한 코드를 형상화하고 구분하는 추상적인 개념)  
`EC (Execution Context)`

> 실행 컨텍스트(Execution Context)는 scope, hoisting, this, function, closure 등 동작원리를 담고 있음
> 함수를 호출하면 실행컨텍스트 스택에 쌓임.


1. 스코프 생성 및 초기화

> 스코프 생성 및 초기화 진행
> 스코프 체인은 변수를 검색하기 위한 방식.(식별자 중 변수가 아닌 객체를 검색하는 프로퍼티는 프로토타입 체인)
> JS엔진은 스코프 체인을 통해 렉시컬 스코프를 파악. 
> 스코프체인이라는 의미는 해당 변수를 현재 스코프에서 검색 없을 경우 상위 스코프로 올라가면서 찾는 것을 스코프 체인이라고 함.


2. Variable Instantiation `Variable Object (VO/변수 객체)`
> 스코프 체인 생성 및 초기화가 종료되면 Variable Instantiation(변수 객체화) 실행
> 실행에 필요한 여러 정보 생성(변수, 매개변수(arguments), 함수 선언(함수 표현식 제외))
> > 변수 선언 방식
> > 1. 매개변수가 인수(arguments)로 선언
> > 2. 대상 코드에서 함수 선언식이 호이스팅됨(함수 호이스팅)
> > 3. 변수 호이스팅 (undefined) 됨. var는 선언과 초기화가 같이되어 undfined, let은 선언만 되어 있기 때문에 ref오류.
> arguments 프로퍼티 초기화, 스코프 체인 연결
> 전역 컨텍스트와 함수 컨텍스트(`Activation Ojbect/ AO- 할성화객체`)는 다른점은 전역의 경우 매개변수와 인자가 없기 때문에 전역에는 arugments Object가 없다. 전역 컨텍스트의 경우 `GO(Global Object)를 가리킴`



3. this value 할당

> this value 가 할당되며, 결정되기 전에는 this는 전역객체를 가르키고 있다가, 호출되는 패턴에 의해 this 값 할당 

### 변수 생성 단계

호이스팅을 통해서 변수는 상단에 올라와서 선언은 되지만, 실제 할당은 그 위치에서 됨.

1. 선언단계(declaration phses)
2. 초기화단계(Initalization phses) - undefined로 초기화
3. 할당 단계(Assignment phses) - undefined에 실제 사용 값 할당
`var의 경우 선언과 초기화가 함께 이루어지기 때문에 순서에 관련없이 사용해도  undefined로 표시`

선언 단계(ReferenceError)에서 초기화 단계 사이에는 일시적인 사각지대(TDZ = Temporal Dead Zone)에 빠져서 ReferenceError발생.


### 프로토타입



### 즉시실행함수(IIFE) => Immediately Invoked Function Expression
```javascript
// 선언 후 바로 실행
(() => {
  ...
})();
```
### 모듈 생성
  * 샌드박스 : 유틸성으로 사용할 때.
```javascript

var modal = (function(){

  ...

  return {
    open: function(){ ... },
    close: function(){ ... }
  }
}());
```


### 패턴(Scope-Safe Constructor) 

> **네임스페이스란** 수많은 함수, 객체, 변수들로 이루어진 코드가 전역 유효범위를 어지럽히지 않고, 애플리케이션이나 라이브러리를 위한 하나의 전역 객체를 만들고 모든 기능을 이 객체에 추가하는 것을 말합니다  
코드에 네임스페이스를 지정해주며, 코드 내의 이름 충돌뿐만 아니라 이 코드와 같은 페이지에 존재하는 또 다른 자바스크립트 라이브러리나 위젯등 서드파티 코드와의 이름 충돌도 미연에 방지해 주는 것입니다  
출처: https://webclub.tistory.com/5 [Web Club]  
네임스페이스 모듈이란 하나의 대표적 객체명 아래 필요한 변수, 객체, 함수를 모아두는 패턴이며, 네임스페이스 아래 집합되어 있으며로 전역 컨텐스트를 어지럽히지 않는 장점이 있다.


#### Module 패턴
(https://itstory.tk/entry/%EA%BC%AD-%EC%95%8C%EC%95%84%EC%95%BC%ED%95%98%EB%8A%94-Javascript-%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4-4%EA%B0%80%EC%A7%80)

Java의 클래스와 유사
public, private 으로 구분될 수 있음.

```javascript
(function() { 
  // private 변수들과 함수들을 선언 
  return { 
    // public 변수들과 함수들을 선언
  }
})();
```

```javascript
var HTMLChanger = (function() {
  var contents = 'contents' 
  var changeHTML = function() { 
    var element = document.getElementById('attribute-to-change');
    element.innerHTML = contents; 
  } 
  
  return { 
    callChangeHTML: function() { 
      changeHTML(); 
      console.log(contents); 
    } 
  }; 
})(); 

HTMLChanger.callChangeHTML(); // Outputs: 'contents' 
console.log(HTMLChanger.contents); // undefined
```

단점
> - 전체적으로 코드량이 약간 더 많아지고 따라서 다운로드해야 하는 파일크기도 늘어난다.
> - 전역 인스턴스가 단 하나뿐이기 때문에 코드의 어느 한 부분이 수정되어도 전역 인스턴스를  수정하게 된다. 
> 즉, 나머지 기능들도 갱신된 상태를 물려받게 된다.

장점
> - 점점 더 늘어만 가는 코드를 정리할때 널리 사용되며 자바스크립트 코딩패턴에서 널리 권장되는 방법이기도 하다
> - 전역 컨텍스트를 어지럽히지 않음.


### 의존관계 설정
```javascript
var myFunction = function () { 
  // 의존 관계에 있는 모듈들 
  var event = YAHOO.util.Event, 
    dom = YAHOO.util.Dom; 
    // 이제 event 와 dom 이라는 변수를 사용한다... 
};

함수의 첫 번째에 의존관계를 선언하는 것은 의존관계를 파악하는데 편리하고, 해당 변수를 접근하는데 지역변수가 빠름
```

#### 즉시객체 초기화
http://www.nextree.co.kr/p7650/

```javascript
({
    // 속성 정의
    name: "nextree",

    // 객체 메소드 정의
    getName: function () {
        return this.name;
    },

    // 초기화 메소드 정의
    init: function () {
        console.log(this.getName());   // nextree 출력
    }
}).init();
```

> 또 한가지 고려해야 할 것은, 즉시 실행 함수와 즉시 객체 초기화의 남용으로 인한 메모리 낭비입니다. JavaScript는 이렇게 할당이 없이 정의만 할 경우, 전역 네임스페이스는 건드리지 않더라도, 전역 실행 컨텍스트(EC: Execution Context)의 temp=[]내에 key-value를 추가하게 됩니다. 이 EC.temp영역은 개발자가 접근할 수 없는 영역입니다. 그렇기 때문에 스크립트 내의 다른 영역은 물론 어디에서도 접근할 수 없어, 소스코드의 신뢰성에는 큰 도움이 됩니다. 하지만 같은 이유로 이 패턴을 남용하면, 직접 관리 할 수 없는 공간에 메모리가 계속 쌓이게 됩니다. 그렇기 때문에 소스코드의 신뢰성과 메모리의 문제를 함께 고민해서, 이를 남용하지 않고 적절히 사용해야 합니다.

#### Observer  패턴

```javascript


```

#### Single Ton 패턴


```javascript
var printer = (function () { 
  var printerInstance; 
  
  function create () { 
    function print() { 
    // underlying printer mechanics 
    } 
    
    function turnOn() { 
      // warm up 
      // check for paper 
    } 
    
    return { 
      // public + private states and behaviors 
      print: print, 
      turnOn: turnOn
    }; 
  } 
    
  return { 
    getInstance: function() { 
      if(!printerInstance) { 
        printerInstance = create();
      } 
      
      return printerInstance; 
    }
  }; 
  
})();

// 사용
var officePrinter = printer.getInstance();

```
#### 샌드박스패턴

> 샌드박스는 본래, 말 그대로 어린이가 안에서 노는 모래 놀이 통을 의미합니다. 모래를 담은 상자에는 그 상자 밖으로 모래를 흘리거나 더럽히지 말고 그 안에서는 맘껏 놀라는 의미가 담긴 것입니다. JavaScript 샌드박스 패턴도 본래의 의미와 같이 코드들이 전역 범위를 더럽히지 않고 맘껏 쓰일 수 있도록 유효 범위를 정해줍니다.
> 
> 위에서 살펴 보았던 네임스페이스 패턴에서는 단 하나의 전역 객체를 생성했습니다. 샌드박스 패턴에서는 생성자를 유일한 전역으로 사용합니다. 그리고 유일한 전역인 생성자에게 콜백 함수(Callback function)를 전달해 모든 기능을 샌드박스 내부 환경으로 격리 시키는 방법을 사용합니다.

```javascript
function Sandbox() {  
        // argument를 배열로 바꿉니다.
    var args = Array.prototype.slice.call(arguments),
        // 마지막 인자는 콜백 함수 
        callback = args.pop(),
        // 모듈은 배열로 전달될 수도있고 개별 인자로 전달 될 수도 있습니다.
        modules = (args[0] && typeof args[0] === "string") ? args : args[0],
        i;

    // 함수가 생성자로 호출되도록 보장(new를 강제하지 않는 패턴)
    if (!(this instanceof Sandbox)) {
        return new Sandbox(modules, callback);
    }

    // this에 필요한 프로퍼티들을 추가
    this.a = 1;
    this.b = 2;

    // "this객체에 모듈을 추가"
    // 모듈이 없거나 "*"(전부)이면 사용 가능한 모든 모듈을 사용한다는 의미입니다.
    if (!modules || modules === '*' || modules[0] === '*') {
        modules = [];
        for (i in Sandbox.Modules) {
            if (Sandbox.modules.hasOwnProperty(i)) {
                modules.push(i);
            }
        }
    }

    // 필요한 모듈들을 초기화
    var m_length = modules.length;
    for (i=0; i<m_length; i+=1) {
        Sandbox.modules[modules[i]](this);
    }

    // 콜백 함수 호출
    callback(this);
}

// 필요한 프로토타입 프로퍼티들을 추가
Sandbox.prototype = {  
    name: "nextree",
    getName: function () {
        return this.name;
    }
};
```

### prototpye
https://poiemaweb.com/js-prototype


> 부모객체인 Person 함수 영역의 this를 Korean 함수 안의 this로 바인딩합니다. 이것은 부모의 속성을 자식 함수 안에 모두 복사합니다. 객체를 생성하고, name을 출력합니다. 객체를 생성할 때 넘겨준 인자를 출력하는 것을 볼 수 있습니다. 기본 방법에서는 부모객체의 멤버를 참조를 통해 물려받았습니다. 하지만 생성자 빌려 쓰기는 부모객체 멤버를 복사하여 자신의 것으로 만들어 버린다는 차이점이 있습니다. 하지만 이 방법은 부모객체의 this로 된 멤버들만 물려받게 되는 단점이 있습니다. 그래서 부모객체의 프로토타입 객체의 멤버들을 물려받지 못합니다. 위 그림 8 그림을 보시면 kor1 객체에서 부모객체의 프로토타입 객체에 대한 링크가 없다는 것을 볼 수 있습니다.
* 생성자 빌려쓰기

http://www.nextree.co.kr/p7323/
```javascript
function Person(name) {  
    this.name = name || "혁준"; }

Person.prototype.getName = function(){  
    return this.name;
};

function Korean(name){  
    Person.apply(this, arguments);
}
Korean.prototype = new Person();

var kor1 = new Korean("지수");  
console.log(kor1.getName());  // 지수 
```

* 생성자와 프로토 타입 지정

```javascript
function Person(name) {  
    this.name = name || "혁준"; }

Person.prototype.getName = function(){  
    return this.name;
};

function Korean(name){  
    Person.apply(this, arguments);
}
Korean.prototype = new Person();

var kor1 = new Korean("지수");  
console.log(kor1.getName());  // 지수 
```

### 클로저

렉시컬 환경으로 실행되어서 외부 실행 컨텍스트가 사라져도 내부 실행 컨텍스트에서 참조되고 있다면 실행환경유 유지되는 것을 말합니다.

외부 실행 컨텍스트가 사라져도 내부 컨텍스트에 참조가 되어있다면, 실행 환경이 유지되는 것을 클로저, 클로저를 이용하여 모듈 구현
`클로저는 함수와 그 함수가 선언되었을 때의 렉시컬 환경 조합`


반환된 내부함수가 자신이 선언되었던 때의 환경을 기억하여(렉시컬 환경= Lexical environment) 밖에서 호출되더라도 그 환경(스코프)에 접근할 수 있는 함수 == 클로저란 자신이 생성되었을 때 환경을 기억(Lexical environment)하는 함수

`렉시컬 스코핑`: 스코프는 함수를 호출할 때 어디서 선언되었는지에 따라 결정






## 웹 성능 향상 방법
  * HTTP 요청 최소화
    * https://wikibook.co.kr/article/web-sites-optimization-1/
    * css 스프라이트 기법 (여러 이미지 파일 하나로 합치는)
    * 자바스크립트 통합

* 파일 크기의 최소화
  * https://wikibook.co.kr/article/web-sites-optimization-2/
  * GZip을 통한 압축
  * 쿠키 크기의 최소화
  * css, js 파일 압축
> [Google Closure Compiler](https://developers.google.com/closure/compiler)


* 랜더링 성능 향상
  * https://wikibook.co.kr/article/web-sites-optimization-3/


> 브라우저가 화면을 보여주는 순서    
> 1. HTML, DOM 트리를 요청하면 네트워크를 통해 마크업을 받아 옴, 파싱을 진행, DOM Tree 생성
> 2. 랜더트리(DOM + Style) 구성을 위해 바로 화면에 나타나지 않고, DOM 트리 구성 후 스타일 규칙을 적용하여 랜더트리(Render Tree) 구성
> 3. 랜더트리 배치의 최종적으로 스타일 규칙에 따른 각 요소를 화면에 배치 좌표 설정
> 4. 랜더트리 요소의 좌표가 설정되면, 브라우저에 순차적으로 화면 그리기.   

*  * style은 최상단, script 는 하단에 배치
> style의 최상단 위치는 브라우저의 랜더링 단계에서 사용자에게 보여줄 화면을 보여주기 전에 랜더트리를 생성하는데, 이 때 스타일 시트가 필요하다. 그리고 FF, IE의 경우 스타일시트 파일 모두 다운로드 전까지 랜더링을 하지 않고 대기한다.
> script 파일의 하단 위치. 브라우저는 스크립트를 다운받기를 요청하면 완료될때까지 DOM 파싱을 중지하고, 렌더링을 진행하지 않음. 자바스크립트안에 `document.write(...)`를 통해 DOM을 추가할 수 있기 때문. 
* * 초기 렌더링시 ajax 요청 최소화

> 화면의 정의를 ajax로 하는 경우 해당 데이터가 오기 전까지 화면이 멈춤것 처럼 보임.
* * 마크업의 최적화
> table 태그의 경우 table 전체 DOM이 완성후 한번에 나타나므로, table보다는 div로 작업할 경우 화면이 순차적으로 표시.
> 전체 태그를 1000개 미만으로 하되, 태그 중복을 최소화
> 이미지를 너무 크지 않게 한다.
* * 이미지를 너무 크지 않게 한다.

## 웹브라우저 실행 순서

## 브라우저 동작 방법


## 도커
-- todo

## 쿠버네틱스 K8S
-- todo

## 바벨 **

최신문법을 지원하지 않는 브라우저를 위해 ES5이하의 코드로 변환(`트랜스파일링`) 하는 기능
.bablerc 설정 파일을 통해 프리셋 설정- 대표적 프리셋
> - @babel/preset-env
> - @babel/preset-flow
> - @babel/preset-react
> - @babel/preset-typescript

바벨 트랜스파일링 설정

```json
{
  "name": "es6-project",
  "version": "1.0.0",
  "scripts": {  
    // -w 타켓 디렉토리의 모든 파일
    // -d 결과물 디렉토리
    "build": "babel src/js -w -d dist/js"
  },
  "devDependencies": {
    "@babel/cli": "^7.7.0",
    "@babel/core": "^7.7.2",
    "@babel/preset-env": "^7.7.1"
  }
}
```

> Promise, Object.assign, Array.from 등과 같이 ES5 이하로 대체할 수 없는 기능은 트랜스파일링이 되지 않는다.
따라서 오래된 브라우저에서도 ES6+에서 새롭게 추가된 객체나 메소드를 사용하기 위해서는 @babel/polyfill을 설치해야 한다!!

> $ npm install @babel/polyfill

바벨 사용시 @bable/pollfill 추가
```javascript
// webpack.config.js
const path = require('path');

module.exports = {
  // entry files
  entry: ['@babel/polyfill', './src/js/main.js'],
```



## 웹팩 **

`의존 관계에 있는 모듈들을 하나의 자바스크립트 파일로 번들링하는 모듈 번들러이다`. Webpack을 사용하면 의존 모듈이 하나의 파일로 번들링되므로 별도의 모듈 로더가 필요 없고, 그리고 다수의 자바스크립트 파일을 하나의 파일로 번들링하므로 html 파일에서 script 태그로 다수의 자바스크립트 파일을 로드해야 하는 번거로움 및 속도가 개선.

웹팩의 옵션은 오른쪽에서 왼쪽으로 진행.


바벨 로더. 설치 
> $ npm install --save-dev babel-loader


webpack.config.js 파일 webpack config

```javscript
module.exports = {
  // enntry file
  entry: './src/js/main.js',
  // 컴파일 + 번들링된 js 파일이 저장될 경로와 이름 지정
  output: {
    path: path.resolve(__dirname, 'dist/js'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        include: [
          path.resolve(__dirname, 'src/js')
        ],
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
            plugins: ['@babel/plugin-proposal-class-properties']
          }
        }
      }
    ]
  },
  devtool: 'source-map',
  // https://webpack.js.org/concepts/mode/#mode-development
  mode: 'development'
};
```

웹팩 사용중 모듈화 된 파일의 용량이 큰 경우 코드 스플릿(코드를 나누어)하여 필요한 시점에서 로딩하는 방식으로 할 경우 네트워크 요처이 늘어남, 하지만 캐시를 이용하여, 파일명 뒤에 checksum을 붙여 변경시 새로 로딩되도록 하는 방법도 존재


> entry: 웹팩이 파일을 읽을 시작점
> 로더 : 파일을 읽어서 모듈화하는 기능
> 

**SASS 로더**

Sass(Syntactically Awesome StyleSheets)  
node-sass는 node.js 환경에서 사용할 수 있는 Sass 라이브러리이다. 실제로 Sass를 css로 컴파일하는 것은 node-sass이다. style-loader, css-loader, sass-loader는 Webpack 플러그인이다.

-- todo sass 문법


>$ npm install node-sass style-loader css-loader sass-loader --save-dev

```javascript
const path = require('path');

module.exports = {
  // entry files
  entry: ['@babel/polyfill', './src/js/main.js', './src/sass/main.scss'],
  // 컴파일 + 번들링된 js 파일이 저장될 경로와 이름 지정
  output: {
    path: path.resolve(__dirname, 'dist/js'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        include: [
          path.resolve(__dirname, 'src/js')
        ],
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
            plugins: ['@babel/plugin-proposal-class-properties']
          }
        }
      },
      {
        test: /\.scss$/,
        use: [
          "style-loader", // creates style nodes from JS strings
          "css-loader",   // translates CSS into CommonJS
          "sass-loader"   // compiles Sass to CSS, using Node Sass by default
        ],
        exclude: /node_modules/
      }
    ]
  },
  devtool: 'source-map',
  // https://webpack.js.org/concepts/mode/#mode-development
  mode: 'development'
};
```

## 클라우드 
AWS  확인 필요

## vuejs **

Templates 형식으로 앱 제작 Vue 앱에서는 HTML 파일에 마크업을 작성하는게 기본, `{{}}`

Directive 를 이용하여 Template 기능 확장 가능   
v-on:click ... 로 시작.
Vue2.x부터는 render() 모두 지원
Template와 Render Function 모두 사용 가능
간단한 프로젝트 설정
빠른 렌더링

```html
<div id="app">
  <p>{{ message }}</p>
  <button v-on:click="reverseMessage">Reverse Message</button>
</div>
```
```javascript
new Vue({
  el: '#app',
  data: {
    message: 'Hello Vue.js!'
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('');
    }
  }
});
```
```javascript
<p>Using mustaches: {{ rawHtml }}</p>
<p>Using v-html directive: <span v-html="rawHtml"></span></p> //HTML 출력

// !! 속성 변경
<div v-bind:id="dynamicId"></div> // ID에 dynamicID가 자동 변경됨
<button v-bind:disabled="isButtonDisabled">Button</button>

// if 문
<p v-if="seen">이제 나를 볼 수 있어요</p>

```

// 컴포넌트 사용
```javascript
var ComponentA = { /* ... */ }

var ComponentB = {
  components: {
    'component-a': ComponentA
  },
  // ...
}
```




## react **
> Redux , Flux, ReactNative

Web과 native 앱 개발에 모두 가능
Virtual DOM으로 빠른 랜더링
경량 라이브러리
Service Side 랜더링
라우터
JSX 자바스크립트 문법 확장

props // 부모로부터 물려받은 속성 값, 이를 통해 보모와 소통, prope는 부모가 변경시 자동 변경
status // 내부 값, 변경시 setState를 해야 함.
defaultProps // props의 기본 값



## TypeScript


## node.js **

* npm

## sass **


## 엘라스틱서치
제품군으로는 엘라스틱서치, 로그스테쉬로 구성되어 있으며, 설정을 진행할 수 있는 화면 제품으로 Kibana 존재, 데이터를 가져오기 위한 beats 제품군이 있으며 그 기능에 따라 이름이 존재 함.

* Beats 
  * FileBeat: (로그파일 등)파일 읽어서 전달
  * MetricBeat: 시스템 정보(CPU, Memory, Apache ...) 판단
  * PacketBeat: 네트워크 패킷 분석, WinlogBeat: 윈도우 이벤트로그
  * Auditbeat: 리눅스 감사 시스템(사용자 활동 및 프로세스)
  * HeartBeat: 시스템 활동 체크(URL로 확인)
  * FunctionBeat: FAAS(Function as a Service)플랫폼 기능을 이용하여 클라우드 서버 모니터링 

* 클러스터!!: 하나이상의 노드(서버)가 모인 집합, 이를 통해 데이터 저장 및 검색 기능의 제어. (Master)
* 노드!!: 클러스터에 포함된 하나의 서버, 데이터 저장 및 색인화 검색 기능 등에 참여,
* 인덱스: 색인은 비슷한 문서의 모음. 
* 타입: 하나의 색인에 하나이상의 타입 지정 가능
* 도큐먼트: 문서의 기본단위, 기본정보 단위.
* 샤드&리플리카!!: 샤드 - 색인을 샤드라는 조각으로 나눠서 노드에 제공, 샤드 수는 색인 생성시 설정(사후 변경 불가) 리플리카(샤드 사본 수), 기본적으로 샤드(5), 리플리카(1) 설정됨.
* 샤딩!! : 콘텐츠 볼륨의 수평 분활 및 확장 가능, 검색 등의 병렬화를 통한 성능 개선



## java8 

script engine
```java
ScriptEngine engine = new ScriptEngineManager().getEngineByName("nashorn"); //  --- (1)
engine.eval("print('Hello World');");
```

// javascript의 함수를 java에서 호출
```java
ScriptEngine engine = new ScriptEngineManager().getEngineByName("nashorn");
engine.eval(new FileReader("example.js"));
// cast the script engine to an invocable instance
Invocable invocable = (Invocable) engine;
Object result = invocable.invokeFunction("sayHello", "John Doe");
System.out.println(result);
System.out.println(result.getClass());
// Hello, John Doe!
// hello from javascript
// class java.lang.String
```

javascript에서 java호출
```java
package my.package;

public class MyJavaClass {
    public static String sayHello(String name) {
        return String.format("Hello %s from Java!", name);
    }
    public int add(int a, int b) {
        return a + b;
    }
}
```

```java
var MyJavaClass = Java.type('my.package.MyJavaClass');
// call the static method
var greetingResult = MyJavaClass.sayHello('John Doe');
print(greetingResult);
// create a new intance of MyJavaClass
var myClass = new MyJavaClass();
var calcResult = myClass.add(1, 2);
print(calcResult);
// Hello John Doe from Java!
// 3
```
## Grafana

## 코딩테스트

- position을 고정으로 잡기 위해서 fixed 를 사용하여 전체 영역을 잡았으며,
그 상단에 relact 를 이용하여 top 50%로 중앙을 잡고, margin: 0 auto를 사용하여 중앙을 잡았음.

- css로 zindex 설정한 것을 style로 가져오지 못한점에 대해서` document.defaultView.getcomputedStyle(el, null).getPropertyValue('z-index');` 로 가져 옴

- innerHTML로 DOM 태그 생성하던 것을 div 태그에 그린 후 tag를 복사하는 방법으로 변경


## ETC

* ember (js 프레임워크)

* TC39 프로세스
> TC39 프로세스는 ECMA-262 명세(ECMAScript)에 새로운 표준 사양(제안. Proposal)을 추가하기 위해 공식적으로 명문화해 놓은 과정을 말한다. TC39 프로세스는 0 단계부터 4 단계까지 총 5개의 단계로 구성되어 있고 상위 단계로 승급하기 위한 명시적인 조건들이 존재한다. 승급 조건을 충족시킨 제안(Proposal)은 TC39의 동의를 통해 다음 단계(Stage)로 승급된다. TC39 프로세스는 아래의 단계를 거쳐 최종적으로 ECMA-262 명세(ECMAScript)의 새로운 표준 사양이 된다.

stage 0: strawman => stage 1: proposal => stage 2: draft => stage 3: candidate(캔티데드) => stage 4: finished

* 오버라이딩(Overriding)
> 상위 클래스가 가지고 있는 메소드를 하위 클래스가 재정의하여 사용하는 방식이다.

* 오버로딩(Overloading)
> 매개변수의 타입 또는 갯수가 다른, 같은 이름의 메소드를 구현하고 매개변수에 의해 메소드를 구별하여 호출하는 방식이다. 자바스크립트는 오버로딩을 지원하지 않지만 arguments 객체를 사용하여 구현할 수는 있다.

## 확인 필요
Object.assign, Array.form (배열 일차원) -- todo

* HTTP HyperText Transfer Protocol

* html5 선언 방식
```html
<!DOCTYPE html>
```
* meta tag
viewport: 모바일에서 사용 1:1비율 스케일과 크기. 
X-UA-Compatible = IE=edag // IE8 이상 최신 브라우저로 랜더링
keywords // 검색엔진 사용 단어
description // 검색엔진 설명
roobots// all 기본, none, index(해당 페이지 수집), follow(해당 페이지 포함 링크까지 수집), noindex(페이지 수집 제외), nofllow(링크 수집 제외)
expries // 캐쉬 만료일
og(Open Graph) // 오픈그래프, 
og:title // 제목
og:type // website
og:site_name // 사이트 명
og:description
og:url


## SEO (Search Engine Optimization) 검색엔진 최적화
-- todo tag 파악

* SPA(Single page application)
-- 장단점 파악

* SEO(Search Engine Optimization) // 검색엔진 최적화 (옵티미제이션)
* SSR(Server side render)
* next.js
* flow
* prettier ( 코드 스타일)
* axios (react ajax)
* 리터럴 객체 `{key:value}` 로 구성된 객체
* void 
> void 연산자는 뒤에 나타나는 표현식을 실행하고 undefined 를 돌려줌


### css 문법 