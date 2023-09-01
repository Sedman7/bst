-- Drop table

DROP TABLE spr.scaletype;

CREATE TABLE spr.scaletype (
	idtype serial NOT NULL,
	kod int4 NULL,
	znach varchar NULL,
	note varchar NULL,
	CONSTRAINT scaletype_pk PRIMARY KEY (idtype)
);


ALTER TABLE spr.scaletype OWNER TO sadmin;
GRANT ALL ON TABLE spr.scaletype TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.scaletype TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT 			ON TABLE spr.scaletype TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE spr.scaletype TO bst_guest WITH GRANT OPTION;
REVOKE ALL ON TABLE spr.scaletype FROM public;

COMMENT ON TABLE spr.scaletype IS 'Справочник типы счетчиков';
COMMENT ON COLUMN spr.scaletype.kod   IS 'код 0 - неопределен, 1 - электричество, 2 - вода, 3 - газ';
COMMENT ON COLUMN spr.scaletype.znach    IS 'текстовое значение';