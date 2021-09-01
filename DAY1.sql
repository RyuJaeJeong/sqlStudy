-- 01.
-- 가독성을 높이기 위해 sql 은 대문자, 칼럼명과 테이블 명은 소문자로 작성하기를 권장하고있다.
-- 쿼리문이 길어 질 수 있어 select 절과 from 절은 별도의 라인에 작성하는 것을 권장
-- from 절 2~3칸 뛰어 주면 좋다.
SELECT empno, ename, sal 
  FROM emp;

--02. 모든 열 출력하기.
SELECT *
   FROM emp;
   
-- 모든 칼럼 출력하고 특정칼럼 한번 더 출력해야하는 경우   
SELECT emp.*,empno 
   FROM emp;

-- 03. 별칭 사용하기    
SELECT empno as 사원번호, ename as 사원이름, sal as "Salary" 
    FROM emp;
    
SELECT ename as 사원이름, sal * (12 + 3000) as 월급 
    FROM emp;

--04. 연결 연산자
SELECT ename || '의 월급은 ' || sal || '입니다' as 월급정보 
    FROM emp;
SELECT ename || '의 직업은 ' || job || '입니다' as 직업정보 
    FROM emp;
    
--05. distinct 사용하기
SELECT DISTINCT job 
    FROM emp;

SELECT UNIQUE job 
    FROM emp;
   
--06. 데이터를 정렬해서 출력하기.

SELECT ename, sal as 월급
    FROM emp
    ORDER BY 월급 desc;

--order by 절은 제일 마지막에 실행된다.

SELECT ename,deptno,sal as 월급
    FROM emp
    ORDER BY 2 asc, 3 desc;
    
--07. where 절 사용하기 (1)

SELECT ename, sal, job
    FROM emp
    WHERE sal >= 3000;

-- where 절에서는 별칭을 사용 할 수 없다. 쿼리문 실행순서가 select 문 보다 앞이기 때문이다. 


--08. where 절 사용하기 (2)

SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE ename='SCOTT';
    
SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE hiredate='81/11/17';  
    
--09. 산술연산자 

SELECT sal + comm 
    FROM emp
    WHERE ename='KING';

-- NVL 함수 사용하면 NULL 값 대신 0 반환한다. 5000+NULL=NULL
    
SELECT sal + NVL(comm, 0) 
    FROM emp
    WHERE ename='KING';  
    
--10. 비교연산자    


--11. 비교연산자 BETWEEN AND

SELECT ename, sal 
    FROM emp 
    WHERE sal BETWEEN 1000 AND 3000
    ORDER BY  sal asc;
    
SELECT ename, sal 
    FROM emp 
    WHERE sal NOT BETWEEN 1000 AND 3000
    ORDER BY  sal asc;
    
-- BETWEEN 상한가 AND 하한가 여야한다. 반대의 경우에는 동작하지않는다. 

SELECT ename, hiredate 
    FROM emp 
    WHERE hiredate between '1982/01/01' AND '1982/12/31';
    
--12. 비교연산자 LIKE 

SELECT ename, sal
    FROM emp
    WHERE ename LIKE 'S%';
    
SELECT ename, sal
    FROM emp
    WHERE ename LIKE '_M%';

--%는 와일드 카드. 이 자리에 어떠한 철자가 와도 상관없고 철자의 개수가 몇개든 관계없다는 뜻임.
--%가 특수문자 퍼센트가아니라 와일드 카드로 사용되기 위해서는 LIKE 연산자를 사용해야
--언더바(_) 는 어떠한 철자가 와도 관계없으나 자리수는 한자리여야 된다는 의미.

--13. 비교연산자 IS NULL

SELECT ename, comm 
    FROM emp
    WHERE comm is null;
    
--14. 비교연산자 IN

SELECT ename, sal, job
    FROM emp 
    WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER');
    
--이퀄 연산자는 하나의 값만 조회할 수 있는 반면 IN 연산자는 여러 리스트의 값을 조회할 수 있다.     

--15. 논리연산자 and or not 