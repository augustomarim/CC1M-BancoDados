create schema if not exists ESTUDO_CASO1;

use ESTUDO_CASO1;

create table if not exists FORNECEDORES(
FORNEC_COD INT primary key,
FORNEC_NOME VARCHAR(45) NOT NULL,
FORNEC_RUA VARCHAR(45) NOT NULL,
FORNEC_NUMRUA INT NOT NULL,
FORNEC_BAIRRO VARCHAR(45) NOT NULL,
FORNEC_CIDADE VARCHAR(45) NOT NULL,
FORNEC_ESTADO VARCHAR(45) NOT NULL,
FORNEC_PAIS VARCHAR(45) NOT NULL,
FORNEC_CODPOSTAL VARCHAR(45) NOT NULL,
FORNEC_TELEFONE VARCHAR(45) NOT NULL,
FORNEC_CONTATO TEXT NOT NULL
);

create table if not exists PRODUTOS(
PROD_COD INT primary key,
PROD_NOME VARCHAR(50) NOT NULL,
PROD_DESCRICAO TEXT NOT NULL,
PROD_ESPECTEC TEXT NOT NULL,
PROD_QUANT DECIMAL(10,3) NOT NULL,
PROD_PRECOUNIT DECIMAL(10,2) NOT NULL,
PROD_UNIDADEMEDIDA VARCHAR(10) NOT NULL,
PROD_ESTOQ_MIN DECIMAL(10,3) NOT NULL
);

create table if not exists FILIAIS(
FIL_COD INT primary key,
FIL_NOME VARCHAR(30) NOT NULL,
FIL_RUA VARCHAR(100) NOT NULL,
FIL_NUMRUA INT NOT NULL,
FIL_BAIRRO VARCHAR(50) NOT NULL,
FIL_CIDADE VARCHAR(50) NOT NULL,
FIL_ESTADO VARCHAR(50) NOT NULL,
FIL_PAIS VARCHAR(50) NOT NULL,
FIL_CODPOSTAL VARCHAR(10) NOT NULL,
FIL_CAPACIDADE TEXT NOT NULL
);

create table if not exists PEDIDOS(
PED_COD INT primary key,
PED_DATA DATE NOT NULL,
PED_HORA TIME NOT NULL,
PED_PREVISAO DATE NOT NULL,
PED_STATUS ENUM('PENDENTE','CONCLUIDO','EM ESPERA') NOT NULL,
PED_FORNECEDOR INT NOT NULL,
constraint FK_FORNECEDOR foreign key (PED_FORNECEDOR) 
references FORNECEDORES(FORNEC_COD) 
);


create table if not exists RECEBIMENTOS(
RECEB_DATA DATE NOT NULL,
RECEB_HORA TIME NOT NULL,
RECEB_QUANT_PROD DECIMAL(10,2) NOT NULL,
RECEB_CONDICAO TEXT NOT NULL,
RECEB_PEDIDOS INT primary key,
constraint FK_PEDIDOS foreign key (RECEB_PEDIDOS) references PEDIDOS(PED_COD)
);

create table if not exists PEDIDOS_PRODUTOS(
PDPR_PEDIDOS INT,
PDPR_PRODUTOS INT,
primary key(PDPR_PEDIDOS,PDPR_PRODUTOS),
PDPR_QUANT decimal(10,2) NOT NULL,
constraint PDPR_PKFK_PEDIDOS foreign key(PDPR_PEDIDOS) references PEDIDOS(PED_COD),
constraint PDPR_PKFK_PRODUTOS foreign key(PDPR_PRODUTOS) references PRODUTOS(PROD_COD)
);

create table if not exists FILIAIS_PRODUTOS(
FLPR_FILIAIS INT,
FLPR_PRODUTOS INT,
primary key(FLPR_FILIAIS,FLPR_PRODUTOS),
FLPR_QUANT decimal(10,2) NOT NULL,
constraint FLPR_FK_FILIAIS foreign key(FLPR_FILIAIS) references FILIAIS(FIL_COD),
constraint FLPR_FK_PRODUTOS foreign key(FLPR_PRODUTOS) references PRODUTOS(PROD_COD)
);

create table if not exists FORNECEDORES_PRODUTOS(
FRPR_FORNECEDORES INT,
FRPR_PRODUTOS INT,
primary key(FRPR_FORNECEDORES,FRPR_PRODUTOS),
constraint FRPR_FK_FORNECEDORES foreign key(FRPR_FORNECEDORES) references FORNECEDORES(FORNEC_COD),
constraint FRPR_FK_PRODUTOS foreign key(FRPR_PRODUTOS) references PRODUTOS(PROD_COD)
);


#ExemploS alters
alter table FORNECEDORES modify column FORNEC_NOME VARCHAR(50) NOT NULL;
alter table PRODUTOS modify column PROD_NOME VARCHAR(60) NOT NULL;
alter table FILIAIS modify column FIL_NOME VARCHAR (40) NOT NULL;
alter table PEDIDOS modify column PED_STATUS VARCHAR(20) NOT NULL;
alter table RECEBIMENTOS modify column RECEB_QUANT_PROD DECIMAL(10,3) NOT NULL;
alter table PEDIDOS_PRODUTOS modify column PDPR_QUANT decimal(10,3) NOT NULL;
alter table FILIAIS_PRODUTOS modify column FLPR_QUANT decimal(10,3) NOT NULL;
alter table FORNECEDORES_PRODUTOS add TWICE INT NOT NULL;
alter table FORNECEDORES_PRODUTOS drop column TWICE;

#Exemplo de DROP
create table if not exists ABC(
A INT primary key
);
drop table ABC
