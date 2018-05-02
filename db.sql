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
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON schools
FOR EACH ROW EXECUTE PROCEDURE updated_at();

CREATE TABLE students(
    name VARCHAR ( 100 ) NOT NULL,
    score DECIMAL,
    school_id UUID REFERENCES schools,
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER updated_at BEFORE UPDATE ON students
FOR EACH ROW EXECUTE PROCEDURE updated_at();

-- ******** SEED DATA ********
INSERT INTO schools( title )
VALUES
    ( 'Hogwarts' ),
    ( 'Beauxbatons' ),
    ( 'Castelobruxo' ), 
    ( 'Durmstrang Institute' ),
    ( 'Ilvermorny' );

SELECT * FROM schools;