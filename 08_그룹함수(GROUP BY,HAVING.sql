
-- �׷� �Լ� AVG, MAX, MIN, SUM, COUNT
-- �׷�ȭ�� ���� �������� ������ �׷��� ���̺� ��ü
SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM
    employees;
    
    
SELECT
    COUNT(*)    -- �� �� �������� ��
FROM
    employees;
    
    
SELECT
   COUNT(commission_pct)    -- NULL�� �ƴ� ���� ��
FROM
    employees;
    

SELECT
   COUNT(manager_id)    -- NULL�� �ƴ� ���� ��
FROM
    employees;


-- �μ����� �׷�ȭ, �׷� �Լ��� ���
SELECT
    department_id, AVG(salary)
FROM
    employees
GROUP BY
    department_id;


-- ������ ��
-- �׷� �Լ��� �ܵ������� ���� ���� ��ü ���̺��� �׷� ����� ������
-- �Ϲ� �÷��� ���ÿ� ����� ���� ����. �׷� �ʼ�

-- ����
SELECT
    department_id, AVG(salary)
FROM
    employees;


-- GROUP BY���� ����� �� GROUP���� ������ ���� �÷��� ��ȸ�� �� ����
-- ����
SELECT
    job_id, department_id, AVG(salary)
FROM
    employees
GROUP BY
    department_id;


-- GROUP BY�� 2�� �̻� ���
SELECT
    job_id, department_id, AVG(salary)
FROM
    employees
GROUP BY
    department_id, job_id;


-- GROUP BY�� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���
-- WHERE�� �Ϲ� ������, GROUP BY���� ���� �����
SELECT
    job_id, department_id, AVG(salary)
FROM
    employees
GROUP BY
    department_id, job_id
HAVING
    AVG(salary) > 10000;


SELECT
    job_id, COUNT(*)
FROM
    employees
GROUP BY
    job_id
HAVING
    COUNT(*) >= 5;


-- �μ� ���̵� 50 �̻��� �͵��� �׷�ȭ��Ű��, �׷� �޿� ����� 5000 �̻� ��ȸ
SELECT
    department_id, AVG(salary) AS ���
FROM
    employees
WHERE
    department_id >= 50
GROUP BY
    department_id
HAVING
    AVG(salary) >= 5000
ORDER BY
    AVG(salary) DESC;

-- ���� ����
-- FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY


-------------------------------------------------------------

/*
���� 1.
1-1. ��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
1-2. ��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/

SELECT
    job_id, COUNT(*) AS "��� ��"
FROM
    employees
GROUP BY
    job_id;
    

SELECT
    job_id, AVG(salary) AS "���� ���"
FROM
    employees
GROUP BY
    job_id
ORDER BY
    "���� ���" DESC;


/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/


SELECT
    TO_CHAR(hire_date, 'yy') AS ����, COUNT(*) AS "��� ��"
FROM
    employees
GROUP BY
    TO_CHAR(hire_date, 'yy');


/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/
    

SELECT
    department_id, AVG(salary) AS ��ձ޿�
FROM
    employees
WHERE
    salary >= 5000
GROUP BY
    department_id
HAVING
    AVG(salary) >= 7000;

/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/


SELECT
    department_id,
    TRUNC(AVG(salary + salary * commission_pct), 2) AS ���,
    SUM(salary + salary * commission_pct) AS �հ�, COUNT(*)
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY
    department_id;
