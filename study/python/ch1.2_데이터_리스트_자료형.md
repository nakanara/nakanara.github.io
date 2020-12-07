
# 데이터 리스트 자료형

![image](https://user-images.githubusercontent.com/1871682/97956992-5a0a2100-1ded-11eb-9e37-083a872fb6aa.png)

리스트 자료형 선언 방법은 대괄호`[]`로 감싸며, 각 항목 값은 `,`로 구분한다.

**시작 Index는 0부터 시작한다.**

### 리스트 선언

```python
>>> a = [1,2,3,4,5] # 선언 방법
>>> b = list() # 빈 리스트 선언
>>> a[0]
1
>>> c = [1,2,3,['a', 'b']]
>>> c[3]
['a', 'b']
>>> c[3][0]
'a'
```

### 리스트의 슬라이싱

```python
>>> a = [1, 2, 3, 4, 5]

>>> a[0:2]
[1, 2]

>>> a[:2]
[1, 2]

>>> a[2:]
[3, 4, 5]

>>> b = a[:2]
>>> b
[1, 2]

>>> c = a[2:]
>>> c
[2, 3, 4]

```

### 리스트 연산

* 리스트 결합

```python
>>> a = [1, 2, 3]
>>> b = [4, 5, 6]
>>> a + b
[1, 2, 3, 4, 5, 6]
```

* 리스트 반복

```python
>>> a = [1, 2, 3]
>>> a * 3
[1, 2, 3, 1, 2, 3, 1, 2, 3]
```

* 리스트 길이 구하기

```python
>>> a = [1, 2, 3]
>>> len(a)
3
```

* 리스트 연산 시 Type(자료형) 유의

자료 유형에 유의하여 연산해야 함   

```python 
>>> a = [1, 2, 3]
>>> a[2] + "Hi"

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'int' and 'str'

>>> 2 + "Hi"
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'int' and 'str'

>>> str(a[2]) + "Hi"
'3Hi'
```


* 리스트 값 수정
  
``` python
>>> a = [1, 2, 3]
>>> a[1] = 5
>>> a
[1, 5, 3]
```

* 리스트 값 삭제

```python 
>>> a = [1, 2, 3]
>>> del a[1]
>>> a
[1, 3]

# 슬라이싱을 통해 범위로 삭제도 가능
>>> b = [1, 2, 3, 4, 5]
>>> del b[2:]
>>> b
[1, 2]
```

### 리스트 함수

* 리스트 항목 추가(append)

```python
>>> a = [1, 2, 3]
>>> a.append(4)
>>> a
[1, 2, 3, 4]

>>> a.append([5, 6])
>>> a
[1, 2, 3, 4, [5, 6]]
```

* 리스트 정렬(sort)

sort는 정렬만 진행

```python
>>> a = [1, 4, 3, 2]
>>> a.sort()
>>> a
[1, 2, 3, 4]

>>> a.sort(reverse = True) # 내림차순
>>> a
[4, 3, 2, 1]
```

* 리스트 복사 후 정렬 (sorted)

```python
>>> a = [1, 4, 3, 2]
>>> b = sorted(a)
>>> a
[1, 4, 3, 2]
>>> b
[1, 2, 3, 4]

>>> b = sorted(a, reverse = True)
>>> b
[4, 3, 2, 1]
```

* 리스트 뒤집기(reverse)

값의 크기에 대한 정렬이 아닌 Index를 기준으로 역순 정렬

```python
>>> a = [1, 4, 3, 2]
>>> a.reverse()
>>> a
[2, 3, 4, 1]
```

* 위치 반환(index)

해당 값이 없는 경우 오류가 발생하며, 값이 중복되어 있는 경우 처음 발견한 index 반환

```python
>>> a = [1, 4, 3, 2, 3]
>>> a.index(3)
>>> 2

>>> a.index(5)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: 5 is not in list
```

* 항목 삽입(insert)

지정한 위치에 항목을 삽입

```python 
>>> a = [1, 4, 3, 2]
>>> a.insert(0, 0)
>>> a
[0, 1, 4, 3, 2]

>>> a.insert(2, 2)
>>> a
[0, 1, 2, 4, 3, 2]
```

* 리스트 값에 해당하는 항목 제거(remove)

```python
>>> a = [1, 4, 3, 2, 3]
>>> a.remove(3)
>>> a
[1, 4, 2, 3]
```

* 리스트 항목 꺼내기(pop)

첫 번째 항목을 돌려주고, 해당 항목은 삭제한다.

```python
>>> a = [1, 4, 3, 2]
>>> a.pop()
>>> a
[4, 3, 2]
```

* 리스트에 포함된 항목의 동일 값 개수 세기(count)

```python
>>> a = [1, 4, 3, 2, 3]
>>> a.count(3)
2
```

* 리스트 확장(extend)

```python
>>> a = [1, 2, 3]
>>> a.extend([4, 5])
>>> a
[1, 2, 3, 4, 5];

>>> b = [6, 7]
>>> a.extend(b)
>>> a
[1, 2, 3, 4, 5, 6, 7]

>>> a += [8, 9]
>>> a
[1, 2, 3, 4, 5, 6, 7, 8, 9]

>>> c = [10, 11]
>>> a += c
>>> a
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
```

#python #리스트 #list