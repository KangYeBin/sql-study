
/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (p_num IN NUMBER)
IS
    v_cnt NUMBER := 0;
BEGIN
    FOR i IN 1..p_num
    LOOP
        IF
            MOD(p_num, i) = 0
            THEN
                v_cnt := v_cnt + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('약수의 개수 : ' || v_cnt || '개');
END;

EXEC divisor_proc(10);

/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (
        p_department_id IN depts.department_id%type,
        p_department_name IN depts.department_name%type,
        flag IN VARCHAR2
    )  
IS
    v_cnt NUMBER := 0;
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM
        depts
    WHERE
        department_id = p_department_id;

    CASE
        WHEN flag = 'I'
            THEN
                INSERT INTO
                    depts(depts.department_id, depts.department_name)
                VALUES
                    (p_department_id, p_department_name);
        WHEN flag = 'U'
            THEN
                IF
                    v_cnt = 0
                        THEN
                            dbms_output.put_line('수정하고자 하는 부서가 존재하지 않습니다.');
                            RETURN;                            
                END IF;

                UPDATE
                    depts
                SET
                    depts.department_name = p_department_name
                WHERE
                    p_department_id = depts.department_id;
        WHEN flag = 'D'
        THEN
                IF
                    v_cnt = 0
                        THEN
                            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
                            RETURN;                            
                END IF;

                DELETE depts
                WHERE
                    p_department_id = depts.department_id;
    END CASE;
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS
            THEN
                dbms_output.put_line('예외가 발생했습니다.');
                dbms_output.put_line('ERROR msg: ' || SQLERRM);
                ROLLBACK;                
    
END;

EXEC depts_proc(400, '경영부', 'D');



/*
employee_id를 전달 받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
CREATE OR REPLACE PROCEDURE emp_hire_proc
    (
        p_emp_id IN employees.employee_id%TYPE,
        p_year OUT NUMBER
    )
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT
        hire_date
    INTO
        v_hire_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_year := TRUNC((sysdate - v_hire_date) / 365);
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_emp_id || '은(는) 없는 데이터 입니다.');
        p_year := 0;
    
END;


DECLARE
    v_year NUMBER(10);
BEGIN 
    proc(128, v_year);
    if v_year > 0 THEN
        dbms_output.put_line(v_year||'년');
    END IF;
END;


