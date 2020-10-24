use APORTACIONES

DROP TABLE dbo.GASTOS
go
DROP TABLE dbo.OFRENDAS
go
DROP TABLE dbo.DIEZMOS
go
DROP TABLE dbo.APORTACIONES
go
DROP TABLE dbo.BANCOS
go
DROP TABLE dbo.USUARIOS
go

CREATE TABLE dbo.USUARIOS(
	id_usuario int identity(1,1) NOT NULL,
	codigo varchar(15) NULL,
	nombre varchar(200) NOT NULL,
	estado char(1) NOT NULL,
	anciano smallint NULL,
	coordinador smallint NULL,
	servidor_ministerial smallint NULL,
	conteo_ofrenda smallint NULL,
	pueblo smallint NULL,
	CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario),
	CONSTRAINT chk_usuarios_estado CHECK (estado IN ('V', 'G'))
)
go

CREATE TABLE dbo.BANCOS(
	id_banco int identity(1,1) NOT NULL,
	nombre varchar(50) NULL,
	estado char(1) NOT NULL,
	CONSTRAINT pk_bancos PRIMARY KEY (id_banco)
)
go

INSERT INTO BANCOS(nombre, estado) VALUES('BANCO INDUSTRIAL, S.A. (BI)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('EL CREDITO HIPOTECARIO NACIONAL (CHN)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO DE AMERICA CENTRAL, S.A. (BAC-REFORMADOR)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO DE DESARROLLO RURAL, S.A. (BANRURAL)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO AGROMERCANTIL DE GUATEMALA S.A. (BAM)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO DE LOS TRABAJADORES (BANTRAB)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO G&T CONTINENTAL, S.A. (G&T)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO INTERNACIONAL, S.A. (INTERBANCO)', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO FICOHSA GUATEMALA, S.A.', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO INMOBILIARIO, S.A.', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO PROMERICA, S.A.', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO DE ANTIGUA, S.A.', 'V')
go
INSERT INTO BANCOS(nombre, estado) VALUES('BANCO AZTECA DE GUATEMALA, S.A.', 'V')
go

CREATE TABLE dbo.APORTACIONES(
	id_aportacion int identity(1,1) NOT NULL,
	fecha smalldatetime NOT NULL,
	fecha_registro smalldatetime NOT NULL,
	tipo_aportacion varchar(2) NOT NULL,
	no_boleta varchar(15) NULL,
	encargado varchar(75) NOT NULL,
	ayuda1 varchar(75) NULL,
	ayuda2 varchar(75) NULL,
	ayuda3 varchar(75) NULL,
	culto int NULL,
	CONSTRAINT pk_aportaciones PRIMARY KEY (id_aportacion),
	CONSTRAINT chk_aportaciones_tipo_aportacion CHECK (tipo_aportacion IN ('O', 'D', 'SO'))
)
go

CREATE TABLE dbo.DIEZMOS(
	id_aportacion int NOT NULL,
	correlativo int identity(1,1) NOT NULL,
	id_usuario int NULL,
	id_tipo_diezmo int NULL,
	id_banco int NULL,
	no_documento varchar(20) NULL,
	monto_q decimal(14,2) NOT NULL,
	monto_d decimal(14,2) NOT NULL,
	CONSTRAINT pk_diezmos PRIMARY KEY (id_aportacion, correlativo),
	CONSTRAINT fk_diezmos_aportaciones FOREIGN KEY (id_aportacion) REFERENCES APORTACIONES(id_aportacion),
	CONSTRAINT fk_diezmos_usuarios FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario),
	CONSTRAINT fk_diezmos_bancos FOREIGN KEY (id_banco) REFERENCES BANCOS(id_banco)
)
go

CREATE TABLE dbo.OFRENDAS(
	id_aportacion int NOT NULL,
	correlativo int NOT NULL,
	tipo_ofrenda int NOT NULL,
	nombre_billete varchar(50) NULL,
	denominación_billete decimal(7,2) NULL,
	cantidad int NULL,
	moneda int, 
	CONSTRAINT pk_ofrendas PRIMARY KEY (id_aportacion, correlativo, tipo_ofrenda),
	CONSTRAINT fk_ofrendas_aportaciones FOREIGN KEY (id_aportacion) REFERENCES APORTACIONES(id_aportacion)
)
go

CREATE TABLE dbo.GASTOS(
	id_aportacion int NOT NULL,
	correlativo int identity(1,1) NOT NULL,
	descripcion varchar(100) NULL,
	monto decimal(14,2) NULL,
	entregado_a varchar(100) NULL,
	autorizado_por varchar(100) NULL,
	CONSTRAINT pk_gastos PRIMARY KEY (id_aportacion, correlativo),
	CONSTRAINT fk_gastos_aportaciones FOREIGN KEY (id_aportacion) REFERENCES APORTACIONES(id_aportacion)
)
go
