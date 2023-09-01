-- Function: org.user_delete(character varying,boolean)

-- DROP FUNCTION IF EXISTS org.user_delete(character varying,boolean);

--CREATE OR REPLACE FUNCTION org.user_delete(pulogin character varying, ppas character varying, prole character varying, pnote character varying) RETURNS integer AS
CREATE OR REPLACE FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) RETURNS integer AS
$BODY$ 
-- *************************************************************************************************************************
-- Входные параметры: 	pulogin 	- логин пользователя
--                    	pfulldelete - удалить физически из базы
-- Проект: bst
-- Автор: Козловский П. С.
-- Дата: 2021-01-10
-- Описание: Удаление пользователя
-- запрос:
-- select org.user_delete('ttt2', '111', ARRAY['bst_admin'], 'тест создания роли хранимой процедурой','create',0,true);
-- *************************************************************************************************************************
DECLARE
	result INTEGER;
BEGIN
	result:=0;
	RAISE INFO ' 01';

	IF (pfulldelete)THEN
		EXECUTE 'DROP ROLE ' || pulogin;

		DELETE FROM org.user_roles WHERE ulogin = pulogin;
		DELETE FROM org.users WHERE ulogin = pulogin;
	ELSE	
		UPDATE org.users SET status = 2 WHERE ulogin = pulogin;
	END IF; 

	RETURN result;
END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION org.user_delete(character varying,boolean) OWNER TO sadmin;
GRANT ALL ON FUNCTION org.user_delete(character varying,boolean) TO sadmin;
COMMENT ON FUNCTION org.user_delete(character varying,boolean) IS 'Создает пользователя в БД';

GRANT EXECUTE ON FUNCTION org.user_delete(character varying,boolean) TO bst_admin  WITH GRANT OPTION;
--GRANT EXECUTE ON FUNCTION org.user_delete(character varying,character varying,text[],character varying,character varying,integer,integer) TO bst_user  WITH GRANT OPTION;
--GRANT EXECUTE ON FUNCTION org.user_delete(character varying,character varying,text[],character varying,character varying,integer,integer) TO bst_guest  WITH GRANT OPTION;
