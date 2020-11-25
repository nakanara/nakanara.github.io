
# 연산 및 제어문

![image](https://user-images.githubusercontent.com/1871682/97956992-5a0a2100-1ded-11eb-9e37-083a872fb6aa.png)

## 연산

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

## 변수 사용

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

## 제어문

### 조건문 if

중괄호로 감싸는 것이 없으며 들여 쓰기로 구분하기 때문에 **탭 또는 공백(4칸)으로 들여 쓰기 필요**

```python
>>> a = 15
>>> if a > 10:
...    print("a는 10보다 크다")
...
a는 10보다 크다    

>>> if a != 1: 
...    print("1 아님")
'1 아님'

>>> x = 100
>>> y = 100
>>> if x and y:
....    print("yes")
....else :
....    print("no")    
yes
```


### 반복문 for


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

### 반복문 while

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

## 함수

```python
>>> def sum(a, b):
...    return a+b
...
>>> sum(10, 5)
15
```



## Bitwise 연산

```python 
>>> a = 8    # 0000 1000
>>> b = 11   # 0000 1011
>>> c = a & b  # 0000 1000 (8)
>>> d = a ^ b  # 0000 0011 (3)
>>> print(a, b, c, d)
8 11 8 3
```

## Membership

멤버 연산자에는 in, not in 존재, 해당 값이 존재하는지 파악

```python 
>>> a = [1, 2, 3, 4]
>>> b = 3 in a # True
>>> print(b)
True

>>> b = 3 not in a # False
>>> print(b)
False

```

## Identity 연산자

동일 객체 여부 판단
mutable 데이터 타입과 immutable 데이터 타입이 존재

* mutable: 객체를 생성한 후, 객체의 값을 수정 가능, 변수는 값이 수정된 같은 객체를 표시(list, set, dict)
* immutable: 객체를 생성한 후, 객체의 값 수정 불가, 변수는 해당 값을 가진 다른 객체를 주소 값을 가지고 있으며, 수정하는 경우 새로운 주소 값을 할당 받음(int, float, complex, bool, string, tuple)

```python 
>>> a = "ABC"
>>> b = a
>>> print(a is b)
True

>>> a = "BCD"
>>> print(a is b)
False

# ID로 비교 및 확인 가능
>>> id(a)
>>> id(b)
```

#python #연산 #제어문