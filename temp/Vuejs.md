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
### Ref
* https://github.com/snabbdom/snabbdom
