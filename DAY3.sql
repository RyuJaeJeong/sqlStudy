--56. 출력되는 행 제한하기. (ROWNUM)
SELECT ROWNUM as 번호, emp.* 
    FROM emp
    WHERE ROWNUM <= 9;

--ROWNUM은 PSEUDO COLUMN으로 '가짜의' 라는 뜻 그대로 *로 검색해서는 출력되지 않는 감추어진 칼럼이다.    
    
--57. 출력되는 행 제한하기. (Simple TOP-n Queries)
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;

SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 20 PERCENT ROWS ONLY;    

--동일 값이 있으면 같이 출력해준다. WITH TIES
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;    

--OFFSET 옵션을 사용하면 시작되는 행의 위치를 지정할 수 있습니다. 
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS
    FETCH FIRST 2 ROWS ONLY;

--58. 여러 테이블의 데이터를 조인해서 출력하기 (EQUI JOIN)
SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

SELECT ename,job ,loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job='ANALYST';

SELECT e.deptno, e.ename ,e.job ,d.loc 
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job='ANALYST';    
    
--59. 여러 테이블의 데이터를 조인해서 출력하기 (NON EQUI JOIN)

--58번 예제와같이 EQUAL 조건을 줄수 없을때 사용하는 것이 NON EQUI JOIN 이다. 
-- EMP 테이블의 월급은 SALGRADE 테블의 LOSAL 과 HISAL 사이에 있다는 것을 보여줄때 사용하는 것이 
-- 아래의 쿼리문이다. 
SELECT e.ename, e.sal, s.grade 
    FROM emp e, salgrade s
    WHERE e.sal between s.losal and s.hisal;

--60. 여러 테이블의 데이터를 조인해서 출력하기 (OUTER JOIN)

-- EQUI JOIN 양쪽에 다 존재하는 데이터만 출력
-- LEFT OUTER JOIN EMP 테이블에는 존재하는데 DEPT 테이블에는 없는 데이터 출력 
-- RIGHT OUTER JOIN 그 반대

SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno(+) = dept.deptno;

--61. SELF JOIN 

SELECT e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
    FROM emp e, emp m
    WHERE e.mgr = m.empno;
    
--62. 여러 테이블의 데이터를 조인해서 출력하기 (ON절)

--56번과 표기의 차이이다. 56은 오라클 조인 작성법이고 62는 ansi 표준이다. 일반적으로 오라클 조인작성법을 많이 사용한다고 한다.

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
 FROM emp e JOIN dept d
 ON (e.deptno = d.deptno)
 WHERE e.job = 'SALESMAN';
 
--63. 여러 테이블의 데이터를 조인해서 출력하기 USING 
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치" 
    FROM emp e join dept d
    USING (deptno)
    WHERE e.job='SALESMAN';

--USING 절을 사용할때 DEPTNO 앞에는 테이블명이나 테이블 별칭을 사용 할 수 없습니다.
--USING 절에는 반드시 괄호를 사용해야 합니다. 

--여러개의 테이블을 조인하는 경우
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d USING (deptno)
    JOIN salgrade s ON (e.sal between s.losal and s.hisal);
    
--64. 여러 테이블의 데이터를 조인해서 출력하기

--NATURAL JOIN 은 두 테이블에 둘 다 존재하는 동일한 컬럼을 기반으로 암시적인 조인을 수행한다. 둘 다 존재하는 동일한 컬럼인 DEPTNO를 오라클이 알아서 찾아 이를 이용하여 조인을 수행한다. 
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e NATURAL join dept d
    WHERE e.job = 'SALESMAN';

--65. 여러 테이블의 데이터를 조인해서 출력하기(LEFT OUTER JOIN)

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치" 
    FROM emp e  RIGHT OUTER JOIN dept d
    USING (deptno);
--66.  여러 테이블의 데이터를 조인해서 출력하기(FULL OUTER JOIN)

INSERT INTO EMP (empno, ename, sal, job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);
COMMIT;

SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e FULL OUTER JOIN dept d
    ON (e.deptno = d.deptno);
--오라클 표기법으로 full outer join 문을 작성 할 경우 에러가 발생합니다. 

--67. 집합 연산자로 데이터를 위아래로 연결하기 (UNION ALL) 

SELECT deptno, sum(sal)
    FROM emp
    GROUP BY deptno 
UNION ALL
SELECT TO_NUMBER(null) as deptno, sum(sal)
    FROM emp;

--위쪽 쿼리의 결과와 아래쪽 쿼리의 결과를 하나의 결과로 출력해준다.
/*
-union all 위쪽 쿼리와 아래쪽 쿼리 컬럼의 갯수가 동일해야합니다.
-union all 위쪽 쿼리와 아래쪽 쿼리의 데이터 타입이 동일해야합니다.
-결과로 출력되는 컬럼명은 위쪽 쿼리의 컬럼명으로 출력됩니다.
-ORDER BY 절은 제일 아래쪽 쿼리에만 작성할수 있습니다.
*/
    

--68. 집합 연산자로 데이터를 위아래로 연결하기 (UNION)

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

--69. 집합 연산자로 데이터를 위아래로 연결하기 (INTERSECT)

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20) 
INTERSECT
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
--위쪽 쿼리와 아래쪽 쿼리 결과의 교집합만 출력된다.    

--70. 집합 연산자로 데이터의 차이를 출력하기(MINUS)

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20)
MINUS
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
--마이너스 연산자를 이용하여 위쪽 쿼리의 결과 데이터에서 아래쪽 쿼리의 결과데이터의 차이를 출력하는 쿼리문이다. 
--마이너스 연산자의 경우에도 데이터를 내림차순으로 정렬해준다

--71. 서브쿼리 사용하기 1 -- 단일행 서브쿼리

SELECT ename, sal
    FROM emp
    WHERE sal >= (SELECT sal 
                    FROM emp
                    WHERE ename = 'JONES')
          AND ename != 'JONES';          
          
--JONES 보다 더 많은 월급을 받는 사원들을 검색하려면 먼저 JONES사원의 월급을 출력한후, SAL 과 비교하는 두번의 쿼리문 수행을 해야만한다.
-- 서브쿼리를 통해 수행횟수를 1회로 줄일 수 있다.

--72. 서브쿼리 사용하기 2 -- 다중행 서브쿼리

SELECT ename, sal, job
    FROM emp
    WHERE sal in (SELECT sal FROM emp WHERE job = 'SALESMAN');
    
--서브쿼리 에서 메인쿼리로 하나의 값이 아니라 여러개의 값이 반환되는 것을 다중 행 서브쿼리라고 한다. 
--71번의 경우 jones 의 월급을 반환할 뿐임으로 하나의값이 반환된다. 즉 단일행 서브쿼리.
--그러나 72번의 경우 salesman이 한명이 아님으로 여러개의 값이 반환되는데 이를 다중 행 서브쿼리라한다. 
--서브쿼리의 종류에 따라 사용되는 연산자도 다른대, 다중행 서브쿼리에서는 in, not in, >any <any, >all, <all 을 사용한다. 
--참고로 반환되는 칼럼이 여러개일 경우 다중 컬럼 서브쿼리라고한다. 

--73 서브쿼리 사용하기 3 -- not in

--관리자가 아닌 사원들의 이름과 월급과 직업을 출력해보겠습니다.

SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr FROM emp WHERE mgr is not null);

SELECT  distinct mgr
    FROM emp
    WHERE mgr is not null;
    
SELECT *
    FROM emp;
    
--서브쿼리에서 메인쿼리로 null값이 하나라도 리턴되면 결과가 출력되지않는다.
--논리적으로 true and null 은 null이기때문이다.

--74. 서브쿼리 사용하기 4 -- exists 와 not exists

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
                    
--75. 서브쿼리 사용하기5 (HAVING절의 서브쿼리 사용하기)

SELECT job, sum(sal)
    FROM emp
    GROUP BY job 
    HAVING sum(sal) > (SELECT sum(sal)
                        FROM emp
                        WHERE job='SALESMAN');

--76. 서브쿼리 사용하기5 (FROM 절의 서브쿼리 사용하기)

SELECT  v.ename, v.sal, v.순위
    FROM (SELECT ename, sal, rank() over (order by sal desc) 순위 FROM emp) v
    WHERE v.순위 =1;

-- from 절의 서브쿼리를 in line view 라고한다.
-- where 절에는 분석함수를 사용 할 수 없기때문에 from 절에 서브쿼리문을 사용하여 먼저 실행되게 해야한다.

--77. 서브쿼리 사용하기7 (select절의 서브쿼리)

SELECT ename, sal, (SELECT max(sal) FROM emp where job='SALESMAN') as "최대 월급",
                   (SELECT min(sal) FROM emp where job='SALESMAN') as "최소 월급"
    FROM emp
    WHERE job='SALESMAN';
    

--78 데이터 입력하기 

--데이터를 입력하고 수정하고 삭제하는 SQL문을 DML문이라고한다.

INSERT INTO emp (empno, ename, sal, hiredate, job)
    VALUES(2812, 'JACK', 3500, TO_DATE('2019/06/05', 'RRRR/MM/DD'), 'ANALYST');

commit;    