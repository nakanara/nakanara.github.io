# Real MaraiDB CH1 ~ CH3

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



