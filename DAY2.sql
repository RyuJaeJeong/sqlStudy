--16. ´ë¼Ò¹®ÀÚ º¯È¯ ÇÔ¼ö

/*
¹®ÀÚ ÇÔ¼ö : UPPER, LOWER INITCAP SUBSTR LENGTH CONCAT INSTR TRIM LAPD RPAD
*/

SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
    FROM emp;

SELECT *
    FROM emp
    WHERE LOWER(ename) = 'scott';

-- µ¥ÀÌÅÍ°¡ ´ë¹®ÀÚÀÎÁö ¼Ò¹®ÀÚ ÀÎÁö È®½ÇÇÏÁö ¾ÊÀ» ¶§ »ç¿ë ÇÒ ¼ö ÀÖ´Ù.     
-- MysqlÀÇ °æ¿ì¿¡´Â INITCAPÀÌ Á¦°øµÇÁö ¾Ê¾Æ¼­ ²À ÇÊ¿äÇÑ °æ¿ì º°µµÀÇ ÇÔ¼ö¸¦ ¸¸µé¾î »ç¿ëÇØ¾ßÇÑ´Ù.
    
insert  into emp values(9999, UPPER('financeRyu'), UPPER('clerk'), 9999, sysdate, 5000, 0, 0);    

--insert ¹®¿¡µµ »ç¿ë ÇÒ ¼ö ÀÖ´Ù. 


--17. ¹®ÀÚ¿¡¼­ Æ¯Á¤ ¹®ÀÚ ÃßÃâÇÏ±â 

--SUBSTR(A,B,C) A -- ÀÚ¸¦ ¹®ÀÚ¿­ B--½ÃÀÛ ÀÎµ¦½º C--B·ÎºÎÅÍ ¸î±ÛÀÚ ÀÚ¸¦ °ÍÀÎÁö.
--MYSQL¿¡¼­´Â SUBSTR°ú SUBSTRING ¸ðµÎ »ç¿ë °¡´ÉÇÏ´Ù. 

SELECT SUBSTR('SMITH', 1, 3) AS ±ÛÀÚ
    FROM DUAL;

SELECT SUBSTR('SMITH', 2, 2) AS ±ÛÀÚ
    FROM DUAL;

SELECT SUBSTR('SMITH', -2, 2) AS ±ÛÀÚ
    FROM DUAL;    
    
SELECT SUBSTR('SMITH', 2) AS ±ÛÀÚ
    FROM DUAL;

SELECT SUBSTR(ename, 1, 3) AS ÀÌ¸§
    FROM emp;

--18. ¹®ÀÚ¿­ÀÇ ±æÀÌ¸¦ Ãâ·ÂÇÏ±â 

--MYSQLÀÇ °æ¿ì LENGTH CHAR_LENGTH°¡ÀÖ´Âµ¥ ÇÑ±ÛÀ» »ç¿ëÇÒ °æ¿ì°¡ ´Ù¸£´Ù
--ÀüÀÚ´Â ¾È³çÀ» 6À¸·Î ¹ÝÈ¯ÇÏ°í, ÈÄÀÚ´Â ¾È³çÀ» 2·Î ¹ÝÈ¯ÇÑ´Ù

SELECT ename, LENGTH(ename) AS ±ÛÀÚ¼ö
    FROM emp;


--19. ¹®ÀÚ¿¡¼­ Æ¯Á¤ Ã¶ÀÚÀÇ À§Ä¡¸¦ Ãâ·ÂÇÏ±â

SELECT INSTR('SMITH','I') 
    FROM dual;

-- IÀÇ À§Ä¡°ªÀÎ 3¹ÝÈ¯ÇÔ. ÀÌ°É ÀÀ¿ëÇÏ¸é ÀÌ·¸°Ôµµ ÇÒ ¼ö ÀÖ´Ù. 

SELECT SUBSTR('fb0982@NAVER.com', INSTR('fb0982@NAVER.com','@')+1) AS µµ¸ÞÀÎÁÖ¼Ò,
    SUBSTR('fb0982@NAVER.com',1, INSTR('fb0982@NAVER.com','@')-1) AS ¸ÞÀÏ¾ÆÀÌµð
    FROM dual;

--20. Æ¯Á¤ Ã¶ÀÚ¸¦ ´Ù¸¥ Ã¶ÀÚ·Î º¯°æÇÏ±â.

SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;

SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as salraryc
    FROM emp;    

--REGEXP_REPLACE Á¤±Ô½Ä ÇÔ¼öÀÓ
/*
-- ÇÑ±ÛÁ¦°Å SELECT REGEXP_REPLACE('abcd(1234)°¡³ª´Ù¶ó', '[°¡-ÆR]', '') AS nickname; 
-- ¼ýÀÚÁ¦°Å SELECT REGEXP_REPLACE('abcd(1234)°¡³ª´Ù¶ó', '[0-9]', '') AS nickname; 
-- ¿µ¹®Á¦°Å SELECT REGEXP_REPLACE('abcd(1234)°¡³ª´Ù¶ó', '[a-z]', '') AS nickname; 
-- Æ¯¼ö¹®ÀÚÁ¦°Å (Æ¯Á¤¹®ÀÚ) SELECT REGEXP_REPLACE('abcd(1234)°¡³ª´Ù¶ó', '[`~!#$%^&*|\\\'\";:\/?]', '') AS nickname; 
-- Æ¯¼ö¹®ÀÚÁ¦°Å (ÀüÃ¼) SELECT REGEXP_REPLACE('abcd(1234)°¡³ª´Ù¶ó', '[^[:alnum:][:space:]]+', '') AS nickname;
*/

 

/* 
    SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') AS "Àü±¤ÆÇ_ÀÌ¸§"
        FROM test_ename;  
*/
--replace ÀÌ¿ëÇÏ¸é ÇÑ±¹ ÀÌ¸§ÀÇ µÎ¹øÂ°ÀÚ¸®¸¦ ·ù*Á¤ ÀÌ·¸°Ô ÂïÈ÷°Ô ¸¸µå´Â °ÍÀÌ °¡´ÉÇÏ´Ù.

--21. Æ¯Á¤ Ã¶ÀÚ¸¦ N°³ ¸¸Å­ Ã¤¿ì±â 


SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salrary2
    FROM emp;

-- LPAD sal ±ÛÀÚ¼ö ÃÑ 10µÇµµ·Ï ¸ðÀÚ¸£´Â ºÎºÐ *·Î Ã¤¿ö ³Ö¾î¶ó. ÀÌ°É ÀÀ¿ëÇÏ¸é ¾Æ·¡¿Í °°ÀÌ µ¥ÀÌÅÍ ½Ã°¢È­¸¦ ÇÏ´Â °ÍÀÌ °¡´ÉÇÏ´Ù. 

SELECT ename, sal, lpad('¡á', round(sal/100), '¡á')  AS bar_chart
    FROM emp;


--22. Ã¶ÀÚ Àß¶ó³»±â 

SELECT 'smith', LTRIM('smith', SUBSTR('smith', 1, 1)), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;

SELECT LTRIM(ename, SUBSTR(ename, 1, 1)), RTRIM(ename, SUBSTR(ename, -1, 1))
    FROM emp;

--trim ÀÇ °æ¿ì ¾çÂÊ ¹æÇâ s Àß¶ó¼­Ãâ·ÂÇÑ´Ù. °ø¹é Ã¼Å©ÇÏ´Â ¿ëµµ·Îµµ »ç¿ë ÇÒ ¼ö ÀÖ´Ù.     



--23.  ¹Ý¿Ã¸²ÇØ¼­ Ãâ·ÂÇÏ±â 

SELECT sal, ROUND(sal/100)
    FROM emp;
    
    
--24.  ¼ýÀÚ¸¦ ¹ö¸®°í Ãâ·ÂÇÏ±â

SELECT '876.567' AS ¼ýÀÚ, TRUNC(876.567,1)
    FROM dual;

SELECT '876.567' AS ¼ýÀÚ, TRUNC(876.567,2)
    FROM dual;

SELECT '876.567' AS ¼ýÀÚ, TRUNC(876.567,0)
    FROM dual;
    
SELECT '876.567' AS ¼ýÀÚ, TRUNC(876.567,-1)
    FROM dual;    

SELECT '876.567' AS ¼ýÀÚ, TRUNC(876.567,-2)
    FROM dual;    
--25.  ³ª´« ³ª¸ÓÁö °ªÀ» Ãâ·ÂÇÏ±â MOD

SELECT MOD(10, 3)
    FROM dual;
    
SELECT empno,ename ,MOD(empno, 2) AS Â¦È¦¼ö
    FROM emp;

SELECT empno,ename
    FROM emp
    WHERE  MOD(empno, 2) = 1;
    
--Âü°í·Î ¸òÀº FLOORÇÔ¼ö¸¦ ÀÌ¿ëÇÑ´Ù

SELECT FLOOR(10/3)
    FROM dual;_

--26. ³¯Â¥ °£ °³¿ù ¼ö Ãâ·ÂÇÏ±â 

SELECT ename, TRUNC(MONTHS_BETWEEN(sysdate, hiredate))
    FROM emp;

--³¯Â¥°£ ÀÏ¼ö´Â ÀÌ·¸°Ô °è»êÇÑ´Ù.

SELECT  TO_DATE('2021-06-10', 'RRRR-MM-DD') -  TO_DATE('2019-06-10', 'RRRR-MM-DD') AS ÀÏ¼ö
    FROM dual;

--27. °³¿ù ¼ö ´õÇÑ ³¯Â¥ Ãâ·ÂÇÏ±â 

--2021³â 5¿ù 1ÀÏ·Î ºÎÅÍ 100´ÞµÚ´Â ¾î¶»°ÔµÇ´ÂÁö?

SELECT ADD_MONTHS(TO_DATE('2021-05-01', 'RRRR-MM-DD'), 100) AS "³¯Â¥ ´õÇÏ±â"
    FROM dual;

--ÀÌ·¸°Ô Ç¥Çö ÇÒ ¼öµµ ÀÖ´Ù.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;

--interval ÀÌ¿ëÇÏ¿© 1³â 3°³¿ùÀ» ÀÌ·¸°Ô Ç¥Çö ÇÒ ¼öµµ ÀÖ´Ù.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;

--3³â 5°³¿ù ÈÄÀÇ ³¯Â¥    
SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS ³¯Â¥
    FROM dual;



--28.   Æ¯Á¤ ³¯Â¥ µÚ¿¡ ¿À´Â ¿äÀÏ ³¯Â¥ Ãâ·ÂÇÏ±â

-- 2019³â 5¿ù 22ÀÏ ·ÎºÎÅÍ ¹Ù·Î µ¹¾Æ¿Ã ¿ù¿äÀÏÀÇ ³¯Â¥°¡ ¾î¶»°ÔµÇ´ÂÁö Ãâ·ÂÇØº¸ÀÚ. 

SELECT '2021/09/03' as ³¯Â¥, NEXT_DAY('2021/09/03', '¿ù¿äÀÏ') as "´ÙÀ½ ¿ù¿äÀÏ" 
    FROM DUAL;


--29.  Æ¯Á¤ ³¯Â¥°¡ ÀÖ´Â ´ÞÀÇ ¸¶Áö¸· ³¯Â¥ Ãâ·ÂÇÏ±â

SELECT '2021/09/03' as ³¯Â¥, LAST_DAY('2021/09/03') as "¸¶Áö¸· ³¯Â¥"
    FROM dual;
    
SELECT TRUNC(LAST_DAY('2021/09/03') - sysdate) AS ³²Àº³¯
    FROM dual;

--30.  ¹®ÀÚÇüÀ¸·Î µ¥ÀÌÅÍ À¯Çü º¯È¯ÇÏ±â

SELECT ename, TO_CHAR(hiredate, 'DAY') as ¿äÀÏ, TO_CHAR(sal, '999,999') as ¿ù±Þ
    FROM emp;
    
SELECT ename, hiredate
    FROM emp
    WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

SELECT ename, EXTRACT(year from hiredate) as ¿¬µµ, 
              EXTRACT(MONTH from hiredate) as ´Þ,
              EXTRACT(day from hiredate) as ¿äÀÏ
    FROM emp;

SELECT *
    FROM emp;

--31.  ³¯Â¥ÇüÀ¸·Î µ¥ÀÌÅÍ À¯Çü º¯È¯ÇÏ±â TO_DATE


--32. ¾Ï½ÃÀû Çü º¯È¯ ÀÌÇØÇÏ±â 

SELECT  ename, sal
    FROM emp
    WHERE sal = '3000';

--¼ýÀÚÇüÀ» '3000' À¸·Î ¹®ÀÚÇüÀ¸·Î ºñ±³ÇÏ¿´À½¿¡µµ ºÒ±¸ÇÏ°í °Ë»ö°á°ú°¡ Ãâ·Â µÊÀ» ¾Ë ¼ö ÀÖ´Ù.
--ÀÌ´Â ¿À¶óÅ¬ÀÌ ¾Ë¾Æ¼­ '¼ýÀÚÇü = ¼ýÀÚÇü' À¸·Î Çü º¯È¯À» ÇÏ±â ¶§¹®¿¡ ¿¡·¯°¡ ¹ß»ýÇÏÁö ¾Ê°í °Ë»öµÇ´Â °ÍÀÌ´Ù. 

--33. NULL °ª ´ë½Å ´Ù¸¥ µ¥ÀÌÅÍ Ãâ·ÂÇÏ±â (NVL, NVL2)

 SELECT ename, comm, NVL(comm, 0)
    FROM emp;

 SELECT ename, sal, comm, sal+NVL(comm, 0)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');
    
 SELECT ename, sal, NVL(comm, 0), NVL2(comm, sal+comm, sal)
    FROM emp
    WHERE job in('SALESMAN', 'ANALYST');   
--34.   IF¹®À» SQL·Î ±¸ÇöÇÏ±â. (DECODE ÇÔ¼ö)

 SELECT ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) AS º¸³Ê½º 
    FROM emp;

-- ºÎ¼­¹øÈ£°¡ 10ÀÏ¶§´Â 300, 20ÀÏ¶§´Â 400 ³ª¸ÓÁö´Â 0 as º¸³Ê½º 

 SELECT empno, mod(empno, 2) AS ³ª¸ÓÁö, DECODE(mod(empno, 2), 0, 'Â¦¼ö', 1, 'È¦¼ö') AS Â¦È¦¼ö
    FROM emp;

-- default °ªÀº »ý·« ÇÒ ¼öµµ ÀÖ´Ù.    

--35. IF¹®À» SQL·Î ±¸ÇöÇÏ±â. (CASE)

 SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
--36. ÃÖ´ñ°ª Ãâ·ÂÇÏ±â (MAX)

 SELECT MAX(sal)
    FROM emp;
    
 SELECT MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN';
 
--  SELECT job, MAX(sal)
--    FROM emp
--    WHERE job = 'SALESMAN';  
-- job Ä®·³Àº ¿©·¯ °³ÀÇ ÇàÀÌ Ãâ·ÂµÇ·Á°í ÇÏ´Âµ¥ ¸Æ½º °ªÀº ÇÏ³ª°¡ Ãâ·Â µÇ·Á ÇÏ±â¶§¹®¿¡ ¿¡·¯°¡ ¶á´Ù. 

 SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN'
    GROUP BY job;
    
--37. ÃÖ¼Ò°ª Ãâ·ÂÇÏ±â (MIN) 

-- ±×·ìÇÔ¼öÀÇ Æ¯Â¡Àº WHERE ÀýÀÇ Á¶°ÇÀÌ °ÅÁþÀÌ¾îµµ °á°ú¸¦ Ç×»ó  Ãâ·ÂÇÑ´Ù´Â °ÍÀÌ´Ù. 

--38. Æò±Õ°ª Ãâ·ÂÇÏ±â (AVG)

SELECT AVG(comm)
    FROM emp;

--±×·ìÇÔ¼ö´Â ³Î°ªÀ» ¹«½ÃÇÑ´Ù. ±×·¯´Ï±î Ä¿¹Ì¼Ç ÃÑÇÕ¿¡¼­ 14¸¦ ³ª´«°ÍÀÌ ¾Æ´Ï¶ó 4¸¦ ³ª´«°ÍÀÌ´Ù.   

--39. ÅäÅ»°ª Ãâ·ÂÇÏ±â(SUM)

SELECT job, sum(sal)
    from emp
    group by job;
    
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    HAVING sum(sal) >= 4000;

--where Àý¿¡ ±×·ìÇÔ¼ö¸¦ »ç¿ëÇØ Á¶°ÇÀ» ÁÖ¸é ±×·ì ÇÔ¼ö »ç¿ëÀÌ Çã°¡µÇÁö¾Ê´Â´Ù°í ¶á´Ù. having À» »ç¿ëÇÏ¿©¾ßÇÑ´Ù. 

--40. °Ç¼ö Ãâ·ÂÇÏ±â COUNT (±×·ìÇÔ¼ö´Â null °ªÀ» Æ÷ÇÔÇÏÁö ¾Ê´Â´Ù´Â °ÍÀ» À¯³äÇØ¾ßÇÑ´Ù. )


--41. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ¼øÀ§ Ãâ·ÂÇÏ±â (RANK)

SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) ¼øÀ§ 
    FROM emp
    WHERE job in ('ANALYST','MANAGER');
    
   
    
SELECT ename, job, sal, RANK() over (PARTITION BY job
                                     ORDER BY sal DESC) ¼øÀ§ 
    FROM emp;
--42. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ¼øÀ§ Ãâ·ÂÇÏ±â (DENSE_RANK)

SELECT ename, job, sal, DENSE_RANK() over (ORDER BY sal DESC) ¼øÀ§ 
    FROM emp
    WHERE job in ('ANALYST','MANAGER');
    
SELECT ename, job, sal, DENSE_RANK() over (PARTITION BY job
                                     ORDER BY sal DESC) ¼øÀ§ 
    FROM emp;    
--43. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î µî±Þ Ãâ·ÂÇÏ±â (NTILE)

SELECT ename, job, sal, 
       NTILE(4) over(order by sal desc nulls last) µî±Þ
    FROM emp
    WHERE job in ('ANALYST','MANAGER','CLERK');
    
--NULLS LAST ¸¦ »ç¿ëÇßÀ» ¶§´Â NULL °ªÀÌ ¸¶Áö¸·À¸·Î Á¤·ÄµË´Ï´Ù.    

--44.  µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ¼øÀ§ÀÇ ºñÀ² Ãâ·ÂÇÏ±â (CUME_DIST)

SELECT ename, sal, RANK() over (order by sal desc) as RANK,
                   DENSE_RANK() over (order by sal desc) as DENSE_RANK,
                   TRUNC(CUME_DIST() over(order by sal desc), 2) as  CUM_DIST
    FROM emp;

SELECT ename, sal, job, RANK() over (PARTITION BY job order by sal desc) as RANK,
                        TRUNC(CUME_DIST() over(PARTITION BY job order by sal desc), 2) as  CUM_DIST
    FROM emp;

--45. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î µ¥ÀÌÅÍ¸¦ °¡·Î·Î Ãâ·ÂÇÏ±â(LISTAGG)

SELECT job, LISTAGG(ename, '/') within group (ORDER BY sal desc) as EMPLOYEE,
            LISTAGG(sal, '/') within group (ORDER BY sal desc) as SAL
    FROM emp
    GROUP BY job;

SELECT job, LISTAGG(ename||'('||sal||')',',') within group (ORDER BY sal desc) as EMPLOYEE
    FROM emp
    GROUP BY job;    
    
--46. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ¹Ù·Î Àü Çà°ú ´ÙÀ½ Çà Ãâ·ÂÇÏ±â (LAG, LEAD)

SELECT empno, ename, sal,
            NVL(LAG(sal, 1) over (order by sal asc), 0) AS ÀüÇà,
            LEAD(sal, 1) over (order by sal asc) "´ÙÀ½ Çà"
    FROM emp
    WHERE job in ('ANALYST','MANAGER');

--47. SUM+DECODE ¸¦ È°¿ëÇÏ¿© ROWÀ» COLUMN·Î Ãâ ·ÂÇÏ±â 

SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp;

--48. PIVOTÀ» È°¿ëÇÏ¿© ROWÀ» COLUMN·Î Ãâ ·ÂÇÏ±â 

SELECT *
    FROM (select deptno, sal from emp)
    PIVOT (sum(sal) for deptno in (10,20,30));

--FROM Àý¿¡ °ýÈ£¸¦ »ç¿ëÇØ¼­ Æ¯Á¤ ÄÃ·³¸¸ ¼±ÅÃÇØ¾ßÇÑ´Ù.    

-- Á¤Ã³±â ½Ç½À¿ë Äõ¸® 

Create table ¼ºÀû (
°ú¸ñÄÚµå number not null,
°ú¸ñÀÌ¸§ varchar2(50) not null,
ÇÐÁ¡ varchar2(50) not null,
Á¡¼ö number not null);

insert into ¼ºÀû values (1000, '¿î¿µÃ¼Á¦', 'B', 80);

SELECT °ú¸ñÀÌ¸§, MAX(Á¡¼ö) AS ÃÖ´ëÁ¡¼ö, MIN(Á¡¼ö) AS ÃÖ¼ÒÁ¡¼ö FROM ¼ºÀû GROUP BY °ú¸ñÀÌ¸§ HAVING °ú¸ñÀÌ¸§ = 'ÄÄÇ»ÅÍ°úÇÐ';




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
    UNPIVOT (°Ç¼ö for ¾ÆÀÌÅÛ in (bicycle, camera, notebook));

--NULL °ªÀÌ ROW¿¡ Æ÷ÇÔµÇ¾îÀÖÀ» °æ¿ì °á°ú°¡ Ãâ·ÂµÇÁö¾Ê´Â´Ù. µ¥ÀÌÅÍ¿¡ NULL°ªÀÌ Æ÷ÇÔµÇ¾î ÀÖ´Â °æ¿ì, UNPIVOT INCLUDE NULLS ¶ó°í ½áÁà¾ßÇÑ´Ù. 
    
--50. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ´©Àû µ¥ÀÌÅÍ Ãâ·ÂÇÏ±â (SUM OVER) 

SELECT empno, ename, sal, SUM(sal) OVER(ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ´©ÀûÄ¡
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER');

--  UNBOUNDED PRECEDINGÀº Á¦ÀÏ Ã¹ ¹øÂ° ÇàÀ» °¡¸®Åµ´Ï´Ù. BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ¶õ Á¦ÀÏ Ã¹ ¹øÂ° ÇàºÎÅÍ ÇöÀç Çà±îÁöÀÇ °ªÀ» ¸»ÇÕ´Ï´Ù. 
--  Âü°í·Î UNBOUNDED FOLLOWING Àº ¸Ç ¸¶Áö¸· ÇàÀ» °¡¸®Åµ´Ï´Ù. 

--51. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î ºñÀ² Ãâ·ÂÇÏ±â (RATIO_TO_REPORT) 

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS ºñÀ² 
    FROM emp
    WHERE deptno = 20;

SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () AS ºñÀ²,
                          SAL/SUM(sal) OVER() as "ºñ±³ ºñÀ²"  
    FROM emp
    WHERE deptno = 20;    

--52. µ¥ÀÌÅÍ ºÐ¼®ÇÔ¼ö·Î Áý°è °á°ú Ãâ·ÂÇÏ±â -- 1 (ROLLUP)

SELECT job, sum(sal)
    FROM emp
    GROUP BY ROLLUP(job);

--ROLLUP ¿¡ Ä®·³À» µÎ°³ »ç¿ëÇÑ °æ¿ì. 

SELECT deptno, job, sum(sal) 
    FROM emp
    GROUP BY ROLLUP(deptno, job);
    
--53.  µ¥ÀÌÅÍ ºÐ¼®ÇÔ¼ö·Î Áý°è °á°ú Ãâ·ÂÇÏ±â -- 2 (CUBE)

SELECT deptno,job, sum(sal)
    FROM emp
    GROUP BY CUBE(deptno,job);

-- ROLLUP Áý°è¿Í CUBE Áý°è´Â ¼ø¼­»Ó¸¸ ¾Æ´Ï¶ó Ãâ·Â°á°úµµ ´Ù¸£´Ù.!


--54. µ¥ÀÌÅÍ ºÐ¼®ÇÔ¼ö·Î Áý°è °á°ú Ãâ·ÂÇÏ±â --3 (GROUPING SETS)

SELECT deptno, job, sum(sal)
    FROM emp
    GROUP BY GROUPING SETS((deptno), (job), ()); 

--55. µ¥ÀÌÅÍ ºÐ¼® ÇÔ¼ö·Î Ãâ·Â °á°ú ³Ñ¹ö¸µ ÇÏ±â (ROW_NUMBER)

SELECT empno, ename, sal, RANK() OVER(ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(ORDER BY sal desc) ¹øÈ£
    FROM emp;
    
-- ºÎ¼­¹øÈ£º°·Î ÆÄÆ¼¼Ç ÁÙ °æ¿ì

SELECT empno, ename, sal, RANK() OVER(PARTITION BY deptno ORDER BY sal desc) RANK,
                          DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal desc) DENSE_RANK,  
                          ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal desc) ¹øÈ£
    FROM emp;