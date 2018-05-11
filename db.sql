;
\c test;
DROP DATABASE IF EXISTS mws;
CREATE DATABASE mws;

\c mws;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE FUNCTION updated_at() RETURNS trigger AS $some_name$
    BEGIN
        NEW.updated_at := CURRENT_TIMESTAMP;
        RETURN NEW;
    END;
$some_name$ LANGUAGE plpgsql;

CREATE TABLE schools(
    title VARCHAR ( 100 ) NOT NULL,
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
    is_deleted BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON schools
FOR EACH ROW EXECUTE PROCEDURE updated_at();

CREATE TABLE students(
    name VARCHAR ( 100 ) NOT NULL,
    score DECIMAL,
    school_id UUID REFERENCES schools NOT NULL,
    is_deleted BOOLEAN DEFAULT false,
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
    created_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON students
FOR EACH ROW EXECUTE PROCEDURE updated_at();

-- ******** SEED DATA SCHOOLS ********
INSERT INTO schools( title, id )
VALUES
    ( 'Hogwarts', 'f4089392-8763-45e8-9538-c237aee00612' ),
    ( 'Beauxbatons', '2fe005ef-5f0a-413f-8f14-8ace3c2e1c1b' ),
    ( 'Castelobruxo', 'bfc01551-024c-4dfe-88d0-b16ef78f9720' ),
    ( 'Durmstrang Institute', '29a7c46c-4b83-48d4-8cb7-aa5409687ab0' ),
    ( 'Ilvermorny', '0aae96e2-d1bf-4365-9568-789b11b5cdfe' );

SELECT * FROM schools;

-- ******** UPDATES ********
UPDATE schools
SET title = 'CastelobruxoNEW'
WHERE id = 'bfc01551-024c-4dfe-88d0-b16ef78f9720';

UPDATE schools
SET title = 'IlvermornyNEW'
WHERE id = '0aae96e2-d1bf-4365-9568-789b11b5cdfe';

UPDATE schools
SET is_deleted = true
WHERE id = 'f4089392-8763-45e8-9538-c237aee00612';

INSERT INTO schools( title, id )
VALUES
    ( 'Mahoutokoro School of Magic', '3d25c232-9bbd-44f1-86e9-807140b70ed9' ),
    ( 'Uagadou School of Magic', '29be25fa-79de-4728-8c6b-257857f1a2a2' );

UPDATE schools
SET is_deleted = false
WHERE id = 'f4089392-8763-45e8-9538-c237aee00612';

-- ******** SEED DATA STUDENTS **********

INSERT INTO students( name, score, id, school_id )
VALUES
    ( 'Dana', 91, '56295fa0-0669-4dfb-a183-d57f69961996', 'f4089392-8763-45e8-9538-c237aee00612' ),
    ( 'Tom', 80, '9bc1b8cd-e304-40c5-98c1-9e20a8573e0f', 'f4089392-8763-45e8-9538-c237aee00612' ),
    ( 'Anna', 93, '27c246bb-09fe-4e74-ba13-c6a537c80b9c', '2fe005ef-5f0a-413f-8f14-8ace3c2e1c1b' ),
    ( 'Donna', 99, '86fd91d2-2515-4e18-9fb6-a21268585a6d', '2fe005ef-5f0a-413f-8f14-8ace3c2e1c1b'),
    ( 'Robert', 95, 'aa43601c-8ce2-42de-9e8a-e488df64d682', 'bfc01551-024c-4dfe-88d0-b16ef78f9720' ),
    ( 'Adam', 98, '24623bd3-6bdf-404b-a7e9-ace5358eb7bc', 'bfc01551-024c-4dfe-88d0-b16ef78f9720' );

SELECT * FROM students;

-- ******** UPDATES ********



27c246bb-09fe-4e74-ba13-c6a537c80b9c used
86fd91d2-2515-4e18-9fb6-a21268585a6d used
9bc1b8cd-e304-40c5-98c1-9e20a8573e0f used
56295fa0-0669-4dfb-a183-d57f69961996 used
8b02ae5d-0ae9-4032-b354-0a19710cb49e
f079af94-dba6-4715-8abf-49396935a797
e59bd7de-cc5c-402a-9e18-6806329361df
691973f2-72d8-446e-befb-781e9b27d0fe
1daba1a1-f543-4707-a86c-ffb9fc08be86
a363a85e-2776-46cc-857e-60e18926ee12
5e30cb3b-dca6-4173-bc0a-fc7e1d76d8d7
c110d994-093b-4e2d-b622-b2098fd79ca7
97446c9e-da07-4112-8a6a-eddf28c08953
ba2fd492-9f66-4169-a3dc-79750c200d75
6766e6e4-d1e0-42be-b3df-ac2ee81ad292
09d3f718-21b9-4737-b0c9-322da095eebd
3b66cfc9-2356-43e2-883a-b816b73e9b1c
16f61e43-0ecc-4f46-802d-ea9f291aad8a
7535d4d6-15c0-45e4-818c-4a2e6aed6008
36830965-4a5e-49a2-8c21-d3c9bbb35226
47b78c28-30dc-4a5e-b879-f11ca441d713
a7f6aef7-daa0-4798-af75-5def53cd8b47
ab45a23e-df19-4042-9d04-c387929db1fe
e8ef5403-61cf-45f6-b279-f9a1923e1e96
2fdebdd0-6d84-48c8-8fd8-7a7bdea86c9f

