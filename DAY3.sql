--56. ��µǴ� �� �����ϱ�. (ROWNUM)
SELECT ROWNUM as ��ȣ, emp.* 
    FROM emp
    WHERE ROWNUM <= 9;

--ROWNUM�� PSEUDO COLUMN���� '��¥��' ��� �� �״�� *�� �˻��ؼ��� ��µ��� �ʴ� ���߾��� Į���̴�.    
    
--57. ��µǴ� �� �����ϱ�. (Simple TOP-n Queries)
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;

SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 20 PERCENT ROWS ONLY;    

--���� ���� ������ ���� ������ش�. WITH TIES
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;    

--OFFSET �ɼ��� ����ϸ� ���۵Ǵ� ���� ��ġ�� ������ �� �ֽ��ϴ�. 
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS
    FETCH FIRST 2 ROWS ONLY;

--58. ���� ���̺��� �����͸� �����ؼ� ����ϱ� (EQUI JOIN)
SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

SELECT ename,job ,loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job='ANALYST';

SELECT e.deptno, e.ename ,e.job ,d.loc 
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job='ANALYST';    
    
--59. ���� ���̺��� �����͸� �����ؼ� ����ϱ� (NON EQUI JOIN)

--58�� �����Ͱ��� EQUAL ������ �ټ� ������ ����ϴ� ���� NON EQUI JOIN �̴�. 
-- EMP ���̺��� ������ SALGRADE �׺��� LOSAL �� HISAL ���̿� �ִٴ� ���� �����ٶ� ����ϴ� ���� 
-- �Ʒ��� �������̴�. 
SELECT e.ename, e.sal, s.grade 
    FROM emp e, salgrade s
    WHERE e.sal between s.losal and s.hisal;

--60. ���� ���̺��� �����͸� �����ؼ� ����ϱ� (OUTER JOIN)

-- EQUI JOIN ���ʿ� �� �����ϴ� �����͸� ���
-- LEFT OUTER JOIN EMP ���̺��� �����ϴµ� DEPT ���̺��� ���� ������ ��� 
-- RIGHT OUTER JOIN �� �ݴ�

SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno(+) = dept.deptno;

--61. SELF JOIN 

SELECT e.ename as ���, e.job as ����, m.ename as ������, m.job as ����
    FROM emp e, emp m
    WHERE e.mgr = m.empno;
    
--62. ���� ���̺��� �����͸� �����ؼ� ����ϱ� (ON��)

--56���� ǥ���� �����̴�. 56�� ����Ŭ ���� �ۼ����̰� 62�� ansi ǥ���̴�. �Ϲ������� ����Ŭ �����ۼ����� ���� ����Ѵٰ� �Ѵ�.

SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
 FROM emp e JOIN dept d
 ON (e.deptno = d.deptno)
 WHERE e.job = 'SALESMAN';
 
--63. ���� ���̺��� �����͸� �����ؼ� ����ϱ� USING 
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ" 
    FROM emp e join dept d
    USING (deptno)
    WHERE e.job='SALESMAN';

--USING ���� ����Ҷ� DEPTNO �տ��� ���̺���̳� ���̺� ��Ī�� ��� �� �� �����ϴ�.
--USING ������ �ݵ�� ��ȣ�� ����ؾ� �մϴ�. 

--�������� ���̺��� �����ϴ� ���
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d USING (deptno)
    JOIN salgrade s ON (e.sal between s.losal and s.hisal);
    
--64. ���� ���̺��� �����͸� �����ؼ� ����ϱ�

--NATURAL JOIN �� �� ���̺� �� �� �����ϴ� ������ �÷��� ������� �Ͻ����� ������ �����Ѵ�. �� �� �����ϴ� ������ �÷��� DEPTNO�� ����Ŭ�� �˾Ƽ� ã�� �̸� �̿��Ͽ� ������ �����Ѵ�. 
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e NATURAL join dept d
    WHERE e.job = 'SALESMAN';

--65. ���� ���̺��� �����͸� �����ؼ� ����ϱ�(LEFT OUTER JOIN)

SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ" 
    FROM emp e  RIGHT OUTER JOIN dept d
    USING (deptno);
--66.  ���� ���̺��� �����͸� �����ؼ� ����ϱ�(FULL OUTER JOIN)

INSERT INTO EMP (empno, ename, sal, job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);
COMMIT;

SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e FULL OUTER JOIN dept d
    ON (e.deptno = d.deptno);
--����Ŭ ǥ������� full outer join ���� �ۼ� �� ��� ������ �߻��մϴ�. 

--67. ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� (UNION ALL) 

SELECT deptno, sum(sal)
    FROM emp
    GROUP BY deptno 
UNION ALL
SELECT TO_NUMBER(null) as deptno, sum(sal)
    FROM emp;

--���� ������ ����� �Ʒ��� ������ ����� �ϳ��� ����� ������ش�.
/*
-union all ���� ������ �Ʒ��� ���� �÷��� ������ �����ؾ��մϴ�.
-union all ���� ������ �Ʒ��� ������ ������ Ÿ���� �����ؾ��մϴ�.
-����� ��µǴ� �÷����� ���� ������ �÷������� ��µ˴ϴ�.
-ORDER BY ���� ���� �Ʒ��� �������� �ۼ��Ҽ� �ֽ��ϴ�.
*/
    

--68. ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� (UNION)

SELECT deptno, sum(sal)
    FROM emp
    GROUP BY deptno 
UNION
SELECT null as deptno, sum(sal)
    FROM emp;

/*
-�ߺ��� �����͸� �ϳ��� ������ ������ ����մϴ�.
-ù��° �÷��� �����͸� �������� �������� �����մϴ�.
*/

--69. ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� (INTERSECT)

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20) 
INTERSECT
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
--���� ������ �Ʒ��� ���� ����� �����ո� ��µȴ�.    

--70. ���� �����ڷ� �������� ���̸� ����ϱ�(MINUS)

SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (10, 20)
MINUS
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno in (20, 30);
    
--���̳ʽ� �����ڸ� �̿��Ͽ� ���� ������ ��� �����Ϳ��� �Ʒ��� ������ ����������� ���̸� ����ϴ� �������̴�. 
--���̳ʽ� �������� ��쿡�� �����͸� ������������ �������ش�

--71. �������� ����ϱ� 1 -- ������ ��������

SELECT ename, sal
    FROM emp
    WHERE sal >= (SELECT sal 
                    FROM emp
                    WHERE ename = 'JONES')
          AND ename != 'JONES';          
          
--JONES ���� �� ���� ������ �޴� ������� �˻��Ϸ��� ���� JONES����� ������ �������, SAL �� ���ϴ� �ι��� ������ ������ �ؾ߸��Ѵ�.
-- ���������� ���� ����Ƚ���� 1ȸ�� ���� �� �ִ�.

--72. �������� ����ϱ� 2 -- ������ ��������

SELECT ename, sal, job
    FROM emp
    WHERE sal in (SELECT sal FROM emp WHERE job = 'SALESMAN');
    
--�������� ���� ���������� �ϳ��� ���� �ƴ϶� �������� ���� ��ȯ�Ǵ� ���� ���� �� ����������� �Ѵ�. 
--71���� ��� jones �� ������ ��ȯ�� �������� �ϳ��ǰ��� ��ȯ�ȴ�. �� ������ ��������.
--�׷��� 72���� ��� salesman�� �Ѹ��� �ƴ����� �������� ���� ��ȯ�Ǵµ� �̸� ���� �� �����������Ѵ�. 
--���������� ������ ���� ���Ǵ� �����ڵ� �ٸ���, ������ �������������� in, not in, >any <any, >all, <all �� ����Ѵ�. 
--����� ��ȯ�Ǵ� Į���� �������� ��� ���� �÷� ������������Ѵ�. 

--73 �������� ����ϱ� 3 -- not in

--�����ڰ� �ƴ� ������� �̸��� ���ް� ������ ����غ��ڽ��ϴ�.

SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr FROM emp WHERE mgr is not null);

SELECT  distinct mgr
    FROM emp
    WHERE mgr is not null;
    
SELECT *
    FROM emp;
    
--������������ ���������� null���� �ϳ��� ���ϵǸ� ����� ��µ����ʴ´�.
--�������� true and null �� null�̱⶧���̴�.

--74. �������� ����ϱ� 4 -- exists �� not exists

SELECT *
    FROM dept d
    WHERE EXISTS (SELECT * 
                    FROM emp e 
                    WHERE e.deptno = d.deptno);

SELECT *
    FROM dept d
    WHERE NOT EXISTS (SELECT * 
                    FROM emp e 
                    WHERE e.deptno = d.deptno);                    
                    
--75. �������� ����ϱ�5 (HAVING���� �������� ����ϱ�)

SELECT job, sum(sal)
    FROM emp
    GROUP BY job 
    HAVING sum(sal) > (SELECT sum(sal)
                        FROM emp
                        WHERE job='SALESMAN');

--76. �������� ����ϱ�5 (FROM ���� �������� ����ϱ�)

SELECT  v.ename, v.sal, v.����
    FROM (SELECT ename, sal, rank() over (order by sal desc) ���� FROM emp) v
    WHERE v.���� =1;

-- from ���� ���������� in line view ����Ѵ�.
-- where ������ �м��Լ��� ��� �� �� ���⶧���� from ���� ������������ ����Ͽ� ���� ����ǰ� �ؾ��Ѵ�.

--77. �������� ����ϱ�7 (select���� ��������)

SELECT ename, sal, (SELECT max(sal) FROM emp where job='SALESMAN') as "�ִ� ����",
                   (SELECT min(sal) FROM emp where job='SALESMAN') as "�ּ� ����"
    FROM emp
    WHERE job='SALESMAN';
    

--78 ������ �Է��ϱ� 

--�����͸� �Է��ϰ� �����ϰ� �����ϴ� SQL���� DML���̶���Ѵ�.

INSERT INTO emp (empno, ename, sal, hiredate, job)
    VALUES(2812, 'JACK', 3500, TO_DATE('2019/06/05', 'RRRR/MM/DD'), 'ANALYST');

commit;    