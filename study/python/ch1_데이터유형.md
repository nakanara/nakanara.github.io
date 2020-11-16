# 파이썬의 자료형

## 숫자

|유형|표현|
|---|---|
|정수|3, 123, -100|
|실수|3.6, 123.45, -456.78, 2e3|
|8진수|0o34, 0o6|
|16진수|0x1A, 0xFF|
|무한대|inf, -inf|

```python
print(int(3.6)) # 3
print(2e3) # 2000.0
print(float("1.6")) # 1.6
print(float("inf")) # 무한대
print(float("-inf")) # 무한대
```


## 문자

파이썬의 문자열은 자바스크립트와 유사하게 큰 따움표(") 및 작은 따움표(')로 문자열을 생성할 수 있다.

멀티라인의 경우 큰 따움표("), 작은 따움표(')를 3번 연속 사용하여 멀티라인으로 표현할 수 있으며, \\n으로도 표시할 수 있다.

만약 큰 따움표로 감싼 문자열에서 큰 따움표(")를 포함하고 싶은 경우 백슬러스(\\)로 해당 문자앞에 표시하여, 문자열로 인식시킨다.


```python

a = "Hello Python!"
b = 'Hello World!'

c = """Hello~ 
Python!"""

d = "Hello~\nPython!"
Hello~
Python!

e = '''Python\'s
very fun'''
Python's
very fun
```

### 문자열 출력

문자열에 곱하기를 할 경우 `문자열 반복`

```python
>>> a = "hi!"
>>> a * 2
Hi!Hi!
```

#### 이스케이프 문자

|코드|설명|
|--|--|
|\\n|줄 바꿈(개행)|
|\\t|탭|
|\\\\|문자 \\ 표시|
|\\'|작은 따움표(') 표시)
|\\"|큰 따움표(") 표시|
|\\r|캐리지 리턴, 해당 행에 커서를 가장 앞으로), \\n\\r 함께 사용|

### 문자열 포맷팅(Formatting)

%를 사용하여 문자 포맷 코드에 대한 값 대입하며, 여러 개의 값을 대입하고 싶은 경우 %(val1, val2)로 사용

```python 
>>> "I have %d apples." %3
'I have 3 apples.'

>>> "I have %s apples." %"three"
'I have three apples.'

>>> "%% I have %s and %s." %("apple", "banana")
'% I have apple and banana.`

# 공백 추가
>>> "%10s" % "*"
'         *'
>>> "%-10s***" % "*"
'*         ***'

# 소수점 표현
# 앞부분의 숫자는 들여쓰기 기준이며, 소수점 포인트 뒤는 나타날 소수점 뒤 숫자
>>> "%0.2f" % 3.14159
'3.14'
>>> "%4.2f" % 3.14159
'3.14'
>>> "%5.2f" % 3.14159
' 3.14'
>>> "%10.2f" % 3.14159
'      3.14'
```

#### 문자열 포맷 코드

|코드|설명|
|--|--|
|%s|문자열(String)|
|%c|문자 1(char)|
|%d|정수(int)|
|%f|부동소수(float)|
|%o|8진수|
|%x|16진수|
|%%|Literal 문자 % 표시|

### format 함수를 이용한 포맷팅

format 문자열의 index에 전달받은 인자를 대입한다.
key=value 형태로도 정의가 가능하다.


```python
>>> "I have {0} apples".format(3)
'I have 3 apples'
>>> "I have {0} apples".format("five")
'I have five apples'

# 여러 인자 넣기
>>> "I have {0} and {1}.".format("apple", "banana")
'I have apple and banana.`

>>> "I have {0} and {0}.".format("apple", "banana")
'I have apple and apple.`

# 이름으로 넣기
>>> "I ate {cnt} {name}".format(cnt=3, name="apples")

# 왼쪽 정렬
>>> "{0:<10}".format("*")
'*         '
# 오른쪽 정렬
>>> "{0:>10}".format("*")
'         *'
>>> "{0:^10}".format("*")
'    *     '
# 공백 채우기
>>> "{0:=^10}".format("*")
'====*====='
# 중괄호 사용하기
>>> "{{ {0} }}".format("hi")
'{ hi }'
```

### f 문자열 포매팅

파이썬 3.6 버전부터는 f 문자열 포매팅 기능을 사용할 수 있다.

```python
>>> name= "Python"
>>> version = "3.6"
>>> f"{name} f 문자열 포매팅이 가능한 버전은 {version}부터 가능합니다."
'Python f 문자열 포매팅이 가능한 버전은 3.6부터 가능합니다.'

# 문자열 포매팅 계산
>>> year = 2020
>>> f"{year}년의 다음년도는 {year+1}이다."
'2020년의 다음년도는 2021이다.'

# 딕셔너리 자료형 사용
>>> d = {'name':'Python', 'version':'3.6'}
>>> f"{d['name']} f 문자열 포매팅이 가능한 버전은 {d['version']}부터 가능합니다."
'Python f 문자열 포매팅이 가능한 버전은 3.6부터 가능합니다.'
```

### 문자열 인덱싱 계산

파이썬의 문자열은 배열처럼 사용할 수 있으며 시작은 **0**부터 시작하며, 마이너스(-)를 사용하여 뒤에서부터 인덱스를 계산할 수 있다.

```python
msg = "Hello World"
msg[4]
'o'
msg[0]
'H'
msg[-1]
'd'
```

### 문자열 슬라이싱

문자열의 특정 영역을 가져오는 방법, `변수[시작 Index:끝 Index]`로 사용
시작 Index가 없는 경우 0, 끝 Index가 없는 경우 마지막 문자열로 인식

```python
msg = "Hello World"
msg[0:5]
'Hello'

msg[6:9]
'Wor'

msg[:9]
'Hello Wor'
msg[9:]
'ld'
msg[:]
'Hello World'

# 마이너스로 한 경우 전체길이(11)에서 -2 -> 9
msg[6: -2]
'Wor'
```


## 문자열 관련 함수

```python
# 문자 갯수 Count
>>> a = "hello World"
>>> a.count('o')
2

# 문자 위치 찾기(find)
>>> a.find('o')
4
>>> a.find('x') 
-1

# 문자열 삽입(array 결합)(join)
>>> ",".join("abcd")
'a,b,c,d'
>>> ",".join(['a','b','c','d'])
'a,b,c,d'

# 대문자 변환(upper)
>>> a = "hi"
>>> a.upper()
'HI'

# 소문자 변환(lower)
>>> a = "HI"
>>> a.lower()
'hi'

# 왼쪽 공백(lstrip)
>>> a = "  hi  "
>>> a.lstrip()
'hi  '

# 오른쪽 공백(Rstrip)
>>> a = "  hi  "
>>> a.rstrip()
'  hi'

# 양쪽 공백(strip)
>>> a = "  hi  "
>>> a.strip()
'hi'

# 문자열 바꾸기(replace)
>>> a = "I eat 3 apples"
>>> a.replace("apples", "bananas")
'I eat 3 bananas'

# 문자열 나누기(split)
>>> a = "I eat 3 apples"
>>> a.split()
['I', 'eat', '3', 'apples']

>>> ip = "127.0.0.1"
>>> ip.split(".")
['127', '0', '0', '1']
```
## Bool 자료형(참, 거짓)

True(참), False(거짓) 두 가지의 값이 정의되어 있다.

값이 있다면 참이며, 값이 비어있거나, 0인 경우 거짓

```python

>>> 2 > 1
True
>>> 2 < 1
False
>>> bool("Yes")
True
>>> bool("")
False
```

|값|결과|
|--|--|
|"Yes"|True|
|"No"|True|
|""|False|
|True|True|
|False|False|
|[1,2,3]|True|
|[]|False|
|(1,2,3)|True|
|()|False|
|{'Key':'val'}|True|
|{}|False|
|1|True|
|0|False|
|None|False|


## None 

Null과 값은 표현 
```python
>>> a= None
bool(a)
>>> a is None
True
```

