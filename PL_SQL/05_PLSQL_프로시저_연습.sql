
/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
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
    dbms_output.put_line('����� ���� : ' || v_cnt || '��');
END;

EXEC divisor_proc(10);

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
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
                            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
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
                            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
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
                dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
                dbms_output.put_line('ERROR msg: ' || SQLERRM);
                ROLLBACK;                
    
END;

EXEC depts_proc(400, '�濵��', 'D');



/*
employee_id�� ���� �޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
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
        dbms_output.put_line(p_emp_id || '��(��) ���� ������ �Դϴ�.');
        p_year := 0;
    
END;


DECLARE
    v_year NUMBER(10);
BEGIN 
    proc(128, v_year);
    if v_year > 0 THEN
        dbms_output.put_line(v_year||'��');
    END IF;
END;


