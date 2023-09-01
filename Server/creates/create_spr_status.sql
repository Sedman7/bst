-- Drop table

-- DROP TABLE spr.status;

CREATE TABLE spr.status (
	idstatus serial NOT NULL,
	kod int4 NULL,
	znach varchar NULL,
	CONSTRAINT status_pk PRIMARY KEY (idstatus)
);


ALTER TABLE spr.status OWNER TO sadmin;
GRANT ALL ON TABLE spr.status TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE spr.status TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT 			ON TABLE spr.status TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE spr.status TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE spr.status IS 'состоЯние записи 0 - норм 1 - блок 2 - удалена';
COMMENT ON COLUMN spr.status.kod   IS 'код 0 - активен, 1 - блокирован, 2 - удален';
COMMENT ON COLUMN spr.status.znach    IS 'текстовое значение';
