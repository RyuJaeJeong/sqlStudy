/*
����ó����� �Ǳ� �غ� ���� SQL���� 

1. TABLE ���� DDL 

--���̺� ����

CREATE TABLE ���̺�� (
 �÷��� ������Ÿ�� [��������],
);

--�÷� �߰�
ALTER TABLE ���̺�� ADD �÷��� ������Ÿ�� [��������];
--�÷� ����
ALTER TABLE ���̺�� MODIFY �÷��� ������Ÿ�� [��������];
--�÷� ����
ALTER TABLE ���̺�� DROP �÷���;


2. VIEW ���� DDL 

--VIEW ���� 
CREATE VIEW ���̸� 
    AS ��ȸ����;

CREATE VIEW EMP_VIEW 
    AS 
    SELECT empno, ename, sal, job, deptno
        FROM emp
        WHERE job='SALESMAN';

CREATE OR REPLACE VIEW EMP_VIEW 
    AS 
    SELECT empno, ename, sal, job, deptno
        FROM emp
        WHERE job='SALESMAN';        

DROP VIEW ���̸� 

3. �ε��� ���� DDL 

--CREATE INDEX
CREATE INDEX �ε����� ON ���̺��(�÷���1, �÷���2, ...);
--ALTER INDEX
ALTER INDEX �ε����� ON ���̺��(�÷���1, �÷���2, ...);
--DROP INDEX
DROP INDEX �ε�����;

DCL 
�׿���, ������ 

*/