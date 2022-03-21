--  56. 출력되는 행 제한하기. (ROWNUM)

USE mysql;


SELECT  @rownum := @rownum + 1 AS ROWNUM, 
		emp.*
	FROM emp, (SELECT @rownum := 0) r;

--  mysql에서는 rownum을 from절에서 초기화 해줘야한다. rownum초기화 시 별칭을 줘야한다.
    
--  ROWNUM은 PSEUDO COLUMN으로 '가짜의' 라는 뜻 그대로 *로 검색해서는 출력되지 않는 감추어진 칼럼이다.    
    
--  57. 출력되는 행 제한하기. (Simple TOP-n Queries)

/*

ORACLE ONLY

SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;

SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 20 PERCENT ROWS ONLY;    

--  동일 값이 있으면 같이 출력해준다. WITH TIES
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;    

-- OFFSET 옵션을 사용하면 시작되는 행의 위치를 지정할 수 있습니다. 
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS
    FETCH FIRST 2 ROWS ONLY;

*/

--  58. 여러 테이블의 데이터를 조인해서 출력하기 (EQUI JOIN)

SELECT * FROM emp;
SELECT * FROM dept;

SELECT emp.*, dept.DNAME, dept.LOC
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;
    
SELECT emp.*, 
	(SELECT DNAME FROM dept d WHERE emp.DEPTNO = d.DEPTNO) AS DNAME,
	(SELECT LOC FROM dept d WHERE emp.DEPTNO = d.DEPTNO) AS LOC
	FROM emp;
    

SELECT ename,job ,loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job='ANALYST';

SELECT e.deptno, e.ename ,e.job ,d.loc 
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job='ANALYST';    
    
--  59. 여러 테이블의 데이터를 조인해서 출력하기 (NON EQUI JOIN)

--  58번 예제와같이 EQUAL 조건을 줄수 없을때 사용하는 것이 NON EQUI JOIN 이다. 
--  EMP 테이블의 월급은 SALGRADE 테블의 LOSAL 과 HISAL 사이에 있다는 것을 보여줄때 사용하는 것이 
--  아래의 쿼리문이다. 

SELECT * FROM salgrade;

SELECT e.ename, e.sal, s.grade 
    FROM emp e, salgrade s
    WHERE e.sal between s.losal and s.hisal;

--  60. 여러 테이블의 데이터를 조인해서 출력하기 (OUTER JOIN)

--  EQUI JOIN 양쪽에 다 존재하는 데이터만 출력
--  LEFT OUTER JOIN EMP 테이블에는 존재하는데 DEPT 테이블에는 없는 데이터 출력 
--  RIGHT OUTER JOIN 그 반대

SELECT ename, loc
    FROM emp RIGHT OUTER JOIN dept
    ON emp.deptno = dept.deptno;

--  61. SELF JOIN 

SELECT e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
    FROM emp e, emp m
    WHERE e.mgr = m.empno;
    
--  62. 여러 테이블의 데이터를 조인해서 출력하기 (ON절)

--  56번과 표기의 차이이다. 56은 오라클 조인 작성법이고 62는 ansi 표준이다. 일반적으로 오라클 조인작성법을 많이 사용한다고 한다. 우리회사는 62번과 같은 표기법을 주로 사용한다.

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
 FROM emp e JOIN dept d
 ON (e.deptno = d.deptno)
 WHERE e.job = 'SALESMAN';
 
-- 63. 여러 테이블의 데이터를 조인해서 출력하기 USING

USE mysql;
 
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치" 
    FROM emp e join dept d
    USING (deptno)
    WHERE e.job='SALESMAN';

-- USING 절을 사용할때 DEPTNO 앞에는 테이블명이나 테이블 별칭을 사용 할 수 없습니다.
-- USING 절에는 반드시 괄호를 사용해야 합니다. 

-- 여러개의 테이블을 조인하는 경우

SELECT e.ename, d.loc, s.grade
    FROM emp e JOIN dept d USING (deptno)
    JOIN salgrade s 
    ON (e.sal between s.losal and s.hisal);
    
-- 64. 여러 테이블의 데이터를 조인해서 출력하기

-- NATURAL JOIN 은 두 테이블에 둘 다 존재하는 동일한 컬럼을 기반으로 "암시적인 조인" 을 수행한다. 둘 다 존재하는 동일한 컬럼인 DEPTNO를 오라클이 알아서 찾아 이를 이용하여 조인을 수행한다. 
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e NATURAL join dept d
    WHERE e.job = 'SALESMAN';

-- 65. 여러 테이블의 데이터를 조인해서 출력하기(LEFT OUTER JOIN)

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치" 
    FROM emp e  RIGHT OUTER JOIN dept d
    USING (deptno);
    
    
-- 66.  여러 테이블의 데이터를 조인해서 출력하기(FULL OUTER JOIN)

INSERT INTO EMP (empno, ename, sal, job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);
COMMIT;

/*

Mysql에서는 full outer join을 지원하지 않는다. UNION 쿼리를 이용해 같은 효과를 낼 수는 있다.

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서위치"
    FROM emp e FULL OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
*/
-- 오라클 표기법으로 full outer join 문을 작성 할 경우 에러가 발생합니다. 

-- 67. 집합 연산자로 데이터를 위아래로 연결하기 (UNION ALL) 

SELECT deptno, sum(sal)
    FROM emp
    GROUP BY deptno 
UNION ALL
SELECT TO_NUMBER(null) as deptno, sum(sal)
    FROM emp;

-- 위쪽 쿼리의 결과와 아래쪽 쿼리의 결과를 하나의 결과로 출력해준다.

/*
-union all 위쪽 쿼리와 아래쪽 쿼리 컬럼의 갯수가 동일해야합니다.
-union all 위쪽 쿼리와 아래쪽 쿼리의 데이터 타입이 동일해야합니다.
-결과로 출력되는 컬럼명은 위쪽 쿼리의 컬럼명으로 출력됩니다.
-ORDER BY 절은 제일 아래쪽 쿼리에만 작성할수 있습니다.

*/
    

-- 68. 집합 연산자로 데이터를 위아래로 연결하기 (UNION)

SELECT deptno, sum(sal)
    FROM emp
    GROUP BY deptno 
UNION
SELECT null as deptno, sum(sal)
    FROM emp;

/*
-중복된 데이터를 하나의 고유한 값으로 출력합니다.
-첫번째 컬럼의 데이터를 기준으로 내림차순 정렬합니다.
*/

-- 69. 집합 연산자로 데이터를 위아래로 연결하기 (INTERSECT)

/*

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20) 
INTERSECT
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
-- 위쪽 쿼리와 아래쪽 쿼리 결과의 교집합만 출력된다.    

*/


-- 70. 집합 연산자로 데이터의 차이를 출력하기(MINUS)

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20)
MINUS
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
-- 마이너스 연산자를 이용하여 위쪽 쿼리의 결과 데이터에서 아래쪽 쿼리의 결과데이터의 차이를 출력하는 쿼리문이다. 
-- 마이너스 연산자의 경우에도 데이터를 내림차순으로 정렬해준다
-- mysql에서는 minus를 사용 할 수 없다.

use mysql;

SELECT * FROM emp;

-- 이런식으로 구현 하면 된다.
SELECT ename, sal, job, deptno
	FROM emp
    WHERE deptno in(10, 20) AND 
    (ename, sal, job, deptno) not in 
		(SELECT ename, sal, job, deptno 
			FROM emp 
			WHERE deptno in (20, 30));




-- 71. 서브쿼리 사용하기 1 --  단일행 서브쿼리

SELECT ename, sal
    FROM emp
    WHERE sal >= (SELECT sal 
                    FROM emp
                    WHERE ename = 'JONES')
          AND ename != 'JONES';          
          
-- JONES 보다 더 많은 월급을 받는 사원들을 검색하려면 먼저 JONES사원의 월급을 출력한후, SAL 과 비교하는 두번의 쿼리문 수행을 해야만한다.
--  서브쿼리를 통해 수행횟수를 1회로 줄일 수 있다.

-- 72. 서브쿼리 사용하기 2 --  다중행 서브쿼리

SELECT ename, sal, job
    FROM emp
    WHERE sal in (SELECT sal FROM emp WHERE job = 'SALESMAN');
    
-- 서브쿼리 에서 메인쿼리로 하나의 값이 아니라 여러개의 값이 반환되는 것을 다중 행 서브쿼리라고 한다. 
-- 71번의 경우 jones 의 월급을 반환할 뿐임으로 하나의값이 반환된다. 즉 단일행 서브쿼리.
-- 그러나 72번의 경우 salesman이 한명이 아님으로 여러개의 값이 반환되는데 이를 다중 행 서브쿼리라한다. 
-- 서브쿼리의 종류에 따라 사용되는 연산자도 다른대, 다중행 서브쿼리에서는 in, not in, >any <any, >all, <all 을 사용한다. 
-- 참고로 반환되는 칼럼이 여러개일 경우 다중 컬럼 서브쿼리라고한다. 

-- 73 서브쿼리 사용하기 3 --  not in

-- 관리자가 아닌 사원들의 이름과 월급과 직업을 출력해보겠습니다.

SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr FROM emp WHERE mgr is not null);

SELECT  distinct mgr
    FROM emp
    WHERE mgr is not null;
    
SELECT *
    FROM emp;
    
-- 서브쿼리에서 메인쿼리로 null값이 하나라도 리턴되면 결과가 출력되지않는다.
-- 논리적으로 true and null 은 null이기때문이다.

-- 74. 서브쿼리 사용하기 4 --  exists 와 not exists

SELECT *
    FROM dept d
    WHERE EXISTS (SELECT * 
                    FROM emp e 
                    WHERE e.deptno = d.deptno);

SELECT *
    FROM dept d
    WHERE NOT EXISTS (SELECT * 
                    FROM emp e 
                    WHERE e.deptno = d.deptno);                    
                    
-- 75. 서브쿼리 사용하기 5 (HAVING절의 서브쿼리 사용하기)

SELECT job, sum(sal)
    FROM emp
    GROUP BY job 
    HAVING sum(sal) > (SELECT sum(sal)
                        FROM emp
                        WHERE job='SALESMAN');

-- 76. 서브쿼리 사용하기5 (FROM 절의 서브쿼리 사용하기)

SELECT  v.ename, v.sal, v.순위
    FROM (SELECT ename, sal, rank() over (order by sal desc) 순위 FROM emp) v
    WHERE v.순위 =1;

--  from 절의 서브쿼리를 in line view 라고한다.
--  where 절에는 분석함수를 사용 할 수 없기때문에 from 절에 서브쿼리문을 사용하여 먼저 실행되게 해야한다.

-- 77. 서브쿼리 사용하기7 (select절의 서브쿼리)

SELECT ename, sal, (SELECT max(sal) FROM emp where job='SALESMAN') as "최대 월급",
                   (SELECT min(sal) FROM emp where job='SALESMAN') as "최소 월급"
    FROM emp
    WHERE job='SALESMAN';
    

-- 78 데이터 입력하기 

-- 데이터를 입력하고 수정하고 삭제하는 SQL문을 DML문이라고한다.

INSERT INTO emp (empno, ename, sal, hiredate, job)
    VALUES(2812, 'JACK', 3500, TO_DATE('2019/06/05', 'RRRR/MM/DD'), 'ANALYST');

commit;    

-- 79. 데이터 수정하기(UPDATE) 

UPDATE emp
    SET sal = 3200
    WHERE ename='SCOTT';
    
-- SET절에도 서브쿼리를 사용할 수 있다. 

UPDATE emp
    SET sal = (SELECT sal FROM emp WHERE ename='KING')
    WHERE ename='SCOTT';
    
commit;    

-- 80. 데이터 삭제하기

-- 오라클에서 데이터를 삭제하는 명령에는 세가지가 있다.
-- DELETE 데이터 삭제
-- TRUNCATE 데이터를 모두 지우고 테이블구조만 남겨두는 것이다. 
-- DROP 테이블자체를 삭제한다. 

-- 81. 데이터 저장 및 취소하기 (COMMIT, ROLLBACK) 

-- ROLLBACK 직전 COMMIT 지점으로 돌아갑니다.

-- 82. 데이터 입력, 수정, 삭제 한번에하기(MERGE) 

use mysql;

ALTER TABLE emp
ADD loc varchar(10);
/*
MERGE INTO emp e
USING dept d
ON (e.deptno = d.deptno)
WHEN MATCHED THEN
UPDATE set e.loc = d.loc
WHEN NOT MATCHED THEN
INSERT (e.empno, e.deptno, e.loc) values (1111, d.deptno, d.loc);
*/

-- mysql에서는 사용 할 수 없다. mysql에서는 insert문 뒤에 ON DUPLICATE KEY 문을 사용하여 
-- 중복되는 값을 update문으로 돌리는 기능이 있다. 



SELECT *
    FROM emp;
    
-- 83. 락 이해하기(LOCK)     

/*
update문을 수행하면 update 대상이 되는 행을 잠궈버립니다.
update는 행 전체를 잠그기 때문에 jones월급 뿐만 아니라 다른 컬럼들의 데이터도 변경 할 수 없고 waiting하게 됩니다.
데이터의 일관성을 보장하기 위해 
*/

-- 84. select from update 절 이해하기.

-- 조회하는 행에 락을 건다.

-- 85. 서브쿼리를 사용하여 데이터 입력하기. 

-- insert select문, 한번에 여러 데이터를 입력하는 것이 가능하다.

CREATE TABLE emp2
AS
    SELECT *
        FROM emp
        WHERE 1=2;

INSERT INTO emp2 (empno, ename, sal, deptno)
    SELECT empno, ename, sal, deptno
        FROM emp
        WHERE deptno = 10;
        
SELECT *
    FROM emp2;
    

-- 86. 서브 쿼리를 사용하여 데이터 수정하기.    

/*
UPDATE emp
    SET sal = ( SELECT sal FROM emp WHERE ename='ALLEN')
    WHERE job = 'SALESMAN';
    
ROLLBACK;    
직업이 SALESMAN 인 사월들의 월급을 ALLEN의 월급으로 갱신합니다.

*/

-- 87. 서브쿼리를 사용하여 데이터 삭제하기

/*
DELETE FROM emp 
WHERE sal > (SELECT sal FROM emp WHERE ename = 'SCOTT');

DELETE FROM emp m
WHERE sal > (SELECT sal FROM emp s WHERE s.deptno = m.deptno);

*/

-- 88. 서브쿼리를 사용하여 데이터 합치기. 

ALTER TABLE dept ADD sumsal number(10);

MERGE INTO dept d
USING (SELECT deptno, sum(sal) sumsal 
            FROM emp
            GROUP BY deptno) v 
ON (d.deptno = v.deptno)
WHEN MATCHED THEN
UPDATE set d.sumsal = v.sumsal;

-- 89. 계층형 질의문으로 서열을 주고 데이터 출력하기.1
 SELECT rpad(' ', LEVEL*3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'       -- 루트 노드의 데이터를 지정합니다.
    CONNECT BY prior empno = mgr;   -- 부모노드와 자식노드의 관계를 지정하는 절. 
-- 90. 계층형 질의문으로 서열을 주고 데이터 출력하기.2
-- CONNECT BY 절에 ename !=blake 를 주게 되면, 블레이크와 블레이크의 자식노드 모두 출력되지 않게 된다. 

-- 91. 계층형 질의문으로 서열을 주고 데이터 출력하기.3 
-- ORDER BY SIBLINGS 를 사용하여 정렬하면 계층형 질의문의 서열 순서를 깨뜨리지 않으면서 출력 할 수 있다. 
-- 사용하지 않으면 서열순서가 깨져서 출력된다.

-- 92. 계층형 질의문으로 서열을 주고 데이터 출력하기.4 

SELECT ename, SYS_CONNECT_BY_PATH(ename, '/') as path
    FROM emp
    START WITH ename='KING'
    CONNECT BY prior empno = mgr;
    
-- 93. 일반 테이블 생성하기
CREATE TABLE EMP01(
EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10,2),   --  숫자 전체 10자리 허용하는데 그중 소숫점 2자리를 허용하겠다. 즉 소수점이 아닌 자리는 8자리까지만 허용되는 것이다.ㅔ
HIREDATE DATE);

/*
테이블명, 컬럼명 지정시 규칙
1. 반드시 문자로 시작해야합니다.
2. 이름의 길이는 30자 이하여야합니다.
3. 대문자 알파벳과 소문자 알파벳과 숫자를 포함할 수 있습니다.
4. 특수문자는 $, _, #만 포함 할 수 있습니다.

테이블 생성시 사용할 수 있는 주요 데이터 유형
CHAR 고정길이 문자데이터 최대길이 2000
VARCHAR2 가변길이 문자 데이터 유형 최대길이 4000
LONG 가변길이 문자데이터 최대 2GB의 문자데이터를 허용한다.
CLOB 문자 데이터 유형이며 최대 4GB의 문자 데이터를 허용합니다.
BLOB 바이너리 데이터 유형 최대 4기가
NUMBER
DATE
*/

-- 94. 임시 테이블 생성하기.

CREATE GLOBAL TEMPORARY TABLE EMP37(
EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10,2))
ON COMMIT DELETE ROWS;

/*
ON COMMIT DELETE ROWS : 임시 테이블에 데이터를 입력하고 COMMIT 할 때 까지만 데이터를 보관합니다.
ON COMMIT PRESERVE ROWS : 임시 테이블에 데이터를 입력하고 세션이 종료될 때까지 데이터를 보관합니다. 그러니까 로그아웃하면 데이터 날아간다고
*/
-- 95.복잡한 쿼리를 단순하게 하기 (1) (VIEW)
CREATE VIEW EMP_VIEW 
    AS 
    SELECT empno, ename, sal, job, deptno
        FROM emp
        WHERE job='SALESMAN';

SELECT *
    FROM EMP_VIEW;
/*
EMP_VIEW의 데이터를 수정하면 EMP 테이블의 데이터가 변경되었습니다. 
VIEW는 데이터를 가지고 있지 않고 단순히 테이블을 바라보는 객체입니다.
뷰를 쿼리하면 뷰를 만들때 작성했던 쿼리문이 수행되면서 실제 EMP테이블을 쿼리합니다.
UPDATE 문도 마찬가지로 EMP_VIEW를 갱신하면 실제 테이블인 EMP 데이터가 갱신됩니다.
*/    
    
        
-- 96. 복잡한 쿼리를 단순하게 하기 (2) (VIEW)

CREATE VIEW EMP_VIEW2
AS
SELECT deptno, round(avg(sal)) 평균월급
    FROM emp
    GROUP BY deptno;

SELECT *
    FROM EMP_VIEW2;

/*
함수나 그룹함수가 포함된 뷰를 복합 뷰라고 합니다. 
복합 뷰의 결과데이터는 수정 할 수 없다.
예를들어 EMP_VIEW2 의 평균월급을 수정할 수 있을까?
말이 안되는 이야기이다.
평균 월급이란 EMP테이블의 SAL을 연산한 결과이기때문이다.
*/    
    
-- 97. 데이터 검색 속도를 높이기(INDEX) 
CREATE INDEX EMP_SAL 
 ON EMP(SAL);
-- 98.  절대로 중복되지 않는 번호 만들기(SEQUENCE) 
CREATE SEQUENCE SEQ1
START WITH 1
INCREMENT BY 1
MAXVALUE 100
NOCYCLE;


-- 99. 실수로 지운 데이터 복구하기 (1) FLASHBACK QUERY 

UPDATE EMP SET SAL = 5000 WHERE ENAME = 'KING';

COMMIT;

SELECT * FROM 
    EMP;

SELECT *
    FROM EMP
    AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '5' MINUTE)
    WHERE ENAME = 'KING';
    
-- 100. 실수로 지운 데이터 복구하기 (2) FLASHBACK TABLE

ALTER TABLE emp ENABLE ROW MOVEMENT;

SELECT  row_movement
    FROM user_tables
    WHERE table_name = 'EMP';

DELETE FROM emp;


FLASHBACK TABLE emp to TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);

commit;

-- 101. 실수로 지운 데이터 복구하기 (2) FLASHBACK DROP

DROP TABLE emp;

commit;

FLASHBACK TABLE emp TO BEFORE DROP;

commit;

-- 102. 실수로 지운 데이터 복구하기 (2) FLASHBACK VERSION QUERY 

SELECT ename, sal, versions_starttime, versions_endtime, versions_operation 
    FROM emp
    VERSIONS BETWEEN TIMESTAMP
        TO_TIMESTAMP('2021-09-21 17:00:00', 'RRRR-MM-DD HH24:MI:SS')
        AND MAXVALUE
    WHERE ename='KING'
    ORDER BY versions_starttime;
    
-- 103. 실수로 지운 데이터 복구하기 (2) FLASHBACK TRANSACTION QUERY 
commit;



SELECT ename, sal, deptno
    FROM emp
    WHERE ename='KING';

UPDATE EMP SET SAL = 8000 WHERE ENAME = 'KING';
commit;
UPDATE EMP SET deptno = 20 WHERE ENAME = 'KING';
commit;
select*from emp;

SELECT versions_startscn, versions_endscn, versions_operation, sal, deptno
    FROM emp
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
    WHERE ename='KING';

/*SELECT undo_sql
    FROM flashback_transaction_query
    WHERE table_owner = 'c##financeRyu' AND table_name = 'EMP'
    AND commit_scn between 4133819 AND 4134115
    ORDER BY start_timestamp desc;    
    
    DB를 아카이브모드로 변경해줘야하나, 변경 후 오라클에 접속 할수없는 에러가 발생함. 아직까지 해결하지 못하고있음
    */

-- 104. 데이터의 품질 높이기(PRIMARY KEY)

CREATE TABLE DEPT2 (
DEPTNO NUMBER(10) CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(13),
LOC VARCHAR2(10));

COMMIT;

-- 테이블에 생성된 제약을 확인하는 방법

SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
    FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
    WHERE a.TABLE_NAME = 'DEPT2'
    AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;
    
-- 105. 데이터의 품질 높이기(UNIQUE)

CREATE TABLE DEPT3 (
DEPTNO NUMBER(10) ,
DNAME VARCHAR2(13) CONSTRAINT DEPT2_DEPTNO_UN UNIQUE,
LOC VARCHAR2(10));

SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
    FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
    WHERE a.TABLE_NAME = 'DEPT3'
    AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;    

-- 106. 데이터의 품질 높이기(NOT NULL)
-- 107. 데이터의 품질 높이기(CHECK)

-- 108. 데이터의 품질 높이기(FOREIGN KEY) 

/*
CREATE TABLE DEPT7 (
DEPTNO NUMBER(10) CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(13),
LOC VARCHAR2(10));

CREATE TABLE EMP7 (
EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10,2),   
DEPTNO NUMBER(10)
CONSTRAINT EMP7_DEPTNO_FK REFERENCES DEPT7(DEPTNO));

*/

-- 109. WITH절 사용하기 (WITH  ~  AS)

WITH JOB_SUMSAL AS (SELECT JOB, SUM(SAL) as 토탈 FROM EMP GROUP BY JOB)

    SELECT JOB, 토탈 
           FROM JOB_SUMSAL 
           WHERE 토탈 > (SELECT AVG(토탈) FROM JOB_SUMSAL);

SELECT JOB, SUM(SAL) as 토탈 
    FROM EMP
    GROUP BY JOB 
    HAVING SUM(SAL) > (SELECT AVG(SUM(SAL)) FROM EMP GROUP BY JOB);

-- 110. WITH 절 사용하기 2 --  서브쿼리 팩토링 

WITH JOB_SUMSAL AS (SELECT JOB, SUM(SAL) as 토탈 FROM EMP GROUP BY JOB),
    DEPTNO_SUMSAL AS(SELECT DEPTNO, SUM(SAL) 토탈 FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) > (SELECT AVG(토탈) + 3000 FROM JOB_SUMSAL))
    SELECT DEPTNO, 토탈 
        FROM DEPTNO_SUMSAL;
    
    SELECT JOB, 토탈 
           FROM JOB_SUMSAL 
           WHERE 토탈 > (SELECT AVG(토탈) FROM JOB_SUMSAL);