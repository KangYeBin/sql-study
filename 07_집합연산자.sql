
-- 집합 연산자
-- 서로 다른 쿼리 결과의 행들을 하나로 결합, 비교, 차이를 구할 수 있게 해 주는 연산자
-- UNION(합집합 중복x), UNION ALL(합집합 중복 o), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입이 정확히 일치해야 합니다.


-- UNION : -- 합집합, 중복 데이터 허용 X
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
    
UNION

SELECT
    employee_id, first_name
FROM
    employees
WHERE
    department_id = 20;
    
    
-- UNION ALL : -- 합집합, 중복 데이터 허용    
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
    
UNION ALL

SELECT
    employee_id, first_name
FROM
    employees
WHERE
    department_id = 20;
    
    
-- INTERSECT : 교집합
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
    
INTERSECT

SELECT
    employee_id, first_name
FROM
    employees
WHERE
    department_id = 20;
    

-- MINUS : 차집합
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
    
MINUS

SELECT
    employee_id, first_name
FROM
    employees
WHERE
    department_id = 20;
    
    
-- 차집합은 같은 두 집합이어도 순서에 따라 결과가 달라진다
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    department_id = 20

MINUS
    
SELECT
    employee_id, first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
