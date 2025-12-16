-- Adds foreign keys, uniqueness constraints, and basic CHECK constraints.


BEGIN;

------------------------------------------------------------
-- 1) FOREIGN KEY CONSTRAINTS
------------------------------------------------------------

-- sites -> water_bodies
ALTER TABLE sites
  ADD CONSTRAINT fk_sites_water_bodies
  FOREIGN KEY (water_body_id)
  REFERENCES water_bodies (water_body_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- source_docs -> source_organizations
ALTER TABLE source_docs
  ADD CONSTRAINT fk_source_docs_source_organizations
  FOREIGN KEY (source_organization_id)
  REFERENCES source_organizations (source_organization_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- observations -> observation_types
ALTER TABLE observations
  ADD CONSTRAINT fk_observations_observation_types
  FOREIGN KEY (observation_type_id)
  REFERENCES observation_types (observation_type_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- observations -> sites
ALTER TABLE observations
  ADD CONSTRAINT fk_observations_sites
  FOREIGN KEY (site_id)
  REFERENCES sites (site_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- observations -> source_docs
ALTER TABLE observations
  ADD CONSTRAINT fk_observations_source_docs
  FOREIGN KEY (source_doc_id)
  REFERENCES source_docs (source_doc_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- observations -> censor_flags
ALTER TABLE observations
  ADD CONSTRAINT fk_observations_censor_flags
  FOREIGN KEY (censor_flag_id)
  REFERENCES censor_flags (censor_flag_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

-- observations -> qc_statuses
ALTER TABLE observations
  ADD CONSTRAINT fk_observations_qc_statuses
  FOREIGN KEY (qc_status_id)
  REFERENCES qc_statuses (qc_status_id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;


------------------------------------------------------------
-- 2) UNIQUENESS CONSTRAINTS
------------------------------------------------------------

-- Lookup/validation names should be unique
ALTER TABLE observation_types
  ADD CONSTRAINT uq_observation_types_name UNIQUE (observation_type_name);

ALTER TABLE water_bodies
  ADD CONSTRAINT uq_water_bodies_name UNIQUE (water_body_name);

ALTER TABLE source_organizations
  ADD CONSTRAINT uq_source_organizations_name UNIQUE (source_organization_name);

ALTER TABLE qc_statuses
  ADD CONSTRAINT uq_qc_statuses_name UNIQUE (qc_status_name);

ALTER TABLE censor_flags
  ADD CONSTRAINT uq_censor_flags_name UNIQUE (censor_flag_name);

ALTER TABLE sites
  ADD CONSTRAINT uq_sites_name UNIQUE (site_name);

ALTER TABLE source_docs
  ADD CONSTRAINT uq_filename UNIQUE (file_name);


------------------------------------------------------------
-- 3) BASIC CHECK CONSTRAINTS
------------------------------------------------------------

-- Keep latitude/longitude in valid ranges when present
ALTER TABLE sites
  ADD CONSTRAINT ck_sites_latitude_range
  CHECK (site_latitude IS NULL OR (site_latitude >= -90 AND site_latitude <= 90));

ALTER TABLE sites
  ADD CONSTRAINT ck_sites_longitude_range
  CHECK (site_longitude IS NULL OR (site_longitude >= -180 AND site_longitude <= 180));

-- observation_types ranges: if both provided, low <= high
ALTER TABLE observation_types
  ADD CONSTRAINT ck_observation_types_range_order
  CHECK (
    data_range_low IS NULL
    OR data_range_high IS NULL
    OR data_range_low <= data_range_high
  );


COMMIT;