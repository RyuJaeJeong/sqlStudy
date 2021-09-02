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