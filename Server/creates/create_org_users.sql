-- Drop table

-- DROP TABLE org.users;

CREATE TABLE org.users
(
  iduser serial NOT NULL,
  idclient integer, -- �������� � �������
  ulogin character varying, -- �����
  pass character varying, -- ������ md5
  regdate timestamp(0) without time zone DEFAULT now(), -- ���� �����������
  status integer DEFAULT 0, -- 0 - �������, 1 - ����������, 2 - ������
  note character varying(1000),
  log boolean DEFAULT true,
  CONSTRAINT users_pk PRIMARY KEY (iduser),
  CONSTRAINT users_fk FOREIGN KEY (status)
      REFERENCES spr.status (kod) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT users_un UNIQUE (ulogin)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE org.users
  OWNER TO sadmin;
  
GRANT ALL ON TABLE org.users TO sadmin;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE org.users TO bst_admin WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT ON TABLE org.users TO bst_user WITH GRANT OPTION;
GRANT SELECT ON TABLE org.users TO bst_guest WITH GRANT OPTION;
REVOKE ALL ON TABLE org.users FROM public;

COMMENT ON TABLE org.users
  IS '������ �������������';
COMMENT ON COLUMN org.users.idclient IS '�������� � �������';
COMMENT ON COLUMN org.users.ulogin IS '�����';
COMMENT ON COLUMN org.users.pass IS '������ md5';
COMMENT ON COLUMN org.users.regdate IS '���� �����������';
COMMENT ON COLUMN org.users.status IS '0 - �������, 1 - ����������, 2 - ������';


