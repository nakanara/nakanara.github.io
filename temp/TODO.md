
## ES6(ECMA2015) 관련

https://github.com/lukehoban/es6features#destructuring

* ~arrow function~
* [classes] 
  - https://jsdev.kr/t/es6/294
  - https://poiemaweb.com/es6-class

* enhanced object literals
* template strings
* destructuring
* default + rest + spread
* let + const
* iterators + for…of
* generators
* unicode
* modules
* module loaders
* map + set + weakmap + weakset
* proxies
* symbols
* subclassable built-ins
* promises
* math + number + string + array + object APIs
* binary and octal literals
* reflect api
* tail calls


## Javascript
* 스코프
* 실행컨텍스트
* 즉시실행함수(IIFE) => Immediately Invoked Function Expression
```javascript
// 선언 후 바로 실행
(() => {
  ...
})();
```
* 모듈 생성
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
* 

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


## 도커
## 쿠버네틱스 K8S
## 웹팩 
## 바벨
## 클라우드
## vue 
## react

## Grafana
