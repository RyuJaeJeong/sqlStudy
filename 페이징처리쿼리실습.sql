--재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행 

insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer FROM tbl_board);


SELECT *
    FROM tbl_board 
    ORDER BY bno desc;
    
SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ *
    FROM tbl_board
    WHERE bno>0;


--오라클 힌트 사용문법

--1. FULL 힌트 - 테이블 전체를 스캔 할 것을 명시하는 힌트 

SELECT
    /*+FULL(tbl_board) */ *
    FROM tbl_board
    ORDER BY bno desc;

--2. INDEX_ASC, INDEX_DESC 힌트 

SELECT
    /*+INDEX_ASC(tbl_board pk_board) */ *
    FROM tbl_board
    WHERE bno>0;
    
--인덱스를 이용한 접근 + ROWNUM 이용


-- 1페이지 
SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE rownum <=10;

-- 2페이지

SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE rownum <=20)
WHERE rn >10;

/*

정리 
1. 필요한 순서로 정렬된  데이터에 ROWNUM을 붙인다. 
2. 처음부터 해당 페이지의 데이터를 ROWNUM <= 30 과 같은 조건을 이용해서 구한다
3. 구해놓은 데이터를 하나의 테이블 처럼 간주하고 인라인뷰로 처리한다.
4. 인라인뷰에서 필요한 데이터만을 남긴다.


*/


--단일 항목 검색을 위한 쿼리문 작성. 
SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE title like '%test%' and rownum <=20)
WHERE rn >10;
    
--다중 항목 검색을 위한 쿼리문 작성. 
--괄호안의 검색 조건이 우선적으로 동작해야한다.
SELECT *
    FROM (SELECT
    /*+INDEX_DESC(tbl_board pk_board) */ 
    ROWNUM rn, tbl_board.*
    FROM tbl_board
    WHERE (title like '%test%' or content like'%test%') and rownum <=20)
WHERE rn >10;

    