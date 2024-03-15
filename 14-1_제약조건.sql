
-- ���̺� ������ ���� ����
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� �� ���� ���� ���� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.(Ŀ����)

-- �÷� ���� ���� ���� (�÷� ���𸶴� ���� ���� ����)
CREATE TABLE
    dept2 (
        -- �������� �ĺ��ڴ� ���� ����, �����ϸ� ����Ŭ�� �˾Ƽ� ����
        dept_no NUMBER(2)
            CONSTRAINT dept2_deptno_pk PRIMARY KEY,  
        dept_name VARCHAR2(14)
            NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
        loca NUMBER(4)
            CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
        dept_bonus NUMBER(10)
            CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
        dept_gender VARCHAR2(1)
            CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M', 'F'))
    );


-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
CREATE TABLE
    dept2 (
        dept_no NUMBER(2),  
        dept_name VARCHAR2(14) NOT NULL,
        loca NUMBER(4),
        dept_bonus NUMBER(10),
        dept_gender VARCHAR2(1),
        
        CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
        CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
        CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
        CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
        CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M', 'F'))
    );


-- �ܷ� Ű(foreign key)�� �θ� ���̺�(���� ���̺�)�� ���� ���̶�� INSERT �Ұ���
INSERT INTO
    dept2
VALUES
    (10, 'gg', 6512, 90000, 'M');   -- ����


-- UNIQUE ���� ���� ����
INSERT INTO
    dept2
VALUES
    (10, 'gg', 1900, 90000, 'M');   -- ����


-- �ܷ�Ű ���� ���� ����
UPDATE dept2
SET loca = 4000
WHERE detp_no = 10; -- ����


-- �ֿ�Ű ���� ���� ����
UPDATE dept2
SET dept_no = 20
WHERE detp_no = 10; -- ����


-- check ���� ���� ����
UPDATE dept2
SET dept_bonus = 900
WHERE detp_no = 10; -- ����


-- ���̺� ���� ���� ���� ���� �߰� �� ����, ����
-- ���� ������ �߰��� ������ ����, ������ X
-- �����Ϸ��� �����ϰ� ���Ӱ� �߰��ؾ� �Ѵ�.
CREATE TABLE
    dept2 (
        dept_no NUMBER(2),  
        dept_name VARCHAR2(14) NOT NULL,
        loca NUMBER(4),
        dept_bonus NUMBER(10),
        dept_gender VARCHAR2(1)
    );
    
-- pk �߰�
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_deptno_pk
    PRIMARY KEY
        (dept_no);
    
-- fk �߰�
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_loca_locid_kf
    FOREIGN KEY
        (loca)
    REFERENCES
        locations(location_id);
    
-- check �߰�
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_bonus_ck
    CHECK
        (dept_bonus > 10000);
    
-- unique �߰�
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_deptname_uk
    UNIQUE
        (dept_name);
    
-- NOT NULL�� �� ���� ���·� ����
ALTER TABLE
    dept2
MODIFY
    dept_bonus
    NUMBER(10) NOT NULL;
    
    
-- ���� ���� Ȯ��
SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'DEPT2';
    
    
-- ���� ���� ���� (���� ������ �̸����� -> �̸��� ���� ���� �ʾҴٸ� ����Ŭ�� �ο��� �̸��� ����)
ALTER TABLE
    dept2
DROP CONSTRAINT
    dept2_deptno_pk;

