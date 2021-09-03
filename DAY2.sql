--16. ��ҹ��� ��ȯ �Լ�

SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
    FROM emp;

SELECT *
    FROM emp
    WHERE LOWER(ename) = 'scott';

--�����Ͱ� �빮������ �ҹ��� ���� Ȯ������ ���� �� ��� �� �� �ִ�.     
    
    
insert  into emp values(9999, UPPER('financeRyu'), UPPER('clerk'), 9999, sysdate, 5000, 0, 0);    

--insert ������ ��� �� �� �ִ�. 

--17. ���ڿ��� Ư�� ���� �����ϱ� 

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

SELECT ename, LENGTH(ename) AS ���ڼ�
    FROM emp;


--19. ���ڿ��� Ư�� ö���� ��ġ�� ����ϱ�

SELECT INSTR('SMITH','I') 
    FROM dual;

--�̰� �����ϸ� �̷��Ե� �� �� �ִ�. 

SELECT SUBSTR('fb0982@NAVER.com', INSTR('fb0982@NAVER.com','@')+1) AS �������ּ�,
    SUBSTR('fb0982@NAVER.com',1, INSTR('fb0982@NAVER.com','@')-1) AS ���Ͼ��̵�
    FROM dual;

--20. Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϱ�.

SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;

SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as salrary
    FROM emp;    

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
    
--������ ���� FLOOR�Լ��� �̿��Ѵ�

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