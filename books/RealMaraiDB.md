# Real MaraiDB 

> 위키북스, 이성욱 지음

## 4. 실행 계획 분석

* 쿼리 실행 절차은 크게 3가지

> 1. 사용자로부터 요청된 SQL문장을 분리하여 MariaDB가 이해할 수준으로 분리(파스 트리)
> 2. sql의 파싱 정보(파스 트리)를 확인하면서 어떤 테이블부터 읽고 어떤 인덱스를 이용해 테이블을 읽을지 선택[최적화 및 실행 계획 수립 단계 `옵티마이저`에서 처리]
> 3. 두 번재 단계에서 결정된 테이블의 읽기 순서나 선택된 인덱스를 이용해 스토리지 엔진으로부터 데이터를 가져 옴

* 옵티마이저 종류  
> 옵티마이저는 현재 대부분의 DBMS가 선택하고 있는 비용 기반 최적화(Cost-based optimizer, CBO) 방법과 예전 오라클에서 많이 사용했던 규칙 기반 최적화 방법(Rule-base optimizer, RBO)로 나눔, 현재는 거의 대부분의 RDBMS가 비용 기반의 옵티마이저를 채택

* 통계 정보
> 비용 기반 최적화에서 가장 중요한 것은 통계정보. MySQL 5.5 버전까지는 `SHOW INDEX STATS`명령으로만 분포도 확인이 가능했지만 MySQL 5.6부터는 mssql 데이터베이스의 `innodb_index_stats`테이블과 `innodb_table_stats`테이블에서도 인덱스 조회 가능  
> MySQL 5.6부터는 테이블 생성할 때 `STATS_PERSISTENT`옵션 설정 가능

|옵션|설명|
|---|---|
|STATS_PERSISTENT=0|통계 테이블을 기존 MySQL5.5이전 방식으로 관리, innodb_index_stats, innodb_table_stats 저장하지 않음|
|STATS_PERSISTENT=1|innodb_index_stats, innodb_table_stats 저장|
|STATS_PERSISTENT=DEFAULT|`innodb_stats_persistent` 시스템 설정에 따름, `기본적으로 ON(1)`로 되어 있음|

* 통계 정보가 새로 수집되는 경우(5.5 버전까지)

  - 테이블이 새로 오픈되는 경우
  - 테이블의 레코드가 대량으로 변경되는 경우(전체의 1/16 정도 CUD 발생 시)
  - ANALYZE TABLE 명령 실행 시
  - SHOW TABLE STATUS 명령이나 SHOW INDEX FROM 실행 시
  - InnoDB 모니터가 활성화 된 경우
  - `innodb_stats_on_metadata` 시스템 설정이 ON된 상태에서 SHOW TABLE STATUS 명령이 실행된 경우
> 자주 통계 정보가 변경되어 버리면, DB 서버가 풀 테이블 스캔으로도 변경되는 상황이 발생, 영구적인 통계 정보가 도입되면서 의도되지 않은 통계 정보 변경을 막을 수 있다. `innodb_stats_auto_recalc`시스템 변수로 통계 정보가 자동 수집되는 것을 막을 수 있음 `기본 ON(1)`, 영구적인 통계를 이용한다면 OFF로 변경, 테이블 생성시 `STATS_AUTO_RECALC`옵션을 통한 테이블 단위 조절 가능

|옵션|설명|
|---|---|
|STATS_AUTO_RECALC=1|통계 정보를 5.5 이전 방식으로 자동 수집|
|STATS_AUTO_RECALC=0|통계 정보를 ANALYZE TABLE 명령시에만 수집|
|STATS_AUTO_RECALC=DEFAULT|`innodb_stats_auto_recalc`시스템 변수 값으로 결정|



* MySQL 5.5 버전에서는 텅계 정보 수집시 몇 개의 InnoDB 테이블 블록으 ㄹ샘플링 할 것인지 결정하는 옵션으로 `innodb_stats_sample_pages` 시스템 변수가 제공되는데, MySQL5.6에서는 사라지고 `innodb_stats_transient_sample_pages`, `innodb_stats_persistent_sample_pages` 로 분리  

|옵션|설명|
|---|---|
|innodb_stats_transient_sample_pages|기본값 8, 통계 수집시 8개의 페이지만 임의의 샘플링|
|innodb_stats_persistent_sample_pages|기본값 20, ANALYZE TABLE명령시 임의의 20페이지 샘플링, 영구 통계값으로 저장 후 활용|

* 통계정보 관리 방법 `use_stat_tables` 설정에 의해 결정, 기본값은 `never`

|통계테이블|설명|
|---|---|
|table_stats|테이블 통계(레코드 수)|
|column_stats|컬럼별 통계(정수값의 경우 최솟값, 최댓값, NULL 비율, 값 평균 길이, 중복값 존재 비율)|
|index_stats|인텍스 통계(인덱스 키 순번, 중복 값 비율)|


|옵션|설명|
|---|---|
|use_stat_tables='never'|MySQL5.6 통계 정보 관리 방ㅂ식과 동일, `table_stats`, `column_stats`, `index_stats` 테이블에는 수집되지 않음, 영구적 통계정보로 사용|
|use_stat_tables='complementary'|각 스토리지 엔진이 제공하는 통계를 우선 사용, 정보가 부족하거나 없는 경우 통합 통계 정보를 사용|
|use_stat_tables='preferably'|각 스토리지 엔진별로 관리되는 통계 정보보다 통합 통계 정보를 우선해서 사용|


```sql
-- tbl 통계 정보 그리고 col1, col2 컬럼, idx1, idx2 통계 정보 수집
ANALYZE TABLE tbl PERSISTENT FOR COLUMNS (col1, col2) INDEXS (idx1, idx2);
-- tbl 통계 정보 그리고 col1, col2 컬럼만 통계 정보 수집
ANALYZE TABLE tbl PERSISTENT FOR COLUMNS (col1, col2) INDEXS ();
-- tbl 통계 정보 그리고 idx1, idx2 통계 정보만 수집
ANALYZE TABLE tbl PERSISTENT FOR COLUMNS () INDEXS (idx1, idx2);
-- tbl 통계 정보의 통계 정보만 수집
ANALYZE TABLE tbl PERSISTENT FOR COLUMNS () INDEXS ();
-- tbl 테이블의 모든 칼럼, 모든 인덱스 통계 정보 수집
ANALYZE TABLE tbl PERSISTENT FOR ALL;
ANALYZE TABLE tbl; -- 동일 기능
```

* 히스토그램? 
MySQL 5.5 버전이나 MariaDB 5.5 버전에서는 실행 계획을 예측이 부정확하여, 이를 보완하기 위해서 실제 데이터 페이지를 분석하기도 한다. MariaDB 10.0에서는 인덱스로 만들어진 칼럼뿐만 아니라 인덱싱되지 않은 컬럼에 대해서도 모두 히스토그램 정보를 저장할 수 있도록 개선. MariaDB 10.0 에서는 테이블의 모든 칼럼에 대해서 최솟값과 최댓값 그리고 NULL 값을 가진 레코드의 비율, 칼럼 값들의 분포를 히스토그램으로 수집해서 `mysql.column_stats` 테이블에서 관리, 히스트르그램 관리 방법은 "Height-Balanced Histogram" 알고리즘 사용

"Height-Balaced Histogram": 칼럼의 모든 값을 정렬해서 동일한 레코드 건수가 되도록 그룹을 몇 개로 나눈고, 각 그룹의 마지막 값(정렬 상태에서 큰 값)을 기록

|옵션|설명|
|---|---|
|optimizer_user_condition_selectivity=1|MariaDB 5.5 에서 사용되던 선택도(Selectivity) 예측 방식 유지|
|optimizer_user_condition_selectivity=2|인덱스가 생성되어 있는 칼럼의 조건에 대해서만 선택도 판단|
|optimizer_user_condition_selectivity=3|모든 칼럼의 조건에 대해서 선택도 판단(히스토그램 사용 안함)|
|optimizer_user_condition_selectivity=4|모든 칼럼의 조건에 대해서 선택도 판단(히스토그램 사용)|
|optimizer_user_condition_selectivity=5|모든 칼럼의 조건에 대해서 히스토그램을 이용해서 선택도 판단하며, 추가적으로 인덱스 레인지 스캔이 불가한 칼럼에 대해서도 레코드 샘플링을 이용해서 선택도 판단|

* 조인 옵티마이저 옵션

  - "Exhausite 검색": MySQL 5.0과 그 이전에 사용되던 기법으로, FROM 절에 명시된 모든 테이블의 조합에 대해서 실행 계획의 비용을 계산하여 최적의 조합 1개를 찾는 방법. 

  - "Heuristic 검색(Greedy 검색)":  Greedy 검색은 Exhaustive 검색의 시간 소모적인 문제점을 해결하기 위해 MySQL 5.0 부터 도입

  > 1. 전체 N개의 테이블 중에서 optimizer_search_depth 시스템 설정 변수에 정의된 갯수의 테이블로 가능한 조인 조합 생성
  > 2. 생성된 조인 조합중에서 최소 비용의 실행 계획 하나를 선정
  > 3. 선정된 실행 계획의 첫 번째 테이블을 "부분 실행 계획"의 첫번째 테이블로 선정
  > 4. 전체 N-1개의 테이블 중에서(3번 선택된 테이블 제외) optimizer_search_depth 시스템 설정 변수에 정의된 갯수의 테이블로 가능한 조인 조합을 생성
  > 5. 4번 생성된 조인 결과들을 하나씩 3번에서 생성된 "부분 실행 계획"에 대입해서 실행 비용을 계산
  > 6. 5번의 비용 계산 결과, 가장 비용이 낮은 실행 계획을 골라서 그중 두 번째 테이블을 3번에서 생성된 "부분 실행 계획"의 두 번째 테이블로 선정
  > 7. 남은 테이블이 모두 없어질 때까지 4~6번 과정 반복
  > 8. 최종적으로 "부분 실행 계획"이 테이블의 조인 순서로 결정 
  
  
optimizer_prune_level: 검색 알고리즘 선택 옵션, "OFF" 설정 Exhausite 검색을 조인 최적화 알고리즘에 사용, ON 설정 Greedy 검색 사용. `기본 ON 설정`

optimizer_search_depth: Greedy 검색에서만 사용되는 변수, 조인 쿼리 실행 계획 수립 성능에 영향(optimizer_search_depth 시스템 변수 기본값은 64), 조인 테이블이 적을 경우 큰 성능 차이 없음. (3 ~ 5개 테이블의 경우)

- 테스트 예제 사이트: https://launchpad.net/test-db
- 테스트 데이터: http://cafe.naver.com/realmysql


* 실행 계획 분석

EXPLAIN 명령어를 이용하여 실행 계획 분석, UPDATE, INSERT, DELETE 문장에 대해서는 실행 계획을 확인할 방법은 없다, 해당 구문의 실행 계획을 확인하려면 동일 조건을 SELECT 조건으로 변경하여 확인

* DEPENDENT SUBQUERY 

서브 쿼리가 바깥쪽(Outer) SELECT 쿼리에서 정의된 칼럼을 사용하는 경우를 DEPENDENT SUBQUERY라고 표현
아래 쿼리는 안쪽(Inner)의 서브 쿼리 결과가 바깥쪽(Outer) SELECT 쿼리의 결과에 의존적이라서 DEPENDENT라는 키워드가 붙는다. 또한 `DEPENDENT UNION과 같이 DEPENDENT SUBQUERY 또한 외부 쿼리가 먼저 수행된 후 내부 쿼리(서브 쿼리)가 실행돼야 하므로 일반 서브 쿼리보다는 속도가 느릴때가 많다.`

```SQL
EXPLAIN
SELECT e.first_name,
  (SELECT COUNT(*) FROM dept_emp de, dept_manager dm
    WHERE dm.dept_no = de.dept_no
      AND dm.emp_no = e.emp_no
  ) AS cnt
FROM employees e
WHERE e.first_name = 'Matt'; 
```

### type 칼럼

쿼리의 실행 계획에서 type 이후의 칼럼은 MariaDB 서버가 각 테이블의 레코드를 어떤 방식으로 읽었는지를 나타낸다. 여기서 방식이라 함은 인덱스를 사용해 레코드를 읽었는지 아니면 테이블을 처음부터 끝까지 읽는 풀 테이블 스캔으로 레코드를 읽었는지 등을 의미한다. 일반적으로 쿼리를 튜닝할 때 인덱스를 효율적으로 사용하는지 확인하는 것이 중요하므로 실행 계획에서 type 칼럼은 반드시 체크해야 할 중요한 정보다.

|Index type|설명|
|---|---|
|system|레코드가 1건만 존재하는 테이블 또는 한 건도 존재하지 않는 테이블 참조 형태|
|const|테이블의 레코드 건수에 관계 없이 쿼리가 PK나 UK 컬럼 이용하는 조건절 있는 경우, PK나 UK 중 일부 컬럼만 조건에 사용시 const 가 아닌 ref 로 표시(레코드가 1건이라고 확신할 수 없음), const의 경우 반드시 한건만 반환|
|eq_ref|여러 테이블 조인되는 쿼리의 실행 계획에서만 표시되며, 조인에서 처음 읽은 테이블의 컬럼 값을 그 다음에 처리할 테이블의 PK 혹은 UK 컬럼의 조회 조건에 사용될 경우 표시, 두 번째 테이블은 반드시 한건만 반환|
|ref|eq_ref와 달리 조인의 순서와 관계 없이 사용, PK 혹은 UK 여부와도 관계 없이 조건으로 동등(Equals) 조건 검색에 사용, 한건 이상의 레코드 가능성|
|fulltext|MATCH...AGAINST 구문 실행시 사용, 인덱스가 fulltext의 경우 사용|
|ref_or_null|ref 접근 방식과 같지만, NULL 비교가 추가된 형태, IS NULL 이 있는 경우|
|unique_subquery|조건절에서 사용되 수 있는 IN(sub query)형태의 쿼리를 위한 접근 방식, 서비 쿼리에서 중복되지 않은 유니크 값만 반환할 때 사용, IN(Sub Query)의 경우 반환 값에 중복이 없으므로 별도의 중복 제거 작ㅇ버이 필요하지 않음|
|index_subquery|서브 쿼리 결과의 중복된 값을 인덱스를 이용해서 제거할 수 있을 때 사용|
|range|하나의 값이 아닌 범위 검색 주로 "<,>,IS NULL, BETWEEN, IN, LIKE" 등의 연산자를 이용해 인덱스를 검색할 때 사용, 일반적으로 많이 사용|
|index_merge|2개 이상의 인덱스를 이용해 각각의 검색 결과를 만들어낸 후 그 결과를 병합처리|
|index|index 접근 방식은 인덱스를 처음부터 끝까지 읽는 `인덱스 풀 스캔`을 의미!!|
|ALL|`테이블 풀 스캔`|

### Extra 칼럼

쿼리의 실행 계획에서 성능에 관련된 중요한 내용이 Extra 칼럼에 자주 표시된다. Extra 칼럼에는 고정된 몇 개의 문장이 표시되는데, 일반적으로 2 ~ 3개씩 같이 표시

|Extra|설명|
|---|---|
|const row not found|테이블을 접근했지만, 해당 테이블에 레코드가 없는 경우|
|distinct|distinct 처리|
|Full scan on NULL key|`col1 IN (select col2 from... )` 과 같은 조건에 많이 발생, NULL이 포함된 것은 풀 테이블 스캔을 해야지 판단 가능,  `col1 is not null` 과 함께 정의시 풀스캔 하지 않음|
|Impossible HAVING|having 절의 조건을 만족하는 레코드가 없는 경우 발생 `쿼리 확인 필요`|
|Impossible WHERE|불가능한 where 조건일 경우 발생, 레코드가 없는 경우|
|Impossible WHERE noticed after reading const tables| 실행 계획 수립단계에서 옵티마이저가 직접 쿼리의 일부를 실행하고, 실행된 결과를 쿼리의 상수로 대체|
|No matching min/max row|min, max와 같은 집합 함수가 있는 쿼리의 조건절에서 일치하는 레코드가 없는 경우|
|no matching row in const table|const 방식으로 접근할 때 일치하는 레코드가 없는 경우|
|No tables used|FROM 절이 없는 문장 from dual|
|Not exists|A테이블에 존재하지만 B에 없는 값을 조회 할때 NOT IN(...)형태나 NOT EXISTS 연산자 사용, 이러한 형태의 조인을 안티-조인(Anti-join)이라고 함, 하지만 동일한 것을 아우터 조인(LEFT OUTER JOIN)을 이용해서 구현이 가능하며, 아우터 조인을 이용하는 경우 표시 됨|
|Rangechecked for each record(index map:N)|매 레코드마다 인덱스 레인지 스캔을 체크|
|Sccanned N databases|INFORMATION_SCHEMA 내의 테이블로부터 데이터를 읽는 경우 표시, 몇 개의 DB 정보를 읽었는지 보여주는 것|


## 5. 최적화

## 6. 스토리지 엔진

## 7. 기타기능

## 8.레플리케이션

## 참고

* HeidiSQL
* MariaDB 사이트