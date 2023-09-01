-- Drop table

-- DROP TABLE main.roles;

CREATE TABLE org.roles (
	idrole serial NOT NULL,
	rolename varchar(50) NULL,
	status integer default 0,
	CONSTRAINT roles_pk PRIMARY KEY (idrole)
);

ALTER TABLE org.roles OWNER TO sadmin;
GRANT ALL ON TABLE org.roles TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE org.roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT 			ON TABLE org.roles TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE org.roles TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE org.roles IS 'Список ролей';
COMMENT ON COLUMN org.roles.rolename   IS 'Наименование';
COMMENT ON COLUMN org.roles.status    IS '0 - активен, 1 - блокирован, 2 - удален';
