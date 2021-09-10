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