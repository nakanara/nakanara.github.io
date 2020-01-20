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
  - polyfillBind: 해당 함수를 ctx로 호출.
  ```js
  function polyfillBind (fn, ctx) {
    function boundFn (a) {
      var l = arguments.length;
      return l
        ? l > 1
          ? fn.apply(ctx, arguments)
          : fn.call(ctx, a)
        : fn.call(ctx)
    }

    boundFn._length = fn.length;
    return boundFn
  }
  ```

  - nativeBind: bind 함수 사용.
  - var bind: bind가 있는경우 nativeBind 없는 경우 polyfillBind
  - toArray: 유사 array -> Array 변환, 속도를 위해 i-- 사용
  ```js
  function toArray (list, start) {
    start = start || 0;
    var i = list.length - start;
    var ret = new Array(i);
    while (i--) {
      ret[i] = list[i + start];
    }
    return ret
  }
  ```
  - extend: map  속성 확장
  ```js
  function extend (to, _from) {
    for (var key in _from) {
      to[key] = _from[key];
    }
    return to
  }
  ```
  - toObject(arr) : 새로운 Object로 돌려 줌. -- 얕은 복사
  - noop: 아무작업 하지 않는 함수
  - no: 무조건 false
  - identity: 동일 값
  - getStaticKeys(modules) : 모듈을 key에 누적
  - looseEqual(a, b) : 깊은 비교
  ```js
  function looseEqual (a, b) {
    if (a === b) { return true }
    var isObjectA = isObject(a);
    var isObjectB = isObject(b);
    if (isObjectA && isObjectB) {
      try {
        var isArrayA = Array.isArray(a);
        var isArrayB = Array.isArray(b);
        if (isArrayA && isArrayB) {
          return a.length === b.length && a.every(function (e, i) {
            return looseEqual(e, b[i])
          })
        } else if (a instanceof Date && b instanceof Date) {
          return a.getTime() === b.getTime()
        } else if (!isArrayA && !isArrayB) {
          var keysA = Object.keys(a);
          var keysB = Object.keys(b);
          return keysA.length === keysB.length && keysA.every(function (key) {
            return looseEqual(a[key], b[key])
          })
        } else {
          /* istanbul ignore next */
          return false
        }
      } catch (e) {
        /* istanbul ignore next */
        return false
      }
    } else if (!isObjectA && !isObjectB) {
      return String(a) === String(b)
    } else {
      return false
    }
  }
  ```
- looseIndexOf(arr, val) : 해당 값 IndexOf.
- once(fn): 한번만 호출되는 함수 만들기
```js
function once (fn) {
    var called = false;
    return function () {
      if (!called) {
        called = true;
        fn.apply(this, arguments);
      }
    }
  }
```
- var SSR_ATTR = 'data-server-rendered';
- var ASSET_TYPES: 속성 타입. 
```JS
 var ASSET_TYPES = [
    'component',
    'directive',
    'filter'
  ]
```
- LEFECYCLE_HOOKS : 라이프 사이클
```JS
var LIFECYCLE_HOOKS = [
    'beforeCreate',
    'created',
    'beforeMount',
    'mounted',
    'beforeUpdate',
    'updated',
    'beforeDestroy',
    'destroyed',
    'activated',
    'deactivated',
    'errorCaptured',
    'serverPrefetch'
  ];
```
- config : 구성정보


### Config
- optionMergeStrategies:
- silent(false)
- productionTip(false): tip message
- devtools(false) : 개발 툴 여부
- performance(false): 성능 기록
- errorHandler(null)
- warnHandler(null)
- ignoredElements[] : 
- keyCode:
- isReservedTag(no):
- isReservedAttr(no)
- isUnknownElement(no)
- getTagNamespace: noop
- parsePlatformTagName: identity
- mustUseProp(no)
- async(true)
- _lifecycleHooks: LIFECYCLE_HOOKS




## 확인
isFinite() ?