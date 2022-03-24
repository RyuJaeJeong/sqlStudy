-- 109, 110 WITH 절 사용하기. 

/*
검색 시간이 오래 걸리는 SQL이 하나의 SQL내에서 반복되어 사용될 때 
성능을 높이기 위한 방법으로 WITH절을 사용합니다.

메모리 공간에 JOB_SUMSAL 이라는 임시 테이블을 만들고 거기서 불러오는 방식

데이터가 대용량이어서 호출하는데 시간이 오래걸린다면, 같은 작업을 반복하는 시간을 줄여야한다.
그래서 사용하는 것이 WITH절. 아래 작업을 서브쿼리로 수행한다면 이런식으로 해야만한다

SELECT JOB, SUM(SAL) as 토탈
	FROM EMP
    GROUP BY JOB
    HAVING SUM(SAL) > (SELECT AVG(SAL(SUM)) FROM EMP GROUP BY JOB);
    
    같은 작업을 두번이나 하고있음

*/

USE MYSQL;

WITH JOB_SUMSAL AS (SELECT JOB, sum(SAL) as 토탈 
						FROM EMP
                        group by JOB)
                        
SELECT JOB, 토탈
	FROM JOB_SUMSAL
	WHERE 토탈 > (SELECT AVG(토탈)
					FROM JOB_SUMSAL);
                    
-- WITH절을 이용하면 다른 서브쿼리의 컬럼을 가져 올 수 있다. 

WITH JOB_SUMSAL AS(SELECT JOB, SUM(SAL) AS 토탈 FROM EMP GROUP BY JOB),
	DEPTNO_SUMSAL AS (SELECT DEPTNO, SUM(SAL) AS 토탈 FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) > (SELECT AVG(토탈) + 3000 FROM JOB_SUMSAL))
    SELECT DEPTNO, 토탈
		FROM DEPTNO_SUMSAL
        
-- WITH절의 쿼리의 결과를 임시 테이블로 생성하는 것을 SUBQUERY FACTORING 이라고 한다.