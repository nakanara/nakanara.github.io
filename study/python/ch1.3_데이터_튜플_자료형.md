
# 데이터 튜플 자료형

![image](https://user-images.githubusercontent.com/1871682/97956992-5a0a2100-1ded-11eb-9e37-083a872fb6aa.png)


튜플(tuple)은 몇 가지의 차이점을 제외하고는 리스트와 거의 비슷하다.

* 리스트는 `[]`으로 감싸서 사용하지만, 튜플은 `()`으로 사용
* 리스트는 그 값의 추가, 삭제, 수정이 가능하지만 튜플은 값을 변경 할 수 없다.


```python
t1 = ()
t2 = (1,) # 한 개의 값만 가질 경우 , 필수
t3 = (1,2)
t4 = 1,2,3 # ()를 생략 할 수 있다.
t5 = (1,2,3,('a','b')) # 튜플안에 또 다른 튜플이 가능
```

* 튜플은 요소값을 수정, 삭제하려면 오류 발생

```python
>>> t1 = (1, 2, 'a', 'b') 
>>> del t1[0]
```
```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object doesn't support item deletion
```

```python
>>> t1[0] = 10
```

```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
```

* 튜플 요소 값 사용

```python
>>> t1 = (1, 2, 'a', 'b') 
>>> print(t1[0])
1
```

* 튜플 슬라이싱

```python
>>> t1 = (1, 2, 'a', 'b') 
>>> print(t1[1:])
(2, 'a', 'b')
```

* 튜플 결합

```python
>>> t1 = (1, 2, 'a', 'b') 
>>> t2 = (3, 4)
>>> t1 = t1 + t2
>>> print(t1)
(1, 2, 'a', 'b', 3, 4)
```

* 튜플 곱하기

```python
>>> t2 = (3, 4)
>>> t2 * 3
(3, 4, 3, 4, 3, 4)
```

* 튜플 길이 구하기

```python
>>> t1 = (1, 2, 'a', 'b') 
>>> len(t1)
4
```