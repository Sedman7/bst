-- Table: spr.streets

-- DROP TABLE spr.streets;

CREATE TABLE spr.streets
(
    idstreet serial NOT NULL,
    name character varying COLLATE pg_catalog."default",
    note character varying COLLATE pg_catalog."default",
    idtown integer,
    CONSTRAINT streets_pk PRIMARY KEY (idstreet),
    CONSTRAINT streets_fk FOREIGN KEY (idtown)
        REFERENCES spr.towns (idtown) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE spr.streets OWNER TO admin;
GRANT ALL ON TABLE spr.streets TO admin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.streets TO bst_uprav WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.streets TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE spr.streets TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE spr.streets IS 'Список улиц';
COMMENT ON COLUMN spr.streets.name    IS 'Название улицы';
COMMENT ON COLUMN spr.streets.note    IS 'Примечание';
COMMENT ON COLUMN spr.streets.idtown  IS 'Привязка к нас. пункту';