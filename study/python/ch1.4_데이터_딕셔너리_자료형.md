
# 데이터 딕셔너리 자료형

![image](https://user-images.githubusercontent.com/1871682/97956992-5a0a2100-1ded-11eb-9e37-083a872fb6aa.png)

Key = Value 형식으로 Key에 대응하는 값을 표현 할 수 있으며, 이러한 대응 관계를 연관 배열(Associative array) 또는 해시(Hash)라고 한다.

```python
>>> dic = {'key':'value', 'name':'Kai', 'age':'20'}
>>> dic['key']
'value'

# Key는 정수값 가능
>>> a = {1:'a', 'b':2}
>>> a[1]
'a'
>>> a['b']
2

# Value에는 다른 자료형도 가능
>>> a = {'a':[1,2,3]}
>>> a['a']
[1, 2, 3]
```

dic 에 담긴 대응 관계 정보

|Key|Value|
|--|--|
|key|value|
|name|Kai|
|age|20|


* 딕셔너리 값 추가

```python
>>> a = {1: 'a'}
>>> a[2] = 'b' 
>>> a
{1: 'a', 2: 'b'}
>>> a['x'] = 'X'
>>> a
{1: 'a', 2: 'b', 'x': 'X'}
```

* 딕셔너리 값 삭제

```python 
>>> a = {1: 'a', 2: 'b', 'x': 'X'}
>>> del a['x'] 
>>> a
{1: 'a', 2: 'b'}
```

* 딕셔너리 값 사용

```python 
>>> dic = {'key':'value', 'name':'Kai', 'age':'20'}
>>> dic['name']
'Kai'
```

* 같은 Key로 생성할 경우 앞에 값이 덮어쓰임

```python
>>> a = {1:'a', 1:'b'}
>>> a
{1: 'b'}
```

* Key로 리스트는 사용할 수 없다.

변경이 가능한 자료형은 Key 값으로 사용이 불가능 하다

```python

# Key로 튜플 자료형 사용
>>> a = {(1,):'a'}
>>> a 
{(1,): 'a'}
>>> a[(1,)]
'a'

# Key로 리스트 사용
>>> b = {[1,2]:'a'}
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unhashable type: 'list'
```

* 딕셔너리에서 Key값 추출

```python
>>> dic = {'key':'value', 'name':'Kai', 'age':'20'}
>>> dic.keys()
dict_keys(['key', 'name', 'age'])

# Key를 이용한 반복문
>>> for k in dic.keys(): 
...     print(k)
... 
key
name
age

# Key를 list로 변환
>>> list(dic.keys())
['key', 'name', 'age']
```

* 딕셔너리에서 Value값 추출

```python
>>> dic.values()
dict_values(['value', 'Kai', '20'])
```

* 딕셔너리 Key, Value 항목 얻기(items)

```python 
>>> dic.items()
dict_items([('key', 'value'), ('name', 'Kai'), ('age', '20')])
```

* 딕셔너리 초기화

```python
>>> dic.clear()
>>> dic
{}
```

* 딕셔너리 Key로 Value 얻기(get)

Key가 없는 값을 조회할 때 dic[key]로 할 때 없다면 오류 발생

```python
>>> dic = {'key':'value', 'name':'Kai', 'age':'20'}
>>> dic.get('name')
'Kai'
>>> dic['name']
'Kai'

# Key가 없는 값을 조회할 때 dic[key]로 할 때 없다면 오류 발생
>>> dic.get('na')
>>> dic['na']
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
KeyError: 'na'

# 값이 없을 경우 default 값 설정하기
>>> dic.get('na', 'None')
'None'
```

* 해당 Key 존재 여부 (in)

```python 
>>> 'na' in dic
False
>>> 'name' in dic
True
```

