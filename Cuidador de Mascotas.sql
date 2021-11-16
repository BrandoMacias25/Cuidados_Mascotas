/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CODIGO_CLIENTE       INT4                 not null,
   NOMBRES_CLIENTE      CHAR(30)             null,
   APELLIDOS_CLIENTE    CHAR(30)             null,
   NACIONALIDAD         CHAR(15)             null,
   CEDULA_CLIENTE       CHAR(10)             null,
   FECHA_NACIMIENTOCLIENTE DATE                 null,
   GENERO               CHAR(15)             null,
   DIRECCION            CHAR(20)             null,
   TELEFONO_CLIENTE     CHAR(10)             null,
   TELEFONO_COMPLEMENTARIO CHAR(10)             null,
   constraint PK_CLIENTE primary key (CODIGO_CLIENTE)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
CODIGO_CLIENTE
);

/*==============================================================*/
/* Table: CUIDADOR                                              */
/*==============================================================*/
create table CUIDADOR (
   CODIGO_CUIDADORES    INT4                 not null,
   NOMBRE_CUIDADOR      CHAR(20)             null,
   FECHA_INGRESO        DATE                 null,
   PAGO_HORA            DECIMAL              null,
   HORAS_TRABAJADAS     INT4                 null,
   MASCOTA_POR_SEMANA   INT4                 null,
   MASCOTAS_ABANDONADAS CHAR(20)             null,
   CANTIDAD_ABANDONADAS INT4                 null,
   CANTIDAD_ADOPCION    INT4                 null,
   INGRESO_GENERADO     INT4                 null,
   constraint PK_CUIDADOR primary key (CODIGO_CUIDADORES)
);

/*==============================================================*/
/* Index: CUIDADOR_PK                                           */
/*==============================================================*/
create unique index CUIDADOR_PK on CUIDADOR (
CODIGO_CUIDADORES
);

/*==============================================================*/
/* Table: CUIDADOR_MASCOTA                                      */
/*==============================================================*/
create table CUIDADOR_MASCOTA (
   CODIGO_CUIDADORES    INT4                 not null,
   CODIGO_MASCOTA       INT4                 not null,
   CODIGO_CLIENTE       INT4                 not null,
   CANTIDAD_MASCOTA     INT4                 null,
   MASCOTAS_ANUALES     DATE                 null, 
   constraint PK_CUIDADOR_MASCOTA primary key (CODIGO_CUIDADORES, CODIGO_MASCOTA, CODIGO_CLIENTE)
);

/*==============================================================*/
/* Index: CUIDADOR_MASCOTA_PK                                   */
/*==============================================================*/
create unique index CUIDADOR_MASCOTA_PK on CUIDADOR_MASCOTA (
CODIGO_CUIDADORES,
CODIGO_MASCOTA,
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: TIENEN_FK                                             */
/*==============================================================*/
create  index TIENEN_FK on CUIDADOR_MASCOTA (
CODIGO_MASCOTA,
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: PUEDEN_FK                                             */
/*==============================================================*/
create  index PUEDEN_FK on CUIDADOR_MASCOTA (
CODIGO_CUIDADORES
);

/*==============================================================*/
/* Table: FORMA_PAGO                                            */
/*==============================================================*/
create table FORMA_PAGO (
   CODIGO_PAGO          INT4                 not null,
   PLAN_DIARIO          INT4                 null,
   PLAN_SEMANAL         INT4                 null,
   PLAN_MENSUAL         INT4                 null,
   PLAN_ANUAL           INT4                 null,
   constraint PK_FORMA_PAGO primary key (CODIGO_PAGO)
);

/*==============================================================*/
/* Index: FORMA_PAGO_PK                                         */
/*==============================================================*/
create unique index FORMA_PAGO_PK on FORMA_PAGO (
CODIGO_PAGO
);

/*==============================================================*/
/* Table: MASCOTA                                               */
/*==============================================================*/
create table MASCOTA (
   CODIGO_MASCOTA       INT4                 not null,
   CODIGO_CLIENTE       INT4                 not null,
   CODIGO_RAZA          INT4                 not null,
   FECHA_NACIMIENTOMASCOTA DATE                 null,
   CARACTERISTICAS      CHAR(50)             null,
   SERVICIOS            CHAR(30)             null,
   FECHA_INICIO         DATE                 null,
   FECHA_SALIDA         DATE                 null,
   constraint PK_MASCOTA primary key (CODIGO_MASCOTA, CODIGO_CLIENTE)
);

/*==============================================================*/
/* Index: MASCOTA_PK                                            */
/*==============================================================*/
create unique index MASCOTA_PK on MASCOTA (
CODIGO_MASCOTA,
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: GENERA_FK                                             */
/*==============================================================*/
create  index GENERA_FK on MASCOTA (
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: PUEDE_FK                                              */
/*==============================================================*/
create  index PUEDE_FK on MASCOTA (
CODIGO_RAZA
);

/*==============================================================*/
/* Table: PLAN                                                  */
/*==============================================================*/
create table PLAN (
   CODIGO_PAGO          INT4                 not null,
   CODIGO_CLIENTE       INT4                 not null,
   FECHA_COMIENZO       DATE                 null,
   FECHA_VENCIMIENTO    DATE                 null,
   VALOR_PAGAR          INT4                 null,
   VALOR_PAGADO         INT4                 null,
   constraint PK_PLAN primary key (CODIGO_PAGO, CODIGO_CLIENTE)
);

/*==============================================================*/
/* Index: PLAN_PK                                               */
/*==============================================================*/
create unique index PLAN_PK on PLAN (
CODIGO_PAGO,
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create  index TIENE_FK on PLAN (
CODIGO_CLIENTE
);

/*==============================================================*/
/* Index: ACCEDE_FK                                             */
/*==============================================================*/
create  index ACCEDE_FK on PLAN (
CODIGO_PAGO
);

/*==============================================================*/
/* Table: RAZA                                                  */
/*==============================================================*/
create table RAZA (
   CODIGO_RAZA          INT4                 not null,
   ORIGEN_RAZA          CHAR(40)             null,
   constraint PK_RAZA primary key (CODIGO_RAZA)
);

/*==============================================================*/
/* Index: RAZA_PK                                               */
/*==============================================================*/
create unique index RAZA_PK on RAZA (
CODIGO_RAZA
);

alter table CUIDADOR_MASCOTA
   add constraint FK_CUIDADOR_PUEDEN_CUIDADOR foreign key (CODIGO_CUIDADORES)
      references CUIDADOR (CODIGO_CUIDADORES)
      on delete restrict on update restrict;

alter table CUIDADOR_MASCOTA
   add constraint FK_CUIDADOR_TIENEN_MASCOTA foreign key (CODIGO_MASCOTA, CODIGO_CLIENTE)
      references MASCOTA (CODIGO_MASCOTA, CODIGO_CLIENTE)
      on delete restrict on update restrict;

alter table MASCOTA
   add constraint FK_MASCOTA_GENERA_CLIENTE foreign key (CODIGO_CLIENTE)
      references CLIENTE (CODIGO_CLIENTE)
      on delete restrict on update restrict;

alter table MASCOTA
   add constraint FK_MASCOTA_PUEDE_RAZA foreign key (CODIGO_RAZA)
      references RAZA (CODIGO_RAZA)
      on delete restrict on update restrict;

alter table PLAN
   add constraint FK_PLAN_ACCEDE_FORMA_PA foreign key (CODIGO_PAGO)
      references FORMA_PAGO (CODIGO_PAGO)
      on delete restrict on update restrict;

alter table PLAN
   add constraint FK_PLAN_TIENE_CLIENTE foreign key (CODIGO_CLIENTE)
      references CLIENTE (CODIGO_CLIENTE)
      on delete restrict on update restrict;
	  
	  
	  
	  
	  
/*==============================================================*/
/* Insertar datos en la tabla cliente                           */
/*==============================================================*/
insert into cliente (codigo_cliente, nombres_cliente, apellidos_cliente, nacionalidad, cedula_cliente, fecha_nacimientocliente, genero, direccion, telefono_cliente, telefono_complementario) values ('00001','Jose Alfredo','Mendoza Martinez','Ecuatoriano','1682493756','25/08/1980','Masculino','Los Esteros','0968463872','0985297613');
insert into cliente (codigo_cliente, nombres_cliente, apellidos_cliente, nacionalidad, cedula_cliente, fecha_nacimientocliente, genero, direccion, telefono_cliente, telefono_complementario) values ('00002','Federick Antonio','Macias Fernandez','Colombiano','1308549353','07/11/1992','Masculino','San Pedro','0989764381','0969985317');
insert into cliente (codigo_cliente, nombres_cliente, apellidos_cliente, nacionalidad, cedula_cliente, fecha_nacimientocliente, genero, direccion, telefono_cliente, telefono_complementario) values ('00003','Susana Sofia','Intriago Perez','Peruana','1316863492','12/03/1990','Femenino','Montecristi','0959384065','0983951674');
insert into cliente (codigo_cliente, nombres_cliente, apellidos_cliente, nacionalidad, cedula_cliente, fecha_nacimientocliente, genero, direccion, telefono_cliente, telefono_complementario) values ('00004','Alberto Felipe','Mercedes Mero','Ecuatoriano','1353492861','27/03/1985','Masculino','Tarqui','096522156','0952659762');
insert into cliente (codigo_cliente, nombres_cliente, apellidos_cliente, nacionalidad, cedula_cliente, fecha_nacimientocliente, genero, direccion, telefono_cliente, telefono_complementario) values ('00005','Cristina Carolina','Alcivar Mera','Ecuatoriana','1356963258','01/08/2000','Femenino','Pradera','0982816439','0969655861')
/*==============================================================*/
/* Insertar datos en la tabla cuidador                          */
/*==============================================================*/
insert into cuidador (codigo_cuidadores, nombre_cuidador, fecha_ingreso, pago_hora, horas_trabajadas, mascota_por_semana, mascotas_abandonadas, cantidad_abandonadas, cantidad_adopcion, ingreso_generado) values ('00101', 'Juan Macias', '20/06/2018', '0.75', '1000', '3', 'Gato', '15', '7', '600' );
insert into cuidador (codigo_cuidadores, nombre_cuidador, fecha_ingreso, pago_hora, horas_trabajadas, mascota_por_semana, mascotas_abandonadas, cantidad_abandonadas, cantidad_adopcion, ingreso_generado) values ('00102', 'Felipe Moreira', '05/07/2019', '0.50', '700', '3', 'Perro', '20','13', '500');
insert into cuidador (codigo_cuidadores, nombre_cuidador, fecha_ingreso, pago_hora, horas_trabajadas, mascota_por_semana, mascotas_abandonadas, cantidad_abandonadas, cantidad_adopcion, ingreso_generado) values ('00103', 'Kevin Perez', '25/10/2020', '1', '400', '3', 'Pajaro', '25', '10', '400')
/*==============================================================*/
/* Insertar datos en la tabla cuidador_mascota                  */
/*==============================================================*/
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00101', '10001', '00001', '10', '11/11/2021');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00101', '10002', '00001', '15', '11/11/2021');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00101', '10003', '00001', '20', '11/11/2021');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00102', '10004', '00002', '50', '31/12/2020');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00102', '10005', '00002', '18', '31/12/2020');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00102', '10006', '00003', '30', '31/12/2020');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00103', '10007', '00004', '42', '31/12/2019');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00103', '10008', '00005', '36', '31/12/2019');
insert into cuidador_mascota (codigo_cuidadores, codigo_mascota, codigo_cliente, cantidad_mascota, mascotas_anuales) values ('00103', '10009', '00005', '29', '31/12/2019')
/*==============================================================*/
/* Insertar datos en la tabla forma_pago                        */
/*==============================================================*/
insert into forma_pago (codigo_pago, plan_diario) values ('01001','5');
insert into forma_pago (codigo_pago, plan_semanal) values ('01002','20');
insert into forma_pago (codigo_pago, plan_mensual) values ('01003','120');
insert into forma_pago (codigo_pago, plan_anual) values ('01004','1600')
/*==============================================================*/
/* Insertar datos en la tabla mascota                           */
/*==============================================================*/
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10001', '00001', '11001', '25/10/2020','Color gris y ojos color azul','Baño','18/01/2021','22/01/2021');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10002', '00001', '11002', '19/01/2018','Color blanco y ojos color cafe','Baño','01/02/2021','01/02/2021');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10003', '00001', '11003', '30/05/2018','Color cafe y ojos color azul','Cuidado','11/05/2021','11/05/2021');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10004', '00002', '11001', '15/12/2020','Color negro y ojos color verde','Cuidado','24/10/2020','29/10/2020');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10005', '00002', '11002', '03/11/2019','Color blanco y negro, ojos color negro','Baño','21/07/2020','22/07/2020');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10006', '00003', '11003', '09/09/2019','Color blanco y cafe, ojos color negro','Arreglo','17/07/2019','17/07/2020');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10007', '00004', '11001', '26/06/2018','Color cafe y negro, ojos color cafe','Cuidado','28/04/2019','28/04/2019');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10008', '00005', '11002', '02/03/2018','Color blanco y gris, ojos color azul','Arreglo','30/06/2019','30/06/2019');
insert into mascota (codigo_mascota, codigo_cliente, codigo_raza, fecha_nacimientomascota, caracteristicas, servicios, fecha_inicio, fecha_salida) values ('10009', '00005', '11003', '07/10/2019','Color cafe y gris, ojos color celeste','Arreglo','22/09/2019','22/11/2019')
/*==============================================================*/
/* Insertar datos en la tabla plan                              */
/*==============================================================*/
insert into plan (codigo_pago, codigo_cliente, fecha_comienzo, fecha_vencimiento, valor_pagar, valor_pagado) values ('01004', '00001', '11/05/2020', '11/05/2021', '0', '1600');
insert into plan (codigo_pago, codigo_cliente, fecha_comienzo, fecha_vencimiento, valor_pagar, valor_pagado) values ('01003', '00002', '21/07/2020', '21/10/2020', '300', '480');
insert into plan (codigo_pago, codigo_cliente, fecha_comienzo, fecha_vencimiento, valor_pagar, valor_pagado) values ('01001', '00003', '17/07/2019', '17/07/2019', '15', '0');
insert into plan (codigo_pago, codigo_cliente, fecha_comienzo, fecha_vencimiento, valor_pagar, valor_pagado) values ('01001', '00004', '28/04/2019', '28/04/2019', '120', '120');
insert into plan (codigo_pago, codigo_cliente, fecha_comienzo, fecha_vencimiento, valor_pagar, valor_pagado) values ('01003', '00005', '30/06/2019', '30/07/2019', '0',  '120')
/*==============================================================*/
/* Insertar datos en la tabla raza                              */
/*==============================================================*/
insert into raza (codigo_raza, origen_raza) values ('11001','Gato');
insert into raza (codigo_raza, origen_raza) values ('11002','Perro');
insert into raza (codigo_raza, origen_raza) values ('11003','Pajaro');

select 
cuidador.ingreso_generado as ingreso,
raza.origen_raza as tipo
from cuidador
inner join cuidador_mascota on cuidador_mascota.codigo_cuidadores=cuidador_mascota.codigo_cuidadores
inner join mascota on cuidador_mascota.codigo_mascota=mascota.codigo_mascota
inner join raza on mascota.codigo_raza=raza.codigo_raza

select*from cliente 
select*from cuidador
select*from cuidador_mascota
select*from mascota
select*from raza
select*from forma_pago
select*from plan



-- CONSULTAS

select
mascota.codigo_mascota,
raza.origen_raza as mascotas,
mascota.servicios,
cuidador_mascota.cantidad_mascota,
extract(Year from mascota.fecha_inicio) as anual
from cliente
inner join mascota on cliente.codigo_cliente=mascota.codigo_cliente
inner join raza on mascota.codigo_raza=raza.codigo_raza
inner join cuidador_mascota on mascota.codigo_mascota=cuidador_mascota.codigo_mascota


select 
cuidador.codigo_cuidadores,
cuidador.nombre_cuidador,
raza.origen_raza as mascotas,
cuidador_mascota.cantidad_mascota,
extract (Year from cuidador_mascota.mascotas_anuales) as anual
from mascota
inner join cuidador_mascota on mascota.codigo_mascota=cuidador_mascota.codigo_mascota
inner join cuidador on cuidador_mascota.codigo_cuidadores=cuidador.codigo_cuidadores
inner join raza on mascota.codigo_raza=raza.codigo_raza

select
cliente.codigo_cliente,
cliente.nombres_cliente,
raza.origen_raza as mascotas,
plan.valor_pagado,
plan.valor_pagar
from cliente
inner join plan on cliente.codigo_cliente=plan.codigo_cliente
inner join mascota on cliente.codigo_cliente=mascota.codigo_cliente
inner join raza on mascota.codigo_raza=raza.codigo_raza

select
cuidador.codigo_cuidadores,
cuidador.nombre_cuidador,
cuidador.mascotas_abandonadas,
cuidador.cantidad_abandonadas,
extract (Year from cuidador_mascota.mascotas_anuales) as abandono_anual
from mascota
inner join cuidador_mascota on mascota.codigo_mascota=cuidador_mascota.codigo_mascota
inner join cuidador on cuidador_mascota.codigo_cuidadores=cuidador.codigo_cuidadores





-- TRIGGERS
create table LOG_TRIGGERS (               
   NOMBRE_CUIDADOR  CHAR(20),             
   MASCOTAS_SEMANA  INT4            
);

create or replace function SP_Test() returns trigger
as
$$
begin	
		if new.nombre_cuidador is null then
			Raise Exception 'No se inserto el nombre del empleado';
		end if;
		
		if new.mascotas_semana is null then
			Raise Exception '% No se inserto el numero de mascotas por semana', new.mascotas_semana;
		end if;
		
		if new.mascotas_semana > 3 then
			Raise Exception '% No se permite más de 3 mascotas por semana',new.mascotas_semana;
		end if;
		return new;
end
$$
language plpgsql;

create trigger Tr_Test before insert on log_triggers
for each row execute procedure SP_Test();

insert into log_triggers (
nombre_cuidador,
mascotas_semana
)
values
(
'Juan Macias',
5
)

Select*from log_triggers




-- CURSOR
do $$
declare 

		registro Record;
		Cur_cuidador Cursor for select * from "cuidador";
		
begin
Open Cur_cuidador;
Fetch Cur_cuidador into registro;
while (Found) loop
Raise Notice 'tipo_mascota: %, cantidad_abandonadas: %, cantidad_adopcion: %, ingreso_generado: %',
              registro.mascotas_abandonadas,registro.cantidad_abandonadas,registro.cantidad_adopcion,registro.ingreso_generado; 
Fetch Cur_cuidador into registro;
end loop;
end $$
Language plpgsql;

		
	
--Procedimiento Almacenado
Create function  Atenciones (varchar) returns int 
as
$$
		select
		cuidador_mascota.cantidad_mascota
		from cuidador_mascota
		inner join mascota on cuidador_mascota.codigo_mascota=mascota.codigo_mascota
		inner join cuidador on cuidador_mascota.codigo_cuidadores=cuidador.codigo_cuidadores
		where nombre_cuidador = $1
$$
Language sql;
select Atenciones ('Juan Macias')
select Atenciones ('Felipe Moreira')
select Atenciones ('Kevin Perez')

		
