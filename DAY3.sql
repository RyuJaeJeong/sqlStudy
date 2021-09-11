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