-- Function: org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean)

-- DROP FUNCTION IF EXISTS org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean);

--CREATE OR REPLACE FUNCTION org.user_create(pulogin character varying, ppas character varying, prole character varying, pnote character varying) RETURNS integer AS
CREATE OR REPLACE FUNCTION org.user_create(	pulogin character varying, 
						ppas character varying, 
						role_values text[], 
						pnote character varying,
						pce character varying,
						pblocked integer,
						plog boolean) RETURNS integer AS
$BODY$ 
-- *************************************************************************************************************************
-- Входные параметры: 	pulogin 	- логин пользователя
--                    	ppas     	- пароль
--			role_values	- массив ролей назначеные пользователю
--			pnote 		- комент к пользователю
--			pce			- 'create' - создание пользователя 'edit' - редактирование
--			pblocked	- >0 - блокировка пользователя 
--			plog		- 1 - вести лог действий пользователя   0-нет
-- Проект: bst
-- Автор: Козловский П. С.
-- Дата: 2021-01-10
-- Описание: Создает пользователя в БД
-- запрос:
-- select org.user_create('ttt2', '111', ARRAY['bst_admin'], 'тест создания роли хранимой процедурой','create',0,true);
-- *************************************************************************************************************************
DECLARE
	result INTEGER;
	pid integer;
	
	i 	integer;
	cur RECORD;
	RoleParamCreate character varying;
	recreate boolean;
	zpass character varying;
	zstatus integer;
BEGIN
	result:=0;
	RAISE INFO ' 01';

	
	--проверяем статус пользователя, если = удален (2) то сохраняем его
	select status into zstatus from org.users WHERE ulogin = pulogin;	
	IF zstatus<>2 THEN 
		zstatus:=pblocked;
	END IF;

	--хешируем пароль в мд5
	zpass:=md5(ppas);
	
	IF (pce='edit') THEN
		IF ppas IS NOT NULL THEN
			--если меняли пароль то необходимо пересоздать роль
			recreate:=true;--RAISE EXCEPTION 'null !';
			EXECUTE 'DROP ROLE ' || pulogin;
		ELSE
			--используем преждний пароль если редактируем запись и пароль не указывали
			select pass into zpass from org.users WHERE ulogin = pulogin;		
			recreate:=false;
		END IF;
	END IF; 

	--пересоздаем запись в таблицу пользователей, получаяя ее ID
	DELETE FROM org.user_roles WHERE ulogin = pulogin;
	DELETE FROM org.users WHERE ulogin = pulogin;

	INSERT INTO org.users (idclient,ulogin,pass,status,note,"log") VALUES (2, pulogin, zpass, pblocked, pnote,plog) RETURNING iduser INTO pid;

	RAISE INFO ' 02';

	-- по умолчанию запрещаем создание ролей пользователю
	RoleParamCreate:='NOCREATEROLE';

	RAISE INFO ' 03';
	
	--формируем список параметров для создания роли/пользователя
	For i in 1..array_length(role_values,1) loop
	
		-- если есть роль админа - то позволяем создавать роли
		if (role_values[i]='bst_admin') THEN
			RoleParamCreate:='CREATEROLE';
		END IF;
		
		RAISE INFO 'обработка роли %',role_values[i];
	end loop;

	RAISE INFO ' 04';

	--если роль создается то создаем записи в таблице
	IF (pce='create') OR (recreate) THEN
		--создаем роль/пользователя
		EXECUTE 'CREATE ROLE '|| pulogin || ' NOSUPERUSER NOCREATEDB '||RoleParamCreate||' INHERIT LOGIN PASSWORD ' || CHR(39) || ppas || CHR(39);
	END IF;

	
	RAISE INFO ' 05';

	--отзываем все наследования ролей (потом их переназначим)
	FOR cur IN select rolename from org.roles where idrole>1
	LOOP
	    RAISE INFO 'Отзываем роль % ', cur.rolename;
	    EXECUTE 'REVOKE '|| cur.rolename ||' FROM ' || pulogin;
	END LOOP;
	
	--GRANTим наследование ролей для вновь созданной и пишем роли в таблицу
	For i in 1..array_length(role_values,1) loop
		EXECUTE 'GRANT ' || role_values[i] || ' TO ' || pulogin;
		INSERT INTO org.user_roles (iduser, ulogin, rolename, userole)	VALUES	(pid, pulogin, role_values[i], true);
	end loop;

	RETURN result;
END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean) OWNER TO sadmin;
GRANT ALL ON FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean) TO sadmin;
COMMENT ON FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean) IS 'Создает пользователя в БД';

GRANT EXECUTE ON FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,boolean) TO bst_admin  WITH GRANT OPTION;
--GRANT EXECUTE ON FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,integer) TO bst_user  WITH GRANT OPTION;
--GRANT EXECUTE ON FUNCTION org.user_create(character varying,character varying,text[],character varying,character varying,integer,integer) TO bst_guest  WITH GRANT OPTION;
