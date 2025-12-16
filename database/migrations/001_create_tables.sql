
-- Creates base tables only (PKs + columns). Foreign keys / additional constraints / indexes in later migrations.

BEGIN;

-- Validation / dimension tables

CREATE TABLE IF NOT EXISTS observation_types (
    observation_type_id  SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    observation_type_name TEXT NOT NULL,
    data_range_low        NUMERIC,
    data_range_high       NUMERIC,
    unit                  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS water_bodies (
    water_body_id   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    water_body_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS source_organizations (
    source_organization_id   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_organization_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS qc_statuses (
    qc_status_id   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    qc_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS censor_flags (
    censor_flag_id   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    censor_flag_name TEXT NOT NULL
);

-- Dimension tables

CREATE TABLE IF NOT EXISTS sites (
    site_id        SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    site_name      TEXT NOT NULL,
    site_latitude  DOUBLE PRECISION,
    site_longitude DOUBLE PRECISION,
    water_body_id  SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS source_docs (
    source_doc_id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_organization_id  SMALLINT NOT NULL,
    file_name               TEXT NOT NULL,
    storage_folder_path     TEXT,
    metadata_link           TEXT,
    etl_processing_datetime TIMESTAMPTZ
);

-- Fact table

CREATE TABLE IF NOT EXISTS observations (
    observation_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    observation_datetime TIMESTAMPTZ NOT NULL,
    observation_value    NUMERIC,
    observation_type_id  SMALLINT NOT NULL,
    site_id              SMALLINT NOT NULL,
    source_doc_id        INTEGER NOT NULL,
    censor_flag_id       SMALLINT,
    qc_status_id         SMALLINT NOT NULL
);

COMMIT;
