-- Adds initial foreign key indexes 

BEGIN;

-- observations foreign keys
CREATE INDEX idx_observations_site_id
  ON observations (site_id);

CREATE INDEX idx_observations_observation_type_id
  ON observations (observation_type_id);

CREATE INDEX idx_observations_source_doc_id
  ON observations (source_doc_id);

CREATE INDEX idx_observations_qc_status_id
  ON observations (qc_status_id);

CREATE INDEX idx_observations_censor_flag_id
  ON observations (censor_flag_id);

-- source_docs foreign keys
CREATE INDEX idx_source_docs_source_organization_id
  ON source_docs (source_organization_id);

-- sites foreign keys
CREATE INDEX idx_sites_water_body_id
  ON sites (water_body_id);


COMMIT;