create database huella_Carbono;
use huella_Carbono;


CREATE TABLE `huella_carbono`.`ciudad` (  
`codigo` VARCHAR(30) NOT NULL,  
`nombre` VARCHAR(20) NOT NULL,  
`emisionPromedio` DOUBLE NOT NULL, check (emisionPromedio>0),
 `pais` VARCHAR(20) NOT NULL,  
`poblacion` INT NOT NULL, check (poblacion>0),  
`area` DOUBLE NOT NULL, check (area>0),  
PRIMARY KEY (`codigo`));



CREATE TABLE `huella_carbono`.`usuario` (  
`codigo` VARCHAR(30) NOT NULL,  
`nombre` VARCHAR(20) NOT NULL,  
`apellido` VARCHAR(20) NOT NULL,  
`fecha_nacimiento` DATE NOT NULL,  
`profesion` VARCHAR(20) NULL,  
`contrasena` VARCHAR(20) NOT NULL,  
`correo` VARCHAR(100) NOT NULL,  
`cod_ciudad` VARCHAR(30) NOT NULL,  
PRIMARY KEY (`codigo`),
  INDEX `cod_ciudad_idx` (`cod_ciudad` ASC),  
CONSTRAINT `cod_ciudad`    
FOREIGN KEY (`cod_ciudad`)    
REFERENCES `huella_carbono`.`ciudad` (`codigo`)    
ON DELETE NO ACTION    
ON UPDATE NO ACTION);



CREATE TABLE `huella_carbono`.`transporte` (
  `codigo` VARCHAR(30) NOT NULL,  
`nombreGenerico` VARCHAR(20) NOT NULL,  
`nombreReal` VARCHAR(20) NULL,  
`co2Km` DOUBLE NOT NULL,  
`marca` VARCHAR(20) NULL,  
`combustible` VARCHAR(20) NOT NULL,  
`descripcion` VARCHAR(100) NULL,  
`cilindraje` DOUBLE NOT NULL,check (cilindraje>0),  
`modelo` INT NOT NULL,check (modelo>1900),  
PRIMARY KEY (`codigo`));

CREATE TABLE `huella_carbono`.`viaje` (
 `cod_viaje` INT  NOT NULL AUTO_INCREMENT,
`cod_usuario` VARCHAR(30) NOT NULL,
`cod_transporte` VARCHAR(30) NOT NULL,
 `fecha` DATE NOT NULL,
`kilometros` DOUBLE NOT NULL,
`totalCo` DOUBLE NOT NULL,  
PRIMARY KEY (`cod_viaje`, `cod_usuario`),    
FOREIGN KEY (`cod_usuario`)
 REFERENCES `huella_carbono`.`usuario` (`codigo`),    
FOREIGN KEY (`cod_transporte`)
    REFERENCES `huella_carbono`.`transporte` (`codigo`));


CREATE TABLE `huella_carbono`.`electrodomestico` (  
`codigo` VARCHAR(30) NOT NULL,  
`nombreGenerico` VARCHAR(20) NOT NULL,  
`nombreReal` VARCHAR(20) NOT NULL,  
`watts` DOUBLE NOT NULL,  
`marca` VARCHAR(20)  NULL,  
`descripcion` VARCHAR(100)  NULL,  
`Co2` DOUBLE NOT NULL,  
PRIMARY KEY (`codigo`));



CREATE TABLE `huella_carbono`.`consumo` (
`cod_consumo` INT  NOT NULL AUTO_INCREMENT,
`cod_usuario` VARCHAR(30) NOT NULL,  
`cod_electro` VARCHAR(30) NOT NULL,  
`fecha` DATE NOT NULL,  
`horasdeUso` INT NOT NULL,  
`totalCo` DOUBLE NULL,  
PRIMARY KEY (`cod_consumo`,`cod_usuario`),
  INDEX `cod_electro_idx` (`cod_electro` ASC),
  CONSTRAINT `cod_usuario`    
FOREIGN KEY (`cod_usuario`)    
REFERENCES `huella_carbono`.`usuario` (`codigo`)    
ON DELETE NO ACTION    
ON UPDATE NO ACTION,  
CONSTRAINT `cod_electro`    
FOREIGN KEY (`cod_electro`)    
REFERENCES `huella_carbono`.`electrodomestico` (`codigo`)
    ON DELETE NO ACTION    
ON UPDATE NO ACTION);

CREATE TABLE `huella_carbono`.`propuesta` (
`num` INT NOT NULL AUTO_INCREMENT, 
`cod_usuario` VARCHAR(30) NOT NULL ,
`tipo` VARCHAR(20) NOT NULL,    
`co2` VARCHAR(20)  NOT NULL,  
`nombreEs` VARCHAR(20) NOT NULL,
`nombrelg` VARCHAR(20) NOT NULL,
`descripcion` VARCHAR(50) NOT NULL,
`fuente` VARCHAR(20) NOT NULL,
PRIMARY KEY (`num`,`cod_usuario`),
FOREIGN KEY (`cod_usuario`)    
REFERENCES `huella_carbono`.`usuario` (`codigo`)
  );



CREATE TABLE `huella_carbono`.`recomendacion` (
`num` INT NOT NULL auto_increment,
`descripcion` VARCHAR(100) NOT NULL,
`reduccion` DOUBLE NOT NULL,
PRIMARY KEY (`num`));



CREATE TABLE `huella_carbono`.`asignacion` (  
`num_recomendacion` INT NOT NULL auto_increment,  
`cod_usuario` VARCHAR(20) NOT NULL,  
`estado` DOUBLE NOT NULL,
`fecha` DATE NOT NULL,
PRIMARY KEY (`num_recomendacion`,`cod_usuario`),
FOREIGN KEY (`num_recomendacion`) 
REFERENCES `huella_carbono`.`recomendacion` (`num`),
FOREIGN KEY (`cod_usuario`)
REFERENCES `huella_carbono`.`usuario` (`codigo`)
);









