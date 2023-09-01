
--DELETE FROM gf.sprivil WHERE (tip = 'F') AND (name = 'ihsb.insert_meter_data_curent(character varying,text,character varying)');

--DROP FUNCTION IF EXISTS ihsb.insert_meter_data_curent(character varying,text,character varying);

CREATE OR REPLACE FUNCTION ihsb.insert_meter_data_curent(plogin character varying, pmeterdate text, pperiod character varying) RETURNS integer AS
$BODY$ 
-- ************************************************************************
-- Входные параметры: login
--                    pmeterdate - показания счетчиков, приходит строка вида:
--			171545~6522~59235~Ж/дом,ул.Нахимова,5~Ж/дом^338986~4783~630270~ж/дом,ул.Нахимова,6~Ж/дом^310053~1994~97507~Ж/дом,ул.Нахимова,8~Ж/дом^
--			idscale~показания~№ счетчика~адрес~вид учета
--                    pperiod - период показаний
--
-- Возвращаемое значение: <result_descr>
-- Проект: ПП "Подомовой учет"
-- Автор: Неизвестно
-- Дата: неизвестно
-- ISSUE: <func_issue>
-- Версия: 1.0
-- Описание: функция для сверки счетчиков в базе с энергосбыт и внесения показаний 
-- ************************************************************************
-- 27-05-2020
-- Козловский П.С.
-- дополнение функционала, к "счетчик не найден" добавлены сообщения если "счетчик найден но не совпадает номер с энергосбытом"
-- ************************************************************************
DECLARE
	result integer;         -- результат
	ameter text[];		-- массив с данными по счетчикам
	aval text[];		-- инфо по каждому счетчику
				-- aval[1] - idscale  
				-- aval[2] - показания
				-- aval[3] - № счетчика
				-- avav[4] - адрес
				-- aval[5] - вид учета
	i integer;
	aidobject integer; 
	aidscale integer;
	avalue_n numeric;
	aid integer;
	aidmessage INTEGER;
	vperiod character varying;
	anum character varying;	-- номер счетчика в базе
BEGIN
	result := 0;
	--если период вида 20201,20202... то добавляется доп. 0 -> 202001 202002 и тд, для совместимости
	IF(LENGTH(pperiod)=5)THEN SELECT SUBSTRING(pperiod,1,4)||'0'||SUBSTRING(pperiod,5,1) INTO vperiod;
	ELSE vperiod = pperiod;	END IF;

	--формируем массив с данными по счетчикам разделяя строку по символу ^
	ameter = string_to_array(pmeterdate,'^');

	--сверяем каждый элемент массива (прибор учета) с базой
	for i in 1..array_length(ameter,1)-1 loop

		-- выводим инфо счетчика	
		RAISE INFO 'Обработка данных по счетчику %',ameter[i]; 
		
		-- формируем массив параметров по счетчику
		aval = string_to_array(ameter[i],'~');
		
		-- Ищем счетчик в базе по idscale
		BEGIN
			SELECT idobject INTO aidobject FROM gf.bkart WHERE kodattr=3604 AND value_n=CAST(aval[1] AS INTEGER);
			RAISE INFO 'Провека данных под idScale %, idObject = %',aval[1],aidobject;
			IF (aidobject IS NULL)THEN
				BEGIN
					RAISE INFO 'idscale: % в базе не найден, пробуем искать по № счетчика - %',aval[1],aval[3];
					
					SELECT idobject INTO aidobject FROM gf.bkart WHERE kodattr=2020 AND value_s=aval[3];
					IF (aidobject IS NOT NULL)THEN
						-- Счетчик есть и он один, обновим параметр idscale
						RAISE INFO 'Счетчик № % найден, обновляем для него idscale = %',aval[3],aval[1];

						--удаляем старый id если он есть
				--##############################################################################################
				--#########      Закомментированный блок на время разработки Сашей ###########################
				--	тут ничего не меняли!!!!!!!!!!!!!!
				--##############################################################################################
						
						DELETE FROM gf.bkart WHERE idobject = aidobject AND kodattr=3604; 							
						-- вписываем новый id
						INSERT INTO gf.bkart(idobject, kodattr, tipattr, value_n, flag) values (aidobject, 3604, 'N', CAST(aval[1] AS INTEGER), 0); 
					
				--##############################################################################################
					ELSE
						--формируем сообщение для пользователя если не найден счетчик
				--##############################################################################################
				--#########      Закомментированный блок на время разработки Сашей ###########################
				--##############################################################################################
					/*	RAISE INFO 'Счетчик по idscale: % и №: % не найден - отправляем сообщение об отсутствии',aval[1],aval[3];
						INSERT INTO gf.bmessages(username,message,senddate,jreo) VALUES('gf','Счетчик не найден - idscale: '||aval[1]||' № счетчика: '||aval[3]||' ('||aval[4]||','||aval[5]||')',now(),68) RETURNING idmessage INTO aidmessage;
						INSERT INTO gf.busermessages(idmessage,username,readdate) SELECT aidmessage AS idmessage,username,NULL AS readdate FROM ihsb.bmeter_user_messages WHERE login = plogin;
						--VALUES(aidmessage, 'ozaiko',NULL);   
					*/
				--##############################################################################################
						
					END IF;
			/*	EXCEPTION
				WHEN no_data_found THEN
					RAISE INFO 'Такого номера счетчика (%) в базе нет',aval[3];
					aidobject := NULL;
				WHEN too_many_rows THEN
					RAISE INFO 'Таких номеров счетчиков (%) в базе несколько',aval[3];
					aidobject := NULL;  */
				END; 
			END IF;
		
		END;		
		IF (aidobject IS NOT NULL)THEN
			
			RAISE INFO 'idscale % найден, проверяем соответствие № счетчика',aval[1];
--			RAISE INFO 'Обновим показания счетчика (%,%,%)',aidobject,aval[2],vperiod;
			-- Проверим, есть ли показания по этому объекту в периоде
			BEGIN 
				SELECT id, value_n INTO aid, avalue_n FROM gf.bkart WHERE idobject = aidobject AND kodattr=3725 AND period = vperiod;
				SELECT value_s INTO anum FROM gf.bkart WHERE idobject = aidobject AND kodattr=2020;

				If (anum=aval[3]) THEN
				
					IF(aid IS NULL)THEN
						-- Добавляем данные по счетчику
						RAISE INFO 'Добавляем данные по счетчику';
					  --INSERT INTO gf.bkart(idobject, kodattr,tipattr,value_n,flag, period) VALUES (aidobject, 2032,'N',CAST(aval[2] AS NUMERIC),0,vperiod);
						INSERT INTO gf.bkart(idobject, kodattr,tipattr,value_n,flag, period) VALUES (aidobject, 3725,'N',CAST(aval[2] AS NUMERIC),0,vperiod);
						
						-- Пересчитаем подчиненные
						RAISE INFO 'Пересчитаем подчиненные aidobject=%, vperiod=%',aidobject, vperiod;
						PERFORM gf.queryattr_refresh(aidobject, vperiod);
					ELSE 
						IF(CAST(aval[2] AS NUMERIC)=avalue_n)THEN 
							RAISE INFO 'Показания внесены и равны';
						ELSE
							RAISE INFO 'Показания внесены и не равны';
							
				--##############################################################################################
				--#########      Закомментированный блок на время разработки Сашей ###########################
				-- ничего не меняли!!!!!
				--##############################################################################################
					
							UPDATE gf.bkart SET value_n=CAST(aval[2] AS NUMERIC) WHERE id=aid;
					
				--##############################################################################################
						END IF;
				--##############################################################################################
				--#########      Закомментированный блок на время разработки Сашей ###########################
				-- ничего не меняли!!!!!
				--##############################################################################################
					
						PERFORM gf.queryattr_refresh(aidobject, vperiod);
					
				--##############################################################################################
					END IF;
				ELSE
					--номера счетчиков не совпадают, формируем сообщение
					RAISE INFO 'Несовпадение номеров счетчиков idscale: %. Энергосбыт: % - в базе: %',aval[1],aval[3],anum;
--					INSERT INTO gf.bmessages(username,message,senddate,jreo) VALUES('gf','Счетчик не найден '||aval[3]||'('||aval[4]||','||aval[5]||')',now(),68) RETURNING idmessage INTO aidmessage;
					IF (anum IS NULL) THEN anum='отсутствует'; END IF;
					
				--##############################################################################################
				--#########      Закомментированный блок на время разработки Сашей ###########################
				--##############################################################################################
				/*
					INSERT INTO gf.bmessages(username,message,senddate,jreo) VALUES('gf','Несовпадение номеров счетчиков idscale: '||aval[1]||' № энергосбыт: '||aval[3]||' - № в базе: '||anum||' ('||aval[4]||','||aval[5]||')',now(),68) RETURNING idmessage INTO aidmessage;
					INSERT INTO gf.busermessages(idmessage,username,readdate) SELECT aidmessage AS idmessage,username,NULL AS readdate FROM ihsb.bmeter_user_messages WHERE login = plogin;
				*/
				--##############################################################################################
				END IF;	
			EXCEPTION
			WHEN no_data_found THEN
				RAISE INFO 'Не нашли показания';
			WHEN too_many_rows THEN
				RAISE INFO 'Таких показаний в базе несколько';
			END;
		END IF;
	--	RAISE INFO 'idscale = %, ind=%, номер счетчика=%',aval[1],aval[2],aval[3];
	end loop;
	RETURN result;
END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) OWNER TO gf;
GRANT ALL ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO gf;
REVOKE ALL ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) FROM public;
COMMENT ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) IS '<func_comment>';


GRANT EXECUTE ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO gf_admin    WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO ihsb_admin  WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO ihsb_uprav  WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO ihsb_master WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION ihsb.insert_meter_data_curent(character varying,text,character varying) TO ihsb_guest  WITH GRANT OPTION;

INSERT INTO gf.sprivil(rolename, tip, name, privil) VALUES('gf_admin',    'F', 'ihsb.insert_meter_data_curent(character varying,text,character varying)', '000001');
INSERT INTO gf.sprivil(rolename, tip, name, privil) VALUES('ihsb_admin',  'F', 'ihsb.insert_meter_data_curent(character varying,text,character varying)', '000001');
INSERT INTO gf.sprivil(rolename, tip, name, privil) VALUES('ihsb_uprav',  'F', 'ihsb.insert_meter_data_curent(character varying,text,character varying)', '000001');
INSERT INTO gf.sprivil(rolename, tip, name, privil) VALUES('ihsb_master', 'F', 'ihsb.insert_meter_data_curent(character varying,text,character varying)', '000001');
INSERT INTO gf.sprivil(rolename, tip, name, privil) VALUES('ihsb_guest',  'F', 'ihsb.insert_meter_data_curent(character varying,text,character varying)', '000001');
