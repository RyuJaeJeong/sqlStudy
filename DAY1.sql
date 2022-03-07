-- 01.
-- SQL문장을 작성 할 때는 대문자, 소문자 상관없이 수행된다.
-- 하지만, 가독성을 높이기 위해 sql 은 대문자, 칼럼명과 테이블 명은 소문자로 작성하기를 권장하고있다.
-- 쿼리문이 길어 질 수 있어 select 절과 from 절은 별도의 라인에 작성하는 것을 권장
-- from 절 2~3칸 뛰어 주면 좋다.
SELECT empno, ename, sal 
  FROM emp;

--02. 모든 열 출력하기.
SELECT *
   FROM emp;
   
-- 모든 칼럼 출력하고 특정칼럼 한번 더 출력해야하는 경우 
-- emp.* emp 테이블의 모든 칼럼 다 출력한다
SELECT emp.*,empno 
   FROM emp;

-- 03. 별칭 사용하기

--컬럼 별칭 대소문자를 구분하고자 할때, 공백문자를 출력하고자 할때, 특수문자 $, _, #을 출력하고자 할때는 컬럼별칭양쪽에 더블 쿼테이션 마크를 감싸줘야한다.
SELECT empno as 사원번호, ename as 사원이름, sal as "Salary" 
    FROM emp;
    
--수식을 사용할 경우 별칭을 이용하는것이 유용하다.    
SELECT ename as 사원이름, sal * (12 + 3000) as 월급 
    FROM emp;

--04. 연결 연산자

--Mysql의 경우 concat(str1, str2...); 혹은 concat_ws('구분자', str1, str2, ...) 를 사용한다.

SELECT ename || '의 월급은 ' || sal || '입니다' as 월급정보 
    FROM emp;
SELECT ename || '의 직업은 ' || job || '입니다' as 직업정보 
    FROM emp;
    
--05. distinct 사용하기

--Mysql에서도 동일하게 사용할 수 있다 unique는 사용되지 않는 것으로 보인다.

SELECT DISTINCT job 
    FROM emp;

SELECT UNIQUE job 
    FROM emp;
   
--06. 데이터를 정렬해서 출력하기.

--asc 오름차순, desc 내림차순

SELECT ename, sal as 월급
    FROM emp
    ORDER BY 월급 desc;

--order by 절은 제일 마지막에 실행되기 때문에 SELECT절에서 사용한 컬럼 별칭을 사용 할 수도 있다. 컬럼명 대신에 SELECT절 컬럼의 순서를 숫자로 적을 수도 있다.


SELECT ename,deptno,sal as 월급
    FROM emp
    ORDER BY 2 asc, 3 desc;
    
--07. where 절 사용하기 (1)

SELECT ename, sal, job
    FROM emp
    WHERE sal >= 3000;


-- where 절에서는 별칭을 사용 할 수 없다. 쿼리문 실행순서가 select 문 보다 앞이기 때문이다. 

/*

>= 크거나 같다
<= 작거나 같다
=  같다
!= 같지 않다.
IS NULL 널값인지 여부 
IN 값 리스트 중 일치하는 값 검색

*/

--08. where 절 사용하기 (2)

--문자를 검색 할때는 문자 양 쪽에 싱글 쿼테이션 마크를 둘러 감싸 주어야 한다.
--날짜 또한 마찬가지.
-- RR/MM/DD 81/12/20 1981년 12월임 YY/MM/DD는 2081년 12월임.
SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE ename='SCOTT';
    
SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE hiredate='81/11/17';  

-- 세션의 날짜 형식 조회
SELECT *
    FROM NLS_SESSION_PARAMETERS
    WHERE PARAMETER = 'NSL_DATE_FORMAT';
    
--09. 산술연산자 

SELECT sal + comm 
    FROM emp
    WHERE ename='KING';

-- NVL 함수 사용하면 NULL 값 대신 0 반환한다. 5000+NULL=NULL
-- Mysql의 IFNULL함수 !!    
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