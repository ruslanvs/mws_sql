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
    created_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON schools
FOR EACH ROW EXECUTE PROCEDURE updated_at();

CREATE TABLE students(
    name VARCHAR ( 100 ) NOT NULL,
    score DECIMAL,
    school_id UUID REFERENCES schools,
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
    created_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON students
FOR EACH ROW EXECUTE PROCEDURE updated_at();

-- ******** SEED DATA ********
INSERT INTO schools( title, id )
VALUES
    ( 'Hogwarts', 'f4089392-8763-45e8-9538-c237aee00612' ),
    ( 'Beauxbatons', '2fe005ef-5f0a-413f-8f14-8ace3c2e1c1b' ),
    ( 'Castelobruxo', 'bfc01551-024c-4dfe-88d0-b16ef78f9720' ), 
    ( 'Durmstrang Institute', '29a7c46c-4b83-48d4-8cb7-aa5409687ab0' ),
    ( 'Ilvermorny', '0aae96e2-d1bf-4365-9568-789b11b5cdfe' );

SELECT * FROM schools;

-- ******** UPDATING A RECORD ********
UPDATE schools
SET title = 'CastelobruxoNEW'
WHERE id = 'bfc01551-024c-4dfe-88d0-b16ef78f9720';

UPDATE schools
SET title = 'IlvermornyNEW'
WHERE id = '0aae96e2-d1bf-4365-9568-789b11b5cdfe';

