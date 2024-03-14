
-- ���� Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT;

-- ���� Ŀ�� ��
SET AUTOCOMMIT ON;
-- ���� Ŀ�� ����
SET AUTOCOMMIT OFF;


SELECT
    *
FROM
    emps;


DELETE
FROM
    emps
WHERE
    employee_id = 100;

INSERT INTO
    emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail@com', sysdate, 'text');

-- ���� ���� ��� ������ ���� ������ ��� (���)
-- ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
ROLLBACK;
-- ���̺� ����Ʈ�� �����


-- ���̺� ����Ʈ ����
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
-- ANSI ǥ�ع����� �ƴϱ� ������ �������� ����
SAVEPOINT insert_park;

INSERT INTO
    emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (305, 'park', 'park1234@gmail@com', sysdate, 'text');

ROLLBACK TO SAVEPOINT insert_park;

-- ��������(���� �����ͺ��̽��� ������� ����) ��� ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� ����
COMMIT;
