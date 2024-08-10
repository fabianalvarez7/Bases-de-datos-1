------------------------------------------------------------
-------------- UNIVERSIDAD NACIONAL DE ROSARIO -------------
-- FACULTAD DE CIENCIAS EXACTAS, INGENIERÍA Y AGRIMENSURA --
--- TECNICATURA UNIVERSITARIA EN INTELIGENCIA ARTIFICIAL ---
--------------------- BASES DE DATOS I ---------------------
------------------- TRABAJO PRÁCTICO N° 1 Y N° 2 ------------------
------------------------------------------------------------
/*
DOCENTES: Fernando Roldán
          Luciano Anselmino
		  Augusto Alvarez Arnesi

ALUMNOS: Gustavo Fabián Alvarez, Legajo: A-4501/2
		 Franco Pilafis, Legajo: P-5288/4
		 Ignacio Coiutti, Legajo: C-7320/2
*/



-- TP1 - CONSIGNA 2: CREACIÓN DE TABLAS

create database Speedy_Gonzalez
use Speedy_Gonzalez

create table PROVINCIAS(
ProvinciaId int identity primary key not null,
Nombre_provincia varchar(20) unique
);

create table CIUDADES(
CodigoPostal varchar(8) primary key not null,
Nombre_ciudad varchar(20) unique,
Provincia int,
foreign key (Provincia) references PROVINCIAS (ProvinciaId)
);

create table TIPO_CLIENTE(
TipoClienteId int identity primary key not null,
Descripcion_tipo_cliente varchar(20) unique not null
);

create table CLIENTES(
CodigoCliente int identity primary key not null,
TipoClienteId int,
Nombre_cliente varchar(20),
Apellido_cliente varchar(20),
DNI_cliente varchar(10),
Razon_social varchar(30),
CUIT varchar(20),
Direccion_cliente varchar(30),
Ciudad_cliente varchar(8),
Telefono_cliente varchar(20),
Email_cliente varchar(30),
foreign key (TipoClienteId) references TIPO_CLIENTE (TipoClienteId),
foreign key (Ciudad_cliente) references CIUDADES (CodigoPostal),
CONSTRAINT validacion_cliente CHECK (TipoClienteId = 1 and razon_social is null and CUIT is null OR
									 TipoClienteId = 2 and Nombre_cliente is null and Apellido_cliente is null and DNI_cliente is null)
);
/* Esta constraint hace la validación del tipo de cliente: si es de tipo persona (1), entonces establace 'null'
para Razon_social y CUIT; y si es de tipo 'empresa' (2), establece 'null' para Nombre, Apellido y DNI */

create table TIPO_REMOLQUE(
TipoRemolqueId int identity primary key not null,
Descripcion_remolque varchar(30) not null
);

create table CAMIONES(
CamionId int identity primary key not null,
Patente varchar(10),
Marca varchar(20),
Modelo varchar(20),
Anio int,
TipoRemolqueId int,
foreign key (TipoRemolqueId) references TIPO_REMOLQUE (TipoRemolqueId)
);

create table CODIGO_REGISTRO(
CodigoRegistro varchar(2) primary key not null,
Descripcion_registro varchar(250) not null
);

create table CONDUCTORES(
ConductorId int identity primary key not null,
Nombre_conductor varchar(20),
Apellido_conductor varchar(20),
DNI_conductor varchar(10),
Direccion_conductor varchar(30),
Ciudad_conductor varchar(8),
Tel_fijo_conductor varchar(15),
Tel_cel_conductor varchar(15),
Edad_conductor int,
Email_conductor varchar(30),
Codigo_registro varchar(2),			
foreign key (Codigo_registro) references CODIGO_REGISTRO (CodigoRegistro),
foreign key (Ciudad_conductor) references CIUDADES (CodigoPostal)
);

create table CAMION_ASIGNADO(
CamionAsignadoId int identity primary key,
ConductorId int,
CamionId int,
fecha_inicio date, 
fecha_fin date,				
foreign key (ConductorId) references CONDUCTORES (ConductorId),
foreign key (CamionId) references CAMIONES (CamionId)
);

create table VIAJES(
CodigoViaje int identity primary key not null,
Cliente int,
Direccion_destino varchar(30),
Ciudad_destino varchar(8),
Direccion_origen varchar(30),
Ciudad_origen varchar(8),
km_recorridos int,					
Salida_estimada date,
Llegada_estimada date,
Salida_efectiva date,
Llegada_efectiva date,
Conductor int,
Camion int,
foreign key (Cliente) references CLIENTES (CodigoCliente),
foreign key (Ciudad_destino) references CIUDADES (CodigoPostal),
foreign key (Ciudad_origen) references CIUDADES (CodigoPostal),
foreign key (Conductor) references CONDUCTORES (ConductorId),
foreign key (Camion) references CAMIONES (CamionId)			
);



-- TP 1 - CONSIGNA 3: INSERCIÓN DE DATOS

insert into PROVINCIAS values
('Santa Fe'),
('Buenos Aires'),
('Entre Ríos'),
('Córdoba'),
('Mendoza');

insert into CIUDADES values
('2000', 'Rosario', 1),
('3000', 'Santa Fe', 1),
('1000', 'Buenos Aires', 2),
('1900', 'La Plata', 2),
('7600', 'Mar del Plata', 2),
('3100', 'Paraná', 3),
('3200', 'Concordia', 3),
('5000', 'Córdoba', 4),
('5800', 'Río Cuarto', 4),
('5900', 'Villa María', 4),
('5500', 'Mendoza', 5);

insert into TIPO_CLIENTE values
('Persona'),
('Empresa');

insert into CLIENTES values
(1, 'Carlos', 'Gonzales', '34136401',null, null,'Peron 101','3000','341554323', 'alfregutierrez@gmail.com'),
(1,'Franco', 'Pilafis', '38547942', null,null,'Santiago 812', '7600', '2984345733','afpialafis@hotmail.com'),
(1,'Ramon', 'Cardo', '38124942', null,null,'Formosa 3022', '2000', '2984555713','Ramon@hotmail.com'),
(1,'Sergio', 'Serpita', '384353942', null,null,'Richeri 8012', '2000', '2984675733','Sergio@hotmail.com'),
(1,'Rodolfo', 'Roca', '38131942', null,null,'Corncordia 820', '1000', '2314555733','Rodolfo@hotmail.com'),
(1,'Ana', 'Anasta', '38547964', null,null,'Av Roca 812', '2000', '6584555733','Ana@hotmail.com'),
(1,'Cristina', 'Kirchner', '32547942', null,null,'Tucuman 1112', '3100', '1184555733','Cristina@hotmail.com'),
(1,'Fernando', 'Contreras', '38547642', null,null,'Rioja 412', '1000', '2344555733','Fernando@hotmail.com'),
(1,'Saul', 'Menem', '38547432', null,null,'Catamarca 3102', '5000', '2986755733','Saul@hotmail.com'),
(1,'Khalil', 'Najul', '38531642', null,null,'Sarmiento 523', '5500', '2982255733','Khalil@hotmail.com'),
(2, null, null, null, '123542534531', 'S.A Rock', 'Sarmiento 645', '5500', '2982255733','Rock@hotmail.com'),
(2, null, null, null, '123544534531', 'S.A dinn', 'Bs As 1001', '5800', '2982642733','dinn@hotmail.com'),
(2, null, null, null, '123567534531', 'Electrus', 'Roca 111', '5000', '123633451','Electrus@hotmail.com'),
(2, null, null, null, '123875534531', 'BamBom', 'Pellegrini 5467', '3200', '3412255733','BamBom@hotmail.com'),
(2, null, null, null, '123421534531', 'S.A Rill', 'Cordoba 22', '3100', '2982299833','Rill@hotmail.com'),
(2, null, null, null, '123975534531', 'Tock Comp', 'Entre Rios 5672', '7600', '2982255733','Comp@hotmail.com'),
(2, null, null, null, '123211534531', 'S.A elefant', 'Santa Fe 1645', '1900', '2981115733','elefant@hotmail.com'),
(2, null, null, null, '123111534531', 'S.A cars', 'Santa Cruz 7854', '1000', '2982250493','cars@hotmail.com'),
(2, null, null, null, '123888534531', 'Truck', 'Rio Negro 7568', '3000', '2982200733','Truck@hotmail.com'),
(2, null, null, null, '123666634531', 'luck', 'Neuquen 2342', '2000', '2982255700','luck@hotmail.com');

insert into TIPO_REMOLQUE values
('Plataforma baja'),
('Plataforma extensible'),
('Plataforma basculante'),
('Caja seca'),
('Caja refrigerada'),
('Caja abierta');

insert into CAMIONES values
('NER162', 'Iveco', 'Tector 170E', 2014, 1),
('PAH331', 'Mercedes-Benz', 'Accelo 815', 2016, 4),
('AA508AB','Volkswagen', 'Constellation', 2017, 6),
('GPW918', 'Mercedes-Benz', 'Atego 1721', 2007, null),
('KVE042', 'Iveco', 'Stralis', 2012, 2),
('AD013GE', 'Scania', 'R-Series', 2018, 3);

insert into CODIGO_REGISTRO values
('B1', 'Automóviles, camionetas, utilitarios, vans de uso privado y casas rodantes motorizadas hasta 3.500 kg de peso total'),
('B2', 'Automóviles, camionetas, vans de uso privado y casas rodantes motorizadas hasta 3500 kg de peso con un acoplado de hasta 750 kg o casa rodante no motorizada'),
('C1', 'Camiones sin acoplado o casas rodantes motorizadas hasta 12.000 kg'),
('C2', 'Camiones sin acoplado, ni semiacoplado, ni articulado y vehículos o casa rodante motorizada de más de 12.000 kg de peso y hasta 24.000 kg'),
('C3', 'Camiones sin acoplado, ni semiacoplado, ni articulado y vehículos o casa rodante motorizada de más de 24.000 kg de peso'),
('E1', 'Vehículos automotores de clase C o D, con uno o más remolques o articulaciones');

insert into CONDUCTORES values
('Juan', 'Funes', '30678912', 'Av. Rivadavia 1823', '1000', null, '115555678', 37, 'juanfu3@gmail.com', 'E1'),
('Hector', 'Quiroga', '16467890', 'San Martín 537', '5000', '3514556919', '3515552345', 49, 'hquiroga62@hotmail.com', 'E1'),
('Carlos', 'López', '18902434', 'Av. Belgrano 789', '2000', '3414612782', '3415559012', 42, 'carlos1274@gmail.com', 'E1'),
('Raúl', 'Bustamante', '23126081', 'Mitre 890', '5500', null, '2615238420', 38, 'raulbusta99@hotmail.com', 'E1'),
('Diego', 'Fernández', '27147561', 'Sarmiento 4388', '2000', null, '3413553271', 36, 'diegofer7@gmail.com', 'E1'),
('Federico', 'Dineno', '19284158', 'Independencia 1823', '2000', null, '3414557419', 40, 'feded13@gmail.com', 'C2'),
('Javier', 'Benavidez', '34729012', 'Belgrano 206', '3000', '3414551042', '3415107265', 33, 'javibenavidez@hotmail.com', 'E1'),
('Marcos', 'Sanchez', '33507820', 'San Juan 518', '3100', null, '343532776', 35, 'marcossanchez32@gmail.com', 'E1'),
('Fernando', 'Luna', '35178123', 'Entre Ríos 941', '2000', null, '3413669012', 33, 'fernandoluna22@gmail.com', 'E1'),
('Mariano', 'Castro', '22834206', 'Av. Pellegrini 884', '3100', null, '3436555121', 41, 'marianc@gmail.com', 'E1');

insert into CAMION_ASIGNADO values
(1, 1, '2023-01-10','2024-01-01'),
(2, 2, '2023-10-10','2023-12-01'),
(3, 3, '2023-08-01','2024-01-01'),
(5, 3, '2023-05-20','2023-07-20'),
(6, 5, '2023-03-01','2024-01-01'),
(7, 4, '2023-01-11','2023-07-10'),
(4, 4, '2023-07-15','2023-10-25'),
(8, 2, '2023-12-10','2024-10-10'),
(9, 4, '2023-11-01','2024-01-01'),
(10, 6, '2022-11-01','2024-01-01'),
(1, 1, '2022-06-01','2022-10-10'),
(3, 5, '2022-09-01','2023-12-01'),
(6, 3, '2022-03-01','2023-02-10'),
(2, 1, '2022-11-01','2023-01-01'),
(3, 4, '2022-12-10','2023-01-10');

INSERT INTO VIAJES VALUES
(1, 'Peron 101', '3000', 'Avenida Central 456', '5900', 882, '2023-01-10', '2023-01-11','2023-01-10', '2024-01-01', 1, 1),
(2, 'Santiago 812', '7600', 'Boulevard Este 012', '1000', 414, '2023-10-11', '2023-10-12', '2023-10-11', '2023-10-12', 2, 2),
(2, 'Formosa 3022', '3100', 'Plaza Oeste 890', '5000', 204, '2023-08-12', '2023-08-12','2023-08-12', '2023-08-12', 3, 3),
(2, 'Richeri 8012', '2000', 'Ronda Central 567', '5800', 880, '2023-05-13', '2023-05-15', '2023-05-13', '2023-05-15', 5, 3),
(2, 'Corncordia 820', '3200', 'Avenida Este 345', '5000', 425, '2023-03-14', '2023-03-15', '2023-03-14', '2023-03-15', 6, 5),
(1, 'Av Roca 812', '3200', 'Calle Este 678', '5000', 401, '2023-01-15', '2023-01-16', '2023-01-15', '2023-01-16', 7, 4),
(1, 'Tucuman 1112', '3100', 'Avenida Sur 123', '5500', 940, '2023-07-16', '2023-07-17',  '2023-07-16', '2023-07-18', 4, 4),
(1, 'Rioja 412', '1000', 'Boulevard Central 890', '3100', 500, '2023-12-17', '2023-12-18', '2023-12-17', '2023-12-18', 8, 2),
(1, 'Catamarca 3102', '2000', 'Plaza Sur 456', '5000', 401, '2023-11-18', '2023-11-19', '2023-11-18', '2023-11-19', 9, 4),
(2, 'Sarmiento 523', '5500', 'Calle Sur 678', '1900', 1003, '2022-11-19', '2022-11-21', '2022-11-19', '2022-11-20', 10, 6),
(2, 'Sarmiento 645', '5500', 'Boulevard Sur 234', '5800', 475, '2022-06-20', '2022-06-21', '2022-06-20', '2022-06-21', 1, 1),
(2, 'Bs As 1001', '5800', 'Avenida Oeste 890', '5000', 214, '2022-09-21', '2022-09-21', '2022-09-21', '2022-09-22', 3, 5),
(2, 'Roca 111', '7600', 'Calle Norte 123', '3100', 913, '2022-03-22', '2022-03-23', '2022-03-22', '2022-03-23', 6, 3),
(1, 'Pellegrini 3100', '1900', 'Plaza Este 567', '7600', 369, '2022-11-23', '2022-11-24', '2022-11-23', '2022-11-24', 2, 1),
(1, 'Cordoba 22', '3200', 'Ronda Oeste 012', '3000', 294, '2022-12-24', '2022-12-24', '2022-12-24', '2022-12-24',3,4);


-- TP1 - CONSIGNA 4.a)
--¿Cuántos viajes se realizaron hacia la provincia de Santa Fe? --

SELECT COUNT(*) AS TotalViajesSantaFe
FROM VIAJES
WHERE Ciudad_destino = '3000'


-- TP1 - CONSIGNA 4.b)
--Mostrar los datos que considere relevantes sobre los viajes realizados desde la provincia de Córdoba durante el primer semestre de 2023 
--

SELECT * FROM VIAJES
WHERE Ciudad_origen = '5000' or Ciudad_origen = '5800' or Ciudad_origen = '5900'
					AND Llegada_estimada BETWEEN '2023-01-01' AND '2023-06-30';


-- TP1 - CONSIGNA 4.c)
--Listar los tres choferes que registraron la mayor cantidad de kilómetros recorridos en el año 2023
--mostrando sus nombres y la cantidad de kilómetros recorridos en orden descendente. 


SELECT TOP 3 c.Nombre_conductor, c.Apellido_conductor, SUM(v.km_recorridos) AS KilometrosRecorridos
FROM CONDUCTORES c
JOIN VIAJES v ON c.ConductorId = v.Conductor
WHERE v.Llegada_efectiva > '01-01-2023'
GROUP BY c.ConductorId, c.Nombre_conductor, c.Apellido_conductor
ORDER BY KilometrosRecorridos DESC;


-- TP1 - CONSIGNA 4.d)
--Obtener una lista de los clientes que solicitaron viajes/envíos en 2023
--junto con los nombres de los choferes y la cantidad de kilómetros recorridos en cada viaje.
--Muestra esta información en orden descendente de kilómetros recorridos --


SELECT cl.CodigoCliente AS 'Codigo cliente', c.Nombre_conductor AS 'Nombre conductor', c.Apellido_conductor AS 'Apellido conductor', v.km_recorridos
FROM CLIENTES cl
JOIN VIAJES v ON cl.CodigoCliente = v.Cliente
JOIN CONDUCTORES c ON v.Conductor = c.ConductorId
WHERE v.Llegada_efectiva > '01-01-2023'
ORDER BY v.km_recorridos DESC;


---------------------------------------------------------------------
-- CORRECCION COLUMNAS Razon_social y CUIT
-- Crear tabla temporal
SELECT CodigoCliente, Razon_social, CUIT INTO #temp FROM CLIENTES;

-- Actualizar tabla original
UPDATE CLIENTES
SET Razon_social = t.CUIT, CUIT = t.Razon_social
FROM CLIENTES
INNER JOIN #temp t ON CLIENTES.CodigoCliente = t.CodigoCliente
WHERE TipoClienteId = 2;
SELECT * FROM CLIENTES;
---------------------------------------------------------------------

/* TP2 - CONSIGNA 1)
Determine si las relaciones presentadas en la resolución del Trabajo Práctico 1 están en 3FN.
En caso afirmativo, justificar por qué. En caso negativo, explicar por qué no lo están 
y realizar las modificaciones necesarias para que sí lo estén. Incluya el diagrama entidad-relación
original y el modificado (en caso de que haya hecho alguna modificación).


En el primer diagrama la relación 'VIAJES' no estaba normalizada, ya que contenía el atributo 'Anio_mes' que se encontraba también
en la relación 'Camion_asignado'. Se decidió quitar el atributo de la tabla 'VIAJES' para evitar la redundancia de datos y además se
lo cambió por 'Fecha_inicio' y 'Fecha_fin' para llevar un mejor control de los períodos de tiempo.
Las demás relaciones sí se encuentran normalizadas. Cada atributo tiene solo valores atómicos en cada una de sus tuplas, es decir no hay
atributos compuestos ni multievaluados (1FN). Además, todos los atributos que no son clave son completamente dependientes de la
clave primaria (2FN). Por último, no se encuentran dependencias transitivas entre los atributos no clave y las claves primarias.
Finalmente aclarar que se modificaron los nombres de algunos atributos para evitar ambigüedades en las consultas, por ejemplo:
'Nombre' por 'Nombre_conductor' o 'Nombre_cliente'
'Apellido' por 'Apellido_conductor' o 'Apellido_cleinte'
'DNI' por 'DNI_cliente' o 'DNI_conductor'
'Ciudad' por 'Ciudad_conductor' o 'Ciudad_cliente'
'Descripción' por 'Descripcion_tipo_cliente', o 'Descripcion_tipo_registro' o 'Descripcion_tipo_remolque'
*/




/* TP2 -  CONSIGNA 2) */

/*Teniendo en cuenta el siguiente requerimiento en el TP1: “Si el cliente es una empresa,
se deben registrar la Razón Social y el CUIT. En caso contrario, se deben registrar
el Nombre, Apellido y DNI.” En el caso de que estos ajustes no se hayan realizado
en el primer TP , realice las modificaciones necesarias en la/las tabla/s de la Base de
datos para que esto sea validado a nivel base de datos mediante el uso de check
constraint.*/

-- Ya resuelto en TP 1.



/* TP2 - CONSIGNA 3)
Identifica en las tablas del diseño de la base de datos campos que se utilicen
en búsquedas o cláusulas WHERE y JOIN, y procede a crear al menos
cinco índices que permitan mejorar la eficiencia de estas consultas. */

CREATE INDEX IDX_Ciudad ON CIUDADES (Nombre_ciudad)

CREATE INDEX IDX_Conductores ON CONDUCTORES (Nombre_conductor, Apellido_conductor)

CREATE INDEX IDX_Cl_Persona ON CLIENTES (Nombre_cliente, Apellido_cliente)

CREATE INDEX IDX_Cl_Empresa ON CLIENTES (Razon_social)

CREATE INDEX IDX_Patentes ON CAMIONES (Patente)

CREATE INDEX IDX_Viajes ON VIAJES (Llegada_efectiva)

EXECUTE sp_helpindex 'CIUDADES';
EXECUTE sp_helpindex 'CONDUCTORES';
EXECUTE sp_helpindex 'CLIENTES';
EXECUTE sp_helpindex 'CAMIONES';
EXECUTE sp_helpindex 'VIAJES';

--Comprobación de rendimiento con índices, pero por la cantidad de datos no se ven diferecias.

SET STATISTICS TIME ON
SELECT Nombre_conductor
FROM CONDUCTORES
SET STATISTICS TIME OFF;

SET STATISTICS TIME ON
SELECT Nombre_conductor
FROM CONDUCTORES
SET STATISTICS TIME OFF;



/* TP2 CONSIGNA 4)  
Diseña un Stored Procedure llamado 'ActualizarViajeEnvio' que acepte parámetros
para identificar un viaje/envío a actualizar y el nuevo valor para la fecha estimada de
llegada. Este SP se utilizará para actualizar, de ser necesario, este campo pero solo se 
debe poder actualizar para viajes que no hayan llegado. */

GO
CREATE PROCEDURE usp_ActualizarViajeEnvio
	@id_viaje int, 
	@Nueva_fecha_llegada  datetime
	
AS
	IF EXISTS (SELECT v.llegada_efectiva, v.CodigoViaje 
			FROM VIAJES v
			WHERE v.CodigoViaje = @id_viaje and v.Llegada_efectiva > GETDATE() )
			UPDATE VIAJES
			SET Llegada_efectiva = @Nueva_fecha_llegada
			WHERE CodigoViaje = @id_viaje
GO			 
			    
EXECUTE usp_ActualizarViajeEnvio @id_viaje = 1 , @Nueva_fecha_llegada = '2028-01-01'



/* TP2 CONSIGNA 5)
Escriba un Stored Procedure llamado 'ObtenerPatenteCamionAsignado’ que acepte
como parámetros de entrada el DNI de un chofer y una fecha de consulta y devuelva
en dos parámetros independientes:
	a) Un mensaje indicando si encontró o no al chofer y si tiene un camión
	asignado en la fecha dada.
	b) La patente del camión asignado al chofer en esa fecha en caso de que se
	encuentre el mismo. */

GO
CREATE PROCEDURE pro_ObtenerPatenteCamionAsignado
	@DNI VARCHAR(10), 
	@fecha_consulta DATETIME,
	@mensaje_chofer VARCHAR (100) OUTPUT,
	@mensaje_fecha VARCHAR (100) OUTPUT,
	@patente VARCHAR (100) OUTPUT
	
AS
BEGIN
	IF NOT EXISTS (SELECT c.DNI_conductor
		FROM CONDUCTORES c
		WHERE c.DNI_conductor = @DNI )
		SET @mensaje_chofer = 'No se encontro el chofer'
	ELSE
		SET @mensaje_chofer = 'Se encontro el chofer'

				IF EXISTS (SELECT ca.ConductorId, ca.Fecha_inicio, ca.Fecha_fin, c.DNI_conductor, c.ConductorId
					FROM CAMION_ASIGNADO ca
					INNER JOIN CONDUCTORES c
					ON ca.ConductorId = c.ConductorId
					WHERE c.DNI_conductor = @DNI AND @fecha_consulta BETWEEN ca.fecha_inicio AND ca.fecha_fin)

					BEGIN
					SET @mensaje_fecha = 'El chofer tiene un camion asignado'
					
					SELECT @patente = n.Patente
					FROM CAMIONES n
					INNER JOIN CAMION_ASIGNADO ca ON n.CamionId = ca.CamionId
					INNER JOIN CONDUCTORES c ON c.ConductorId = ca.ConductorId
					WHERE c.DNI_conductor = @DNI 
					END
				ELSE
				SET @mensaje_fecha = 'El chofer no tiene un camion asignado'
END					
		
DECLARE @mensaje_chofer VARCHAR (100);
DECLARE @mensaje_fecha VARCHAR (100);
DECLARE @patente VARCHAR (100);


EXEC pro_ObtenerPatenteCamionAsignado	
    @DNI = '30678912',
    @fecha_consulta = '2021-01-15',
    @mensaje_chofer = @mensaje_chofer OUTPUT,
    @mensaje_fecha = @mensaje_fecha OUTPUT,
    @patente = @patente OUTPUT;

PRINT 'Mensaje del Chofer: ' + @mensaje_chofer;
PRINT 'Mensaje de la Fecha: ' + @mensaje_fecha;
PRINT 'Patente: ' + @patente;