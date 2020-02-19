# 클라우드 환경에서의 데브옵스 보안

> 줄리엔 비앙트 지음/ 홍성민, 주성식 옮김 (위키북스)

`글쓰기는 쉽다. 이마에 피땀이 맺힐 때까지 빈 종이를 응시하기만 하면 된다.`
`배는 항구에서 안전하지만, 그것이 배가 만들어진 목적은 아니다. -존 쉐드`


예제
* http://www.manning.com/books/securing-devops
* https://securing-devops.com/code


## 1부 사례 연구
### 데브옵스 보안
#### 데보옵스 접근법

데브옵스는 신속한 출시 주가, 통합 및 전달 파이프라인의 글로벌 자동화, 팀 간의 긴밀한 협업을 통해 소프트웨어 제품을 지속적으로 개선하는 프로세스

신속하고 꾸준히 개선되는 혁신적은 제품을 위해서는 개발 주기의 비용과 대기 시간을 줄이고, 고객 요구를 맞추기 위해서는 데브옵스를 채택

데브옵스 파이프라인의 주요 구성 요소는 개발자의 패치 제출에서 운영 환경으로 배포된 서비스를 완전 자동화 방식으로 진행하는 연속된 자동화 단계가 필요하며 그 과정을 완성하기 위해서는 지속적인 통합(CI: Continuous integraion), 지속적인 전달(CD: Continuos delivery), 서비스형 인프라(IaaS: Infrastructue as a service) 필요.


#### 지속적인 보안( Continuous security)

* 테스트 주도 보안(TDS: Test-driven security)
보안 테스트 후 기능 테스트(TDD: Test-driven develop)

* 사고 대응
> 보안 사고는 혼란을 야기하며 심지어 가장 안정적인 회사의 상태를 심각하게 손상할 수 있는 불확실성을 가져온다. 시스템 및 애플리케이션의 무결성을 복구하기 위해 서두르는 동안에 리더십은 피해 통제를 처리하고 비즈니스가 가능한 한 빨리 정상 운영 상태로 복귀할 수 있도록 보장해야 한다.


### 기본 데브옵스 파이프라인 구축하기

* 지속적인 통합, 웹훅을 통해 구성 요소와 통신해 코드를 테스트하고, 컨테이너를 빌드한다
* 수동 검토를 제외하고, CI/CD 파이프라인의 모든 단계는 완전히 자동화돼 있다.

### 보안 계층 1: 웹 애플리케이션 보호하기

취약점 점검 툴: OWASP Zed Attack Prox(ZAP) ![](https://zaproxy.org)

* XSS공격으로 방어 방법
  - 제출 시 사용자 입력 유효성을 검사한다. 
  - 사용자에게 반환된 모든 데이터를 페이지에서 렌더링하기 전에 이스케이프(Escape)처리.
  - 최신 웹 앱은 웹 브라우저에 내장된 보안 기능을 사용하며, 그중 가장 강력한 기능은 콘텐츠 보안 정책(CSP)!! Page(56)
> Content-Security-Policy: default-src 'self';  
[모질라 CSP](https://addons.mozilla.org)

```json
Content-Security-Policy:
  script-src # 인라인 스크립트를 포함한 스크립트 사이트
    'self'
    https://addons.mozilla.org;
  default-src
    'self';
  img-src  # HTML 랜더링 이미지 사이트
    'self';
  style-src
    'self'
    'unsafe-inline'; # 보호를 우회하고 HTML 요소 내부의 스타일 허용
  child-src # iframe 대상 사이트
    'self'
    'https://www.google.com/recaptcha/
  object-src: #플래시와 같은 모든 플러그인을 허용하지 않는다.
    'none';
  connect-src # ajax요청만 허용
    'self'; 
  font-src # 사이트와 CND에서 글꼴 로드
    'self'
    https://addons.cdn.mozilla.net
```

* 교차사이트 요청 위조

  - CSRP: 페이지를 어는 시점에 임의의 값을 클라이언트로 전송 전달받은 토큰을 해더에 기록, 해당 토큰을 요청시 함께 전달하여, 검증
  > SameSite 쿠키, 새로운 파라미터, CSRF공격에 대한 더 간단한 완화를 제공하기 위해 웹 브라우저에 통합, `SameSite=Strict` 속성 설정

* 클릭재킹(Clickjacking)
  > 웹페이지 위에 iframe로 투명한 레이어를 올린 후 사용자는 다른 사이트 버튼을 클릭하게 함으로써, 해를 끼침.

* 사용자인증
  - 암호관리 필요
  > 사용자 암호를 데이터 베이스에 저장하지 않고 비가역적 방식으로 암호를 저장, 저장 단계는 대략 다음과 같다.

  1. 일반 텍스트로 된 사용자 암호를 입력
  1. salt라 부르는 임의의 바이트 읽음
  1. 사용자 암호와 salt를 더해 H1 해시를 계산 H1=hash(password+salt)
  1. H1 해시와 salt를 데이터베이스에 저장

  - ID 제공자(IdP)
  > 최신 애플리케이션은 서드파트가 IdP 역할을 할 수 있어, 사용자는 각 사이트에 대해 새로운 계정을 생성하는 대신 ID 제공자 중 하나에서 보유한 계정을 사용해 애플리케이션에 로그인  
  > 싱글 사인 온(Single Sigin-ON, SSO), SAML(Security Assertion Markup Language)를 예전에는 많이 사용되었지만, 최근에는 OAuth2와 OpenID Connect는  SAML보다 애플리케이션에서 구현하기 쉬운 프로토콜을 정의해 인기.

  1. 사용자가 먼저 애필리케이션에 접근하고 로그인 메시지 표시
  1. 로그인 버튼은 질의 문자열에 사용자 지정 파라미터가 들어 있는 주소를 사용해 사용자를 IdP로 리디렉션
  1. IdP는 사용자에게 로그인을 위한 메시지 표시(존재하는 경우 기존 세션을 재사용) 사용자에게는 두 번째 리디렉션을 통해 애플리케이션으로 다시 보내짐
  1. 두 번째 리디렉션에는 애플리케이션이 토큰을 추출하고 교환하는 코드가 들어 있음
  1. API 토큰을 이용해 애플리케이션이 IdP에서 사용자 정보 검색
  1. 이 시점에서 사용자는 애플리케이션에 로그인돼 계속 사요

* 종속성 관리
  - 가용성 손실: 원본이 오프라인이거나 종속성의 개발자가 원본을 제거했을 수 있다. 또한 애플리케이션을 빌드하려는 서버가 인터넷에 접근하지 못할 수도 있다.
  - 무결성 손실: 소스 코드가 악의적인 것으로 대체될 수 있다.

**벤더링**: 개발자는 종종 종속성을 특정 버전으로 고정하고, 때로는 의존성 사본을 내려받아 프로젝트와 함께 저장.
  



### 보안 계층 2: 클라우드 인프라 보호하기

**SSH**: SSH 프로토콜의 첫 번째 버전은 90년대 중반 헬싱키 대학의 타투 일료넨(Tatu ylonen)이 개발, 일료넨은 독점 라이선스 하에 원래 SSH코드를 유지했으며, 그에 따라 OpenBSD 프로젝트가 90년대 후반 OpenSSH라는 오픈 소스 버전으로 개발 사용.

```sh
$ ssh-keygen -t rsa \
-f ~/.ssh/id_rsa_$(whoami)_$(date+%Y-%m-%d) \
-C "$(whoami)'s bastion key"
Generation public/private rsa key pair
Enter passphrase (emtpy for passphrase): # 비밀키를 보호하려면 항상 암호 사용.
Enter same passphrase again:
Your identification has been saved in ~/.ssh/id_rsa_sma_2020-02-11.
Your public key has been saved in ~/.ssh/id_rsa_sma_2020-02-11.pub.
```

> SSH 키 알고리즘: 최신 SSH 시스템일 경우 RSA 대신 ed2519 알고리즘 사용, ed2519의 키는 RSA보다 휠씬 작으며, 더 높은 수준은 아니지만 동등한 보안 수준을 제공


### 보안 계층 3: 통신 보안

* HTTPS
> 웹의 애플리케이션 프로토콜인 HTTP와 인터넷에서 가장 널리 사용되는 암호화 프로토콜인 TLS(Transport Layer Security)로 구성

* 통신 보안
  - 기밀성(Confidentiality): 합법적인 통신 참가자만 정보에 접근
  - 무결성(Integrity): 참가자 간에 교환한 메시지는 전송 중에 수정하면 안된다.
  - 진정성(Authenticity): 통신 참가자는 서로에게 자신의 정체성을 증명할 수 있어야 한다.

* 대칭 암호화 프로토콜(symmetric encryption protocal)
> 이동할 Key를 서로 약속하고 이동할 알파벳 숫자를 공유, 시저(Caesar)의 치환 암호(substitution cipher)는 로마 장군이 개인적인 편지에 사용한 초기 암호화 프로토콜  
  - 암호문은 암호를 해독할 수 없는 공격자가 전송 중이라도 수정할 수 있다.
  - 메시지가 기대한 작성자에게서 왔다는 증거가 없다.

* Diffie-Hellman과 RSA
> 1976년에 위트필드 디피(Whitfield Diffie)와 마틴 헬만(Martin Hellman)이 디피-헬만(Diffie-Hellman, DH) 키 교환 알고리즘을 발표했을 때 일종의 돌파구가 생겼다, 디피-헬만 교환(Diffie-Hellman Exchange, DHE)을 사용하면 두 사람이 먼저 암호화 키를 생성하는 키 교환 프로토콜을 수행해 통신 채널을 시작할 수 있다.

> 디피-헬만 키 교환  
> 앨리스는 소수 p=23, 생성자 g=5, 임의의 암호 a=6을 생성    
> 앨리스는  A= g^a p=5^6 mod 23 = 8을 계산  
> 앨리스는 p=23, g=5, A=8을 밥에게 전송(임의의 암호 a는 비공개 키, A는 공개키)  
> 밥 암호 b=15를 생성  
> 밥은  B = g^b mod p p = 5^15, mod 23= 19 계산  
> 밥은 B=19 를 앨리스에게 전송  
> 앨리스는 key = B^a mod p = 19^6 mod 23 = 2 계산  
> 밥은 key = A^b mod p = 8^15, mod 23 = 2를 계산  
> 앨리스와 밥은 협의된 Key = 2를 갖음  

> DH의 발표 후 1년 만에 로널드 라이베스트(Ron Rivest), 아디 샤미르(Adi Shamir), 레너드 애들먼(Leonard Adleman)은 DH 알고리즘 기반으로 작성된 공개키 암호화 시스템인 RSA를 공개

* RSA 알고리즘
> RSA 알고리즘은 통신 참여자가 두 개의 키를 사용해 비밀 메시지를 교환할 수 있게 한다. 한 키가 메시지를 암호화하면 다른 키는 이를 복호화할 수 있지만, 암호화된 키는 복호화할 수 없다.

* SSL과 TLS

* HSTS: Strict Transport Security 
서비스가 항상 HTTPS를 사용하도록 수성되면 안전하지 않은 HTTP로 되돌아갈 이유가 없어야 한다. HTTP Strict Transport Security(HSTS)는 서비스가 항상 HTTPS 를 사용하도록 브라우저에 보낼 수 있는 HTTP헤더.

### 보안 계층 4: 전달 파이프라인 보안

## 2부 이상징후 발견과 공격으로부터의 서비스 보호

### 로그 수집 및 저장하기

참고
 * 프로메테우스 https://prometheus.io
 * 그라파나: http://grafana.org

명령어
 * grep, awk, sed, cut


### 부정행위와 공격에 대한 로그 분석

로그 분석
 * Hindsight(http:/mng.bz/m4gg)
> 데이터 스트림에서 분석 플러그인을 실행하도록 설계

 * 슬라이딩 윈도와 원형 버퍼
> 제한 사항을 위반하는 클라이언트를 탐지하려면 일정 기간 동안 각 클라이언트가 보낸 요청을 계산해야 한다.
클라이언트가 최근 8분 동안 보낸 요청을 현재의 분 단위로 세고, 클라이언트가 해당 기간 동안 x개 이상의 요청을 보내면 경고를 유발을 가정해 보자
이러한 접근 방식을 `슬라이딩 윈도`  구현하려면 주어진 분 내에 수신된 모든 요청을 계산하고 그 값이 저장해야 마지막 8분 동안의 총량을 계산할 수 있다. 시간이 1분씩 진행되며 가장 오래된 값을 삭제하고 새 값을 추가해 윈도를 효과적으로 앞으로 이동

* 이동 평균(Moving Averages)
> 트래픽을 비교하여, 평균보다 두 세배 이상 더 많은 트래픽을 보내는 클라이언트를 발견하면 의심스러운 것으로 플래그를 지정

* 지리 데이터를 사용해 악용 사례 찾기
> 사용자 지오프로파일링(Geoprofiling) 접속자의 지리적 프로파일을 유지하고, 이를 데이터베이스에 저장
  - 지리정보 : Maxmind의 GeoIP City 데이터 베이스(http://mng.bz/8U91)
  - 거리 계산: IP 주소의 위도와 경도를 알아내면 일반 연결 영역에서 얼마나 멀리 떨어져있는지 계산, 아버사인 공식(haversing formula)(http://mng.bz/mkO0)
### 침입 탐지
### 캐리비안 침해 사고: 침해 사고 대응 사례 연구

## 3부 데브옵스 보안을 성숙하게 만들기
### 위험평가
### 보안 테스트
### 지속적인 보안

## 용어 정리

* 풀리케스트? 
> '풀 리퀘스트'는 주어진 브랜치에서 다른 브랜치(일반적으로 기능과 마스터 브랜치)로 변경을 가져오기 위한 요청을 나타내는 용어로 깃허브에 의해 대중화, 개발자가 검토를 위해 패치를 제출하면 풀 리퀘스트가 열린다. 

* ELB - Elastic Load Balancing
* EC2 - Elastic Compute Cloud 
* RDB - Relational Database
* Lua - 언어?
