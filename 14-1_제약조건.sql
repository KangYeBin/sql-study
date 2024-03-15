
-- 테이블 생성과 제약 조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열 레벨 제약 조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.(커스텀)

-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약 조건 지정)
CREATE TABLE
    dept2 (
        -- 제약조건 식별자는 생략 가능, 생략하면 오라클이 알아서 지음
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


-- 테이블 레벨 제약 조건 (모든 열 선언 후 제약 조건을 취하는 방식)
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


-- 외래 키(foreign key)가 부모 테이블(참조 테이블)에 없는 값이라면 INSERT 불가능
INSERT INTO
    dept2
VALUES
    (10, 'gg', 6512, 90000, 'M');   -- 에러


-- UNIQUE 제약 조건 위반
INSERT INTO
    dept2
VALUES
    (10, 'gg', 1900, 90000, 'M');   -- 에러


-- 외래키 제약 조건 위반
UPDATE dept2
SET loca = 4000
WHERE detp_no = 10; -- 에러


-- 주요키 제약 조건 위반
UPDATE dept2
SET dept_no = 20
WHERE detp_no = 10; -- 에러


-- check 제약 조건 위반
UPDATE dept2
SET dept_bonus = 900
WHERE detp_no = 10; -- 에러


-- 테이블 생성 이후 제약 조건 추가 및 변경, 삭제
-- 제약 조건은 추가와 삭제만 가능, 변경은 X
-- 변경하려면 삭제하고 새롭게 추가해야 한다.
CREATE TABLE
    dept2 (
        dept_no NUMBER(2),  
        dept_name VARCHAR2(14) NOT NULL,
        loca NUMBER(4),
        dept_bonus NUMBER(10),
        dept_gender VARCHAR2(1)
    );
    
-- pk 추가
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_deptno_pk
    PRIMARY KEY
        (dept_no);
    
-- fk 추가
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_loca_locid_kf
    FOREIGN KEY
        (loca)
    REFERENCES
        locations(location_id);
    
-- check 추가
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_bonus_ck
    CHECK
        (dept_bonus > 10000);
    
-- unique 추가
ALTER TABLE
    dept2
ADD CONSTRAINT
    dept2_deptname_uk
    UNIQUE
        (dept_name);
    
-- NOT NULL은 열 수정 형태로 변경
ALTER TABLE
    dept2
MODIFY
    dept_bonus
    NUMBER(10) NOT NULL;
    
    
-- 제약 조건 확인
SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'DEPT2';
    
    
-- 제약 조건 삭제 (제약 조건의 이름으로 -> 이름을 직접 짓지 않았다면 오라클이 부여한 이름을 제시)
ALTER TABLE
    dept2
DROP CONSTRAINT
    dept2_deptno_pk;

