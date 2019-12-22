
## ES6(ECMA2015) 관련

https://github.com/lukehoban/es6features#destructuring

* ~arrow function~
* [classes] 
  - https://jsdev.kr/t/es6/294
  - https://poiemaweb.com/es6-class

* enhanced object literals
* template strings --OK
* destructuring
* default + rest + spread
* let + const -- const 상수, 오브젝트 변환 추가 필요
* iterators + for…of
* generators
* unicode
* modules
* module loaders
* map + set + weakmap + weakset
* proxies
* symbols
* subclassable built-ins
* promises -- 동기화 then, 확인 필요
* math + number + string + array + object APIs
* binary and octal literals
* reflect api
* tail calls


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
> arguments 프로퍼티 초기화, 스코프 체인 연결
> 전역 컨텍스트와 함수 컨텍스트(`Activation Ojbect/ AO- 할성화객체`)는 다른점은 전역의 경우 매개변수와 인자가 없기 때문에 전역에는 arugments Object가 없다. 전역 컨텍스트의 경우 `GO(Global Object)를 가리킴`
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


3. this value 할당

> this value 가 할당되며, this의 경우 호출 패턴에 따라서 결정
> 

### 변수 생성 단계

호이스팅을 통해서 변수는 상단에 올라와서 선언은 되지만, 실제 할당은 그 위치에서 됨.

1. 선언단계(declaration phses)
2. 초기화단계(Initalization phses) - undefined로 초기화
3. 할당 단계(Assignment phses) - undefined에 실제 사용 값 할당
`var의 경우 선언과 초기화가 함께 이루어지기 때문에 순서에 관련없이 사용해도  undefined로 표시`

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


### 패턴(Scope-Safe Constructor) ??

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
### 클로저

외부 실행 컨텍스트가 사라져도 참조가 되어있다면, 실행 환경은 유지되는 것이 클로저, 클로저를 이용하여 모듈 구현
`클로저는 함수와 그 함수가 선언되었을 때의 렉시컬 환경 조합`


반환된 내부함수가 자신이 선언되었던 때의 환경을 기억하여(렉시컬 환경= Lexical environment) 밖에서 호출되더라도 그 환경(스코프)에 접근할 수 있는 함수 == 클로저란 자신이 생성되었을 때 환경을 기억(Lexical environment)하는 함수

`렉시컬 스코핑`: 스코프는 함수를 호출할 때 어디서 선언되었는지에 따라 결정




## 웹브라우저 실행 순서

* 웹 성능 향상 방법
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


## 브라우저 동작 방법


## 도커
## 쿠버네틱스 K8S
## 웹팩 **
## 바벨 **
## 클라우드
## vue **
## react **

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




## Grafana

## 코딩테스트

- position을 고정으로 잡기 위해서 fixed 를 사용하여 전체 영역을 잡았으며,
그 상단에 relact를 이용하여 top 50%로 중앙을 잡고, margin: 0 auto를 사용하여 중앙을 잡았음.

- css로 zindex 설정한 것을 style로 가져오지 못한점에 대해서` document.defaultView.getcomputedStyle(el, null).getPropertyValue('z-index');` 로 가져 옴

- innerHTML로 DOM 태그 생성하던 것을 div 태그에 그린 후 tag를 복사하는 방법으로 변경

