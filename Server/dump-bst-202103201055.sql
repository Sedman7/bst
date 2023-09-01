PGDMP           7    
            y            bst    9.5.24    12.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16413    bst    DATABASE     s   CREATE DATABASE bst WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';
    DROP DATABASE bst;
                postgres    false                        2615    16414    main    SCHEMA        CREATE SCHEMA main;
    DROP SCHEMA main;
                postgres    false            �           0    0    SCHEMA main    COMMENT     P   COMMENT ON SCHEMA main IS 'основные рабочие материалы';
                   postgres    false    8            �           0    0    SCHEMA main    ACL     3  REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO test;
GRANT USAGE ON SCHEMA main TO aaa;
GRANT ALL ON SCHEMA main TO bst_admin;
GRANT USAGE ON SCHEMA main TO bst_user;
GRANT USAGE ON SCHEMA main TO bst_guest;
                   postgres    false    8            
            2615    16529    org    SCHEMA        CREATE SCHEMA org;
    DROP SCHEMA org;
                postgres    false            �           0    0 
   SCHEMA org    COMMENT     y   COMMENT ON SCHEMA org IS 'организационные таблицы, роли, пользователи и тд...';
                   postgres    false    10            �           0    0 
   SCHEMA org    ACL     �   REVOKE ALL ON SCHEMA org FROM PUBLIC;
REVOKE ALL ON SCHEMA org FROM postgres;
GRANT ALL ON SCHEMA org TO postgres;
GRANT ALL ON SCHEMA org TO bst_admin;
GRANT ALL ON SCHEMA org TO bst_user;
GRANT USAGE ON SCHEMA org TO bst_guest;
                   postgres    false    10                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    6            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    6            	            2615    16606    spr    SCHEMA        CREATE SCHEMA spr;
    DROP SCHEMA spr;
                postgres    false            �           0    0 
   SCHEMA spr    ACL     �   REVOKE ALL ON SCHEMA spr FROM PUBLIC;
REVOKE ALL ON SCHEMA spr FROM postgres;
GRANT ALL ON SCHEMA spr TO postgres;
GRANT ALL ON SCHEMA spr TO bst_admin;
GRANT ALL ON SCHEMA spr TO bst_user;
GRANT USAGE ON SCHEMA spr TO bst_guest;
                   postgres    false    9            �            1255    16815 `   object_create(character varying, integer, integer, integer, character varying, integer, integer)    FUNCTION     x  CREATE FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
-- *************************************************************************************************************************
-- Входные параметры: 	pname 		- наименование объекта
--                    	pidtown 	- id города 
--						pidstreet 	- id улицы 
--						pdom 		- № дома
--						pdomindex 	- буквенный индекс дома
--						pdomkorp 	- корпус
--						pobjtype 	- тип объекта
-- Проект: bst
-- Автор: Козловский П. С.
-- Дата: 2021-02-13
-- Описание: Создает объект в БД
-- запрос:
-- select main.object_create('ttt2', '111', ARRAY['bst_admin'], 'тест создания роли хранимой процедурой','create',0,true);
-- *************************************************************************************************************************
DECLARE
	result INTEGER;
BEGIN
	result:=0;

	INSERT INTO main.objects ("name",idtown, idstreet, dom, domindex, domkorp, objtype) 
					VALUES (  pname, pidtown,pidstreet,pdom,pdomindex,pdomkorp,pobjtype) 
	RETURNING idobject INTO result;

	RETURN result;
END;
$$;
 �   DROP FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer);
       main          sadmin    false    8            �           0    0 �   FUNCTION object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer)    COMMENT     �   COMMENT ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) IS 'Создает объект в БД';
          main          sadmin    false    222            �           0    0 �   FUNCTION object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer)    ACL     �  REVOKE ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) FROM sadmin;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO sadmin;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO PUBLIC;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO bst_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO bst_user WITH GRANT OPTION;
          main          sadmin    false    222            �            1255    16764    get_value(text, text[], "char")    FUNCTION     �  CREATE FUNCTION org.get_value(param text, reloptions text[], relkind "char") RETURNS double precision
    LANGUAGE sql
    AS $$
  SELECT coalesce(
    -- если параметр хранения задан, то берем его
    (SELECT option_value
     FROM   pg_options_to_table(reloptions)
     WHERE  option_name = CASE
              -- для toast-таблиц имя параметра отличается
              WHEN relkind = 't' THEN 'toast.' ELSE ''
            END || param
    ),
    -- иначе берем значение конфигурационного параметра
    current_setting(param)
  )::float;
$$;
 L   DROP FUNCTION org.get_value(param text, reloptions text[], relkind "char");
       org          sadmin    false    10            �            1255    16693 q   user_create(character varying, character varying, text[], character varying, character varying, integer, boolean)    FUNCTION     �  CREATE FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
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
$$;
 �   DROP FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean);
       org          sadmin    false    10            �           0    0 �   FUNCTION user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean)    COMMENT     �   COMMENT ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) IS 'Создает пользователя в БД';
          org          sadmin    false    223            �           0    0 �   FUNCTION user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean)    ACL       REVOKE ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) FROM sadmin;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO sadmin;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO PUBLIC;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO bst_admin WITH GRANT OPTION;
          org          sadmin    false    223            �            1255    16813 '   user_delete(character varying, boolean)    FUNCTION     �  CREATE FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
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
$$;
 O   DROP FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean);
       org          sadmin    false    10            �           0    0 D   FUNCTION user_delete(pulogin character varying, pfulldelete boolean)    COMMENT     �   COMMENT ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) IS 'Создает пользователя в БД';
          org          sadmin    false    221            �           0    0 D   FUNCTION user_delete(pulogin character varying, pfulldelete boolean)    ACL        REVOKE ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) FROM sadmin;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO sadmin;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO PUBLIC;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO bst_admin WITH GRANT OPTION;
          org          sadmin    false    221            �            1259    16417    objects    TABLE       CREATE TABLE main.objects (
    idobject integer NOT NULL,
    name character varying,
    idtown integer,
    idstreet integer,
    dom integer,
    domindex character varying(15),
    domkorp integer,
    objtype integer,
    datecor timestamp(0) without time zone DEFAULT now()
);
    DROP TABLE main.objects;
       main            sadmin    false    8            �           0    0    TABLE objects    COMMENT     B   COMMENT ON TABLE main.objects IS 'Список объектов';
          main          sadmin    false    185            �           0    0    COLUMN objects.idobject    COMMENT     1   COMMENT ON COLUMN main.objects.idobject IS 'id';
          main          sadmin    false    185            �           0    0    COLUMN objects.name    COMMENT     C   COMMENT ON COLUMN main.objects.name IS 'Наименование';
          main          sadmin    false    185            �           0    0    COLUMN objects.idtown    COMMENT     L   COMMENT ON COLUMN main.objects.idtown IS 'Населенный пункт';
          main          sadmin    false    185            �           0    0    COLUMN objects.idstreet    COMMENT     9   COMMENT ON COLUMN main.objects.idstreet IS 'Улица';
          main          sadmin    false    185            �           0    0    COLUMN objects.dom    COMMENT     0   COMMENT ON COLUMN main.objects.dom IS 'Дом';
          main          sadmin    false    185            �           0    0    COLUMN objects.domindex    COMMENT     D   COMMENT ON COLUMN main.objects.domindex IS 'Индекс дома';
          main          sadmin    false    185            �           0    0    TABLE objects    ACL     y  REVOKE ALL ON TABLE main.objects FROM PUBLIC;
REVOKE ALL ON TABLE main.objects FROM sadmin;
GRANT ALL ON TABLE main.objects TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.objects TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.objects TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.objects TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    185            �            1259    16415    objects_idobject_seq    SEQUENCE     {   CREATE SEQUENCE main.objects_idobject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE main.objects_idobject_seq;
       main          sadmin    false    185    8            �           0    0    objects_idobject_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE main.objects_idobject_seq OWNED BY main.objects.idobject;
          main          sadmin    false    184            �           0    0    SEQUENCE objects_idobject_seq    ACL     V  REVOKE ALL ON SEQUENCE main.objects_idobject_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE main.objects_idobject_seq FROM sadmin;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO sadmin;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO bst_admin WITH GRANT OPTION;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO bst_user WITH GRANT OPTION;
          main          sadmin    false    184            �            1259    16439    owners    TABLE     �   CREATE TABLE main.owners (
    idowner integer NOT NULL,
    idobject integer,
    fam character varying,
    name character varying,
    sname character varying,
    phone character varying,
    ownertype integer
);
    DROP TABLE main.owners;
       main            sadmin    false    8            �           0    0    TABLE owners    COMMENT     T   COMMENT ON TABLE main.owners IS 'Список владельцев/жильцов';
          main          sadmin    false    187            �           0    0    COLUMN owners.idobject    COMMENT     P   COMMENT ON COLUMN main.owners.idobject IS 'привязка к объекту';
          main          sadmin    false    187            �           0    0    COLUMN owners.fam    COMMENT     7   COMMENT ON COLUMN main.owners.fam IS 'Фамилия';
          main          sadmin    false    187            �           0    0    COLUMN owners.name    COMMENT     0   COMMENT ON COLUMN main.owners.name IS 'Имя';
          main          sadmin    false    187            �           0    0    COLUMN owners.sname    COMMENT     ;   COMMENT ON COLUMN main.owners.sname IS 'Отчество';
          main          sadmin    false    187            �           0    0    COLUMN owners.phone    COMMENT     F   COMMENT ON COLUMN main.owners.phone IS 'номер телефона';
          main          sadmin    false    187            �           0    0    COLUMN owners.ownertype    COMMENT     5   COMMENT ON COLUMN main.owners.ownertype IS 'тип';
          main          sadmin    false    187             	           0    0    TABLE owners    ACL     s  REVOKE ALL ON TABLE main.owners FROM PUBLIC;
REVOKE ALL ON TABLE main.owners FROM sadmin;
GRANT ALL ON TABLE main.owners TO sadmin;
GRANT SELECT ON TABLE main.owners TO bst_guest WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.owners TO bst_user WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.owners TO bst_admin WITH GRANT OPTION;
          main          sadmin    false    187            �            1259    16437    owners_idowner_seq    SEQUENCE     y   CREATE SEQUENCE main.owners_idowner_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE main.owners_idowner_seq;
       main          sadmin    false    8    187            	           0    0    owners_idowner_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE main.owners_idowner_seq OWNED BY main.owners.idowner;
          main          sadmin    false    186            �            1259    16455    scales    TABLE     �   CREATE TABLE main.scales (
    idscale integer NOT NULL,
    idobject integer,
    kvt numeric(10,1),
    note character varying,
    dateview date DEFAULT now(),
    scalenumber character varying(50),
    scaletype integer
);
    DROP TABLE main.scales;
       main            sammy    false    8            	           0    0    COLUMN scales.idobject    COMMENT     P   COMMENT ON COLUMN main.scales.idobject IS 'Привязка к объекту';
          main          sammy    false    189            	           0    0    COLUMN scales.kvt    COMMENT     ;   COMMENT ON COLUMN main.scales.kvt IS 'Показания';
          main          sammy    false    189            	           0    0    COLUMN scales.note    COMMENT     8   COMMENT ON COLUMN main.scales.note IS 'Коммент';
          main          sammy    false    189            	           0    0    COLUMN scales.scalenumber    COMMENT     L   COMMENT ON COLUMN main.scales.scalenumber IS 'Номер счетчика';
          main          sammy    false    189            	           0    0    COLUMN scales.scaletype    COMMENT     m   COMMENT ON COLUMN main.scales.scaletype IS 'Тип счетчика 1-электр. 2 - вода, 3-газ';
          main          sammy    false    189            �            1259    16453    scales_idscale_seq    SEQUENCE     y   CREATE SEQUENCE main.scales_idscale_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE main.scales_idscale_seq;
       main          sammy    false    189    8            	           0    0    scales_idscale_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE main.scales_idscale_seq OWNED BY main.scales.idscale;
          main          sammy    false    188            �            1259    16490    streets    TABLE     �   CREATE TABLE main.streets (
    idstreet integer NOT NULL,
    name character varying,
    note character varying,
    idtown integer
);
    DROP TABLE main.streets;
       main            sadmin    false    8            	           0    0    TABLE streets    COMMENT     :   COMMENT ON TABLE main.streets IS 'Список улиц';
          main          sadmin    false    193            		           0    0    COLUMN streets.name    COMMENT     F   COMMENT ON COLUMN main.streets.name IS 'Название улицы';
          main          sadmin    false    193            
	           0    0    COLUMN streets.note    COMMENT     ?   COMMENT ON COLUMN main.streets.note IS 'Примечание';
          main          sadmin    false    193            	           0    0    COLUMN streets.idtown    COMMENT     U   COMMENT ON COLUMN main.streets.idtown IS 'Привязка к нас. пункту';
          main          sadmin    false    193            	           0    0    TABLE streets    ACL     y  REVOKE ALL ON TABLE main.streets FROM PUBLIC;
REVOKE ALL ON TABLE main.streets FROM sadmin;
GRANT ALL ON TABLE main.streets TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.streets TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.streets TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.streets TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    193            �            1259    16488    streets_idstreet_seq    SEQUENCE     {   CREATE SEQUENCE main.streets_idstreet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE main.streets_idstreet_seq;
       main          sadmin    false    193    8            	           0    0    streets_idstreet_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE main.streets_idstreet_seq OWNED BY main.streets.idstreet;
          main          sadmin    false    192            �            1259    16479    towns    TABLE     q   CREATE TABLE main.towns (
    idtown integer NOT NULL,
    name character varying,
    note character varying
);
    DROP TABLE main.towns;
       main            sadmin    false    8            	           0    0    TABLE towns    ACL     m  REVOKE ALL ON TABLE main.towns FROM PUBLIC;
REVOKE ALL ON TABLE main.towns FROM sadmin;
GRANT ALL ON TABLE main.towns TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.towns TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.towns TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.towns TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    191            �            1259    16477    towns_idtown_seq    SEQUENCE     w   CREATE SEQUENCE main.towns_idtown_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE main.towns_idtown_seq;
       main          sadmin    false    191    8            	           0    0    towns_idtown_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE main.towns_idtown_seq OWNED BY main.towns.idtown;
          main          sadmin    false    190            �            1259    16532    clients    TABLE     X   CREATE TABLE org.clients (
    idclient integer NOT NULL,
    name character varying
);
    DROP TABLE org.clients;
       org            test    false    10            �            1259    16530    clients_idclient_seq    SEQUENCE     z   CREATE SEQUENCE org.clients_idclient_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE org.clients_idclient_seq;
       org          test    false    195    10            	           0    0    clients_idclient_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE org.clients_idclient_seq OWNED BY org.clients.idclient;
          org          test    false    194            	           0    0    SEQUENCE clients_idclient_seq    ACL     �   REVOKE ALL ON SEQUENCE org.clients_idclient_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.clients_idclient_seq FROM test;
GRANT ALL ON SEQUENCE org.clients_idclient_seq TO test;
GRANT ALL ON SEQUENCE org.clients_idclient_seq TO bst_admin;
          org          test    false    194            �            1259    16765    need_vacuum    VIEW     �  CREATE VIEW org.need_vacuum AS
 SELECT (((st.schemaname)::text || '.'::text) || (st.relname)::text) AS tablename,
    st.n_dead_tup AS dead_tup,
    (org.get_value('autovacuum_vacuum_threshold'::text, c.reloptions, c.relkind) + (org.get_value('autovacuum_vacuum_scale_factor'::text, c.reloptions, c.relkind) * c.reltuples)) AS max_dead_tup,
    st.last_autovacuum
   FROM pg_stat_all_tables st,
    pg_class c
  WHERE ((c.oid = st.relid) AND (c.relkind = ANY (ARRAY['r'::"char", 'm'::"char", 't'::"char"])));
    DROP VIEW org.need_vacuum;
       org          sadmin    false    224    10            �            1259    16582    roles    TABLE     �   CREATE TABLE org.roles (
    idrole integer NOT NULL,
    rolename character varying(50),
    status integer DEFAULT 0,
    describe character varying(250)
);
    DROP TABLE org.roles;
       org            sadmin    false    10            	           0    0    TABLE roles    COMMENT     9   COMMENT ON TABLE org.roles IS 'Список ролей';
          org          sadmin    false    199            	           0    0    COLUMN roles.rolename    COMMENT     D   COMMENT ON COLUMN org.roles.rolename IS 'Наименование';
          org          sadmin    false    199            	           0    0    COLUMN roles.status    COMMENT     h   COMMENT ON COLUMN org.roles.status IS '0 - активен, 1 - блокирован, 2 - удален';
          org          sadmin    false    199            	           0    0    TABLE roles    ACL     `  REVOKE ALL ON TABLE org.roles FROM PUBLIC;
REVOKE ALL ON TABLE org.roles FROM sadmin;
GRANT ALL ON TABLE org.roles TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.roles TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.roles TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    199            �            1259    16580    roles_idrole_seq    SEQUENCE     v   CREATE SEQUENCE org.roles_idrole_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE org.roles_idrole_seq;
       org          sadmin    false    199    10            	           0    0    roles_idrole_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE org.roles_idrole_seq OWNED BY org.roles.idrole;
          org          sadmin    false    198            	           0    0    SEQUENCE roles_idrole_seq    ACL     �   REVOKE ALL ON SEQUENCE org.roles_idrole_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.roles_idrole_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.roles_idrole_seq TO sadmin;
GRANT ALL ON SEQUENCE org.roles_idrole_seq TO bst_admin;
          org          sadmin    false    198            �            1259    16637 
   user_roles    TABLE     �   CREATE TABLE org.user_roles (
    id integer NOT NULL,
    iduser integer,
    ulogin character varying NOT NULL,
    rolename character varying(50) NOT NULL,
    userole boolean DEFAULT false
);
    DROP TABLE org.user_roles;
       org            sadmin    false    10            	           0    0    TABLE user_roles    COMMENT     _   COMMENT ON TABLE org.user_roles IS 'роли присвоеные пользователям';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.id    COMMENT     -   COMMENT ON COLUMN org.user_roles.id IS 'id';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.iduser    COMMENT     J   COMMENT ON COLUMN org.user_roles.iduser IS 'id пользователя';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.ulogin    COMMENT     R   COMMENT ON COLUMN org.user_roles.ulogin IS 'логин пользователя';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.rolename    COMMENT     9   COMMENT ON COLUMN org.user_roles.rolename IS 'роль';
          org          sadmin    false    203            	           0    0    TABLE user_roles    ACL     ~  REVOKE ALL ON TABLE org.user_roles FROM PUBLIC;
REVOKE ALL ON TABLE org.user_roles FROM sadmin;
GRANT ALL ON TABLE org.user_roles TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.user_roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.user_roles TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.user_roles TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    203            �            1259    16635    user_roles_id_seq    SEQUENCE     w   CREATE SEQUENCE org.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE org.user_roles_id_seq;
       org          sadmin    false    203    10            	           0    0    user_roles_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE org.user_roles_id_seq OWNED BY org.user_roles.id;
          org          sadmin    false    202            	           0    0    SEQUENCE user_roles_id_seq    ACL     �   REVOKE ALL ON SEQUENCE org.user_roles_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.user_roles_id_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.user_roles_id_seq TO sadmin;
GRANT ALL ON SEQUENCE org.user_roles_id_seq TO bst_admin;
          org          sadmin    false    202            �            1259    16541    users    TABLE        CREATE TABLE org.users (
    iduser integer NOT NULL,
    idclient integer,
    ulogin character varying,
    pass character varying,
    regdate timestamp(0) without time zone DEFAULT now(),
    status integer DEFAULT 0,
    note character varying(1000),
    log boolean DEFAULT true
);
    DROP TABLE org.users;
       org            sadmin    false    10             	           0    0    TABLE users    COMMENT     I   COMMENT ON TABLE org.users IS 'Список пользователей';
          org          sadmin    false    197            !	           0    0    COLUMN users.idclient    COMMENT     N   COMMENT ON COLUMN org.users.idclient IS 'Привязка к клиенту';
          org          sadmin    false    197            "	           0    0    COLUMN users.ulogin    COMMENT     4   COMMENT ON COLUMN org.users.ulogin IS 'Логин';
          org          sadmin    false    197            #	           0    0    COLUMN users.pass    COMMENT     8   COMMENT ON COLUMN org.users.pass IS 'пароль md5';
          org          sadmin    false    197            $	           0    0    COLUMN users.regdate    COMMENT     J   COMMENT ON COLUMN org.users.regdate IS 'дата регистрации';
          org          sadmin    false    197            %	           0    0    COLUMN users.status    COMMENT     h   COMMENT ON COLUMN org.users.status IS '0 - активен, 1 - блокирован, 2 - удален';
          org          sadmin    false    197            &	           0    0    TABLE users    ACL     `  REVOKE ALL ON TABLE org.users FROM PUBLIC;
REVOKE ALL ON TABLE org.users FROM sadmin;
GRANT ALL ON TABLE org.users TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.users TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.users TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.users TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    197            �            1259    16539    users_iduser_seq    SEQUENCE     v   CREATE SEQUENCE org.users_iduser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE org.users_iduser_seq;
       org          sadmin    false    197    10            '	           0    0    users_iduser_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE org.users_iduser_seq OWNED BY org.users.iduser;
          org          sadmin    false    196            (	           0    0    SEQUENCE users_iduser_seq    ACL     �   REVOKE ALL ON SEQUENCE org.users_iduser_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.users_iduser_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.users_iduser_seq TO sadmin;
GRANT ALL ON SEQUENCE org.users_iduser_seq TO bst_admin;
          org          sadmin    false    196            �            1259    16799    objtype    TABLE     �   CREATE TABLE spr.objtype (
    idobjtype integer NOT NULL,
    kod integer,
    znach character varying,
    note character varying
);
    DROP TABLE spr.objtype;
       spr            sadmin    false    9            )	           0    0    TABLE objtype    COMMENT     R   COMMENT ON TABLE spr.objtype IS 'Справочник типы объектов';
          spr          sadmin    false    208            *	           0    0    COLUMN objtype.kod    COMMENT     /   COMMENT ON COLUMN spr.objtype.kod IS 'код';
          spr          sadmin    false    208            +	           0    0    COLUMN objtype.znach    COMMENT     N   COMMENT ON COLUMN spr.objtype.znach IS 'текстовое значение';
          spr          sadmin    false    208            ,	           0    0    TABLE objtype    ACL     l  REVOKE ALL ON TABLE spr.objtype FROM PUBLIC;
REVOKE ALL ON TABLE spr.objtype FROM sadmin;
GRANT ALL ON TABLE spr.objtype TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.objtype TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.objtype TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.objtype TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    208            �            1259    16797    objtype_idobjtype_seq    SEQUENCE     {   CREATE SEQUENCE spr.objtype_idobjtype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE spr.objtype_idobjtype_seq;
       spr          sadmin    false    208    9            -	           0    0    objtype_idobjtype_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE spr.objtype_idobjtype_seq OWNED BY spr.objtype.idobjtype;
          spr          sadmin    false    207            �            1259    16785 	   scaletype    TABLE     �   CREATE TABLE spr.scaletype (
    idtype integer NOT NULL,
    kod integer,
    znach character varying,
    note character varying
);
    DROP TABLE spr.scaletype;
       spr            sadmin    false    9            .	           0    0    TABLE scaletype    COMMENT     V   COMMENT ON TABLE spr.scaletype IS 'Справочник типы счетчиков';
          spr          sadmin    false    206            /	           0    0    COLUMN scaletype.kod    COMMENT     �   COMMENT ON COLUMN spr.scaletype.kod IS 'код 0 - неопределен, 1 - электричество, 2 - вода, 3 - газ';
          spr          sadmin    false    206            0	           0    0    COLUMN scaletype.znach    COMMENT     P   COMMENT ON COLUMN spr.scaletype.znach IS 'текстовое значение';
          spr          sadmin    false    206            1	           0    0    TABLE scaletype    ACL     x  REVOKE ALL ON TABLE spr.scaletype FROM PUBLIC;
REVOKE ALL ON TABLE spr.scaletype FROM sadmin;
GRANT ALL ON TABLE spr.scaletype TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.scaletype TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.scaletype TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.scaletype TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    206            �            1259    16783    scaletype_idtype_seq    SEQUENCE     z   CREATE SEQUENCE spr.scaletype_idtype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE spr.scaletype_idtype_seq;
       spr          sadmin    false    206    9            2	           0    0    scaletype_idtype_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE spr.scaletype_idtype_seq OWNED BY spr.scaletype.idtype;
          spr          sadmin    false    205            3	           0    0    SEQUENCE scaletype_idtype_seq    ACL     -  REVOKE ALL ON SEQUENCE spr.scaletype_idtype_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE spr.scaletype_idtype_seq FROM sadmin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO sadmin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO bst_admin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO bst_user;
          spr          sadmin    false    205            �            1259    16609    status    TABLE     r   CREATE TABLE spr.status (
    idstatus integer NOT NULL,
    kod integer NOT NULL,
    znach character varying
);
    DROP TABLE spr.status;
       spr            sadmin    false    9            4	           0    0    TABLE status    COMMENT     o   COMMENT ON TABLE spr.status IS 'состояние записи 0 - норм 1 - блок 2 - удалена';
          spr          sadmin    false    201            5	           0    0    COLUMN status.kod    COMMENT     m   COMMENT ON COLUMN spr.status.kod IS 'код 0 - активен, 1 - блокирован, 2 - удален';
          spr          sadmin    false    201            6	           0    0    COLUMN status.znach    COMMENT     M   COMMENT ON COLUMN spr.status.znach IS 'текстовое значение';
          spr          sadmin    false    201            7	           0    0    TABLE status    ACL     f  REVOKE ALL ON TABLE spr.status FROM PUBLIC;
REVOKE ALL ON TABLE spr.status FROM sadmin;
GRANT ALL ON TABLE spr.status TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.status TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.status TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.status TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    201            �            1259    16607    status_idstatus_seq    SEQUENCE     y   CREATE SEQUENCE spr.status_idstatus_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE spr.status_idstatus_seq;
       spr          sadmin    false    201    9            8	           0    0    status_idstatus_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE spr.status_idstatus_seq OWNED BY spr.status.idstatus;
          spr          sadmin    false    200                       2604    16420    objects idobject    DEFAULT     p   ALTER TABLE ONLY main.objects ALTER COLUMN idobject SET DEFAULT nextval('main.objects_idobject_seq'::regclass);
 =   ALTER TABLE main.objects ALTER COLUMN idobject DROP DEFAULT;
       main          sadmin    false    185    184    185                       2604    16442    owners idowner    DEFAULT     l   ALTER TABLE ONLY main.owners ALTER COLUMN idowner SET DEFAULT nextval('main.owners_idowner_seq'::regclass);
 ;   ALTER TABLE main.owners ALTER COLUMN idowner DROP DEFAULT;
       main          sadmin    false    186    187    187                       2604    16458    scales idscale    DEFAULT     l   ALTER TABLE ONLY main.scales ALTER COLUMN idscale SET DEFAULT nextval('main.scales_idscale_seq'::regclass);
 ;   ALTER TABLE main.scales ALTER COLUMN idscale DROP DEFAULT;
       main          sammy    false    189    188    189                       2604    16493    streets idstreet    DEFAULT     p   ALTER TABLE ONLY main.streets ALTER COLUMN idstreet SET DEFAULT nextval('main.streets_idstreet_seq'::regclass);
 =   ALTER TABLE main.streets ALTER COLUMN idstreet DROP DEFAULT;
       main          sadmin    false    193    192    193                       2604    16482    towns idtown    DEFAULT     h   ALTER TABLE ONLY main.towns ALTER COLUMN idtown SET DEFAULT nextval('main.towns_idtown_seq'::regclass);
 9   ALTER TABLE main.towns ALTER COLUMN idtown DROP DEFAULT;
       main          sadmin    false    190    191    191                       2604    16535    clients idclient    DEFAULT     n   ALTER TABLE ONLY org.clients ALTER COLUMN idclient SET DEFAULT nextval('org.clients_idclient_seq'::regclass);
 <   ALTER TABLE org.clients ALTER COLUMN idclient DROP DEFAULT;
       org          test    false    195    194    195            #           2604    16585    roles idrole    DEFAULT     f   ALTER TABLE ONLY org.roles ALTER COLUMN idrole SET DEFAULT nextval('org.roles_idrole_seq'::regclass);
 8   ALTER TABLE org.roles ALTER COLUMN idrole DROP DEFAULT;
       org          sadmin    false    199    198    199            &           2604    16640    user_roles id    DEFAULT     h   ALTER TABLE ONLY org.user_roles ALTER COLUMN id SET DEFAULT nextval('org.user_roles_id_seq'::regclass);
 9   ALTER TABLE org.user_roles ALTER COLUMN id DROP DEFAULT;
       org          sadmin    false    202    203    203                       2604    16544    users iduser    DEFAULT     f   ALTER TABLE ONLY org.users ALTER COLUMN iduser SET DEFAULT nextval('org.users_iduser_seq'::regclass);
 8   ALTER TABLE org.users ALTER COLUMN iduser DROP DEFAULT;
       org          sadmin    false    196    197    197            )           2604    16802    objtype idobjtype    DEFAULT     p   ALTER TABLE ONLY spr.objtype ALTER COLUMN idobjtype SET DEFAULT nextval('spr.objtype_idobjtype_seq'::regclass);
 =   ALTER TABLE spr.objtype ALTER COLUMN idobjtype DROP DEFAULT;
       spr          sadmin    false    207    208    208            (           2604    16788    scaletype idtype    DEFAULT     n   ALTER TABLE ONLY spr.scaletype ALTER COLUMN idtype SET DEFAULT nextval('spr.scaletype_idtype_seq'::regclass);
 <   ALTER TABLE spr.scaletype ALTER COLUMN idtype DROP DEFAULT;
       spr          sadmin    false    205    206    206            %           2604    16612    status idstatus    DEFAULT     l   ALTER TABLE ONLY spr.status ALTER COLUMN idstatus SET DEFAULT nextval('spr.status_idstatus_seq'::regclass);
 ;   ALTER TABLE spr.status ALTER COLUMN idstatus DROP DEFAULT;
       spr          sadmin    false    201    200    201            �          0    16417    objects 
   TABLE DATA                 main          sadmin    false    185            �          0    16439    owners 
   TABLE DATA                 main          sadmin    false    187            �          0    16455    scales 
   TABLE DATA                 main          sammy    false    189            �          0    16490    streets 
   TABLE DATA                 main          sadmin    false    193            �          0    16479    towns 
   TABLE DATA                 main          sadmin    false    191            �          0    16532    clients 
   TABLE DATA                 org          test    false    195            �          0    16582    roles 
   TABLE DATA                 org          sadmin    false    199            �          0    16637 
   user_roles 
   TABLE DATA                 org          sadmin    false    203            �          0    16541    users 
   TABLE DATA                 org          sadmin    false    197            �          0    16799    objtype 
   TABLE DATA                 spr          sadmin    false    208            �          0    16785 	   scaletype 
   TABLE DATA                 spr          sadmin    false    206            �          0    16609    status 
   TABLE DATA                 spr          sadmin    false    201            9	           0    0    objects_idobject_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('main.objects_idobject_seq', 14, true);
          main          sadmin    false    184            :	           0    0    owners_idowner_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('main.owners_idowner_seq', 2, true);
          main          sadmin    false    186            ;	           0    0    scales_idscale_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('main.scales_idscale_seq', 2, true);
          main          sammy    false    188            <	           0    0    streets_idstreet_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('main.streets_idstreet_seq', 15, true);
          main          sadmin    false    192            =	           0    0    towns_idtown_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('main.towns_idtown_seq', 1, true);
          main          sadmin    false    190            >	           0    0    clients_idclient_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('org.clients_idclient_seq', 2, true);
          org          test    false    194            ?	           0    0    roles_idrole_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('org.roles_idrole_seq', 4, true);
          org          sadmin    false    198            @	           0    0    user_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('org.user_roles_id_seq', 54, true);
          org          sadmin    false    202            A	           0    0    users_iduser_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('org.users_iduser_seq', 75, true);
          org          sadmin    false    196            B	           0    0    objtype_idobjtype_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('spr.objtype_idobjtype_seq', 5, true);
          spr          sadmin    false    207            C	           0    0    scaletype_idtype_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('spr.scaletype_idtype_seq', 6, true);
          spr          sadmin    false    205            D	           0    0    status_idstatus_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('spr.status_idstatus_seq', 3, true);
          spr          sadmin    false    200            +           2606    16436    objects objects_pk 
   CONSTRAINT     T   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_pk PRIMARY KEY (idobject);
 :   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_pk;
       main            sadmin    false    185            -           2606    16447    owners pk_owners 
   CONSTRAINT     Q   ALTER TABLE ONLY main.owners
    ADD CONSTRAINT pk_owners PRIMARY KEY (idowner);
 8   ALTER TABLE ONLY main.owners DROP CONSTRAINT pk_owners;
       main            sadmin    false    187            /           2606    16463    scales pk_scales 
   CONSTRAINT     Q   ALTER TABLE ONLY main.scales
    ADD CONSTRAINT pk_scales PRIMARY KEY (idscale);
 8   ALTER TABLE ONLY main.scales DROP CONSTRAINT pk_scales;
       main            sammy    false    189            3           2606    16498    streets streets_pk 
   CONSTRAINT     T   ALTER TABLE ONLY main.streets
    ADD CONSTRAINT streets_pk PRIMARY KEY (idstreet);
 :   ALTER TABLE ONLY main.streets DROP CONSTRAINT streets_pk;
       main            sadmin    false    193            1           2606    16487    towns towns_pk 
   CONSTRAINT     N   ALTER TABLE ONLY main.towns
    ADD CONSTRAINT towns_pk PRIMARY KEY (idtown);
 6   ALTER TABLE ONLY main.towns DROP CONSTRAINT towns_pk;
       main            sadmin    false    191            5           2606    16549    clients clients_pk 
   CONSTRAINT     S   ALTER TABLE ONLY org.clients
    ADD CONSTRAINT clients_pk PRIMARY KEY (idclient);
 9   ALTER TABLE ONLY org.clients DROP CONSTRAINT clients_pk;
       org            test    false    195            ;           2606    16588    roles roles_pk 
   CONSTRAINT     M   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (idrole);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_pk;
       org            sadmin    false    199            =           2606    16660    roles roles_un 
   CONSTRAINT     J   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_un UNIQUE (rolename);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_un;
       org            sadmin    false    199            A           2606    16646    user_roles user_roles_pk 
   CONSTRAINT     S   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_pk PRIMARY KEY (id);
 ?   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_pk;
       org            sadmin    false    203            7           2606    16551    users users_pk 
   CONSTRAINT     M   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_pk PRIMARY KEY (iduser);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_pk;
       org            sadmin    false    197            9           2606    16653    users users_un 
   CONSTRAINT     H   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_un UNIQUE (ulogin);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_un;
       org            sadmin    false    197            E           2606    16807    objtype objtype_pk 
   CONSTRAINT     T   ALTER TABLE ONLY spr.objtype
    ADD CONSTRAINT objtype_pk PRIMARY KEY (idobjtype);
 9   ALTER TABLE ONLY spr.objtype DROP CONSTRAINT objtype_pk;
       spr            sadmin    false    208            C           2606    16793    scaletype scaletype_pk 
   CONSTRAINT     U   ALTER TABLE ONLY spr.scaletype
    ADD CONSTRAINT scaletype_pk PRIMARY KEY (idtype);
 =   ALTER TABLE ONLY spr.scaletype DROP CONSTRAINT scaletype_pk;
       spr            sadmin    false    206            ?           2606    16619    status status_pk 
   CONSTRAINT     L   ALTER TABLE ONLY spr.status
    ADD CONSTRAINT status_pk PRIMARY KEY (kod);
 7   ALTER TABLE ONLY spr.status DROP CONSTRAINT status_pk;
       spr            sadmin    false    201            I           2606    16448    owners fk_owners_objects    FK CONSTRAINT     �   ALTER TABLE ONLY main.owners
    ADD CONSTRAINT fk_owners_objects FOREIGN KEY (idobject) REFERENCES main.objects(idobject) ON UPDATE RESTRICT ON DELETE RESTRICT;
 @   ALTER TABLE ONLY main.owners DROP CONSTRAINT fk_owners_objects;
       main          sadmin    false    185    187    2091            J           2606    16464    scales fk_scales_objects    FK CONSTRAINT     �   ALTER TABLE ONLY main.scales
    ADD CONSTRAINT fk_scales_objects FOREIGN KEY (idobject) REFERENCES main.objects(idobject) ON UPDATE RESTRICT ON DELETE RESTRICT;
 @   ALTER TABLE ONLY main.scales DROP CONSTRAINT fk_scales_objects;
       main          sammy    false    189    185    2091            F           2606    16514    objects objects_fk    FK CONSTRAINT     p   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk FOREIGN KEY (idtown) REFERENCES main.towns(idtown);
 :   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk;
       main          sadmin    false    185    2097    191            G           2606    16519    objects objects_fk_1    FK CONSTRAINT     x   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk_1 FOREIGN KEY (idstreet) REFERENCES main.streets(idstreet);
 <   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk_1;
       main          sadmin    false    185    2099    193            H           2606    16808    objects objects_fk_objtype    FK CONSTRAINT     }   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk_objtype FOREIGN KEY (objtype) REFERENCES spr.objtype(idobjtype);
 B   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk_objtype;
       main          sadmin    false    2117    208    185            K           2606    16524    streets streets_fk    FK CONSTRAINT     p   ALTER TABLE ONLY main.streets
    ADD CONSTRAINT streets_fk FOREIGN KEY (idtown) REFERENCES main.towns(idtown);
 :   ALTER TABLE ONLY main.streets DROP CONSTRAINT streets_fk;
       main          sadmin    false    191    193    2097            M           2606    16625    roles roles_fk    FK CONSTRAINT     h   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_fk FOREIGN KEY (status) REFERENCES spr.status(kod);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_fk;
       org          sadmin    false    201    199    2111            N           2606    16647    user_roles user_roles_fk    FK CONSTRAINT     t   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_fk FOREIGN KEY (iduser) REFERENCES org.users(iduser);
 ?   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_fk;
       org          sadmin    false    2103    197    203            P           2606    16661 !   user_roles user_roles_rolename_fk    FK CONSTRAINT     �   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_rolename_fk FOREIGN KEY (rolename) REFERENCES org.roles(rolename);
 H   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_rolename_fk;
       org          sadmin    false    2109    203    199            O           2606    16654    user_roles user_roles_ulogin_fk    FK CONSTRAINT     {   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_ulogin_fk FOREIGN KEY (ulogin) REFERENCES org.users(ulogin);
 F   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_ulogin_fk;
       org          sadmin    false    2105    197    203            L           2606    16630    users users_fk    FK CONSTRAINT     h   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_fk FOREIGN KEY (status) REFERENCES spr.status(kod);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_fk;
       org          sadmin    false    2111    201    197            �      INSERT INTO main.objects VALUES     (    7    ,     'Жилой дом'    ,     1    ,     4    ,     952    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    5    ,     'Жилой дом'    ,     1    ,     2    ,     24    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    1    ,     'Жилой дом'    ,     1    ,     7    ,     555    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    4    ,      'Участок без дома'    ,     1    ,     1    ,     748    ,     NULL    ,     NULL    ,     2    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    10    ,     'Участок Тест'    ,     1    ,     1    ,     107    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    11    ,     'Тест01'    ,     1    ,     2    ,     1    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 00:00:00'    )    ;
    INSERT INTO main.objects VALUES     (    12    ,     'Test01'    ,     1    ,     NULL    ,     NULL    ,     NULL    ,     NULL    ,     5    ,     '2021-02-13 09:34:44'    )    ;
    INSERT INTO main.objects VALUES     (    13    ,     'Тест03'    ,     1    ,     NULL    ,     NULL    ,     NULL    ,     NULL    ,     1    ,     '2021-02-13 09:37:33'    )    ;
    INSERT INTO main.objects VALUES     (    14    ,      'Участок без дома'    ,     1    ,     7    ,     621    ,     NULL    ,     NULL    ,     2    ,     '2021-02-13 09:41:49'    )    ;
    

      �      INSERT INTO main.owners VALUES     (    1    ,     7    ,     'Иванов'    ,     'Василий'    ,     'Владимирович'    ,     NULL    ,     NULL    )    ;
    INSERT INTO main.owners VALUES     (    2    ,     1    ,     'Петрова'    ,     'Раиса'    ,     'Максимовна'    ,     '+375 29 755-55-55'    ,     NULL    )    ;
    

      �      INSERT INTO main.scales VALUES     (    1    ,     7    ,     254.5    ,     NULL    ,     '2020-10-10'    ,     NULL    ,     NULL    )    ;
    INSERT INTO main.scales VALUES     (    2    ,     7    ,     274.0    ,     NULL    ,     '2020-12-17'    ,     NULL    ,     NULL    )    ;
    

      �      INSERT INTO main.streets VALUES     (    1    ,  #   'Линия центральная'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    2    ,     'Линия 1'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    3    ,     'Линия 2'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    4    ,     'Линия 3'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    5    ,     'Линия 4'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    6    ,     'Линия 5'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    7    ,     'Линия 6'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    8    ,     'Линия 7'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    9    ,     'Линия 8'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    10    ,     'Линия 9'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    11    ,     'Линия 10'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    12    ,     'Линия 11'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    13    ,     'Линия 12'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    14    ,     'Линия 13'    ,     NULL    ,     1    )    ;
    INSERT INTO main.streets VALUES     (    15    ,     'Линия 14'    ,     NULL    ,     1    )    ;
    

      �      INSERT INTO main.towns VALUES     (    1    ,     'СТ "Трактор"'    ,     NULL    )    ;
    

      �      INSERT INTO org.clients VALUES     (    1    ,     'client Test'    )    ;
    INSERT INTO org.clients VALUES     (    2    ,     'СТ "Трактор"'    )    ;
    

      �      INSERT INTO org.roles VALUES     (    1    ,     'bst_su'    ,     0    ,  $   'суперпользователь'    )    ;
    INSERT INTO org.roles VALUES     (    2    ,     'bst_admin'    ,     0    ,  /   'Администратор программы'    )    ;
    INSERT INTO org.roles VALUES     (    3    ,  
   'bst_user'    ,     0    ,     'Пользователь'    )    ;
    INSERT INTO org.roles VALUES     (    4    ,     'bst_guest'    ,     0    ,     'Гость'    )    ;
    

      �   !   INSERT INTO org.user_roles VALUES     (    4    ,     1    ,  	   'default'    ,     'bst_guest'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    3    ,     1    ,  	   'default'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    18    ,     22    ,  
   't2_admin'    ,     'bst_admin'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    19    ,     23    ,  
   't3_admin'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    20    ,     24    ,     'aguest'    ,     'bst_guest'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    27    ,     38    ,     'aaa'    ,     'bst_guest'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    8    ,     5    ,  
   'aaa_user'    ,     'bst_guest'    ,     false    )    ;
 !   INSERT INTO org.user_roles VALUES     (    7    ,     5    ,  
   'aaa_user'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    36    ,     54    ,     'test_useradmin'    ,     'bst_admin'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    6    ,     5    ,  
   'aaa_user'    ,     'bst_admin'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    42    ,     60    ,     'ttt2'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    43    ,     61    ,     'aaa2'    ,     'bst_guest'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    44    ,     62    ,     'aaa_admin'    ,     'bst_admin'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    50    ,     71    ,  	   'a_admin'    ,     'bst_admin'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    51    ,     72    ,     'a_user'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    52    ,     73    ,  	   'a_guest'    ,     'bst_guest'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    54    ,     75    ,     'test'    ,  
   'bst_user'    ,     true    )    ;
 !   INSERT INTO org.user_roles VALUES     (    2    ,     1    ,  	   'default'    ,     'bst_admin'    ,     false    )    ;
    

      �      INSERT INTO org.users VALUES     (    54    ,     2    ,     'test_useradmin'    ,     NULL    ,     '2021-01-23 12:22:50'    ,     1    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    60    ,     2    ,     'ttt2'    ,  "   'd41d8cd98f00b204e9800998ecf8427e'    ,     '2021-01-23 12:39:47'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    61    ,     2    ,     'aaa2'    ,  "   'd41d8cd98f00b204e9800998ecf8427e'    ,     '2021-01-23 12:40:14'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    62    ,     2    ,     'aaa_admin'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-23 12:43:35'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    5    ,     2    ,  
   'aaa_user'    ,     NULL    ,     '2021-01-06 21:57:14'    ,     2    ,  F   ' Тестовый пользователь с правами User''a'    ,     true    )    ;
    INSERT INTO org.users VALUES     (    1    ,     2    ,  	   'default'    ,     NULL    ,     '2021-01-06 21:57:14'    ,     0    ,     NULL    ,     true    )    ;
    INSERT INTO org.users VALUES     (    12    ,     2    ,     'test_user'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-17 07:04:09'    ,     0    ,     'note'    ,     true    )    ;
    INSERT INTO org.users VALUES     (    22    ,     2    ,  
   't2_admin'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-17 08:54:25'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    23    ,     2    ,  
   't3_admin'    ,  "   '202cb962ac59075b964b07152d234b70'    ,     '2021-01-17 09:05:49'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    24    ,     2    ,     'aguest'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-20 12:13:52'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    71    ,     2    ,  	   'a_admin'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-24 07:41:00'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    72    ,     2    ,     'a_user'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-24 07:41:11'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    73    ,     2    ,  	   'a_guest'    ,  "   '698d51a19d8a121ce581499d7b701668'    ,     '2021-01-24 07:41:22'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    75    ,     2    ,     'test'    ,     '111'    ,     '2021-02-11 15:15:38'    ,     0    ,     ''    ,     true    )    ;
    INSERT INTO org.users VALUES     (    38    ,     2    ,     'aaa'    ,  "   'd41d8cd98f00b204e9800998ecf8427e'    ,     '2021-01-23 10:55:26'    ,     0    ,     ''    ,     false    )    ;
    

      �      INSERT INTO spr.objtype VALUES     (    1    ,     NULL    ,     'Жилой дом'    ,     NULL    )    ;
    INSERT INTO spr.objtype VALUES     (    2    ,     NULL    ,     'Садовый участок'    ,     NULL    )    ;
    INSERT INTO spr.objtype VALUES     (    3    ,     NULL    ,     'Магазин'    ,     NULL    )    ;
    INSERT INTO spr.objtype VALUES     (    4    ,     NULL    ,     'Эл. подстанция'    ,     NULL    )    ;
    INSERT INTO spr.objtype VALUES     (    5    ,     NULL    ,  %   'Водонапорная башня'    ,     NULL    )    ;
    

      �       INSERT INTO spr.scaletype VALUES     (    1    ,     1    ,     'Электроэнергия'    ,  '   'Учет электроэнергии'    )    ;
     INSERT INTO spr.scaletype VALUES     (    2    ,     2    ,     'Вода холодная'    ,  ;   'Учет потребления холодной воды'    )    ;
     INSERT INTO spr.scaletype VALUES     (    3    ,     3    ,     'Вода горячая'    ,  9   'Учет потребления горячей воды'    )    ;
     INSERT INTO spr.scaletype VALUES     (    5    ,     4    ,     'Отопление'    ,  4   'Учет потребления отопления'    )    ;
    

      �      INSERT INTO spr.status VALUES     (    1    ,     0    ,     'Активен'    )    ;
    INSERT INTO spr.status VALUES     (    2    ,     1    ,     'Заблокирован'    )    ;
    INSERT INTO spr.status VALUES     (    3    ,     2    ,     'Удален'    )    ;
    

      �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16413    bst    DATABASE     s   CREATE DATABASE bst WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';
    DROP DATABASE bst;
                postgres    false                        2615    16414    main    SCHEMA        CREATE SCHEMA main;
    DROP SCHEMA main;
                postgres    false            �           0    0    SCHEMA main    COMMENT     P   COMMENT ON SCHEMA main IS 'основные рабочие материалы';
                   postgres    false    8            �           0    0    SCHEMA main    ACL     3  REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO test;
GRANT USAGE ON SCHEMA main TO aaa;
GRANT ALL ON SCHEMA main TO bst_admin;
GRANT USAGE ON SCHEMA main TO bst_user;
GRANT USAGE ON SCHEMA main TO bst_guest;
                   postgres    false    8            
            2615    16529    org    SCHEMA        CREATE SCHEMA org;
    DROP SCHEMA org;
                postgres    false            �           0    0 
   SCHEMA org    COMMENT     y   COMMENT ON SCHEMA org IS 'организационные таблицы, роли, пользователи и тд...';
                   postgres    false    10            �           0    0 
   SCHEMA org    ACL     �   REVOKE ALL ON SCHEMA org FROM PUBLIC;
REVOKE ALL ON SCHEMA org FROM postgres;
GRANT ALL ON SCHEMA org TO postgres;
GRANT ALL ON SCHEMA org TO bst_admin;
GRANT ALL ON SCHEMA org TO bst_user;
GRANT USAGE ON SCHEMA org TO bst_guest;
                   postgres    false    10                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    6            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    6            	            2615    16606    spr    SCHEMA        CREATE SCHEMA spr;
    DROP SCHEMA spr;
                postgres    false            �           0    0 
   SCHEMA spr    ACL     �   REVOKE ALL ON SCHEMA spr FROM PUBLIC;
REVOKE ALL ON SCHEMA spr FROM postgres;
GRANT ALL ON SCHEMA spr TO postgres;
GRANT ALL ON SCHEMA spr TO bst_admin;
GRANT ALL ON SCHEMA spr TO bst_user;
GRANT USAGE ON SCHEMA spr TO bst_guest;
                   postgres    false    9            �            1255    16815 `   object_create(character varying, integer, integer, integer, character varying, integer, integer)    FUNCTION     x  CREATE FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
-- *************************************************************************************************************************
-- Входные параметры: 	pname 		- наименование объекта
--                    	pidtown 	- id города 
--						pidstreet 	- id улицы 
--						pdom 		- № дома
--						pdomindex 	- буквенный индекс дома
--						pdomkorp 	- корпус
--						pobjtype 	- тип объекта
-- Проект: bst
-- Автор: Козловский П. С.
-- Дата: 2021-02-13
-- Описание: Создает объект в БД
-- запрос:
-- select main.object_create('ttt2', '111', ARRAY['bst_admin'], 'тест создания роли хранимой процедурой','create',0,true);
-- *************************************************************************************************************************
DECLARE
	result INTEGER;
BEGIN
	result:=0;

	INSERT INTO main.objects ("name",idtown, idstreet, dom, domindex, domkorp, objtype) 
					VALUES (  pname, pidtown,pidstreet,pdom,pdomindex,pdomkorp,pobjtype) 
	RETURNING idobject INTO result;

	RETURN result;
END;
$$;
 �   DROP FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer);
       main          sadmin    false    8            �           0    0 �   FUNCTION object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer)    COMMENT     �   COMMENT ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) IS 'Создает объект в БД';
          main          sadmin    false    222            �           0    0 �   FUNCTION object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer)    ACL     �  REVOKE ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) FROM sadmin;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO sadmin;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO PUBLIC;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO bst_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION main.object_create(pname character varying, pidtown integer, pidstreet integer, pdom integer, pdomindex character varying, pdomkorp integer, pobjtype integer) TO bst_user WITH GRANT OPTION;
          main          sadmin    false    222            �            1255    16764    get_value(text, text[], "char")    FUNCTION     �  CREATE FUNCTION org.get_value(param text, reloptions text[], relkind "char") RETURNS double precision
    LANGUAGE sql
    AS $$
  SELECT coalesce(
    -- если параметр хранения задан, то берем его
    (SELECT option_value
     FROM   pg_options_to_table(reloptions)
     WHERE  option_name = CASE
              -- для toast-таблиц имя параметра отличается
              WHEN relkind = 't' THEN 'toast.' ELSE ''
            END || param
    ),
    -- иначе берем значение конфигурационного параметра
    current_setting(param)
  )::float;
$$;
 L   DROP FUNCTION org.get_value(param text, reloptions text[], relkind "char");
       org          sadmin    false    10            �            1255    16693 q   user_create(character varying, character varying, text[], character varying, character varying, integer, boolean)    FUNCTION     �  CREATE FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
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
$$;
 �   DROP FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean);
       org          sadmin    false    10            �           0    0 �   FUNCTION user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean)    COMMENT     �   COMMENT ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) IS 'Создает пользователя в БД';
          org          sadmin    false    223            �           0    0 �   FUNCTION user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean)    ACL       REVOKE ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) FROM sadmin;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO sadmin;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO PUBLIC;
GRANT ALL ON FUNCTION org.user_create(pulogin character varying, ppas character varying, role_values text[], pnote character varying, pce character varying, pblocked integer, plog boolean) TO bst_admin WITH GRANT OPTION;
          org          sadmin    false    223            �            1255    16813 '   user_delete(character varying, boolean)    FUNCTION     �  CREATE FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
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
$$;
 O   DROP FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean);
       org          sadmin    false    10            �           0    0 D   FUNCTION user_delete(pulogin character varying, pfulldelete boolean)    COMMENT     �   COMMENT ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) IS 'Создает пользователя в БД';
          org          sadmin    false    221            �           0    0 D   FUNCTION user_delete(pulogin character varying, pfulldelete boolean)    ACL        REVOKE ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) FROM sadmin;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO sadmin;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO PUBLIC;
GRANT ALL ON FUNCTION org.user_delete(pulogin character varying, pfulldelete boolean) TO bst_admin WITH GRANT OPTION;
          org          sadmin    false    221            �            1259    16417    objects    TABLE       CREATE TABLE main.objects (
    idobject integer NOT NULL,
    name character varying,
    idtown integer,
    idstreet integer,
    dom integer,
    domindex character varying(15),
    domkorp integer,
    objtype integer,
    datecor timestamp(0) without time zone DEFAULT now()
);
    DROP TABLE main.objects;
       main            sadmin    false    8            �           0    0    TABLE objects    COMMENT     B   COMMENT ON TABLE main.objects IS 'Список объектов';
          main          sadmin    false    185            �           0    0    COLUMN objects.idobject    COMMENT     1   COMMENT ON COLUMN main.objects.idobject IS 'id';
          main          sadmin    false    185            �           0    0    COLUMN objects.name    COMMENT     C   COMMENT ON COLUMN main.objects.name IS 'Наименование';
          main          sadmin    false    185            �           0    0    COLUMN objects.idtown    COMMENT     L   COMMENT ON COLUMN main.objects.idtown IS 'Населенный пункт';
          main          sadmin    false    185            �           0    0    COLUMN objects.idstreet    COMMENT     9   COMMENT ON COLUMN main.objects.idstreet IS 'Улица';
          main          sadmin    false    185            �           0    0    COLUMN objects.dom    COMMENT     0   COMMENT ON COLUMN main.objects.dom IS 'Дом';
          main          sadmin    false    185            �           0    0    COLUMN objects.domindex    COMMENT     D   COMMENT ON COLUMN main.objects.domindex IS 'Индекс дома';
          main          sadmin    false    185            �           0    0    TABLE objects    ACL     y  REVOKE ALL ON TABLE main.objects FROM PUBLIC;
REVOKE ALL ON TABLE main.objects FROM sadmin;
GRANT ALL ON TABLE main.objects TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.objects TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.objects TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.objects TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    185            �            1259    16415    objects_idobject_seq    SEQUENCE     {   CREATE SEQUENCE main.objects_idobject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE main.objects_idobject_seq;
       main          sadmin    false    185    8            �           0    0    objects_idobject_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE main.objects_idobject_seq OWNED BY main.objects.idobject;
          main          sadmin    false    184            �           0    0    SEQUENCE objects_idobject_seq    ACL     V  REVOKE ALL ON SEQUENCE main.objects_idobject_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE main.objects_idobject_seq FROM sadmin;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO sadmin;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO bst_admin WITH GRANT OPTION;
GRANT ALL ON SEQUENCE main.objects_idobject_seq TO bst_user WITH GRANT OPTION;
          main          sadmin    false    184            �            1259    16439    owners    TABLE     �   CREATE TABLE main.owners (
    idowner integer NOT NULL,
    idobject integer,
    fam character varying,
    name character varying,
    sname character varying,
    phone character varying,
    ownertype integer
);
    DROP TABLE main.owners;
       main            sadmin    false    8            �           0    0    TABLE owners    COMMENT     T   COMMENT ON TABLE main.owners IS 'Список владельцев/жильцов';
          main          sadmin    false    187            �           0    0    COLUMN owners.idobject    COMMENT     P   COMMENT ON COLUMN main.owners.idobject IS 'привязка к объекту';
          main          sadmin    false    187            �           0    0    COLUMN owners.fam    COMMENT     7   COMMENT ON COLUMN main.owners.fam IS 'Фамилия';
          main          sadmin    false    187            �           0    0    COLUMN owners.name    COMMENT     0   COMMENT ON COLUMN main.owners.name IS 'Имя';
          main          sadmin    false    187            �           0    0    COLUMN owners.sname    COMMENT     ;   COMMENT ON COLUMN main.owners.sname IS 'Отчество';
          main          sadmin    false    187            �           0    0    COLUMN owners.phone    COMMENT     F   COMMENT ON COLUMN main.owners.phone IS 'номер телефона';
          main          sadmin    false    187            �           0    0    COLUMN owners.ownertype    COMMENT     5   COMMENT ON COLUMN main.owners.ownertype IS 'тип';
          main          sadmin    false    187             	           0    0    TABLE owners    ACL     s  REVOKE ALL ON TABLE main.owners FROM PUBLIC;
REVOKE ALL ON TABLE main.owners FROM sadmin;
GRANT ALL ON TABLE main.owners TO sadmin;
GRANT SELECT ON TABLE main.owners TO bst_guest WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.owners TO bst_user WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.owners TO bst_admin WITH GRANT OPTION;
          main          sadmin    false    187            �            1259    16437    owners_idowner_seq    SEQUENCE     y   CREATE SEQUENCE main.owners_idowner_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE main.owners_idowner_seq;
       main          sadmin    false    8    187            	           0    0    owners_idowner_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE main.owners_idowner_seq OWNED BY main.owners.idowner;
          main          sadmin    false    186            �            1259    16455    scales    TABLE     �   CREATE TABLE main.scales (
    idscale integer NOT NULL,
    idobject integer,
    kvt numeric(10,1),
    note character varying,
    dateview date DEFAULT now(),
    scalenumber character varying(50),
    scaletype integer
);
    DROP TABLE main.scales;
       main            sammy    false    8            	           0    0    COLUMN scales.idobject    COMMENT     P   COMMENT ON COLUMN main.scales.idobject IS 'Привязка к объекту';
          main          sammy    false    189            	           0    0    COLUMN scales.kvt    COMMENT     ;   COMMENT ON COLUMN main.scales.kvt IS 'Показания';
          main          sammy    false    189            	           0    0    COLUMN scales.note    COMMENT     8   COMMENT ON COLUMN main.scales.note IS 'Коммент';
          main          sammy    false    189            	           0    0    COLUMN scales.scalenumber    COMMENT     L   COMMENT ON COLUMN main.scales.scalenumber IS 'Номер счетчика';
          main          sammy    false    189            	           0    0    COLUMN scales.scaletype    COMMENT     m   COMMENT ON COLUMN main.scales.scaletype IS 'Тип счетчика 1-электр. 2 - вода, 3-газ';
          main          sammy    false    189            �            1259    16453    scales_idscale_seq    SEQUENCE     y   CREATE SEQUENCE main.scales_idscale_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE main.scales_idscale_seq;
       main          sammy    false    189    8            	           0    0    scales_idscale_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE main.scales_idscale_seq OWNED BY main.scales.idscale;
          main          sammy    false    188            �            1259    16490    streets    TABLE     �   CREATE TABLE main.streets (
    idstreet integer NOT NULL,
    name character varying,
    note character varying,
    idtown integer
);
    DROP TABLE main.streets;
       main            sadmin    false    8            	           0    0    TABLE streets    COMMENT     :   COMMENT ON TABLE main.streets IS 'Список улиц';
          main          sadmin    false    193            		           0    0    COLUMN streets.name    COMMENT     F   COMMENT ON COLUMN main.streets.name IS 'Название улицы';
          main          sadmin    false    193            
	           0    0    COLUMN streets.note    COMMENT     ?   COMMENT ON COLUMN main.streets.note IS 'Примечание';
          main          sadmin    false    193            	           0    0    COLUMN streets.idtown    COMMENT     U   COMMENT ON COLUMN main.streets.idtown IS 'Привязка к нас. пункту';
          main          sadmin    false    193            	           0    0    TABLE streets    ACL     y  REVOKE ALL ON TABLE main.streets FROM PUBLIC;
REVOKE ALL ON TABLE main.streets FROM sadmin;
GRANT ALL ON TABLE main.streets TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.streets TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.streets TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.streets TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    193            �            1259    16488    streets_idstreet_seq    SEQUENCE     {   CREATE SEQUENCE main.streets_idstreet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE main.streets_idstreet_seq;
       main          sadmin    false    193    8            	           0    0    streets_idstreet_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE main.streets_idstreet_seq OWNED BY main.streets.idstreet;
          main          sadmin    false    192            �            1259    16479    towns    TABLE     q   CREATE TABLE main.towns (
    idtown integer NOT NULL,
    name character varying,
    note character varying
);
    DROP TABLE main.towns;
       main            sadmin    false    8            	           0    0    TABLE towns    ACL     m  REVOKE ALL ON TABLE main.towns FROM PUBLIC;
REVOKE ALL ON TABLE main.towns FROM sadmin;
GRANT ALL ON TABLE main.towns TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.towns TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE main.towns TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE main.towns TO bst_guest WITH GRANT OPTION;
          main          sadmin    false    191            �            1259    16477    towns_idtown_seq    SEQUENCE     w   CREATE SEQUENCE main.towns_idtown_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE main.towns_idtown_seq;
       main          sadmin    false    191    8            	           0    0    towns_idtown_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE main.towns_idtown_seq OWNED BY main.towns.idtown;
          main          sadmin    false    190            �            1259    16532    clients    TABLE     X   CREATE TABLE org.clients (
    idclient integer NOT NULL,
    name character varying
);
    DROP TABLE org.clients;
       org            test    false    10            �            1259    16530    clients_idclient_seq    SEQUENCE     z   CREATE SEQUENCE org.clients_idclient_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE org.clients_idclient_seq;
       org          test    false    195    10            	           0    0    clients_idclient_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE org.clients_idclient_seq OWNED BY org.clients.idclient;
          org          test    false    194            	           0    0    SEQUENCE clients_idclient_seq    ACL     �   REVOKE ALL ON SEQUENCE org.clients_idclient_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.clients_idclient_seq FROM test;
GRANT ALL ON SEQUENCE org.clients_idclient_seq TO test;
GRANT ALL ON SEQUENCE org.clients_idclient_seq TO bst_admin;
          org          test    false    194            �            1259    16765    need_vacuum    VIEW     �  CREATE VIEW org.need_vacuum AS
 SELECT (((st.schemaname)::text || '.'::text) || (st.relname)::text) AS tablename,
    st.n_dead_tup AS dead_tup,
    (org.get_value('autovacuum_vacuum_threshold'::text, c.reloptions, c.relkind) + (org.get_value('autovacuum_vacuum_scale_factor'::text, c.reloptions, c.relkind) * c.reltuples)) AS max_dead_tup,
    st.last_autovacuum
   FROM pg_stat_all_tables st,
    pg_class c
  WHERE ((c.oid = st.relid) AND (c.relkind = ANY (ARRAY['r'::"char", 'm'::"char", 't'::"char"])));
    DROP VIEW org.need_vacuum;
       org          sadmin    false    224    10            �            1259    16582    roles    TABLE     �   CREATE TABLE org.roles (
    idrole integer NOT NULL,
    rolename character varying(50),
    status integer DEFAULT 0,
    describe character varying(250)
);
    DROP TABLE org.roles;
       org            sadmin    false    10            	           0    0    TABLE roles    COMMENT     9   COMMENT ON TABLE org.roles IS 'Список ролей';
          org          sadmin    false    199            	           0    0    COLUMN roles.rolename    COMMENT     D   COMMENT ON COLUMN org.roles.rolename IS 'Наименование';
          org          sadmin    false    199            	           0    0    COLUMN roles.status    COMMENT     h   COMMENT ON COLUMN org.roles.status IS '0 - активен, 1 - блокирован, 2 - удален';
          org          sadmin    false    199            	           0    0    TABLE roles    ACL     `  REVOKE ALL ON TABLE org.roles FROM PUBLIC;
REVOKE ALL ON TABLE org.roles FROM sadmin;
GRANT ALL ON TABLE org.roles TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.roles TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.roles TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    199            �            1259    16580    roles_idrole_seq    SEQUENCE     v   CREATE SEQUENCE org.roles_idrole_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE org.roles_idrole_seq;
       org          sadmin    false    199    10            	           0    0    roles_idrole_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE org.roles_idrole_seq OWNED BY org.roles.idrole;
          org          sadmin    false    198            	           0    0    SEQUENCE roles_idrole_seq    ACL     �   REVOKE ALL ON SEQUENCE org.roles_idrole_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.roles_idrole_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.roles_idrole_seq TO sadmin;
GRANT ALL ON SEQUENCE org.roles_idrole_seq TO bst_admin;
          org          sadmin    false    198            �            1259    16637 
   user_roles    TABLE     �   CREATE TABLE org.user_roles (
    id integer NOT NULL,
    iduser integer,
    ulogin character varying NOT NULL,
    rolename character varying(50) NOT NULL,
    userole boolean DEFAULT false
);
    DROP TABLE org.user_roles;
       org            sadmin    false    10            	           0    0    TABLE user_roles    COMMENT     _   COMMENT ON TABLE org.user_roles IS 'роли присвоеные пользователям';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.id    COMMENT     -   COMMENT ON COLUMN org.user_roles.id IS 'id';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.iduser    COMMENT     J   COMMENT ON COLUMN org.user_roles.iduser IS 'id пользователя';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.ulogin    COMMENT     R   COMMENT ON COLUMN org.user_roles.ulogin IS 'логин пользователя';
          org          sadmin    false    203            	           0    0    COLUMN user_roles.rolename    COMMENT     9   COMMENT ON COLUMN org.user_roles.rolename IS 'роль';
          org          sadmin    false    203            	           0    0    TABLE user_roles    ACL     ~  REVOKE ALL ON TABLE org.user_roles FROM PUBLIC;
REVOKE ALL ON TABLE org.user_roles FROM sadmin;
GRANT ALL ON TABLE org.user_roles TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.user_roles TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.user_roles TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.user_roles TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    203            �            1259    16635    user_roles_id_seq    SEQUENCE     w   CREATE SEQUENCE org.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE org.user_roles_id_seq;
       org          sadmin    false    203    10            	           0    0    user_roles_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE org.user_roles_id_seq OWNED BY org.user_roles.id;
          org          sadmin    false    202            	           0    0    SEQUENCE user_roles_id_seq    ACL     �   REVOKE ALL ON SEQUENCE org.user_roles_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.user_roles_id_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.user_roles_id_seq TO sadmin;
GRANT ALL ON SEQUENCE org.user_roles_id_seq TO bst_admin;
          org          sadmin    false    202            �            1259    16541    users    TABLE        CREATE TABLE org.users (
    iduser integer NOT NULL,
    idclient integer,
    ulogin character varying,
    pass character varying,
    regdate timestamp(0) without time zone DEFAULT now(),
    status integer DEFAULT 0,
    note character varying(1000),
    log boolean DEFAULT true
);
    DROP TABLE org.users;
       org            sadmin    false    10             	           0    0    TABLE users    COMMENT     I   COMMENT ON TABLE org.users IS 'Список пользователей';
          org          sadmin    false    197            !	           0    0    COLUMN users.idclient    COMMENT     N   COMMENT ON COLUMN org.users.idclient IS 'Привязка к клиенту';
          org          sadmin    false    197            "	           0    0    COLUMN users.ulogin    COMMENT     4   COMMENT ON COLUMN org.users.ulogin IS 'Логин';
          org          sadmin    false    197            #	           0    0    COLUMN users.pass    COMMENT     8   COMMENT ON COLUMN org.users.pass IS 'пароль md5';
          org          sadmin    false    197            $	           0    0    COLUMN users.regdate    COMMENT     J   COMMENT ON COLUMN org.users.regdate IS 'дата регистрации';
          org          sadmin    false    197            %	           0    0    COLUMN users.status    COMMENT     h   COMMENT ON COLUMN org.users.status IS '0 - активен, 1 - блокирован, 2 - удален';
          org          sadmin    false    197            &	           0    0    TABLE users    ACL     `  REVOKE ALL ON TABLE org.users FROM PUBLIC;
REVOKE ALL ON TABLE org.users FROM sadmin;
GRANT ALL ON TABLE org.users TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org.users TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE org.users TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.users TO bst_guest WITH GRANT OPTION;
          org          sadmin    false    197            �            1259    16539    users_iduser_seq    SEQUENCE     v   CREATE SEQUENCE org.users_iduser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE org.users_iduser_seq;
       org          sadmin    false    197    10            '	           0    0    users_iduser_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE org.users_iduser_seq OWNED BY org.users.iduser;
          org          sadmin    false    196            (	           0    0    SEQUENCE users_iduser_seq    ACL     �   REVOKE ALL ON SEQUENCE org.users_iduser_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE org.users_iduser_seq FROM sadmin;
GRANT ALL ON SEQUENCE org.users_iduser_seq TO sadmin;
GRANT ALL ON SEQUENCE org.users_iduser_seq TO bst_admin;
          org          sadmin    false    196            �            1259    16799    objtype    TABLE     �   CREATE TABLE spr.objtype (
    idobjtype integer NOT NULL,
    kod integer,
    znach character varying,
    note character varying
);
    DROP TABLE spr.objtype;
       spr            sadmin    false    9            )	           0    0    TABLE objtype    COMMENT     R   COMMENT ON TABLE spr.objtype IS 'Справочник типы объектов';
          spr          sadmin    false    208            *	           0    0    COLUMN objtype.kod    COMMENT     /   COMMENT ON COLUMN spr.objtype.kod IS 'код';
          spr          sadmin    false    208            +	           0    0    COLUMN objtype.znach    COMMENT     N   COMMENT ON COLUMN spr.objtype.znach IS 'текстовое значение';
          spr          sadmin    false    208            ,	           0    0    TABLE objtype    ACL     l  REVOKE ALL ON TABLE spr.objtype FROM PUBLIC;
REVOKE ALL ON TABLE spr.objtype FROM sadmin;
GRANT ALL ON TABLE spr.objtype TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.objtype TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.objtype TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.objtype TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    208            �            1259    16797    objtype_idobjtype_seq    SEQUENCE     {   CREATE SEQUENCE spr.objtype_idobjtype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE spr.objtype_idobjtype_seq;
       spr          sadmin    false    208    9            -	           0    0    objtype_idobjtype_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE spr.objtype_idobjtype_seq OWNED BY spr.objtype.idobjtype;
          spr          sadmin    false    207            �            1259    16785 	   scaletype    TABLE     �   CREATE TABLE spr.scaletype (
    idtype integer NOT NULL,
    kod integer,
    znach character varying,
    note character varying
);
    DROP TABLE spr.scaletype;
       spr            sadmin    false    9            .	           0    0    TABLE scaletype    COMMENT     V   COMMENT ON TABLE spr.scaletype IS 'Справочник типы счетчиков';
          spr          sadmin    false    206            /	           0    0    COLUMN scaletype.kod    COMMENT     �   COMMENT ON COLUMN spr.scaletype.kod IS 'код 0 - неопределен, 1 - электричество, 2 - вода, 3 - газ';
          spr          sadmin    false    206            0	           0    0    COLUMN scaletype.znach    COMMENT     P   COMMENT ON COLUMN spr.scaletype.znach IS 'текстовое значение';
          spr          sadmin    false    206            1	           0    0    TABLE scaletype    ACL     x  REVOKE ALL ON TABLE spr.scaletype FROM PUBLIC;
REVOKE ALL ON TABLE spr.scaletype FROM sadmin;
GRANT ALL ON TABLE spr.scaletype TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.scaletype TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.scaletype TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.scaletype TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    206            �            1259    16783    scaletype_idtype_seq    SEQUENCE     z   CREATE SEQUENCE spr.scaletype_idtype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE spr.scaletype_idtype_seq;
       spr          sadmin    false    206    9            2	           0    0    scaletype_idtype_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE spr.scaletype_idtype_seq OWNED BY spr.scaletype.idtype;
          spr          sadmin    false    205            3	           0    0    SEQUENCE scaletype_idtype_seq    ACL     -  REVOKE ALL ON SEQUENCE spr.scaletype_idtype_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE spr.scaletype_idtype_seq FROM sadmin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO sadmin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO bst_admin;
GRANT ALL ON SEQUENCE spr.scaletype_idtype_seq TO bst_user;
          spr          sadmin    false    205            �            1259    16609    status    TABLE     r   CREATE TABLE spr.status (
    idstatus integer NOT NULL,
    kod integer NOT NULL,
    znach character varying
);
    DROP TABLE spr.status;
       spr            sadmin    false    9            4	           0    0    TABLE status    COMMENT     o   COMMENT ON TABLE spr.status IS 'состояние записи 0 - норм 1 - блок 2 - удалена';
          spr          sadmin    false    201            5	           0    0    COLUMN status.kod    COMMENT     m   COMMENT ON COLUMN spr.status.kod IS 'код 0 - активен, 1 - блокирован, 2 - удален';
          spr          sadmin    false    201            6	           0    0    COLUMN status.znach    COMMENT     M   COMMENT ON COLUMN spr.status.znach IS 'текстовое значение';
          spr          sadmin    false    201            7	           0    0    TABLE status    ACL     f  REVOKE ALL ON TABLE spr.status FROM PUBLIC;
REVOKE ALL ON TABLE spr.status FROM sadmin;
GRANT ALL ON TABLE spr.status TO sadmin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE spr.status TO bst_admin WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON TABLE spr.status TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE spr.status TO bst_guest WITH GRANT OPTION;
          spr          sadmin    false    201            �            1259    16607    status_idstatus_seq    SEQUENCE     y   CREATE SEQUENCE spr.status_idstatus_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE spr.status_idstatus_seq;
       spr          sadmin    false    201    9            8	           0    0    status_idstatus_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE spr.status_idstatus_seq OWNED BY spr.status.idstatus;
          spr          sadmin    false    200                       2604    16420    objects idobject    DEFAULT     p   ALTER TABLE ONLY main.objects ALTER COLUMN idobject SET DEFAULT nextval('main.objects_idobject_seq'::regclass);
 =   ALTER TABLE main.objects ALTER COLUMN idobject DROP DEFAULT;
       main          sadmin    false    185    184    185                       2604    16442    owners idowner    DEFAULT     l   ALTER TABLE ONLY main.owners ALTER COLUMN idowner SET DEFAULT nextval('main.owners_idowner_seq'::regclass);
 ;   ALTER TABLE main.owners ALTER COLUMN idowner DROP DEFAULT;
       main          sadmin    false    186    187    187                       2604    16458    scales idscale    DEFAULT     l   ALTER TABLE ONLY main.scales ALTER COLUMN idscale SET DEFAULT nextval('main.scales_idscale_seq'::regclass);
 ;   ALTER TABLE main.scales ALTER COLUMN idscale DROP DEFAULT;
       main          sammy    false    189    188    189                       2604    16493    streets idstreet    DEFAULT     p   ALTER TABLE ONLY main.streets ALTER COLUMN idstreet SET DEFAULT nextval('main.streets_idstreet_seq'::regclass);
 =   ALTER TABLE main.streets ALTER COLUMN idstreet DROP DEFAULT;
       main          sadmin    false    193    192    193                       2604    16482    towns idtown    DEFAULT     h   ALTER TABLE ONLY main.towns ALTER COLUMN idtown SET DEFAULT nextval('main.towns_idtown_seq'::regclass);
 9   ALTER TABLE main.towns ALTER COLUMN idtown DROP DEFAULT;
       main          sadmin    false    190    191    191                       2604    16535    clients idclient    DEFAULT     n   ALTER TABLE ONLY org.clients ALTER COLUMN idclient SET DEFAULT nextval('org.clients_idclient_seq'::regclass);
 <   ALTER TABLE org.clients ALTER COLUMN idclient DROP DEFAULT;
       org          test    false    195    194    195            #           2604    16585    roles idrole    DEFAULT     f   ALTER TABLE ONLY org.roles ALTER COLUMN idrole SET DEFAULT nextval('org.roles_idrole_seq'::regclass);
 8   ALTER TABLE org.roles ALTER COLUMN idrole DROP DEFAULT;
       org          sadmin    false    199    198    199            &           2604    16640    user_roles id    DEFAULT     h   ALTER TABLE ONLY org.user_roles ALTER COLUMN id SET DEFAULT nextval('org.user_roles_id_seq'::regclass);
 9   ALTER TABLE org.user_roles ALTER COLUMN id DROP DEFAULT;
       org          sadmin    false    202    203    203                       2604    16544    users iduser    DEFAULT     f   ALTER TABLE ONLY org.users ALTER COLUMN iduser SET DEFAULT nextval('org.users_iduser_seq'::regclass);
 8   ALTER TABLE org.users ALTER COLUMN iduser DROP DEFAULT;
       org          sadmin    false    196    197    197            )           2604    16802    objtype idobjtype    DEFAULT     p   ALTER TABLE ONLY spr.objtype ALTER COLUMN idobjtype SET DEFAULT nextval('spr.objtype_idobjtype_seq'::regclass);
 =   ALTER TABLE spr.objtype ALTER COLUMN idobjtype DROP DEFAULT;
       spr          sadmin    false    207    208    208            (           2604    16788    scaletype idtype    DEFAULT     n   ALTER TABLE ONLY spr.scaletype ALTER COLUMN idtype SET DEFAULT nextval('spr.scaletype_idtype_seq'::regclass);
 <   ALTER TABLE spr.scaletype ALTER COLUMN idtype DROP DEFAULT;
       spr          sadmin    false    205    206    206            %           2604    16612    status idstatus    DEFAULT     l   ALTER TABLE ONLY spr.status ALTER COLUMN idstatus SET DEFAULT nextval('spr.status_idstatus_seq'::regclass);
 ;   ALTER TABLE spr.status ALTER COLUMN idstatus DROP DEFAULT;
       spr          sadmin    false    201    200    201            �          0    16417    objects 
   TABLE DATA                 main          sadmin    false    185            �          0    16439    owners 
   TABLE DATA                 main          sadmin    false    187   �       �          0    16455    scales 
   TABLE DATA                 main          sammy    false    189   �       �          0    16490    streets 
   TABLE DATA                 main          sadmin    false    193   X       �          0    16479    towns 
   TABLE DATA                 main          sadmin    false    191          �          0    16532    clients 
   TABLE DATA                 org          test    false    195   �        �          0    16582    roles 
   TABLE DATA                 org          sadmin    false    199   �        �          0    16637 
   user_roles 
   TABLE DATA                 org          sadmin    false    203   3       �          0    16541    users 
   TABLE DATA                 org          sadmin    false    197   �	       �          0    16799    objtype 
   TABLE DATA                 spr          sadmin    false    208   �       �          0    16785 	   scaletype 
   TABLE DATA                 spr          sadmin    false    206   �       �          0    16609    status 
   TABLE DATA                 spr          sadmin    false    201   �       9	           0    0    objects_idobject_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('main.objects_idobject_seq', 14, true);
          main          sadmin    false    184            :	           0    0    owners_idowner_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('main.owners_idowner_seq', 2, true);
          main          sadmin    false    186            ;	           0    0    scales_idscale_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('main.scales_idscale_seq', 2, true);
          main          sammy    false    188            <	           0    0    streets_idstreet_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('main.streets_idstreet_seq', 15, true);
          main          sadmin    false    192            =	           0    0    towns_idtown_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('main.towns_idtown_seq', 1, true);
          main          sadmin    false    190            >	           0    0    clients_idclient_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('org.clients_idclient_seq', 2, true);
          org          test    false    194            ?	           0    0    roles_idrole_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('org.roles_idrole_seq', 4, true);
          org          sadmin    false    198            @	           0    0    user_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('org.user_roles_id_seq', 54, true);
          org          sadmin    false    202            A	           0    0    users_iduser_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('org.users_iduser_seq', 75, true);
          org          sadmin    false    196            B	           0    0    objtype_idobjtype_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('spr.objtype_idobjtype_seq', 5, true);
          spr          sadmin    false    207            C	           0    0    scaletype_idtype_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('spr.scaletype_idtype_seq', 6, true);
          spr          sadmin    false    205            D	           0    0    status_idstatus_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('spr.status_idstatus_seq', 3, true);
          spr          sadmin    false    200            +           2606    16436    objects objects_pk 
   CONSTRAINT     T   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_pk PRIMARY KEY (idobject);
 :   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_pk;
       main            sadmin    false    185            -           2606    16447    owners pk_owners 
   CONSTRAINT     Q   ALTER TABLE ONLY main.owners
    ADD CONSTRAINT pk_owners PRIMARY KEY (idowner);
 8   ALTER TABLE ONLY main.owners DROP CONSTRAINT pk_owners;
       main            sadmin    false    187            /           2606    16463    scales pk_scales 
   CONSTRAINT     Q   ALTER TABLE ONLY main.scales
    ADD CONSTRAINT pk_scales PRIMARY KEY (idscale);
 8   ALTER TABLE ONLY main.scales DROP CONSTRAINT pk_scales;
       main            sammy    false    189            3           2606    16498    streets streets_pk 
   CONSTRAINT     T   ALTER TABLE ONLY main.streets
    ADD CONSTRAINT streets_pk PRIMARY KEY (idstreet);
 :   ALTER TABLE ONLY main.streets DROP CONSTRAINT streets_pk;
       main            sadmin    false    193            1           2606    16487    towns towns_pk 
   CONSTRAINT     N   ALTER TABLE ONLY main.towns
    ADD CONSTRAINT towns_pk PRIMARY KEY (idtown);
 6   ALTER TABLE ONLY main.towns DROP CONSTRAINT towns_pk;
       main            sadmin    false    191            5           2606    16549    clients clients_pk 
   CONSTRAINT     S   ALTER TABLE ONLY org.clients
    ADD CONSTRAINT clients_pk PRIMARY KEY (idclient);
 9   ALTER TABLE ONLY org.clients DROP CONSTRAINT clients_pk;
       org            test    false    195            ;           2606    16588    roles roles_pk 
   CONSTRAINT     M   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (idrole);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_pk;
       org            sadmin    false    199            =           2606    16660    roles roles_un 
   CONSTRAINT     J   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_un UNIQUE (rolename);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_un;
       org            sadmin    false    199            A           2606    16646    user_roles user_roles_pk 
   CONSTRAINT     S   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_pk PRIMARY KEY (id);
 ?   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_pk;
       org            sadmin    false    203            7           2606    16551    users users_pk 
   CONSTRAINT     M   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_pk PRIMARY KEY (iduser);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_pk;
       org            sadmin    false    197            9           2606    16653    users users_un 
   CONSTRAINT     H   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_un UNIQUE (ulogin);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_un;
       org            sadmin    false    197            E           2606    16807    objtype objtype_pk 
   CONSTRAINT     T   ALTER TABLE ONLY spr.objtype
    ADD CONSTRAINT objtype_pk PRIMARY KEY (idobjtype);
 9   ALTER TABLE ONLY spr.objtype DROP CONSTRAINT objtype_pk;
       spr            sadmin    false    208            C           2606    16793    scaletype scaletype_pk 
   CONSTRAINT     U   ALTER TABLE ONLY spr.scaletype
    ADD CONSTRAINT scaletype_pk PRIMARY KEY (idtype);
 =   ALTER TABLE ONLY spr.scaletype DROP CONSTRAINT scaletype_pk;
       spr            sadmin    false    206            ?           2606    16619    status status_pk 
   CONSTRAINT     L   ALTER TABLE ONLY spr.status
    ADD CONSTRAINT status_pk PRIMARY KEY (kod);
 7   ALTER TABLE ONLY spr.status DROP CONSTRAINT status_pk;
       spr            sadmin    false    201            I           2606    16448    owners fk_owners_objects    FK CONSTRAINT     �   ALTER TABLE ONLY main.owners
    ADD CONSTRAINT fk_owners_objects FOREIGN KEY (idobject) REFERENCES main.objects(idobject) ON UPDATE RESTRICT ON DELETE RESTRICT;
 @   ALTER TABLE ONLY main.owners DROP CONSTRAINT fk_owners_objects;
       main          sadmin    false    185    187    2091            J           2606    16464    scales fk_scales_objects    FK CONSTRAINT     �   ALTER TABLE ONLY main.scales
    ADD CONSTRAINT fk_scales_objects FOREIGN KEY (idobject) REFERENCES main.objects(idobject) ON UPDATE RESTRICT ON DELETE RESTRICT;
 @   ALTER TABLE ONLY main.scales DROP CONSTRAINT fk_scales_objects;
       main          sammy    false    189    185    2091            F           2606    16514    objects objects_fk    FK CONSTRAINT     p   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk FOREIGN KEY (idtown) REFERENCES main.towns(idtown);
 :   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk;
       main          sadmin    false    185    2097    191            G           2606    16519    objects objects_fk_1    FK CONSTRAINT     x   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk_1 FOREIGN KEY (idstreet) REFERENCES main.streets(idstreet);
 <   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk_1;
       main          sadmin    false    185    2099    193            H           2606    16808    objects objects_fk_objtype    FK CONSTRAINT     }   ALTER TABLE ONLY main.objects
    ADD CONSTRAINT objects_fk_objtype FOREIGN KEY (objtype) REFERENCES spr.objtype(idobjtype);
 B   ALTER TABLE ONLY main.objects DROP CONSTRAINT objects_fk_objtype;
       main          sadmin    false    2117    208    185            K           2606    16524    streets streets_fk    FK CONSTRAINT     p   ALTER TABLE ONLY main.streets
    ADD CONSTRAINT streets_fk FOREIGN KEY (idtown) REFERENCES main.towns(idtown);
 :   ALTER TABLE ONLY main.streets DROP CONSTRAINT streets_fk;
       main          sadmin    false    191    193    2097            M           2606    16625    roles roles_fk    FK CONSTRAINT     h   ALTER TABLE ONLY org.roles
    ADD CONSTRAINT roles_fk FOREIGN KEY (status) REFERENCES spr.status(kod);
 5   ALTER TABLE ONLY org.roles DROP CONSTRAINT roles_fk;
       org          sadmin    false    201    199    2111            N           2606    16647    user_roles user_roles_fk    FK CONSTRAINT     t   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_fk FOREIGN KEY (iduser) REFERENCES org.users(iduser);
 ?   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_fk;
       org          sadmin    false    2103    197    203            P           2606    16661 !   user_roles user_roles_rolename_fk    FK CONSTRAINT     �   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_rolename_fk FOREIGN KEY (rolename) REFERENCES org.roles(rolename);
 H   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_rolename_fk;
       org          sadmin    false    2109    203    199            O           2606    16654    user_roles user_roles_ulogin_fk    FK CONSTRAINT     {   ALTER TABLE ONLY org.user_roles
    ADD CONSTRAINT user_roles_ulogin_fk FOREIGN KEY (ulogin) REFERENCES org.users(ulogin);
 F   ALTER TABLE ONLY org.user_roles DROP CONSTRAINT user_roles_ulogin_fk;
       org          sadmin    false    2105    197    203            L           2606    16630    users users_fk    FK CONSTRAINT     h   ALTER TABLE ONLY org.users
    ADD CONSTRAINT users_fk FOREIGN KEY (status) REFERENCES spr.status(kod);
 5   ALTER TABLE ONLY org.users DROP CONSTRAINT users_fk;
       org          sadmin    false    2111    201    197           