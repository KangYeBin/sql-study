
/*
    view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� ����.
    ��� �⺻ ���̺�� ������ ���� ���̺��̱� ������ �ʿ��� �÷��� ������ �θ� ������ ����.
    ��� ���� ���̺�� ���� �����Ͱ� ���������� ����� ���´� �ƴϴ�.
    �並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ִ�.
*/

-- ���� Ȯ��
SELECT
    *
FROM
    user_sys_privs;


-- �ܼ� �� : �ϳ��� ���̺��� �̿��Ͽ� ������ ��
-- ���� �÷����� �Լ� ȣ�⹮, ����� ���� ���� ǥ������ ����� �� ����.
SELECT
    employee_id, first_name || ' ' || last_name, job_id, salary
FROM
    employees
WHERE
    department_id = 60;


-- AS�� ��Ī �ۼ�
CREATE VIEW
    view_emp
AS (
    SELECT
        employee_id, first_name || ' ' || last_name AS full_name, job_id, salary
    FROM
        employees
    WHERE
        department_id = 60
);


-- ���� �� : ���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���
CREATE VIEW
    view_emp_dept_job
AS (
    SELECT
        e.employee_id, e.first_name || ' ' || e.last_name AS full_name,
        d.department_name,
        j.job_title
    FROM
        employees e
    LEFT JOIN
        departments d
    ON
        e.department_id = d.department_id
    LEFT JOIN
        jobs j
    ON
        e.job_id = j.job_id
)
ORDER BY
    employee_id;

SELECT * FROM view_emp_dept_job;


-- ���� ���� (CREATE OR REPLACE ����)
-- ���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� ������
CREATE OR REPLACE VIEW
    view_emp_dept_job
AS (
    SELECT
        e.employee_id, e.first_name || ' ' || e.last_name AS full_name, e.salary,
        d.department_name,
        j.job_title
    FROM
        employees e
    LEFT JOIN
        departments d
    ON
        e.department_id = d.department_id
    LEFT JOIN
        jobs j
    ON
        e.job_id = j.job_id
)
ORDER BY
    employee_id;


-- view�� ����ϸ� SQL ������ ��������
SELECT
    job_title,
    AVG(salary) AS avg
FROM
    view_emp_dept_job
GROUP BY
    job_title
ORDER BY
    avg DESC;


-- �� ����
DROP VIEW
    view_emp;


/*
    VIEW�� INSERT�� �Ͼ�� ��� ���� ���̺��� �ݿ���.
    �׷��� VIEW�� INSERT, UPDATE, DELETE�� ���� ���� ������ ������.
    ���� ���̺��� NOT NULL�� ��� VIEW�� INSERT�� �Ұ���.
    VIEW���� ����ϴ� �÷��� ���� ���� ��쿡�� �� ��.
*/

-- �� ��° �÷��� 'full_name'�� ���� ��(virtual column)�̹Ƿ� INSERT �� ��
INSERT INTO
    view_emp_dept_job
VALUES
    (300, 'test', 'test', 'test', 10000); -- ����


-- JOIN�� ��(���� ��)�� ��쿡�� �� ���� ������ �� ����.
INSERT INTO
    view_emp_dept_job
    (employee_id, department_name, job_title, salary)
VALUES
    (300, 'test', 'test', 10000); -- ����


-- ���� ���̺� �÷� �� NOT NULL �÷��� �����ϰ�, �ش� �÷��� ��� ������ �� ���ٸ� INSERT �Ұ���.
INSERT INTO
    view_emp
    (employee_id, job_id, salary)
VALUES
    (300, 'test', 10000);   -- ����


--
DELETE
FROM
    view_emp
WHERE
    employee_id = 107;

SELECT
    *
FROM
    view_emp;

-- �信�� DELETE�� ���� ���� ���̺����� �����ȴ�.

SELECT
    *
FROM
    employees;

ROLLBACK;


-- WITH CHECK OPTION -> ���� ���� �÷� ����
-- �並 ������ �� ����� ���� �÷��� �並 ���ؼ� ������ �� ���� ���ִ� Ű����
CREATE OR REPLACE VIEW
    view_emp_test
AS (
    SELECT
        employee_id, first_name, last_name, email,  hire_date,
        job_id,
        department_id
    FROM
        employees
    WHERE
        department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

SELECT * FROM view_emp_test;


UPDATE
    view_emp_test
SET
    department_id = 100
WHERE
    employee_id = 107;
        
DROP VIEW view_emp_test;    


-- �б� ���� �� -> WITH READ ONLY (DML ������ ���� SELECT�� ���)
CREATE OR REPLACE VIEW
    view_emp_test
AS (
    SELECT
        employee_id, first_name, last_name, email,  hire_date,
        job_id,
        department_id
    FROM
        employees
    WHERE
        department_id = 60
)
WITH READ ONLY;
