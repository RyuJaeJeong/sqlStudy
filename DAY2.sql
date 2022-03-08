--16. ��ҹ��� ��ȯ �Լ�

/*
���� �Լ� : UPPER, LOWER INITCAP SUBSTR LENGTH CONCAT INSTR TRIM LAPD RPAD
*/

SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
    FROM emp;

SELECT *
    FROM emp
    WHERE LOWER(ename) = 'scott';

-- �����Ͱ� �빮������ �ҹ��� ���� Ȯ������ ���� �� ��� �� �� �ִ�.     
-- Mysql�� ��쿡�� INITCAP�� �������� �ʾƼ� �� �ʿ��� ��� ������ �Լ��� ����� ����ؾ��Ѵ�.
    
insert  into emp values(9999, UPPER('financeRyu'), UPPER('clerk'), 9999, sysdate, 5000, 0, 0);    

--insert ������ ��� �� �� �ִ�. 


--17. ���ڿ��� Ư�� ���� �����ϱ� 

--SUBSTR(A,B,C) A -- �ڸ� ���ڿ� B--���� �ε��� C--B�κ��� ����� �ڸ� ������.
--MYSQL������ SUBSTR�� SUBSTRING ��� ��� �����ϴ�. 

SELECT SUBSTR('SMITH', 1, 3) AS ����
    FROM DUAL;

SELECT SUBSTR('SMITH', 2, 2) AS ����
    FROM DUAL;

SELECT SUBSTR('SMITH', -2, 2) AS ����
    FROM DUAL;    
    
SELECT SUBSTR('SMITH', 2) AS ����
    FROM DUAL;

SELECT SUBSTR(ename, 1, 3) AS �̸�
    FROM emp;

--18. ���ڿ��� ���̸� ����ϱ� 

--MYSQL�� ��� LENGTH CHAR_LENGTH���ִµ� �ѱ��� ����� ��찡 �ٸ���
--���ڴ� �ȳ��� 6���� ��ȯ�ϰ�, ���ڴ� �ȳ��� 2�� ��ȯ�Ѵ�

SELECT ename, LENGTH(ename) AS ���ڼ�
    FROM emp;


--19. ���ڿ��� Ư�� ö���� ��ġ�� ����ϱ�

SELECT INSTR('SMITH','I') 
    FROM dual;

-- I�� ��ġ���� 3��ȯ��. �̰� �����ϸ� �̷��Ե� �� �� �ִ�. 

SELECT SUBSTR('fb0982@NAVER.com', INSTR('fb0982@NAVER.com','@')+1) AS �������ּ�,
    SUBSTR('fb0982@NAVER.com',1, INSTR('fb0982@NAVER.com','@')-1) AS ���Ͼ��̵�
    FROM dual;

--20. Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϱ�.

SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;

SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as salraryc
    FROM emp;    

--REGEXP_REPLACE ���Խ� �Լ���
/*
-- �ѱ����� SELECT REGEXP_REPLACE('abcd(1234)�����ٶ�', '[��-�R]', '') AS nickname; 
-- �������� SELECT REGEXP_REPLACE('abcd(1234)�����ٶ�', '[0-9]', '') AS nickname; 
-- �������� SELECT REGEXP_REPLACE('abcd(1234)�����ٶ�', '[a-z]', '') AS nickname; 
-- Ư���������� (Ư������) SELECT REGEXP_REPLACE('abcd(1234)�����ٶ�', '[`~!#$%^&*|\\\'\";:\/?]', '') AS nickname; 
-- Ư���������� (��ü) SELECT REGEXP_REPLACE('abcd(1234)�����ٶ�', '[^[:alnum:][:space:]]+', '') AS nickname;
*/

 

/* 
    SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') AS "������_�̸�"
        FROM test_ename;  
*/
--replace �̿��ϸ� �ѱ� �̸��� �ι�°�ڸ��� ��*�� �̷��� ������ ����� ���� �����ϴ�.

--21. Ư�� ö�ڸ� N�� ��ŭ ä��� 


SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salrary2
    FROM emp;

-- LPAD sal ���ڼ� �� 10�ǵ��� ���ڸ��� �κ� *�� ä�� �־��. �̰� �����ϸ� �Ʒ��� ���� ������ �ð�ȭ�� �ϴ� ���� �����ϴ�. 

SELECT ename, sal, lpad('��', round(sal/100), '��')  AS bar_chart
    FROM emp;


--22. ö�� �߶󳻱� 

SELECT 'smith', LTRIM('smith', SUBSTR('smith', 1, 1)), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;

SELECT LTRIM(ename, SUBSTR(ename, 1, 1)), RTRIM(ename, SUBSTR(ename, -1, 1))
    FROM emp;

--trim �� ��� ���� ���� s �߶�����Ѵ�. ���� üũ�ϴ� �뵵�ε� ��� �� �� �ִ�.     



--23.  �ݿø��ؼ� ����ϱ� 

SELECT sal, ROUND(sal/100)
    FROM emp;
    
    
--24.  ���ڸ� ������ ����ϱ�

SELECT '876.567' AS ����, TRUNC(876.567,1)
    FROM dual;

SELECT '876.567' AS ����, TRUNC(876.567,2)
    FROM dual;

SELECT '876.567' AS ����, TRUNC(876.567,0)
    FROM dual;
    
SELECT '876.567' AS ����, TRUNC(876.567,-1)
    FROM dual;    

SELECT '876.567' AS ����, TRUNC(876.567,-2)
    FROM dual;    
--25.  ���� ������ ���� ����ϱ� MOD

SELECT MOD(10, 3)
    FROM dual;
    
SELECT empno,ename ,MOD(empno, 2) AS ¦Ȧ��
    FROM emp;

SELECT empno,ename
    FROM emp
    WHERE  MOD(empno, 2) = 1;
    
--����� ���� FLOOR�Լ��� �̿��Ѵ�

SELECT FLOOR(10/3)
    FROM dual;_

--26. ��¥ �� ���� �� ����ϱ� 

SELECT ename, TRUNC(MONTHS_BETWEEN(sysdate, hiredate))
    FROM emp;

--��¥�� �ϼ��� �̷��� ����Ѵ�.

SELECT  TO_DATE('2021-06-10', 'RRRR-MM-DD') -  TO_DATE('2019-06-10', 'RRRR-MM-DD') AS �ϼ�
    FROM dual;

--27. ���� �� ���� ��¥ ����ϱ� 

--2021�� 5�� 1�Ϸ� ���� 100�޵ڴ� ��ԵǴ���?

SELECT ADD_MONTHS(TO_DATE('2021-05-01', 'RRRR-MM-DD'), 100) AS "��¥ ���ϱ�"
    FROM dual;

--�̷��� ǥ�� �� ���� �ִ�.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;

--interval �̿��Ͽ� 1�� 3������ �̷��� ǥ�� �� ���� �ִ�.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;

--3�� 5���� ���� ��¥    
SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS ��¥
    FROM dual;



--28.   Ư�� ��¥ �ڿ� ���� ���� ��¥ ����ϱ�

-- 2019�� 5�� 22�� �κ��� �ٷ� ���ƿ� �������� ��¥�� ��ԵǴ��� ����غ���. 

SELECT '2021/09/03' as ��¥, NEXT_DAY('2021/09/03', '������') as "���� ������" 
    FROM DUAL;


--29.  Ư�� ��¥�� �ִ� ���� ������ ��¥ ����ϱ�

SELECT '2021/09/03' as ��¥, LAST_DAY('2021/09/03') as "������ ��¥"
    FROM dual;
    
SELECT TRUNC(LAST_DAY('2021/09/03') - sysdate) AS ������
    FROM dual;

--30.  ���������� ������ ���� ��ȯ�ϱ�

SELECT ename, TO_CHAR(hiredate, 'DAY') as ����, TO_CHAR(sal, '999,999') as ����
    FROM emp;
    
SELECT ename, hiredate
    FROM emp
    WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

SELECT ename, EXTRACT(year from hiredate) as ����, 
              EXTRACT(MONTH from hiredate) as ��,
              EXTRACT(day from hiredate) as ����
    FROM emp;

SELECT *
    FROM emp;

--31.  ��¥������ ������ ���� ��ȯ�ϱ� TO_DATE


--32. �Ͻ��� �� ��ȯ �����ϱ� 

SELECT  ename, sal
    FROM emp
    WHERE sal = '3000';

--�������� '3000' ���� ���������� ���Ͽ������� �ұ��ϰ� �˻������ ��� ���� �� �� �ִ�.
--�̴� ����Ŭ�� �˾Ƽ� '������ = ������' ���� �� ��ȯ�� �ϱ� ������ ������ �߻����� �ʰ� �˻��Ǵ� ���̴�. 

--33. NULL �� ��� �ٸ� ������ ����ϱ� (NVL, NVL2)

 SELECT ename, comm, NVL(comm, 0)
    FROM emp;

 SELECT ename, sal, comm, sal+NVL(comm, 0)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');
    
 SELECT ename, sal, NVL(comm, 0), NVL2(comm, sal+comm, sal)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');   
--34.   IF���� SQL�� �����ϱ�. (DECODE �Լ�)

 SELECT ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) AS ���ʽ� 
    FROM emp;

-- �μ���ȣ�� 10�϶��� 300, 20�϶��� 400 �������� 0 as ���ʽ� 

 SELECT empno, mod(empno, 2) AS ������, DECODE(mod(empno, 2), 0, '¦��', 1, 'Ȧ��') AS ¦Ȧ��
    FROM emp;

-- default ���� ���� �� ���� �ִ�.    

--35. IF���� SQL�� �����ϱ�. (CASE)

 SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
--36. �ִ� ����ϱ� (MAX)

 SELECT MAX(sal)
    FROM emp;
    
 SELECT MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN';
 
--  SELECT job, MAX(sal)
--    FROM emp
--    WHERE job = 'SALESMAN';  
-- job Į���� ���� ���� ���� ��µǷ��� �ϴµ� �ƽ� ���� �ϳ��� ��� �Ƿ� �ϱ⶧���� ������ ���. 

 SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN'
    GROUP BY job;
    
--37. �ּҰ� ����ϱ� (MIN) 

-- �׷��Լ��� Ư¡�� WHERE ���� ������ �����̾ ����� �׻�  ����Ѵٴ� ���̴�. 

--38. ��հ� ����ϱ� (AVG)

SELECT AVG(comm)
    FROM emp;

--�׷��Լ��� �ΰ��� �����Ѵ�. �׷��ϱ� Ŀ�̼� ���տ��� 14�� �������� �ƴ϶� 4�� �������̴�.   

--39. ��Ż�� ����ϱ�(SUM)

SELECT job, sum(sal)
    from emp
    group by job;
    
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    HAVING sum(sal) >= 4000;

--where ���� �׷��Լ��� ����� ������ �ָ� �׷� �Լ� ����� �㰡�����ʴ´ٰ� ���. having �� ����Ͽ����Ѵ�. 

--40. �Ǽ� ����ϱ� COUNT (�׷��Լ��� null ���� �������� �ʴ´ٴ� ���� �����ؾ��Ѵ�. )


--41. ������ �м� �Լ��� ���� ����ϱ� (RANK)

SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) ���� 
    FROM emp
    WHERE job in ('ANALYST','MANAGER');
    
   
    
SELECT ename, job, sal, RANK() over (PARTITION BY job
                                     ORDER BY sal DESC) ���� 
    FROM emp;
--42. ������ �м� �Լ��� ���� ����ϱ� (DENSE_RANK)

SELECT ename, job, sal, DENSE_RANK() over (ORDER BY sal DESC) ���� 
    FROM emp
    WHERE job in ('ANALYST','MANAGER');
    
SELECT ename, job, sal, DENSE_RANK() over (PARTITION BY job
                                     ORDER BY sal DESC) ���� 
    FROM emp;    
--43. ������ �м� �Լ��� ��� ����ϱ� (NTILE)

SELECT ename, job, sal, 
       NTILE(4) over(order by sal desc nulls last) ���
    FROM emp
    WHERE job in ('ANALYST','MANAGER','CLERK');
    
--NULLS LAST �� ������� ���� NULL ���� ���������� ���ĵ˴ϴ�.    

--44.  ������ �м� �Լ��� ������ ���� ����ϱ� (CUME_DIST)

SELECT ename, sal, RANK() over (order by sal desc) as RANK,
                   DENSE_RANK() over (order by sal desc) as DENSE_RANK,
                   TRUNC(CUME_DIST() over(order by sal desc), 2) as  CUM_DIST
    FROM emp;

SELECT ename, sal, job, RANK() over (PARTITION BY job order by sal desc) as RANK,
                        TRUNC(CUME_DIST() over(PARTITION BY job order by sal desc), 2) as  CUM_DIST
    FROM emp;

--45. ������ �м� �Լ��� �����͸� ���η� ����ϱ�(LISTAGG)

SELECT job, LISTAGG(ename, '/') within group (ORDER BY sal desc) as EMPLOYEE,
            LISTAGG(sal, '/') within group (ORDER BY sal desc) as SAL
    FROM emp
    GROUP BY job;

SELECT job, LISTAGG(ename||'('||sal||')',',') within group (ORDER BY sal desc) as EMPLOYEE
    FROM emp
    GROUP BY job;    
    
--46. ������ �м� �Լ��� �ٷ� �� ��� ���� �� ����ϱ� (LAG, LEAD)

SELECT empno, ename, sal,
            NVL(LAG(sal, 1) over (order by sal asc), 0) AS ����,
            LEAD(sal, 1) over (order by sal asc) "���� ��"
    FROM emp
    WHERE job in ('ANALYST','MANAGER');

--47. SUM+DECODE �� Ȱ���Ͽ� ROW�� COLUMN�� �� ���ϱ� 

SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp;

--48. PIVOT�� Ȱ���Ͽ� ROW�� COLUMN�� �� ���ϱ� 

SELECT *
    FROM (select deptno, sal from emp)
    PIVOT (sum(sal) for deptno in (10,20,30));

--FROM ���� ��ȣ�� ����ؼ� Ư�� �÷��� �����ؾ��Ѵ�.    

-- ��ó�� �ǽ��� ���� 

Create table ���� (
�����ڵ� number not null,
�����̸� varchar2(50) not null,
���� varchar2(50) not null,
���� number not null);

insert into ���� values (1000, '�ü��', 'B', 80);

SELECT �����̸�, MAX(����) AS �ִ�����, MIN(����) AS �ּ����� FROM ���� GROUP BY �����̸� HAVING �����̸� = '��ǻ�Ͱ���';




--49. COLUMN TO ROW

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
    UNPIVOT (�Ǽ� for ������ in (bicycle, camera, notebook));

--NULL ���� ROW�� ���ԵǾ����� ��� ����� ��µ����ʴ´�. �����Ϳ� NULL���� ���ԵǾ� �ִ� ���, UNPIVOT INCLUDE NULLS ��� ������Ѵ�. 
    
--50. ������ �м� �Լ��� ���� ������ ����ϱ� (SUM OVER) 

SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ����ġ
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER');

--  UNBOUNDED PRECEDING�� ���� ù ��° ���� ����ŵ�ϴ�. BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW �� ���� ù ��° ����� ���� ������� ���� ���մϴ�. 
--  ����� UNBOUNDED FOLLOWING �� �� ������ ���� ����ŵ�ϴ�. 

--51. ������ �м� �Լ��� ���� ����ϱ� (RATIO_TO_REPORT) 

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS ���� 
    FROM emp
    WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS ����,
                          SAL/SUM(sal) OVER() as "�� ����"  
    FROM emp
    WHERE deptno = 20;    

--52. ������ �м��Լ��� ���� ��� ����ϱ� -- 1 (ROLLUP)

SELECT job, sum(sal)
    FROM emp
    GROUP BY ROLLUP(job);

--ROLLUP �� Į���� �ΰ� ����� ���. 

SELECT deptno, job, sum(sal) 
    FROM emp
    GROUP BY ROLLUP(deptno, job);
    
--53.  ������ �м��Լ��� ���� ��� ����ϱ� -- 2 (CUBE)

SELECT deptno,job, sum(sal)
    FROM emp
    GROUP BY CUBE(deptno,job);

-- ROLLUP ����� CUBE ����� �����Ӹ� �ƴ϶� ��°���� �ٸ���.!


--54. ������ �м��Լ��� ���� ��� ����ϱ� --3 (GROUPING SETS)

SELECT deptno, job, sum(sal)
    FROM emp
    GROUP BY GROUPING SETS((deptno), (job), ()); 

--55. ������ �м� �Լ��� ��� ��� �ѹ��� �ϱ� (ROW_NUMBER)

SELECT empno, ename, sal, RANK() OVER(ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(ORDER BY sal desc) ��ȣ
    FROM emp;
    
-- �μ���ȣ���� ��Ƽ�� �� ���

SELECT empno, ename, sal, RANK() OVER(PARTITION BY deptno ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal desc) ��ȣ
    FROM emp;