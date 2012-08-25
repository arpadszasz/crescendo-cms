\connect crescendo;

BEGIN;

DELETE FROM account;

\copy account from STDIN with delimiter ',' csv quote '"'
1,"system.administrator",NULL
2,"crescendo",NULL
\.

COMMIT;
