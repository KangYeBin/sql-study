SELECT
    *
FROM
    employees;
    
    
-- WHERE절 비교 (데이터 값은 대/소문자를 구분)
SELECT
    first_name,
    last_name,
    job_id
FROM
    employees
WHERE
    job_id = 'IT_PROG';
    
    
SELECT
    *
FROM
    employees
WHERE
    last_name = 'King';
    

-- 정수 형태는 문자열 형태로 작성해도 자동 형 변환
SELECT
    *
FROM
    employees
WHERE
    department_id = '50';


SELECT
    *
FROM
    employees
WHERE
    salary >= 15000
    AND
    salary < 20000;
    
    
SELECT
    *
FROM
    employees
WHERE
    hire_date = '04/01/30';


-- 데이터의 행 제한 (BETWEEN, IN, LIKE) 
SELECT
    *
FROM
    employees
WHERE
    salary
    BETWEEN
    15000
    AND
    20000;


SELECT
    *
FROM
    employees
WHERE
    hire_date
    BETWEEN
    '03/01/01'
    AND
    '03/12/31';


-- IN 연산자 사용 (특정 값들을 비교할 때 사용)
SELECT
    *
FROM
    employees
WHERE
    manager_id
    IN
    (100, 101, 102);

    
SELECT
    *
FROM
    employees
WHERE
    job_id
    IN
    ('IT_PROG', 'AD_VP');
    
    
-- LIKE 연산자 (지정 문자열 포함 여부)
-- %는 어떠한 문자든, _는 데이터의 자리(위치)를 표현할 때
SELECT
    first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date
    LIKE
    '03%';   -- 03으로 시작하는
    

SELECT
    first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date
    LIKE
    '%15';  -- 15로 끝나는


SELECT
    first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date
    LIKE
    '%05%';  -- 앞뒤 상관없이 05가 포함된
    
    
SELECT
    first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date
    LIKE
    '___05%';    -- 4번째, 5번째 자리수가 05인
    
    
-- NULL은 동등 비교 연산자(=)가 아닌
-- NULL은 IS NULL/IS NOT NULL로 찾기
SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
    
    
SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NOT NULL;


-- AND, OR
-- AND가 OR보다 연산 순서가 빠르기 때문에
-- 'IT_PROG'에서 salary 조건이 제대로 적용되지 않음
SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR
    job_id = 'FI_MGR'
    AND
    salary >= 6000;
    
    
SELECT
    *
FROM
    employees
WHERE
    (job_id = 'IT_PROG'
    OR
    job_id = 'FI_MGR')
    AND
    salary >= 6000;    
    
    
-- 데이터의 정렬 (SELECT 구문의 가장 마지막에 배치)
-- ASC : ascending 오름차순 (기본값, 생략 가능)
-- DESC : descending 내림차순
SELECT
    *
FROM
    employees
ORDER BY
    hire_date ASC;
    
    
SELECT
    *
FROM
    employees
ORDER BY
    hire_date DESC;
    
    
SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
ORDER BY
    employee_id DESC;
    
    
SELECT
    first_name, salary * 12 AS pay
FROM
    employees
ORDER BY
    pay ASC;
