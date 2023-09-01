-- Table: spr.towns

-- DROP TABLE spr.towns;

CREATE TABLE spr.towns
(
  idtown serial NOT NULL,
  name character varying,
  note character varying,
  CONSTRAINT towns_pk PRIMARY KEY (idtown)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE spr.towns OWNER TO admin;
GRANT ALL ON TABLE spr.towns TO admin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.towns TO bst_uprav WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.towns TO bst_user WITH GRANT OPTION;
GRANT SELECT 				ON TABLE spr.towns TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE spr.towns IS 'Список населенных пунктов';
COMMENT ON COLUMN spr.towns.name    IS 'Наименование';
COMMENT ON COLUMN spr.towns.note    IS 'Примечание';
