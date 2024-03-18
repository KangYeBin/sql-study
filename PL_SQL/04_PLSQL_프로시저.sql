
-- 프로시저(procedure) -> void 메서드와 유사
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
-- 하지만 프로시저를 통해서 값을 리턴하는 방법도 있다.


CREATE PROCEDURE guguproc
    (p_dan IN NUMBER)   -- 매개변수
IS  -- 익명 블록의 DECLARE(선언부)
BEGIN
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(p_dan || ' x ' || i || ' = ' || p_dan * i);
    END LOOP;
END;

-- 프로시저 호출
EXEC guguproc(14);


-- 매개값(인수)이 없는 프로시저
CREATE PROCEDURE p_test
IS  -- 선언부
    v_msg VARCHAR(30) := 'Hello Procedure!';
BEGIN   -- 시작부
    dbms_output.put_line(v_msg);
END;    -- 종료부

EXEC p_test;


-- IN 입력값을 여러 개 전달 받는 프로시저
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (
        p_job_id IN jobs.job_id%TYPE,
        p_job_title IN jobs.job_title%TYPE,
        p_min_sal IN jobs.min_salary%TYPE,
        p_max_sal IN jobs.max_salary%TYPE
    )
IS
BEGIN
    INSERT INTO
        jobs
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    COMMIT;
END;


EXEC my_new_job_proc('JOB1', 'test job1', 2000, 5000);
EXEC my_new_job_proc('JOB2', 'test job2', 3000, 5000);


SELECT
    *
FROM
    jobs;

-- job_id를 확인해서 이미 존재하는 데이터라면 수정, 없다면 새롭게 추가
-- (job_id가 PK이기 때문에)
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (
        p_job_id IN jobs.job_id%TYPE,
        p_job_title IN jobs.job_title%TYPE,
        p_min_sal IN jobs.min_salary%TYPE,
        p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    -- 동일한 job_id가 있는지 체크 (문제가 없다면 INSERT)
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 v_cnt에 저장
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    
    IF v_cnt = 0
        THEN
            INSERT INTO
                jobs
            VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE        
        UPDATE
            jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal
        WHERE
            job_id = p_job_id;
    END IF;
    
    COMMIT;
END;

EXEC my_new_job_proc('JOB2', '테스트 job2', 10000, 15000);

SELECT
    *
FROM
    jobs;


-- 매개값(인수)의 디폴트 값(기본값) 설정
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (
        p_job_id IN jobs.job_id%TYPE,
        p_job_title IN jobs.job_title%TYPE,
        p_min_sal IN jobs.min_salary%TYPE := 0,
        p_max_sal IN jobs.max_salary%TYPE := 1000
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    -- 동일한 job_id가 있는지 체크 (문제가 없다면 INSERT)
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 v_cnt에 저장
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    
    IF v_cnt = 0
        THEN
            INSERT INTO -- 조회 결과가 없다면 INSERT
                jobs
            VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE        
        UPDATE  -- 조회 결과가 있다면 UPDATE
            jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal
        WHERE
            job_id = p_job_id;
    END IF;
    
    COMMIT;
END;

EXEC my_new_job_proc('JOB5', 'test job5');

SELECT
    *
FROM
    jobs;


--------------------------------------------------------------------------------

-- OUT, IN OUT 매개변수 사용
-- OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냄
-- OUT을 이용해서 보낸 값을 바깥 익명 블록에서 실행해야함

CREATE OR REPLACE PROCEDURE my_new_job_proc
    (
        p_job_id IN jobs.job_id%TYPE,
        p_job_title IN jobs.job_title%TYPE,
        p_min_sal IN jobs.min_salary%TYPE := 0,
        p_max_sal IN jobs.max_salary%TYPE := 1000,
        p_result OUT VARCHAR2 -- 프로시저 내부에서 바깥쪽으로 내보내기 위한 변수
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다';
BEGIN
    
    -- 동일한 job_id가 있는지 체크 (문제가 없다면 INSERT)
    -- 이미 존재한다면 1, 존재하지 않는다면 0을 v_cnt에 저장
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    
    IF
        v_cnt = 0
        THEN
            INSERT INTO
                jobs
            VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE        
        SELECT
            p_job_id || '의 최대 급여 : ' || max_salary || ', 최소 급여 : ' || min_salary
        INTO
            v_result
        FROM
            jobs
        WHERE
            job_id = p_job_id;
    END IF;
    
    -- OUT 매개변수에 조회 결과를 할당  -> return 개념과 동일
    -- OUT 매개변수에 값을 할당해놓으면 프로시저 종료 후 호출부로 OUT 변수의 값이 전달
    p_result := v_result;
    
    COMMIT;
END;


DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg);
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO1', 'test_ceo2', 30000, 80000, msg);
    dbms_output.put_line(msg);
END;


--------------------------------------------------------------------------------

-- IN, OUT 동시에 처리
CREATE OR REPLACE PROCEDURE my_param_test_proc
    (
        -- IN : 반환 불가, 받는 용도로만 가능
        p_var1 IN VARCHAR2,
        -- OUT : 받는 용도는 활용 불가
        -- OUT이 되는 시점은 프로시저가 끝날 때. 그 전까지는 할당되지 않음
        p_var2 OUT VARCHAR2,
        -- IN OUT : IN, OUT 둘 다 가능
        p_var3 IN OUT VARCHAR2
    )
IS

BEGIN
    dbms_output.put_line('p_var1: ' || p_var1); -- IN : 출력됨
    dbms_output.put_line('p_var2: ' || p_var2); -- OUT : 값을 전달했음에도 프로시저 내에서 확인 불가
    dbms_output.put_line('p_var3: ' || p_var3); -- IN OUT : IN의 성질을 가지므로 출력됨
    
--  p_var1 := '결과1';    IN : 할당 자체가 불가능
    p_var2 := '결과2';
    p_var3 := '결과3';
    
END;


DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2';
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_param_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
END;


-- RETURN : 값의 반환X, 프로시저 강제 종료할 때 사용

CREATE OR REPLACE PROCEDURE my_new_job_proc
    (
        p_job_id IN jobs.job_id%TYPE,
        p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다.';
BEGIN
    
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM
        jobs
    WHERE
        job_id = p_job_id;
    
    IF
        v_cnt = 0
        THEN 
            dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
            RETURN; -- 프로시저 강제 종료.
    END IF;
     
    SELECT
        p_job_id || '의 최대 연봉: ' || max_salary || ', 최소 연봉: ' || min_salary
    INTO
        v_result 
    FROM
        jobs
    WHERE
        job_id = p_job_id;

    p_result := v_result;
    
    COMMIT;
END;


DECLARE
    msg VARCHAR2(100);
BEGIN 
    my_new_job_proc('JOB1', msg);
    dbms_output.put_line(msg);
END;


--------------------------------------------------------------------------------

-- 예외 처리
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
    
    /*
        OTHERS 자리에 예외의 타입을 작성.
        ACCESS_INTO_NULL -> 객체 초기화가 되어 있지 않은 상태에서 사용.
        NO_DATA_FOUND -> SELECT INTO 시 데이터가 한 건도 없을 때
        ZERO_DIVIDE -> 0으로 나눌 때
        VALUE_ERROR -> 수치 또는 값 오류
        INVALID_NUMBER -> 문자를 숫자로 변환할 때 실패한 경우
    */
    
    EXCEPTION
        WHEN ZERO_DIVIDE
            THEN
                dbms_output.put_line('0으로 나누면 안돼요');
                dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE);
                dbms_output.put_line('SQL ERROR MESSAGE : ' || SQLERRM);
        WHEN OTHERS
            THEN
                -- WHEN으로 설정한 예외가 아닌 다른 예외가 발생 시 OTHERS 실행
                dbms_output.put_line('알 수 없는 예외 발생');
                
    dbms_output.put_line('익명 블록 종료');
END;
