--16. 대소문자 변환 함수

SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
    FROM emp;

SELECT *
    FROM emp
    WHERE LOWER(ename) = 'scott';

--데이터가 대문자인지 소문자 인지 확실하지 않을 때 사용 할 수 있다.     
    
    
insert  into emp values(9999, UPPER('financeRyu'), UPPER('clerk'), 9999, sysdate, 5000, 0, 0);    

--insert 문에도 사용 할 수 있다. 

--17. 문자에서 특정 문자 추출하기 

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

--18. 문자열의 길이를 출력하기 

SELECT ename, LENGTH(ename) AS 글자수
    FROM emp;


--19. 문자에서 특정 철자의 위치를 출력하기

SELECT INSTR('SMITH','I') 
    FROM dual;

--이걸 응용하면 이렇게도 할 수 있다. 

SELECT SUBSTR('fb0982@NAVER.com', INSTR('fb0982@NAVER.com','@')+1) AS 도메인주소,
    SUBSTR('fb0982@NAVER.com',1, INSTR('fb0982@NAVER.com','@')-1) AS 메일아이디
    FROM dual;

--20. 특정 철자를 다른 철자로 변경하기.

SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;

SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as salrary
    FROM emp;    

--replace 이용하면 한국 이름의 두번째자리를 류*정 이렇게 찍히게 만드는 것이 가능하다. 

--21. 특정 철자를 N개 만큼 채우기 

SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal, 10, '*') as salrary2
    FROM emp;

-- LPAD sal 글자수 총 10되도록 모자르는 부분 *로 채워 넣어라. 이걸 응용하면 아래와 같이 데이터 시각화를 하는 것이 가능하다. 

SELECT ename, sal, lpad('■', round(sal/100), '■')  AS bar_chart
    FROM emp;

--22. 철자 잘라내기 

SELECT 'smith', LTRIM('smith', SUBSTR('smith', 1, 1)), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;

SELECT LTRIM(ename, SUBSTR(ename, 1, 1)), RTRIM(ename, SUBSTR(ename, -1, 1))
    FROM emp;

--trim 의 경우 양쪽 방향 s 잘라서출력한다. 공백 체크하는 용도로도 사용 할 수 있다.     




--23.  반올림해서 출력하기 

SELECT sal, ROUND(sal/100)
    FROM emp;
    
    
--24.  숫자를 버리고 출력하기

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
--25.  나눈 나머지 값을 출력하기 MOD

SELECT MOD(10, 3)
    FROM dual;
    
SELECT empno,ename ,MOD(empno, 2) AS 짝홀수
    FROM emp;

SELECT empno,ename
    FROM emp
    WHERE  MOD(empno, 2) = 1;
    
--참고로 몫은 FLOOR함수를 이용한다

SELECT FLOOR(10/3)
    FROM dual;_

--26. 날짜 간 개월 수 출력하기 

SELECT ename, TRUNC(MONTHS_BETWEEN(sysdate, hiredate))
    FROM emp;

--날짜간 일수는 이렇게 계산한다.

SELECT  TO_DATE('2021-06-10', 'RRRR-MM-DD') -  TO_DATE('2019-06-10', 'RRRR-MM-DD') AS 일수
    FROM dual;

--27. 개월 수 더한 날짜 출력하기 

--2021년 5월 1일로 부터 100달뒤는 어떻게되는지?

SELECT ADD_MONTHS(TO_DATE('2021-05-01', 'RRRR-MM-DD'), 100) AS "날짜 더하기"
    FROM dual;

--이렇게 표현 할 수도 있다.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;

--interval 이용하여 1년 3개월을 이렇게 표현 할 수도 있다.

SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;

--3년 5개월 후의 날짜    
SELECT TO_DATE('2021-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS 날짜
    FROM dual;



--28.   특정 날짜 뒤에 오는 요일 날짜 출력하기

-- 2019년 5월 22일 로부터 바로 돌아올 월요일의 날짜가 어떻게되는지 출력해보자. 

SELECT '2021/09/03' as 날짜, NEXT_DAY('2021/09/03', '월요일') as "다음 월요일" 
    FROM DUAL;


--29.  특정 날짜가 있는 달의 마지막 날짜 출력하기

SELECT '2021/09/03' as 날짜, LAST_DAY('2021/09/03') as "마지막 날짜"
    FROM dual;
    
SELECT TRUNC(LAST_DAY('2021/09/03') - sysdate) AS 남은날
    FROM dual;

--30.  문자형으로 데이터 유형 변환하기

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

--31.  날짜형으로 데이터 유형 변환하기 TO_DATE