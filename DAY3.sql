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