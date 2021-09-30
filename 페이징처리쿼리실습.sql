--��� ���縦 ���ؼ� �������� ������ �ø���. �ݺ��ؼ� ���� �� ���� 

insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer FROM tbl_board);


SELECT *
    FROM tbl_board 
    ORDER BY bno desc;
    
SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ *
    FROM tbl_board
    WHERE bno>0;


--����Ŭ ��Ʈ ��빮��

--1. FULL ��Ʈ - ���̺� ��ü�� ��ĵ �� ���� ����ϴ� ��Ʈ 

SELECT
    /*+FULL(tbl_board) */ *
    FROM tbl_board
    ORDER BY bno desc;

--2. INDEX_ASC, INDEX_DESC ��Ʈ 

SELECT
    /*+INDEX_ASC(tbl_board pk_board) */ *
    FROM tbl_board
    WHERE bno>0;
    
--�ε����� �̿��� ���� + ROWNUM �̿�


-- 1������ 
SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE rownum <=10;

-- 2������

SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE rownum <=20)
WHERE rn >10;

/*

���� 
1. �ʿ��� ������ ���ĵ�  �����Ϳ� ROWNUM�� ���δ�. 
2. ó������ �ش� �������� �����͸� ROWNUM <= 30 �� ���� ������ �̿��ؼ� ���Ѵ�
3. ���س��� �����͸� �ϳ��� ���̺� ó�� �����ϰ� �ζ��κ�� ó���Ѵ�.
4. �ζ��κ信�� �ʿ��� �����͸��� �����.


*/


--���� �׸� �˻��� ���� ������ �ۼ�. 
SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE title like '%test%' and rownum <=20)
WHERE rn >10;
    
--���� �׸� �˻��� ���� ������ �ۼ�. 
--��ȣ���� �˻� ������ �켱������ �����ؾ��Ѵ�.
SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE (title like '%test%' or content like'%test%') and rownum <=20)
WHERE rn >10;

    