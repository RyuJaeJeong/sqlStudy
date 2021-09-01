-- 01.
-- �������� ���̱� ���� sql �� �빮��, Į����� ���̺� ���� �ҹ��ڷ� �ۼ��ϱ⸦ �����ϰ��ִ�.
-- �������� ��� �� �� �־� select ���� from ���� ������ ���ο� �ۼ��ϴ� ���� ����
-- from �� 2~3ĭ �پ� �ָ� ����.
SELECT empno, ename, sal 
  FROM emp;

--02. ��� �� ����ϱ�.
SELECT *
   FROM emp;
   
-- ��� Į�� ����ϰ� Ư��Į�� �ѹ� �� ����ؾ��ϴ� ���   
SELECT emp.*,empno 
   FROM emp;

-- 03. ��Ī ����ϱ�    
SELECT empno as �����ȣ, ename as ����̸�, sal as "Salary" 
    FROM emp;
    
SELECT ename as ����̸�, sal * (12 + 3000) as ���� 
    FROM emp;

--04. ���� ������
SELECT ename || '�� ������ ' || sal || '�Դϴ�' as �������� 
    FROM emp;
SELECT ename || '�� ������ ' || job || '�Դϴ�' as �������� 
    FROM emp;
    
--05. distinct ����ϱ�
SELECT DISTINCT job 
    FROM emp;

SELECT UNIQUE job 
    FROM emp;
   
--06. �����͸� �����ؼ� ����ϱ�.

SELECT ename, sal as ����
    FROM emp
    ORDER BY ���� desc;

--order by ���� ���� �������� ����ȴ�.

SELECT ename,deptno,sal as ����
    FROM emp
    ORDER BY 2 asc, 3 desc;
    
--07. where �� ����ϱ� (1)

SELECT ename, sal, job
    FROM emp
    WHERE sal >= 3000;

-- where �������� ��Ī�� ��� �� �� ����. ������ ��������� select �� ���� ���̱� �����̴�. 


--08. where �� ����ϱ� (2)

SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE ename='SCOTT';
    
SELECT ename, sal, job, hiredate deptno
    FROM emp
    WHERE hiredate='81/11/17';  
    
--09. ��������� 

SELECT sal + comm 
    FROM emp
    WHERE ename='KING';

-- NVL �Լ� ����ϸ� NULL �� ��� 0 ��ȯ�Ѵ�. 5000+NULL=NULL
    
SELECT sal + NVL(comm, 0) 
    FROM emp
    WHERE ename='KING';  
    
--10. �񱳿�����    


--11. �񱳿����� BETWEEN AND

SELECT ename, sal 
    FROM emp 
    WHERE sal BETWEEN 1000 AND 3000
    ORDER BY  sal asc;
    
SELECT ename, sal 
    FROM emp 
    WHERE sal NOT BETWEEN 1000 AND 3000
    ORDER BY  sal asc;
    
-- BETWEEN ���Ѱ� AND ���Ѱ� �����Ѵ�. �ݴ��� ��쿡�� ���������ʴ´�. 

SELECT ename, hiredate 
    FROM emp 
    WHERE hiredate between '1982/01/01' AND '1982/12/31';
    
--12. �񱳿����� LIKE 

SELECT ename, sal
    FROM emp
    WHERE ename LIKE 'S%';
    
SELECT ename, sal
    FROM emp
    WHERE ename LIKE '_M%';

--%�� ���ϵ� ī��. �� �ڸ��� ��� ö�ڰ� �͵� ������� ö���� ������ ��� ������ٴ� ����.
--%�� Ư������ �ۼ�Ʈ���ƴ϶� ���ϵ� ī��� ���Ǳ� ���ؼ��� LIKE �����ڸ� ����ؾ�
--�����(_) �� ��� ö�ڰ� �͵� ��������� �ڸ����� ���ڸ����� �ȴٴ� �ǹ�.

--13. �񱳿����� IS NULL

SELECT ename, comm 
    FROM emp
    WHERE comm is null;
    
--14. �񱳿����� IN

SELECT ename, sal, job
    FROM emp 
    WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER');
    
--���� �����ڴ� �ϳ��� ���� ��ȸ�� �� �ִ� �ݸ� IN �����ڴ� ���� ����Ʈ�� ���� ��ȸ�� �� �ִ�.     

--15. �������� and or not 