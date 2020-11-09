# Python 기초 문법

## 사칙연산 및 산술연산

```python

"더하기"
>>> 1 + 2 
3
"나누기"
>>> 3 / 2.4
1.25
"나누기 몫 반환"
>>> 3 // 2.4
1.0
>>> 3 // 2
1
"나머지"
>>> 7%3
1
"곱하기"
>>> 3 * 9
27
"제곱"
>>> 2 ** 3
8


```

* 변수 대입

```python
>>> a = 1
>>> b = 2
>>> c = a + b
3
```

* 출력하기

```python
>>> a = "Hello World!"
>>> print(a)
Hello World!
```

* 조건문 if

들여쓰기 규칙에 의해 탭 또는 공백(4칸)으로 들여쓰기 필요

```python
>>> a = 15
>>> if a > 10:
...    print("a는 10보다 크다")
...
a는 10보다 크다    
```

* 반복문 for

```python
>>> for i in [1,2,3,"a","b","c"]:
...    print(i)
...
1
2
3
a
b
c
```

* 반복문 while

```python
>>> i = 0
>>> while i < 3:
...    i += 1
...    print(i)
... 
1
2
3
```

* 함수

```python
>>> def sum(a, b):
...    return a+b
...
>>> sum(10, 5)
15
```

## 추천 에디터

* 비주얼 스튜디오

비주얼 스튜디오(Visual Studio Code)는 마이크로 소프트사에서 만든 에디터로 가볍고 지원이 빠르다.
인터프리터 언어인 파이썬에 많이 사용된다.

https://code.visualstudio.com/


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

파이썬의 문자열은 자바스크립트와 유사하게 큰따움표(") 및 작은따움표(')로 문자열을 생성할 수 있다.

멀티라인의 경우 큰따움표("), 작은 따움표(')를 3번 연속 사용하여 멀티라인으로 표현할 수 있으며, \\n으로도 표시할 수 있다.

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

### 이스케이프 문자

|코드|설명|
|--|--|
|\\n|줄 바꿈(개행)|
|\\t|탭|
|\\\\|문자 \\ 표시|
|\\'|작은 따움표(') 표시)
|\\"|큰 따움표(") 표시|
|\\r|캐리지 리턴, 해당 행에 커서를 가장 앞으로), \\n\\r 함께 사용|






# 파이썬의 기본 데이터 타입
#
# int: 정수형 데이터 100, 0xFF(16진수), 0o56(8진수)
# float: 소수점을 포함한 실수 a=10.25
# bool: 참,거진을 표현 a=True
# None: Null과 같은 표현 a=None


print(bool(-1))  # True
print(bool("False"))  # True
print(bool(0))  # 공백과 숫자 0만 False 임
print(bool(""))  # False

a = None
print(a)
print(a is None)


# 산술 연산자
print("# 산술 연산자")
print(5%2) # 나머지 연산
print(5//2) # 나누기

print("비교연산자")
if a != 1:
    print("> 1 아님")

print("논리연산자")
x = True
y = False

if x and y:
    print("yes")
else :
    print("no")

# Bitwise 연산
print("# Bitwise 연산")
a = 8    # 0000 1000
b = 11   # 0000 1011
c = a & b  # 0000 1000 (8)
d = a ^ b  # 0000 0011 (3)
print(a, b, c, d)

# Membership
# 멤버연산자에는 in, not in 존재, 해당 값이 존재하는지 파악
print("#Membership ")
a = [1, 2, 3, 4]
b = 3 in a # True

print(b)

# Identity 연산자
print("# Identity 연산자")
a = "ABC"
b = a
print(a is b)


# 문자열
# 단일인용부호('), 이중인용부호(") 를 사용, 멀티라인으로 작성시 ''' , """ 인용부호를 3번 사용
s = '문자열'
s = "문자열"

s = '''
가나다라마
abcd
'''

print(s)
print(s.lower())
print(s.upper())
# 문자열 포맷팅
# % 앞부분은 템플릿, 뒷 부분은 대입할 값이며, 값이 여러개일 경우 괄호(튜플)로 묶는다
print("#문자열 포맷팅")
p = "이름: %s 나이: %d %g %G" %("김유신", 65, 123, 123)
print(p)

# 변수의 값을 문자에 사용시 f를 사용하며, 해당 변수에 중괄호로 묶으면 변수가 치환됩니다
first_name = "홍"
last_name = "길동"
full_name = f"{first_name} {last_name}"
print(full_name)

# %s : 문자열(파이썬 객체 str() 사용하여 반환)
# %r : 문자열(파이썬 객체 repr() 사용하여 반환)
# %c : 문자(char)
# %d, %i: 정수(int)
# %f, %F: 부동소수 (float)
# %e, %E: 지수형 부동소수
# %g, %G: 일반형, 값에 따라
# %o, %O: 8진수
# %x, %X: 16진수
# %%: 퍼센트 티러럴

# str(문자열 클래스)
# 기본적으로 유니코드이며, 한벌 설정되면 수정하지 못하는 immutable 타입
