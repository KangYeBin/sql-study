-- INNER JOIN
-- �̳� (����) ����
SELECT
    *
FROM
    info i
INNER JOIN
    auth a
ON
    i.auth_id = a.auth_id;
    
    
-- ����Ŭ ���� (����Ŭ ���� �����̶� �����δ� �ۼ� X)
SELECT
    *
FROM
    info i, auth a
WHERE
    i.auth_id = a.auth_id;
    

-- auth_id �÷��� �׳ɾ��� ��ȣ�ϴ� ��� ���
-- �� ������ ���ʿ� ��� �����ϴ� �÷��̴ϱ�
-- �÷��� ���̺� �̸��� ���̴���, ��Ī�� ���� Ȯ���ϰ� ����

-- �ʿ��� �����͸� ��ȸ�Ϸ���
-- WHERE ������ ���� ���� �ɱ�
SELECT
    a.auth_id, i.title, i.content, a.name
FROM
    info i
JOIN
    auth a -- JOIN�̶�� ���� INNER JOIN���� �ν�
ON
    i.auth_id = a.auth_id
WHERE
    a.name = '�̼���';


-- OUTER JOIN
-- �ƿ��� (�ܺ�) ����
SELECT
    *
FROM
    info i
LEFT OUTER JOIN
    auth a
ON
    i.auth_id = a.auth_id;


-- ����Ŭ
SELECT
    *
FROM
    info i, auth a
WHERE
    i.auth_id = a.auth_id(+);


-- ���� ���̺�� ���� ���̺� �����͸� ��� �о� ǥ���ϴ� �ܺ� ����
-- ��ġ�ϴ� ���� ���� ��� NULL ��
SELECT
    *
FROM
    info i
FULL JOIN
    auth a
ON
    i.auth_id = a.auth_id;


-- CROSS JOIN : JOIN ������ �������� �ʱ� ������ ��� �÷��� ���� JOIN ����
-- �����δ� ���� ������� ����
SELECT
    *
FROM
    info 
CROSS JOIN
    auth;


SELECT
    *
FROM
    info, auth;


-- ���� �� ���̺� ���� -> Ű ���� ã�� ������ �����ؼ� �ۼ�
SELECT
    *
FROM
    employees e
LEFT JOIN
    departments d
ON
    e.department_id = d.department_id
LEFT JOIN
    locations loc
ON
    d.location_id = loc.location_id;


/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/
SELECT
    i.id, i.title, i.content, a.job
FROM
    auth a
LEFT OUTER JOIN
    info i
ON
    a.auth_id = i.auth_id
WHERE
    job = 'scientist';


-- ���� �����̶� ���� ���̺������ ����
-- ���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ���
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM
    employees e1
JOIN
    employees e2
ON
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;