/*
정보처리기사 실기 준비를 위한 SQL정리 

1. TABLE 관련 DDL 

--테이블 생성

CREATE TABLE 테이블명 (
 컬럼명 데이터타입 [제약조건],
);

--컬럼 추가
ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [제약조건];
--컬럼 수정
ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입 [제약조건];
--컬럼 삭제
ALTER TABLE 테이블명 DROP 컬럼명;


2. VIEW 관련 DDL 

--VIEW 생성 
CREATE VIEW 뷰이름 
    AS 조회쿼리;

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

DROP VIEW 뷰이름 

3. 인덱스 관련 DDL 

--CREATE INDEX
CREATE INDEX 인덱스명 ON 테이블명(컬럼명1, 컬럼명2, ...);
--ALTER INDEX
ALTER INDEX 인덱스명 ON 테이블명(컬럼명1, 컬럼명2, ...);
--DROP INDEX
DROP INDEX 인덱스명;

DCL 
그온투, 리온프 

*/