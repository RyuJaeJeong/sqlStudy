use mysql;
	
DELIMITER $$

CREATE PROCEDURE GetEmp()
BEGIN
	SELECT *
		FROM emp;
END$$							 
DELIMITER ;      				

CALL GetEmp();  



DELIMITER $$					-- 구분기호를 ; 에서 $$로 임시 변경한다.

CREATE PROCEDURE GetEmp()
BEGIN
	SELECT *
		FROM emp;
END$$							 
DELIMITER ;      				-- 구분기호를 다시 ; 로 변경함.

CALL GetEmp();  				 

-- 쿼리를 나중에 실행 할 수 있도록, 데이터베이스 서버에 저장하려면 저장 프로시저를 사용하는 것이 방법이 될 수있다.
/*

저장 프로시저의 장점. 
1. 네트워크 트래픽 감소 - 애플리케이션과 MySQL 서버간의 네트워크 트래픽을 줄이는 데 도움이 된다. 
2. 여러 응용 프로그램에서 재사용 할 수 있는 비즈니스논리를 구현 할 수 있다. (예를들어, vine mes의 경우 마감기능을 모듈별로 구현 할 필요가 없어진다.)
3. 기본 테이블에 접근 권한을 부여하지않고, 특정 저장프로시저에만 엑세스하는 에플리케이션에 적절한 권한을 부여 할 수 있다.

단점
1. 연결 메모리 사용량이 증가한다
2. 유지보수가 까다롭다. 


*/

-- stored procedure 매게변수 사용하기

-- 1. IN 매게변수


DELIMITER //

CREATE PROCEDURE GetSalaryByJOBS(
	IN getJOB VARCHAR(255)
)
BEGIN
	SELECT * 
 	FROM emp
	WHERE JOB = getJOB;
END //

DELIMITER ;

CALL GetSalaryByJOBS('SALESMAN');



-- 2. OUT 매게변수

DELIMITER $$
CREATE PROCEDURE GetSalaryByJOBSTOTALSS(
	IN getJOB VARCHAR(255),
    OUT TOTAL INT
)
BEGIN
	SELECT AVG(SAL)
    INTO TOTAL
 	FROM emp
	WHERE JOB = getJOB;
END $$
DELIMITER ;

CALL GetSalaryByJOBSTOTALSS('MANAGER', @TOTAL);
SELECT @TOTAL;	


/*

DECLARE variable_name datatype(size) [DEFAULT default_value];

DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
	DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;


*/



-- 변수 선언 및 사용하는 법

DELIMITER // 
CREATE PROCEDURE GETAVGSAL()
begin
	declare totalOrder INT DEFAULT 0;
    SELECT AVG(SAL)
    INTO totalOrder 
    FROM emp;
    
    SELECT totalOrder;
END//
DELIMITER ;    

CALL GETAVGSAL();


-- 출처 : https://www.mysqltutorial.org/mysql-stored-procedure-tutorial.aspx