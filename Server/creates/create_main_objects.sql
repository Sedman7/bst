-- Table: main.objects

-- DROP TABLE main.objects;

CREATE TABLE main.objects
(
    idobject integer NOT NULL DEFAULT nextval('main.objects_idobject_seq'::regclass),
    name character varying COLLATE pg_catalog."default",
    idtown integer,
    idstreet integer,
    dom integer,
    domindex character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT objects_pk PRIMARY KEY (idobject),
    CONSTRAINT objects_fk FOREIGN KEY (idtown)
        REFERENCES main.towns (idtown) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT objects_fk_1 FOREIGN KEY (idstreet)
        REFERENCES main.streets (idstreet) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE main.objects OWNER TO sadmin;
GRANT ALL ON TABLE main.objects TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE main.objects TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE main.objects TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE main.objects TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE main.objects IS 'Список объектов';
COMMENT ON COLUMN main.objects.idobject   IS 'id';
COMMENT ON COLUMN main.objects.name   IS 'Наименование';
COMMENT ON COLUMN main.objects.idtown    IS 'Населенный пункт';
COMMENT ON COLUMN main.objects.idstreet    IS 'Улица';
COMMENT ON COLUMN main.objects.dom    IS 'Дом';
COMMENT ON COLUMN main.objects.domindex    IS 'Индекс дома';