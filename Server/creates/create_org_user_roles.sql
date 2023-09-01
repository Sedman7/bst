-- DROP TABLE org.user_roles;

CREATE TABLE org.user_roles (
	id serial NOT NULL,
	iduser integer NULL,
	ulogin varchar NOT NULL,
	rolename varchar(50) NOT NULL,
	userole boolean NULL DEFAULT false
);

ALTER TABLE org.user_roles OWNER TO sadmin;
GRANT ALL ON TABLE org.user_roles TO sadmin;

GRANT SELECT, UPDATE, INSERT, DELETE 	ON TABLE org.user_roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT 			ON TABLE org.user_roles TO bst_user WITH GRANT OPTION;
GRANT SELECT 							ON TABLE org.user_roles TO bst_guest WITH GRANT OPTION;

COMMENT ON TABLE org.user_roles IS 'роли присвоеные пользователям';
COMMENT ON COLUMN org.user_roles.id IS 'id';
COMMENT ON COLUMN org.user_roles.ulogin IS 'логин пользователя';
COMMENT ON COLUMN org.user_roles.rolename IS 'роль';
COMMENT ON COLUMN org.user_roles.iduser IS 'id пользователя';


