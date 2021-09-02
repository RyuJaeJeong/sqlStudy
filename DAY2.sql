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