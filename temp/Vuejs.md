# Vue.js

사용자 인터페이스를 만들기 위한 프로그레시브 프레임워크

## 특정
* 가상 DOM을 활용
* 반응적이고 조합 가능한 컴포넌트 제공
* 코어 라이브러리에만 집중, 라우팅 및 전역 상태 관리하는 컴패니언 라이브러리 존재


*** Vuex


### tutorial


```html
<div id='app'>
  {{ message }}
</div>
```

```javascript
var app = new Vue({
  el: '#app',
  data: {
    message: '안녕하세요 Vue!'
  }
})
```

### 속성

* v-bind:[title]="message"

### Ref
* https://github.com/snabbdom/snabbdom
* https://scrimba.com/p/pXKqta/cEQe4SJ (조건문과 반복문)
* https://scrimba.com/p/pXKqta/cEQVkA3 (컴포넌트)

## Vue 인스턴스

* 라이프 사이클
1. new Vue 생성
2. Init Events & Lifecycle
 --> beforeCreate
3. Init injections & reactivity
[Life Cycle](https://kr.vuejs.org/v2/guide/instance.html)


## 분석

- boolean isUnder() : undefined 여부
- boolean isDef() : !undefined
- boolean isTrue(): true 여부
- boolean isFalse() : false 여부
- boolean isPrimitive(value): 원시 객체 string, number, sysbol, boolean
- boolean isObject(obj) : Object 여부
- _toString : Object.prototype.toString
- string toRawType(value): _toString.call(value).slice(8, -1) ==> [Object Object] => Object
- isPlainObject(obj): Object 여부
- isRegExp(v): [Object RegExp] 여부
- isValidArrayIndex: Index 존재 여부, isFinite() 사용
- isPromise(val): 값이 있고, then, catch 가 있는지.
- toString(val) : toString
- toNumber(val): isNaN
- makeMap(str, expectsLowerCase): 문자열을 ,로 짜른후 map에 Key로 담아서 돌려 줌. expectsLowerCase(대소문자 구분)
- isBuiltInTag : Tag 맵 (makeMap 이용)
- isReservedAttribute: 필요 속성 맵 생성(makeMap 이용)
- remove(arr, item): Array 값 제거
```js
function remove (arr, item) {
    if (arr.length) {
      var index = arr.indexOf(item);
      if (index > -1) {
        return arr.splice(index, 1)
      }
    }
```
 - hasOwnProperty = Object.prototype.hasOwnProperty : 
 - hasOwn(obj, key) : 자기 속성여부 파악
 - cached(fn): 함수에 대한 캐쉬를 생성 후 담아둠 (메모제이션)
 ```js
   function cached (fn) {
    var cache = Object.create(null);
    return (function cachedFn (str) {
      var hit = cache[str];
      return hit || (cache[str] = fn(str))
    })
  }
  ```
  - camelizeRE = /-(\w)/g : 문자열 reg exp
  - camelize: 문자앞 - 제거 (cached 사용)
  - hyphenateRE = /\B([A-Z])/g; : \B (문자가 아닌경우) 후 대문자.
  - hyphenate : 
  ```
  var hyphenate = cached(function (str) {
    return str.replace(hyphenateRE, '-$1').toLowerCase()
  });
  ```
  - polyfillBind: todo

## 확인
isFinite() ?