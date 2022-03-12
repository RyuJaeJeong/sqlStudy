--  16. 대소문자 변환 함수

/*
문자 함수 : UPPER, LOWER INITCAP SUBSTR LENGTH CONCAT INSTR TRIM LAPD RPAD
*/

SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
    FROM emp;

SELECT *
    FROM emp
    WHERE LOWER(ename) = 'scott';

--  데이터가 대문자인지 소문자 인지 확실하지 않을 때 사용 할 수 있다.     
--  Mysql의 경우에는 INITCAP이 제공되지 않아서 꼭 필요한 경우 별도의 함수를 만들어 사용해야한다.
    
insert  into emp values(9999, UPPER('financeRyu'), UPPER('clerk'), 9999, sysdate, 5000, 0, 0);    

--  insert 문에도 사용 할 수 있다. 


--  17. 문자에서 특정 문자 추출하기 

-- SUBSTR(A,B,C) A --  자를 문자열 B-- 시작 인덱스 C-- B로부터 몇글자 자를 것인지.
-- MYSQL에서는 SUBSTR과 SUBSTRING 모두 사용 가능하다. 

SELECT SUBSTR('SMITH', 1, 3) AS 글자
    FROM DUAL;

SELECT SUBSTR('SMITH', 2, 2) AS 글자
    FROM DUAL;

SELECT SUBSTR('SMITH', -2, 2) AS 글자
    FROM DUAL;    
    
SELECT SUBSTR('SMITH', 2) AS 글자
    FROM DUAL;

SELECT SUBSTR(ename, 1, 3) AS 이름
    FROM emp;

-- 18. 문자열의 길이를 출력하기 

-- MYSQL의 경우 LENGTH CHAR_LENGTH가있는데 한글을 사용할 경우가 다르다
-- 전자는 안녕을 6으로 반환하고, 후자는 안녕을 2로 반환한다

SELECT ename, LENGTH(ename) AS 글자수
    FROM emp;


-- 19. 문자에서 특정 철자의 위치를 출력하기

SELECT INSTR('SMITH','I') 
    FROM dual;

--  I의 위치값인 3반환함. 이걸 응용하면 이렇게도 할 수 있다. 

SELECT SUBSTR('fb0982@NAVER.com', INSTR('fb0982@NAVER.com','@')+1) AS 도메인주소,
    SUBSTR('fb0982@NAVER.com',1, INSTR('fb0982@NAVER.com','@')-1) AS 메일아이디
    FROM dual;

-- 20. 특정 철자를 다른 철자로 변경하기.

SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;

SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as salraryc
    FROM emp;    

-- REGEXP_REPLACE 정규식 함수임
/*
--  한글제거 SELECT REGEXP_REPLACE('abcd(1234)가나다라', '[가-R]', '') AS nickname; 
--  숫자제거 SELECT REGEXP_REPLACE('abcd(1234)가나다라', '[0-9]', '') AS nickname; 
--  영문제거 SELECT REGEXP_REPLACE('abcd(1234)가나다라', '[a-z]', '') AS nickname; 
--  특수문자제거 (특정문자) SELECT REGEXP_REPLACE('abcd(1234)가나다라', '[`~!#$%^&*|\\\'\";:\/?]', '') AS nickname; 
--  특수문자제거 (전체) SELECT REGEXP_REPLACE('abcd(1234)가나다라', '[^[:alnum:][:space:]]+', '') AS nickname;
*/

 

/* 
    SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') AS "전광판_이름"
        FROM test_ename;  
*/
-- replace 이용하면 한국 이름의 두번째자리를 류*정 이렇게 찍히게 만드는 것이 가능하다.

-- 21. 특정 철자를 N개 만큼 채우기 


SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salrary2
    FROM emp;

--  LPAD sal 글자수 총 10되도록 모자르는 부분 *로 채워 넣어라. 이걸 응용하면 아래와 같이 데이터 시각화를 하는 것이 가능하다. 

SELECT ename, sal, lpad('■', round(sal/100), '■')  AS bar_chart
    FROM emp;


-- 22. 철자 잘라내기 

SELECT 'smith', LTRIM('smith', SUBSTR('smith', 1, 1)), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;

SELECT LTRIM(ename, SUBSTR(ename, 1, 1)), RTRIM(ename, SUBSTR(ename, -1, 1))
    FROM emp;

-- trim 의 경우 양쪽 방향 s 잘라서출력한다. 공백 체크하는 용도로도 사용 할 수 있다.     



-- 23.  반올림해서 출력하기 

SELECT sal, ROUND(sal/100)
    FROM emp;

SELECT '876.567' as 숫자, ROUND(876.567, 1)
    FROM dual;

/*
    8  7  6 . 5  6  7
   -3 -2 -1   1  2  3
*/
    
    
--  24.  숫자를 버리고 출력하기

--  mysql은 truncate 

SELECT '876.567' AS 숫자, TRUNC(876.567,1)
    FROM dual;

SELECT '876.567' AS 숫자, TRUNC(876.567,2)
    FROM dual;

SELECT '876.567' AS 숫자, TRUNC(876.567,0)
    FROM dual;
    
SELECT '876.567' AS 숫자, TRUNC(876.567,-1)
    FROM dual;    

SELECT '876.567' AS 숫자, TRUNC(876.567,-2)
    FROM dual;    
-- 25.  나눈 나머지 값을 출력하기 MOD

SELECT MOD(10, 3)
    FROM dual;
    
SELECT empno,ename ,MOD(empno, 2) AS 짝홀수
    FROM emp;

SELECT empno,ename
    FROM emp
    WHERE  MOD(empno, 2) = 1;
    
--  참고로 몫은 FLOOR함수를 이용한다


SELECT FLOOR(10/3)
    FROM dual;
--  mysql의 경우 FLOOR함수는 작거나 가장 큰 정수를 반환하는 의미로 쓰인다. 오라클이랑 다른의미의 함수임.


-- 26. 날짜 간 개월 수 출력하기 

--  MONTHS_BETWEEN(최신날짜, 예전날짜)

/*

 TIMESTAMPDIFF(단위, 날짜1, 날짜2) 
 MYSQL은 이렇게 한다.
 단위
 SECOND : 초
 MINUTE : 분
 HOUR : 시
 DAY : 일
 WEEK : 주
 MONTH : 월
 QUARTER : 분기
 YEAR : 연

 
*/

SELECT ename, MONTHS_BETWEEN(sysdate, hiredate)
    FROM emp;

-- 날짜간 일수는 이렇게 계산한다.

SELECT  TO_DATE('2021-06-10', 'RRRR-MM-DD') -  TO_DATE('2019-06-10', 'RRRR-MM-DD') AS 일수
    FROM dual;

-- 27. 개월 수 더한 날짜 출력하기 

-- 2021년 5월 1일로 부터 100달뒤는 어떻게되는지?

SELECT ADD_MONTHS(TO_DATE('2021-05-01', 'RRRR-MM-DD'), 100) AS "날짜 더하기"
    FROM dual;

-- 이렇게 표현 할 수도 있다.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;

-- interval 이용하여 1년 3개월을 이렇게 표현 할 수도 있다.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;

-- 3년 5개월 후의 날짜    
SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS 날짜
    FROM dual;

-- MYSQL은 이렇게 사용한다.
/*

ADDDATE(date, INTERVAL value addunit)

MICROSECOND
SECOND
MINUTE
HOUR
DAY
WEEK
MONTH
QUARTER
YEAR
SECOND_MICROSECOND
MINUTE_MICROSECOND
MINUTE_SECOND
HOUR_MICROSECOND
HOUR_SECOND
HOUR_MINUTE
DAY_MICROSECOND
DAY_SECOND
DAY_MINUTE
DAY_HOUR
YEAR_MONTH

*/


-- 28.   특정 날짜 뒤에 오는 요일 날짜 출력하기

--  2019년 5월 22일 로부터 바로 돌아올 월요일의 날짜가 어떻게되는지 출력해보자. 
--  MYSQL에서는 지원하지 않는 기능.

SELECT '2021/09/03' as 날짜, NEXT_DAY('2021/09/03', '월요일') as "다음 월요일" 
    FROM DUAL;


-- 29.  특정 날짜가 있는 달의 마지막 날짜 출력하기

--  MYSQL에서 지원하는 기능

SELECT '2021/09/03' as 날짜, LAST_DAY('2021/09/03') as "마지막 날짜"
    FROM dual;
    
SELECT TRUNC(LAST_DAY('2021/09/03') - sysdate) AS 남은날
    FROM dual;



-- 30.  문자형으로 데이터 유형 변환하기

--  MYSQL FORMAT, CHAR_FORMAT 으로 대체

SELECT ename, TO_CHAR(hiredate, 'DAY') as 요일, TO_CHAR(sal, '999,999') as 월급
    FROM emp;
    
SELECT ename, hiredate
    FROM emp
    WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

SELECT ename, EXTRACT(year from hiredate) as 연도, 
              EXTRACT(MONTH from hiredate) as 달,
              EXTRACT(day from hiredate) as 요일
    FROM emp;

SELECT *
    FROM emp;

-- 31.  날짜형으로 데이터 유형 변환하기 TO_DATE


-- 32. 암시적 형 변환 이해하기 

SELECT  ename, sal
    FROM emp
    WHERE sal = '3000';

-- 숫자형을 '3000' 으로 문자형으로 비교하였음에도 불구하고 검색결과가 출력 됨을 알 수 있다.
-- 이는 오라클이 알아서 '숫자형 = 숫자형' 으로 형 변환을 하기 때문에 에러가 발생하지 않고 검색되는 것이다. 

-- 33. NULL 값 대신 다른 데이터 출력하기 (NVL, NVL2)

--  Mysql IFNULL함수.

SELECT COMM 
    FROM EMP;

 SELECT ename, comm, NVL(comm, 0)
    FROM emp;

 SELECT ename, sal, comm, sal+NVL(comm, 0)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');
    
 SELECT ename, sal, NVL(comm, 0), NVL2(comm, sal+comm, sal)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');   
    
    
-- 34.   IF문을 SQL로 구현하기. (DECODE 함수)

 SELECT ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) AS 보너스 
    FROM emp;

--  부서번호가 10일때는 300, 20일때는 400 나머지는 0 as 보너스 

 SELECT empno, mod(empno, 2) AS 나머지, DECODE(mod(empno, 2), 0, '짝수', 1, '홀수') AS 짝홀수
    FROM emp;

--  default 값은 생략 할 수도 있다.    

--  Mysql에는 if함수가 있다

--  IF(조건,'조건이 일치할 경우의 VALUE','조건이 일치하지 않을경우의 VALUE')


-- 35. IF문을 SQL로 구현하기. (CASE)

--  Mysql에서도 사용 할 수 있다.

 SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
    
-- 36. 최댓값 출력하기 (MAX)

 SELECT MAX(sal)
    FROM emp;
    
 SELECT MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN';
 
--   SELECT job, MAX(sal)
--     FROM emp
--     WHERE job = 'SALESMAN';  
--  job 칼럼은 여러 개의 행이 출력되려고 하는데 맥스 값은 하나가 출력 되려 하기때문에 에러가 뜬다. 

 SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN'
    GROUP BY job;
    
-- 37. 최소값 출력하기 (MIN) 

--  그룹함수의 특징은 WHERE 절의 조건이 거짓이어도 결과를 항상  출력한다는 것이다. 

-- 38. 평균값 출력하기 (AVG)

SELECT AVG(comm)
    FROM emp;

-- 그룹함수는 널값을 무시한다. 그러니까 커미션 총합에서 14를 나눈것이 아니라 4를 나눈것이다.   

-- 39. 토탈값 출력하기(SUM)

SELECT job, sum(sal)
    from emp
    group by job;
    
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    HAVING sum(sal) >= 4000;

-- where 절에 그룹함수를 사용해 조건을 주면 그룹 함수 사용이 허가되지않는다고 뜬다. having 을 사용하여야한다. 

-- 40. 건수 출력하기 COUNT (그룹함수는 null 값을 포함하지 않는다는 것을 유념해야한다. )


-- 41. 데이터 분석 함수로 순위 출력하기 (RANK)

SELECT * FROM 
	emp;
    
    

-- 2등이 두명이라 3등이 출력되지 않았다. 3등을 출력하기 위해서는 DENSE_RANK() 함수를 사용하여야 한다.
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) 순위 
    FROM emp;
    
   
-- 직업별 파티션을 줘서 순위를 매기고 싶을 경우     
SELECT ename, job, sal, RANK() over (PARTITION BY job ORDER BY sal DESC) 순위 
    FROM emp;
    
    
-- 42. 데이터 분석 함수로 순위 출력하기 (DENSE_RANK)

SELECT ename, job, sal, DENSE_RANK() over (ORDER BY sal DESC) 순위 
    FROM emp
    WHERE job in ('ANALYST','MANAGER');
    
SELECT ename, job, sal, DENSE_RANK() over (PARTITION BY job
                                     ORDER BY sal DESC) 순위 
    FROM emp;    


-- 43. 데이터 분석 함수로 등급 출력하기 (NTILE)

INSERT INTO EMP VALUES (7521,'WARD','CLERT',7698,'81-02-23',NULL,500,30);
COMMIT;

SELECT*FROM EMP;

SELECT ename, job, sal, 
       NTILE(4) over(order by sal desc) 등급 
    FROM emp
    WHERE job in ('ANALYST','MANAGER','CLERK');
-- NULLS LAST 를 사용했을 때는 NULL 값이 마지막으로 정렬됩니다. (오라클)
-- Mysql에서는 null은 등급계산에 포함되지 않는다.


-- 44.  데이터 분석 함수로 순위의 비율 출력하기 (CUME_DIST)

SELECT ename, sal, RANK() over (order by sal desc) as 순위,
                   DENSE_RANK() over (order by sal desc) as 순위2,
                   TRUNCATE(CUME_DIST() over(order by sal desc), 2) as  CUM_DIST
    FROM emp;

SELECT ename, sal, job, RANK() over (PARTITION BY job order by sal desc) as 'RANK',
                        TRUNCATE(CUME_DIST() over(PARTITION BY job order by sal desc), 2) as  CUM_DIST
    FROM emp;

-- 45. 데이터 분석 함수로 데이터를 가로로 출력하기(LISTAGG)

/* 
SELECT job, LISTAGG(ename, '/') within group (ORDER BY sal desc) as EMPLOYEE,
            LISTAGG(sal, '/') within group (ORDER BY sal desc) as SAL
    FROM emp
    GROUP BY job;
*/

-- mysql에서는 이렇게쓴다.

SELECT job, GROUP_CONCAT(ename SEPARATOR ' / ') AS ENAME,
			GROUP_CONCAT(sal SEPARATOR ' / ') AS SAL
  FROM emp
  group by job;

    
-- 46. 데이터 분석 함수로 바로 전 행과 다음 행 출력하기 (LAG, LEAD)

-- 숫자 1넣으면 전행, 2넣으면 전전행을 출력한다.
SELECT empno, ename, sal,
            IFNULL(LAG(sal, 1) over (order by sal asc), 0) AS 전행,
            IFNULL(LEAD(sal, 1) over (order by sal asc), 0) AS "다음 행"
    FROM emp
    WHERE job in ('ANALYST','MANAGER');


-- 47. SUM+DECODE 를 활용하여 ROW을 COLUMN로 출 력하기 

-- Mysql
SELECT SUM(IF(job = 'ANALYST',sal , 0)) as "ANALYST",
       SUM(IF(job = 'CLERK',sal , 0)) as "CLERK",
       SUM(IF(job = 'MANAGER',sal , 0)) as "MANAGER",
       SUM(IF(job = 'SALESMAN',sal , 0)) as "SALESMAN"
    FROM emp;
    
/* 
ORACLE    

SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp;
*/
    

-- 48. PIVOT을 활용하여 ROW을 COLUMN로 출 력하기 

/*
SELECT *
    FROM (select deptno, sal from emp)
    PIVOT (sum(sal) for deptno in (10,20,30));

-- FROM 절에 괄호를 사용해서 특정 컬럼만 선택해야한다. 
-- mysql에서는 사용 할 수 없다 47과 같이 구현이 가능하다.   
*/


-- 49. COLUMN TO ROW

drop  table order2;

create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );

commit;

SELECT *
    FROM order2;

SELECT * 
    FROM order2
    UNPIVOT (건수 for 아이템 in (bicycle, camera, notebook));

-- NULL 값이 ROW에 포함되어있을 경우 결과가 출력되지않는다. 데이터에 NULL값이 포함되어 있는 경우, UNPIVOT INCLUDE NULLS 라고 써줘야한다. 
    
-- 50. 데이터 분석 함수로 누적 데이터 출력하기 (SUM OVER) 

SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 누적치
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER');

--   UNBOUNDED PRECEDING은 제일 첫 번째 행을 가리킵니다. BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 란 제일 첫 번째 행부터 현재 행까지의 값을 말합니다. 
--   참고로 UNBOUNDED FOLLOWING 은 맨 마지막 행을 가리킵니다. 

-- 51. 데이터 분석 함수로 비율 출력하기 (RATIO_TO_REPORT) 

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS 비율 
    FROM emp
    WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS 비율,
                          SAL/SUM(sal) OVER() as "비교 비율"  
    FROM emp
    WHERE deptno = 20;    

-- 52. 데이터 분석함수로 집계 결과 출력하기 --  1 (ROLLUP)

SELECT job, sum(sal)
    FROM emp
    GROUP BY ROLLUP(job);

-- ROLLUP 에 칼럼을 두개 사용한 경우. 

SELECT deptno, job, sum(sal) 
    FROM emp
    GROUP BY ROLLUP(deptno, job);
    
-- 53.  데이터 분석함수로 집계 결과 출력하기 --  2 (CUBE)

SELECT deptno,job, sum(sal)
    FROM emp
    GROUP BY CUBE(deptno,job);

--  ROLLUP 집계와 CUBE 집계는 순서뿐만 아니라 출력결과도 다르다.!


-- 54. 데이터 분석함수로 집계 결과 출력하기 -- 3 (GROUPING SETS)

SELECT deptno, job, sum(sal)
    FROM emp
    GROUP BY GROUPING SETS((deptno), (job), ()); 

-- 55. 데이터 분석 함수로 출력 결과 넘버링 하기 (ROW_NUMBER)

SELECT empno, ename, sal, RANK() OVER(ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(ORDER BY sal desc) 번호
    FROM emp;
    
--  부서번호별로 파티션 줄 경우

SELECT empno, ename, sal, RANK() OVER(PARTITION BY deptno ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal desc) 번호
    FROM emp;