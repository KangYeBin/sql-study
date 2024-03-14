
-- INSERT

-- ���̺� ���� Ȯ��
DESC departments;

-- INSERT�� ù ��° ��� (��� �÷� �����͸� �� ���� �����ؼ� ����)
INSERT INTO
    departments
VALUES
    (300, '���ߺ�'); -- ����
-- -> �÷��� �������� �ʰ� ���� �ִ� ��쿡�� NULL ��� ��� ���� ��� ���� �� ��� �Ѵ�

INSERT INTO
    departments
VALUES
    (300, '���ߺ�', 100, 1500);

SELECT
    *
FROM
    departments;

-- ���� ������ �ٽ� �ڷ� �ǵ����� Ű����
ROLLBACK;

-- INSERT�� �� ��° ��� (���� �÷��� �����ϰ� ����, NOT NULL �÷��� �� Ȯ���� ��
INSERT INTO
    departments
    (department_id, department_name)
VALUES
    (300, '���ߺ�');    -- ���� ���� ���� ���� NULL��

INSERT INTO
        departments
        (department_id)
VALUES
    (300);    -- ���� -> NOT NULL�� �ʼ��� �Է�


-- �纻 ���̺����
-- ��ȸ�� �����ͱ��� ��� ����
-- CTAS���� �÷��� ������ �����͸� ������ ��, ��������(FK, PK..)�� �������� �ʴ´�
CREATE TABLE
    emps
AS
    (
        SELECT
            employee_id, first_name, job_id, hire_date
        FROM
            employees
    );

-- WHERE���� false���� �����ϸ� ���̺��� ������ ����ǰ� �����ʹ� ������� �ʴ´� 
CREATE TABLE
    emps
AS
    (
        SELECT
            employee_id, first_name, job_id, hire_date
        FROM
            employees WHERE 1 = 2
    );

SELECT
    *
FROM
    emps;

DROP TABLE
    emps;


-- INSERT (��������)
INSERT INTO
    emps
    (
        SELECT
            employee_id, first_name, job_id, hire_date
        FROM
            employees
        WHERE
            department_id = 50
    );


-- PK�� �������� �ʾƼ� ���� employee_id�� ���� ���� ���� �� ����
SELECT
    *
FROM
    emps
WHERE
    employee_id = 120;


--------------------------------------------------------------------------------

-- UPDATE

CREATE TABLE
    emps
AS
    (
        SELECT
            *
        FROM
            employees
    );

SELECT
    *
FROM 
    emps;


-- UPDATE ���̺� �̸� SET �÷�=��, �÷�=�� ... WHERE ������ �������� (����)
-- ������ �������� ������ ��ü ���̺��� ������
UPDATE
    emps
SET
    salary = 30000;


SELECT
    *
FROM
    emps;

ROLLBACK;


UPDATE
    emps
SET
    salary = salary + salary * 0.1
WHERE
    employee_id = 100;


UPDATE
    emps
SET
    phone_number = '010.1234.5678',
    manager_id = '102'
WHERE
    employee_id = 100;


-- UPDATE (��������)
UPDATE
    emps
SET
    (job_id, salary, manager_id) = (
        SELECT
            job_id, salary, manager_id
        FROM
            emps
        WHERE
            employee_id = 100
    )
WHERE employee_id = 101;


--------------------------------------------------------------------------------

-- DELETE
-- DELETE�� WHERE�� �������� ������ ���̺� ��ü ���� ����� ��
DELETE
FROM
    emps
WHERE
    employee_id = 103;


-- DELETE (��������)
DELETE
FROM
    emps
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            departments
        WHERE
            department_name = 'IT'
    );




SELECT
    *
FROM
    emps;
