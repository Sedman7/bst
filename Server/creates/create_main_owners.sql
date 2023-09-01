-- Table: main.owners

-- DROP TABLE main.owners;

CREATE TABLE main.owners
(
    idowner integer NOT NULL DEFAULT nextval('main.owners_idowner_seq'::regclass),
    idobject integer,
    fam character varying COLLATE pg_catalog."default",
    name character varying COLLATE pg_catalog."default",
    sname character varying COLLATE pg_catalog."default",
    phone character varying COLLATE pg_catalog."default",
    ownertype integer,
    CONSTRAINT pk_owners PRIMARY KEY (idowner),
    CONSTRAINT fk_owners_owners FOREIGN KEY (idobject)
        REFERENCES main.owners (idobject) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE main.owners OWNER TO sadmin;
GRANT ALL ON TABLE main.owners TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE main.owners TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE main.owners TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE main.owners TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE main.owners IS 'Список владельцев/жильцов';
COMMENT ON COLUMN main.owners.idobject    IS 'привязка к объекту';
COMMENT ON COLUMN main.owners.fam    IS 'Фамилия';
COMMENT ON COLUMN main.owners.name    IS 'Имя';
COMMENT ON COLUMN main.owners.sname    IS 'Отчество';
COMMENT ON COLUMN main.owners.phone    IS 'номер телефона';
COMMENT ON COLUMN main.owners.ownertype    IS 'тип';