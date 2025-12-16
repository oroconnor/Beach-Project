-- Seed lookup data 

BEGIN;

INSERT INTO qc_statuses (qc_status_name)
VALUES
  ('valid'),
  ('suspect'),
  ('invalid')
ON CONFLICT (qc_status_name) DO NOTHING;


INSERT INTO censor_flags (censor_flag_name)
VALUES
  ('lt_dl'),     -- less than upper detection limit
  ('gt_ul')     -- greater than upper detection limit
ON CONFLICT (censor_flag_name) DO NOTHING;


COMMIT;