
-- 1.
CREATE TABLE
    members (
        m_name VARCHAR(20)
            NOT NULL,
        m_num NUMBER(3)
            CONSTRAINT mem_memnum_pk PRIMARY KEY,
        reg_date DATE
            NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
        gender VARCHAR(1),
        loca NUMBER(4)
            CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
    );
    
INSERT INTO
    members
VALUES
    ('AAA', 1, '2018-07-01', 'M', 1800);

INSERT INTO
    members
VALUES
    ('BBB', 2, '2018-07-02', 'F', 1900);

INSERT INTO
    members
VALUES
    ('CCC', 3, '2018-07-03', 'M', 2000);

INSERT INTO
    members
VALUES
    ('DDD', 4, sysdate, 'M', 2000);


-- 2.
SELECT
    m.m_name, m.m_num,
    loc.street_address, loc.location_id
FROM
    members m
INNER JOIN
    locations loc
ON
    m.loca = loc.location_id
ORDER BY
    m.m_num;

SELECT * FROM members;
