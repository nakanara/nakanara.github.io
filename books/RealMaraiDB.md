# Real MaraiDB 

> 위키북스, 이성욱 지음

## 1. MariaDB 

1. MaraiDB는 MySQL  커뮤니티 코드 베이스를 이용해서 탄생
1. MariaDB는 Monty Program AB회사에 의해서 다듬어진 MySQL    
  
    
* MariaDB와 MySQL 프로그램 비교

||MariaDB|MySQL|
|---|---|---|
|데이터베이스 서버| mysqld|mysqld|
|MyISAM 체크|myisamchk|myisamchk|
|클라이언트|mysql|mysql|
|서버 관리자 유틸리티|mysqladmin|mysqladmin|
|데이터 덤프|mysqldump|mysqldump|
|데이터 적재|mysqlimport|mysqlimport|
|빌트인 백업|mysqlhotcopy|mysqlhostcopy|
|스키마 업그레이드|mysql_upgrade|mysql_upgrade|
|바이너리 로그 분석|mysqlshow|mysqlshow|
|슬로우 쿼리 로그 분석|mysqldumpslow|mysqldumpslow|



## 2. 설치


* 데이터 덤프

```sh
# 데이터 덤프
$ mysqldump -u root -p --all-databases > backup.dump

# 데이터 Import
$ mysql -u root -p < ackup.dump

# 새로운 버전의 DB 업그레이드
$ mysql_upgrade --verbose
# 예전 MySQL 서버에서 모든 데이터베이스 (구조, information_schema 등 관리용 DB)를 가진 경우라면 인증이나 딕셔너리 테이블의 구조는 버전 간 호환되지 않을 수도 있으므로 mysql_upgrade로 업그레이드
```

## 3. MariaDB 기동 및 쿼리 실행

* 수동 실행
```sh
#! /bin/bash

MYSQL_HOME=/usr/local/mysql
${MYSQL_HOME}/bin/mysqld_safe --defaults-file=/etc/my.cfg &
```

* 사용자의 식별
> 사용자 계정과 접속 지점도 계정에 함께 포함되므로, 판단하여야 계정설정을 진행해야하며, 동일 설정이 있는 경우 작은 범위를 우선적으로 실행 함

* 권한
> \*.\* : 대상 오브젝트가 MariaDB 서버 전체를 의미  
> db1.* : 특정 데이터베이스 전체  
> db1.table1:특정 데이터베이스의 특정 테이블  
> db1.stored_program1: 특정 데이터베이스의 스토어드 프로그램 지정  

```sql
-- 전체  
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* to 'user'@'localhost';  
-- employees 데이터베이스만  
GRANT SELECT, INSERT, UPDATE, DELETE ON employees.* to 'user'@'localhost';  
-- department 테이블만  
GRANT SELECT, INSERT, UPDATE, DELETE ON employees.department to 'user'@'localhost'; 
-- UPDATE시 DEPT_NAME은 업데이트 할 수 없는 권한
GRANT SELECT, INSERT, UPDATE (dept_name) ON employees.department to 'user'@'localhost'; 
```

#### * 전역 권한

|권한(Privilege)|설명|
|---|---|---|
|CREATE USER|새로운 사용자 생성할 수 있는 권한|
|FILE|LOAD DATA INFILE이나 LOAD_FILE() 함수와 같이 디스크의 파일 접근 권한|
|GRANT OPTION|다른 사용자에게 권한을 부여할 수 있는 권한(GRANT 권한이 있어도 자신이 가진 권한만 부여 가능)
|PROCESS|SHOW PROCESSLIST 명령과 같이 MariaDB 서버 내의 프로세스를 조회|
|RELOAD|FLUSH 명령을 실행할 수 있는 권한|
|REPLICATION CLIENT|SHOW MASTER STATUS나 SHOW SLAVE STATUS와 같이 복제 클라이언트 정보 조회|
|REPLICATION SLAVE|슬레이브 MariaDB 서버가 마스터 MariaDB 접속 할 때 사용하는 사용자 계정에 필요한 권한|
|SHOW DATABASES|데이터베이스 목록 조회 권한|
|SHOWDOWN|MariaDB 서버 종료 권한|


#### * 데이터베이스 레벨

|권한(Privilege)|설명|
|---|---|---|
|CREATE|새로운 데이터베이스 생성|
|CREATE ROUTINE|새로운 스토어드 프로시저나 함수 생성 권한|
|CREATE TEMPORARY TABLES|임시 테이블 생성 권한(내부 임시 테이블의 생성과는 무관)|
|DROP|데이터베이스 삭제 권한|
|EVENT|이벤트 생성 및 삭제 권한|
|GRANT OPTION|데이터베이스에 대한 권한을 다른 사용자에게 부여할 수 있는 권한(자신이 가진 권한에 한해서)|
|LOCK TABLES|LOCK TABLES명령을 이용하여 명시적으로 테이블 잠글 수 있는 권한|

#### * 테이블 레벨 권한

|권한(Privilege)|설명|
|---|---|
|ALTER|테이블 구조 변경 권한|
|CREATE|테이블 생성 권한|
|CREATE VIEW|뷰 생성 권한|
|DELETE|테이블 레코드 삭제(DELETE 쿼리)권한|
|DROP|테이블, 뷰 삭제 권한|
|GRANT OPTION|테이블에 대한 권한 다른 사용자에게 부여 권한|
|INDEX|CREATE INDEX 명령으로 인덱스를 생성할 수 있는 권한(테이블 생성 권한이 있다면 해당 권한이 없어도 CREATE TABLE 문장과 함께 인덱스 를 생성하는 것은 가능)|
|INSERT|테이블 레코드 저장 권한|
|SELECT|테이블 레코드 조회 권한|
|SHOW VIEW|SHOW CREATE VIEW명령을 이용하여 뷰의 구조를 조회할 수 있는 권한|
|TRIGGER|트리거의 생성과 삭제 그리고 실행 권한|
|UPDATE|테이블 레코드 변경 권한|

#### * 스토어드 프로그램 레벨 권한

|권한(Privilege)|설명|
|---|---|
|ALTER ROUTINE|스토어드 프로그램(프로시저와 함수)의 내용 변경 권한|
|EXECUTE|스토어드 프로그램(프로시저 함수) 실행 권한|
|GRANT OPTION|다른 사용자에게 스토어드 프로그램(프로시저와 함수) 권한 부여 권한|

### 권한 그룹(Role)
> 권한 그룹은 CREATE ROLE 명령으로 생성, CREATE USER 권한이 있는 사용자만 가능, CREATE ROLE 명령이 실행될 때 USER 테이블에 권한 그룹의 정보가 저장, is_role 컬럼이 'Y'로 설정(사용자와 권한 그룹은 동일 mysql.user 테이블 관리)

```sql
-- with 가 없을 경우 current_user 로 자동 생성
create role dba; 
create role developer with admin { current_user | current_role | user | role };

-- 그룹에 권한 부여
grant all privileges on *.* to dba;
grant select, insert, update, delete on 'db1'.* to developer;

-- 사용자에 권한 그룹(role) 부여
grant developer to 'user1'@'%';

-- 자신의 권한 확인
select current_role; 

-- ! 권한 그룹을 획득하기 위해서는 set role 명령을 실행
set role dba;

-- ! 한 사용자가 2개 이상의 권한 그룹을 가질수 없음. set role 명령시 마지막으로 설정된 권한 그룹 인식
```

* 테이블 생성

```sql
-- **IF NOT EXISTS** 조건은 테이블이나 컬럼 생성시 사용, 테이블이나 컬럼이 이미 존재하는 경우 에러를 발생시키지 않고 경고만 발생  
CREATE TABLE [IF NOT EXISTS] tab_test(
  tid bigint not null auto_increment,
  tname varchar(100) not null,
  tmemo text not null,
  PRIMARY KEY (tid),
  INDEX ix_tname_tid (tname, tid)
) ENGINE=InnoDB; -- engine 가 없는 경우 my.cnf, my.ini 의 기본 스토리지 엔진 사용

-- 생성된 테이블 내역 확인
SHOW CREATE TABLE tab_test;
DESC tab_test;

-- 컬럼 추가
ALTER TABLE tab_test ADD created DATETIME NOT NULL;
-- 인덱스 추가
ALTER TABLE tab_test ADD INDEX ix_created(created); 
-- alter 동시 작업 (오프라인 작업시 테이블 복사가 이루어지기 때문에 여러 개의 스키마를 변경할 수 있도록 지원)
ALTER TABLE tab_test ADD created DATETIME NOT NULL,
                     ADD INDEX ix_created(created); 
```

* 오프라인 스키마 변경
> 기존 MariaDB 10.0 버전과 MySQL 5.6 이상 버전에서는 온라인 스키마 변경 기능 도입  
오프라인 스키마 변경의 경우 다음의 절차 수행  
> 1. tab_test 테이블 잠금
> 2. 변경 요청된 내용이 적용된 임시 테이블 생성 후 레코드를 한건씩 복사
> 3. 전체 복사 후 tab_test 테이블 삭제, 임시 테이블의 이름을 tab_test로 RENAME
> 4. tab_test 테이블 잠금 해제
>   
> ※ 다음의 경우 테이블 복사 형태의 작업 진행 하지 않음
> > 컬럼 명 변경  
> > 숫자 타입의 표시 길이 변경 INT(2) -> INT(3)  
> > 테이블 코멘트 변경  
> > ENUM 타임의 아이템 리스트의 마지막에 새로운 아이템 추가  
> > 테이블 이름 변경  



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

optimizer_search_depth: Greedy 검색에서만 사용되는 변수, 조인 쿼리 실행 계획 수립 성능에 영향(optimizer_search_depth 시스템 변수 기본값은 64), 조인 테이블이 적을 경우 큰 성능 차이 없음. (3 ~ 5개 테이블의 경우 )


## 5. 최적화

## 6. 스토리지 엔진

## 7. 기타기능

## 8.레플리케이션

## 참고

* HeidiSQL
* MariaDB 사이트