마이크 커뮤니케이션 - 머리에 거는 수화기
스피커 기본값 - 머리에거는 수화기


패턴 
모듈패턴 // 함수에 필요한 함수, 변수, 객체를 모아두어서 전역 변수 영역을 어지럽히지 않고, 자기영역에서 작동하는 방법입니다

네임스페이스패턴 // 객체나 변수가 겹치지 않도록 대표적 이름아래 모듈화 하여 다른 서드파티 라이브러리등과 겹치지 않는 안전한 소스를 만드는 패턴

샌드박스패턴 // 호출하는 시점에서 instanceof를 하여 객체가 자신의 객체인지를 판단, 아니라면 새로운 스코프 아래에 구성함으로 그 객체만의 컨텍스트를 구성

mvc // Model, view, control
mvvm // model, view, viewmodel (vuejs)
mvp // model, view, persent

메모이제이션 // 실행한 결과값을 메모리에 담아두고, 동일한 요청이 들어온 경우 담아둔 결과값을 리턴해주는 것으로 변화가 없고, 작업시간이 많이 걸리는 작업에 유용

성능관련
* 레이지로드 
- 화면에서 바로 사용하지 않는 리소스에 대하여, 스크립트, 이미지등은 화면에 onLoad 된 시점에서 스크립트로 이미지를 로딩
(https://frontierdev.tistory.com/45)

* 인피니티스크롤
 - 트위터, 페이스북에서 사용하고 있는 방식으로 페이징 기능 없이 스크롤이 페이지 하단 영역에 올 때 새로운 내용을 아래에 붙이는 방법
 - 페이징을 찾기가 힘듬


* 프리패치/프리로드/프리커넥트(브라우저 우선순위)
(이중으로 다운로드 되지 않도록 유의)
 - 프리로드 - 브라우저에게 우선순위를 높여 미리 로드되도록 지시
   <link rel='preload' as='script' href='xxx.js'/>
   <link rel='preload' as='style' href='xxx.css'/>

 - 프리커넥트 - 브라우저에게 특정사이트의 연결이 필요하니 미리 연결 진행

 - dns-perpath - dns유형만 선 처리 우수한 콜백 지원

 - 프리패치 - 미리가져오기, 사용자가 곧 사용할 데이터를 미리 가지고 오는 것.(중요하지 않은 것을 먼저 가져오기) - 사용자가 다음에 할 해당을 예측하여 미리 준비

 (https://developers.google.com/web/fundamentals/performance/resource-prioritization?hl=ko)

* async/defered
비동기프로그램


* document fragment(프래그먼트)
(https://untitledtblog.tistory.com/44)
DOM 객체를 수정할 경우 replace 가 일어나서 reflow, repaint 의 비싼 작업이 이루어짐, 되도록 적게 하고, 한다면 DocumentFragment 의 경우 부모가 없는 단순한 문서형태, 프래그먼트에 작성된 내용은 활성화된 문서에 작업되지 않음, 최종적인 부분을 clone해서 붙임


* reflow(DOM 수치 재계산) , repaint(랜더트리 다시 그리는 과정)
(http://egloos.zum.com/chideout/v/4442834)
비용이 많이 발생, 랜더트리를 구성하는데 필요한 정보를 바꾸는 것은 reflow, repaint 발생(DOM 노드 추가/제거, DOM 애니메이션,

// bad 
el.style.left = left + "px";
el.style.top  = top  + "px";
// better
el.className += " theclassname"; // className 이용
// better
el.style.cssText += "; left: " + left + "px; top: " + top + "px;";


html구성시 자바스크립트를 만나게 되면, 블록모드에 들어가서 화면 그리는 것을 멈추고 대기함
- 인라인 스타일 최대한 적게
- position: fixed, absoute의 경우 분리
- 테이블 레이아웃 배제 
- 스타일은 한번에 변경 cssText 이용


* http2.0
(https://www.popit.kr/%EB%82%98%EB%A7%8C-%EB%AA%A8%EB%A5%B4%EA%B3%A0-%EC%9E%88%EB%8D%98-http2/)

 - http1.1 : 요청하나씩 처리, 동시전송 불가능, 요청과 처리가 순차적, 무거운 헤더(쿠키포함)
 - http2.0 : 하나의 커넥션에 여러 데이터 처리, 응답은 순서에 상관 없이, 리소스간 우선순위 설정 (css, 이미지 관계), 서버 push(요청하지 않은 데이터를 서버에서 임의로 전송)[PUSH_PROMISE] 라고 부름, 헤더컴프레션 - 헤더압축 중복된 헤더의 경우 기존에는 매번 전송하였지만, 헤더 테이블을 이용하여 중복된 값은 index만 전송하고, 변경된 값만 표시 전송,  
* es6
- promise // pending-> fulfilled(수행) : resolve -> rejected(실패): reject -> settled(세틀드): 수행 된 상태

* 클로저
자바스크립트의 경우 렉스컬환경으로 실행되어 외부 실행 컨텍스트가 사라져도 내부 실행 컨텍스트에서는 외부 자유변수를 참조되어 실행환경이 유지되는 것을 클로저라고 함

자바스크립트의 경우 실행시점에서 스코프를 가지고 있는 동적 실행환경이 아닌 함수의 선언 시점에서 스코프를 가지고 가는 정적 스코프를 가짐

* 브라우저 DOM 랜더링
 네트워크에서 HTML -> DOM 파싱 후 DOM Tree 구성 -> CSS를 파싱 후 랜더Tree 구성 -> 랜더 트리를 기반으로 위치 및 크기 계산 후 랜더링 

* 프로토타입 체인 // 자신을 생성한 부모 생성자
(https://poiemaweb.com/js-prototype)

* 실행컨텍스트
  함수 호출 -> 함수 영역 스코프 생성 및 초기화 -> 매개변수, 인자, arguments 설정, 함수 호이스팅을 함수 선언문 생성, 초기화, 변수 호이스팅을 통한 변수 선언 -> 변수는 선언 과 초기화 사이 Temporal Dead zoon TDZ에 대기 (Referror 발생) -> 선언시 사용가능 -> 초기화 -> this 할당
var변수는 선언과 초기화가 동시에 일어남

* 호이스팅 // 함수 안에 있는 변수를 함수 상단에 끌어올려 선언되도록 하는 것

* map/set // map은 Key,value가 들어 있으며, 들어간 순서도 기억 됨, set value,value로 기억되며 중복 안됨

* symbol // js의 6번째 객체(Stirng, Number, boolean, null, undefined) + Object외 유니크한 키 값을 만들기 위한 객체
sysbol.for('') -> 심볼 찾기.

* event delegate
(https://joshua1988.github.io/web-development/javascript/event-propagation-delegation/)
 이벤트 버블링 - 하위 이벤트를 상단으로 전달
 이벤트 캡쳐링 - 상위 이벤트를 하단으로 전달
 stopPropagation(스탑 프로퍼게이션)으로 이벤트 전달 막음
 Delegation(델리게이션) - 이벤트 대상의 상위 객체의 이벤트를 잡아서 하위 객체 이벤트 체크

* 속도 개선
 - 이미지 스프리팅
 - 도메인 샤딩(리소스를 여러 도메인에서 호출)
 - css, js 압축
 - Data URI 스키마 (이미지를 리소스를 base64로 인코딩하여 html에 기술하여 요청을 줄임)
 - Load Fast : script 는 하단, css는 상단 배치
 - 