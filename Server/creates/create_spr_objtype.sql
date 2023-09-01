-- DROP TABLE spr.objtype;

CREATE TABLE spr.objtype (
	idobjtype serial NOT NULL,
	kod int4 NULL,
	znach varchar NULL,
	note varchar NULL,
	CONSTRAINT objtype_pk PRIMARY KEY (idobjtype)
);


ALTER TABLE spr.objtype OWNER TO sadmin;
GRANT ALL ON TABLE spr.objtype TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.objtype TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT 			ON TABLE spr.objtype TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE spr.objtype TO bst_guest WITH GRANT OPTION;
REVOKE ALL ON TABLE spr.objtype FROM public;

COMMENT ON TABLE spr.objtype IS 'Справочник типы объектов';
COMMENT ON COLUMN spr.objtype.kod   IS 'код';
COMMENT ON COLUMN spr.objtype.znach    IS 'текстовое значение';