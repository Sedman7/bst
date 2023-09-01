-- Function: main.object_create(character varying,integer,integer,integer,character varying,integer,integer)

--DROP FUNCTION IF EXISTS main.object_create(character varying,integer,integer,integer,character varying,integer,integer);

CREATE OR REPLACE FUNCTION main.object_create(pname character varying, 
						pidtown integer, 
						pidstreet integer, 
						pdom integer,
						pdomindex character varying,
						pdomkorp integer,
						pobjtype integer) RETURNS integer AS
$BODY$ 
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
-- select select main.object_create('Участок Тест',1,1,107,null,null,1);
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
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) OWNER TO sadmin;
GRANT ALL ON FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) TO sadmin;
COMMENT ON FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) IS 'Создает объект в БД';

GRANT EXECUTE ON FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) TO bst_admin  WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) TO bst_user  WITH GRANT OPTION;
--GRANT EXECUTE ON FUNCTION main.object_create(character varying,integer,integer,integer,character varying,integer,integer) TO bst_guest  WITH GRANT OPTION;
