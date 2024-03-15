
-- 시퀀스 (순차적으로 증가하는 값을 만들어주는 객체)
CREATE SEQUENCE dept2_seq
    START WITH 1    -- 시작값 (시작값을 생략하면 기본값은 증가할 때 최소값, 감소할 때 최대값)
    INCREMENT BY 1  -- 증가값 (양수면 증가, 음수면 감소, 기본값 1)
    MAXVALUE 10     -- 최대값 (기본값은 증가일 때 1027, 감소일 때 -1)
    MINVALUE 1      -- 최소값 (기본값을 증가일 때 1, 감소일 때 -1028)
    NOCACHE         -- 캐시 메모리 사용 여부 (CACHE)
    NOCYCLE;        -- 순환 여부 (NOCYCLE이 기본, 순환 시키려면 CYCLE)
    
    
DROP TABLE
    dept2;

CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR2(13),
    dept_date DATE
);


-- 시퀀스 사용하기 (NEXTVAL, CURRVAL)

-- 현재 시퀀스 값 확인 (한 번 실행 후에 확인 가능)
SELECT
    dept2_seq.CURRVAL
FROM
    dual;


-- INSERT 실행 시 시퀀스의 다음 값을 활용
INSERT INTO
    dept2
VALUES
    (dept2_seq.NEXTVAL, 'test', 'test', sysdate);

SELECT * FROM dept2;


-- 시퀀스 속성 수정 (직접 수정 가능)
-- START WITH는 수정 불가능
ALTER SEQUENCE
    dept2_seq
    MAXVALUE 9999; -- 최대값 증가

ALTER SEQUENCE
    dept2_seq
    INCREMENT BY 10; -- 증가값 변경

ALTER SEQUENCE
    dept2_seq
    MINVALUE 0; -- 최소값 변경


-- 시퀀스 값을 다시 처음으로 돌리는 방법
-- 1.
ALTER SEQUENCE
    dept2_seq
    INCREMENT BY -22;   -- 기존 시퀀스 값만큼 마이너스하고

SELECT
    dept2_seq.NEXTVAL
FROM
    dual;

ALTER SEQUENCE
    dept2_seq
    INCREMENT BY 1; -- 다시 1씩 증가

-- 2. 지우고 다시 만들기
DROP SEQUENCE
    dept2_seq;

--------------------------------------------------------------------------------

/*
    - index
    index는 primary key, unique 제약 조건에서 자동으로 생성되고,
    조회를 빠르게 해 주는 hint 역할을 한다.
    index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
    오히려 성능 부하를 일으킬 수 있다.
    정말 필요할 때만 index를 사용하는 것이 바람직.
*/
SELECT
    *
FROM
    employees
WHERE
    employee_id = 158;

    
-- 인덱스 생성
CREATE INDEX
    emp_salary_idx
ON
    employees(salary);


/*
    테이블 조회 시 인덱스가 붙은 컬럼을 조건절로 사용한다면
    테이블 전체 조회가 아닌, 컬럼에 붙은 인덱스를 이용해서 조회를 진행합니다.
    인덱스를 생성하게 되면 지정한 컬럼에 ROWID를 붙인 인덱스가 준비되고, 
    조회를 진행할 시 해당 인덱스의 ROWID를 통해 빠른 스캔을 가능하게 합니다.
*/

DROP INDEX emp_salary_idx;

/*
    - 인덱스가 권장되는 경우 
    1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
    2. 열이 광범위한 값을 포함하는 경우
    3. 테이블이 대형인 경우
    4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
    5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는 권장하지 않는다.
*/
