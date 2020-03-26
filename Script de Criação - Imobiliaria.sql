-- MySQL Script generated by MySQL Workbench
-- Sat Mar 21 22:17:42 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bdImobiliaria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bdImobiliaria` ;

-- -----------------------------------------------------
-- Schema bdImobiliaria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdImobiliaria` DEFAULT CHARACTER SET utf8 ;
USE `bdImobiliaria` ;

-- -----------------------------------------------------
-- Table `bdImobiliaria`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`bairro` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`endereco` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(30) NOT NULL,
  `numero_casa` INT UNSIGNED NOT NULL,
  `CEP` INT UNSIGNED NOT NULL,
  `complemento` VARCHAR(80),
  `id_bairro` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `id_bairro_UNIQUE` (`id_bairro` ASC),
  UNIQUE INDEX `numero_casa_UNIQUE` (`numero_casa` ASC),
  CONSTRAINT `id_bairro`
    FOREIGN KEY (`id_bairro`)
    REFERENCES `bdImobiliaria`.`bairro` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`pessoa` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(11) NOT NULL,
  `id_endereco` INT UNSIGNED NOT NULL,
  `estado_civil` VARCHAR(15) NOT NULL,
  `sexo` ENUM('F', 'M') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) ,
  INDEX `id_endereco_idx` (`id_endereco` ASC),
  CONSTRAINT `id_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `bdImobiliaria`.`endereco` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`cliente_proprietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`cliente_proprietario` (
  `profissao` VARCHAR(30) NOT NULL,
  `id_pessoa` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_cliente_proprietario_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `bdImobiliaria`.`pessoa` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`fotos` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `foto1` TINYBLOB NULL,
  `foto2` TINYBLOB NULL,
  `foto3` TINYBLOB NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`imovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`imovel` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_endereco` INT UNSIGNED NOT NULL,
  `data_construcao` DATE NOT NULL,
  `data_alugado_vendido` DATE NULL,
  `data_postagem` DATE NOT NULL,
  `id_fotos` INT UNSIGNED NOT NULL,
  `valor_sugerido_cliente_proprietario` DOUBLE NOT NULL,
  `status` ENUM('Disponível para Venda', 'Disponível para Aluguel', 'Vendido', 'Alugado', 'Indisponível') NOT NULL,
  `area` DOUBLE UNSIGNED NOT NULL,
  `categoria` ENUM('Casa', 'Apartamento', 'Sala Comercial', 'Terreno') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `endereco_UNIQUE` (`id_endereco` ASC),
  UNIQUE INDEX `id_fotos_UNIQUE` (`id_fotos` ASC),
  CONSTRAINT `id_endereço`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `bdImobiliaria`.`endereco` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_fotos`
    FOREIGN KEY (`id_fotos`)
    REFERENCES `bdImobiliaria`.`fotos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`cliente_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`cliente_usuario` (
  `fiador1` VARCHAR(30) NOT NULL,
  `indicacao1` VARCHAR(30) NOT NULL,
  `indicacao2` VARCHAR(30) NOT NULL,
  `indicacao3` VARCHAR(30) NULL,
  `id_pessoa` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_cliente_usuario_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `bdImobiliaria`.`pessoa` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`cargo` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `salario_base` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`funcionario` (
  `id_cargo` INT UNSIGNED NOT NULL,
  `usuario` VARCHAR(30) NOT NULL,
  `senha` VARCHAR(128) NOT NULL,
  `data_ingresso` DATE NOT NULL,
  `id_pessoa` INT UNSIGNED NOT NULL,
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  INDEX `id_cargo_idx` (`id_cargo` ASC),
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `id_cargo`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `bdImobiliaria`.`cargo` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `bdImobiliaria`.`pessoa` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`casa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`casa` (
  `qntd_quarto` INT UNSIGNED NOT NULL,
  `qntd_suite` INT UNSIGNED NOT NULL,
  `qntd_sala_estar` INT UNSIGNED NOT NULL,
  `qntd_sala_jantar` INT UNSIGNED NOT NULL,
  `nmro_vagas` INT UNSIGNED NOT NULL,
  `has_armario_embutido` TINYINT NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `id_casa` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_casa`),
  CONSTRAINT `fk_casa_imovel1`
    FOREIGN KEY (`id_casa`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`apartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`apartamento` (
  `andar` INT UNSIGNED NOT NULL,
  `valor_condominio` DOUBLE UNSIGNED NOT NULL,
  `has_portaria` TINYINT NOT NULL,
  `id_apartamento` INT UNSIGNED NOT NULL,
  `qntd_quarto` INT UNSIGNED NOT NULL,
  `qntd_suite` INT UNSIGNED NOT NULL,
  `qntd_sala_estar` INT UNSIGNED NOT NULL,
  `qntd_sala_jantar` INT UNSIGNED NOT NULL,
  `nmro_vagas` INT UNSIGNED NOT NULL,
  `has_armario_embutido` TINYINT NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_apartamento`),
  CONSTRAINT `fk_apartamento_casa1`
    FOREIGN KEY (`id_apartamento`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`pagamento` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `valor` DOUBLE UNSIGNED NOT NULL,
  `forma_pagamento` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`sala_comercial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`sala_comercial` (
  `qntd_banheiro` INT UNSIGNED NOT NULL,
  `qntd_comodo` INT UNSIGNED NOT NULL,
  `id_sala_comercial` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_sala_comercial`),
  CONSTRAINT `fk_sala_comercial_imovel1`
    FOREIGN KEY (`id_sala_comercial`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`terreno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`terreno` (
  `largura` DOUBLE UNSIGNED NOT NULL,
  `comprimento` DOUBLE UNSIGNED NOT NULL,
  `tipo_inclinacao` ENUM('Aclive', 'Declive', 'Sem Inclinação') NULL,
  `id_terreno` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_terreno`),
  CONSTRAINT `fk_terreno_imovel1`
    FOREIGN KEY (`id_terreno`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`relacao_proprietario_imovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`relacao_proprietario_imovel` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_imovel` INT UNSIGNED NOT NULL,
  `id_proprietario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `id_imovel_idx` (`id_imovel` ASC),
  INDEX `id_proprietario_idx` (`id_proprietario` ASC),
  CONSTRAINT `id_imovel`
    FOREIGN KEY (`id_imovel`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_proprietario`
    FOREIGN KEY (`id_proprietario`)
    REFERENCES `bdImobiliaria`.`cliente_proprietario` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`relacao_cliente_usuario_imovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`relacao_cliente_usuario_imovel` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_imovel_usuario` INT UNSIGNED NOT NULL,
  `id_cliente_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `id_imovel_idx` (`id_imovel_usuario` ASC),
  INDEX `id_cliente_usuario_idx` (`id_cliente_usuario` ASC),
  CONSTRAINT `id_imovel_usuario`
    FOREIGN KEY (`id_imovel_usuario`)
    REFERENCES `bdImobiliaria`.`imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente_usuario`
    FOREIGN KEY (`id_cliente_usuario`)
    REFERENCES `bdImobiliaria`.`cliente_usuario` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`transacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`transacao` (
  `ID` INT UNSIGNED NOT NULL,
  `id_rel_clienteUsuario_imovel` INT UNSIGNED NOT NULL,
  `id_func_responsavel` INT UNSIGNED NOT NULL,
  `data_transacao` DATE NOT NULL,
  `comissao_func` DOUBLE UNSIGNED NOT NULL,
  `id_pagamento` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `id_pagamento_idx` (`id_pagamento` ASC) ,
  INDEX `id_func_responsavel_idx` (`id_func_responsavel` ASC),
  INDEX `id_rel_usuario_imovel_idx` (`id_rel_clienteUsuario_imovel` ASC),
  CONSTRAINT `id_pagamento`
    FOREIGN KEY (`id_pagamento`)
    REFERENCES `bdImobiliaria`.`pagamento` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_func_responsavel`
    FOREIGN KEY (`id_func_responsavel`)
    REFERENCES `bdImobiliaria`.`funcionario` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_rel_usuario_imovel`
    FOREIGN KEY (`id_rel_clienteUsuario_imovel`)
    REFERENCES `bdImobiliaria`.`relacao_cliente_usuario_imovel` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`contrato` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comissao_imobiliaria` DOUBLE UNSIGNED NOT NULL,
  `id_transacao` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `id_transacao_UNIQUE` (`id_transacao` ASC),
  CONSTRAINT `id_transacao`
    FOREIGN KEY (`id_transacao`)
    REFERENCES `bdImobiliaria`.`transacao` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`tel_email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`tel_email` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pessoa` INT UNSIGNED NOT NULL,
  `telefone_contato` VARCHAR(15) NOT NULL,
  `telefone_celular` VARCHAR(15) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `id_pessoa_UNIQUE` (`id_pessoa` ASC),
  UNIQUE INDEX `telefone_contato_UNIQUE` (`telefone_contato` ASC),
  UNIQUE INDEX `telefone_celular_UNIQUE` (`telefone_celular` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `id_pessoa`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `bdImobiliaria`.`pessoa` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bdImobiliaria`.`historico`
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`historico` (
 `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_endereco_hist` INT UNSIGNED NOT NULL,
  `data_construcao` DATE NOT NULL,
  `data_alugado_vendido` DATE NULL,
  `data_postagem` DATE NOT NULL,
  `id_fotos_hist` INT UNSIGNED NOT NULL,
  `valor_sugerido_cliente_proprietario` DOUBLE NOT NULL,
  `status` ENUM('Disponível para Venda', 'Disponível para Aluguel', 'Vendido', 'Alugado', 'Indisponível') NOT NULL,
  `area` DOUBLE UNSIGNED NOT NULL,
  `categoria` ENUM('Casa', 'Apartamento', 'Sala Comercial', 'Terreno') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `endereco_UNIQUE` (`id_endereco_hist` ASC),
  UNIQUE INDEX `id_fotos_UNIQUE` (`id_fotos_hist` ASC),
  CONSTRAINT `id_endereco_hist`
    FOREIGN KEY (`id_endereco_hist`)
    REFERENCES `bdImobiliaria`.`endereco` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_fotos_hist`
    FOREIGN KEY (`id_fotos_hist`)
    REFERENCES `bdImobiliaria`.`fotos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


--
-- Insercao em bairro
--
INSERT INTO `bairro` (`ID`, `nome`) VALUES (1, 'Aviário');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (2, 'Feira VI');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (3, 'Parque IPÊ');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (4, 'Queimadinha');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (5, 'Sobradinho');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (6, 'Brasília');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (7, 'Cidade Nova');
INSERT INTO `bairro` (`ID`, `nome`) VALUES (8, 'Tomba');

--
-- Insercao em endereco
--
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (1, 'Rua A', 100, 4405456, 'Perto do posto Ipiranga', 1);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (2, 'Rua B', 200, 4405457, 'Perto do posto Texaco', 2);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (3, 'Rua C', 300, 4405458, 'Em frente a casa roxa', 4);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (4, 'Rua D', 400, 4405457, 'Próximo a policlínica', 3);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (5, 'Rua 12', 236, 4403337, '', 5);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (6, 'Avenida João Durval', 319, 4401807, 'Próximo à Lotérica', 8);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (7, 'Travessa H', 46, 4404567, 'Vizinho a padaria', 6);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (8, 'Rua dos Soldados', 1080, 4405412, '', 7);
INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES (9, 'Avenida Maria Quitéria', 144, 4403212, '', 7);

--
-- Insercao em Cargo
--
INSERT INTO `cargo` (`ID`, `nome`, `salario_base`) VALUES (1, 'Corretor', 1000);
INSERT INTO `cargo` (`ID`, `nome`, `salario_base`) VALUES (2, 'Gerente', 5000);
INSERT INTO `cargo` (`ID`, `nome`, `salario_base`) VALUES (3, 'Sub-gerente', 3000);

--
-- Insercao em pessoa
--
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (1, 'Francisco Hugo', 'Rezende', '92546317599', 1, 'Solteiro', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (2, 'Gabriel ', 'Medina', '92546317598', 2, 'Casado', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (3, 'Fátima ', 'Bernardes', '92546317597', 3, 'Casada', 'F');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (4, 'Ruan', 'Portos', '92546317592', 4, 'Solteiro', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (5, 'Jonathan', 'Joestar', '8765234512', 5, 'Solteiro', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (6, 'Erina', 'Pendrosa', '6549321785', 6, 'Viúva', 'F');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (7, 'Dio', 'Brando', '1398348756', 7, 'Solteiro', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (8, 'José', 'Joestar', '55864523322', 8, 'Casado', 'M');
INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `estado_civil`, `sexo`) VALUES (9, 'Elisabeth', 'Quenst', '1223109876', 9, 'Solteira', 'F');

--
-- Insercao em cliente_proprietario
--
INSERT INTO `cliente_proprietario` (`profissao`, `id_pessoa`) VALUES ('Carpinteiro', 1);
INSERT INTO `cliente_proprietario` (`profissao`, `id_pessoa`) VALUES ('Professor', 2);
INSERT INTO `cliente_proprietario` (`profissao`, `id_pessoa`) VALUES ('Advogada', 3);

--
-- Insercao em fotos
--
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (1,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (2,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (3,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (4,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (5,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (6,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (7,'','','');
INSERT INTO `fotos`(`ID`,`foto1`,`foto2`,`foto3`) VALUES (8,'','','');

--
-- Insercao em imovel
--
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (1, 1, '2013-07-15', NULL, '2019-02-11', 1, 140000, 'Disponível para Venda', 400, 'Casa');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (2, 2, '2010-09-09', NULL, '2020-02-23', 2, 3500, 'Disponível para Aluguel', 600, 'Apartamento');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (3, 3, '2017-12-05', NULL, '2018-03-10', 3, 200000, 'Disponível para Venda', 380, 'Terreno');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (4, 4, '2015-02-07', NULL, '2019-10-14', 4, 2000, 'Disponível para Aluguel', 300, 'Sala Comercial');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (5, 5, '2013-01-01', '2019-12-23', '2017-03-10', 5, 800000, 'Vendido', 550, 'Casa');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (6, 6, '2005-04-18', '2019-08-16', '2018-08-06', 6, 1900, 'Alugado', 300, 'Apartamento');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (7, 7, '2010-06-02', NULL, '2017-06-09', 7, 200000, 'Disponível para Venda', 355, 'Terreno');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (8, 8, '2015-11-09', NULL, '2018-09-11', 8, 700, 'Disponível para Aluguel', 400, 'Sala Comercial');
INSERT INTO `imovel` (`ID`, `id_endereco`, `data_construcao`, `data_alugado_vendido`, `data_postagem`, `id_fotos`, `valor_sugerido_cliente_proprietario`, `status`, `area`, `categoria`) 
             VALUES (9, 9, '2017-10-06', '2020-01-10', '2018-06-27', 9, 1000000, 'Indisponível', 800, 'Terreno');

--
-- Insercao em Casa
--
INSERT INTO `casa` (`qntd_quarto`, `qntd_suite`, `qntd_sala_estar`, `qntd_sala_jantar`, `nmro_vagas`, `has_armario_embutido`, `descricao`, `id_casa`) 
              VALUES (3, 1, 2, 1, 2, 1, 'Bela Casa 3/4 com Suíte, 2 garagens e 2 enormes salas de jantar', 1);
INSERT INTO `casa` (`qntd_quarto`, `qntd_suite`, `qntd_sala_estar`, `qntd_sala_jantar`, `nmro_vagas`, `has_armario_embutido`, `descricao`, `id_casa`) 
             VALUES (5, 2, 1, 1, 3, 1, 'Mansão bonita e de belo jardim! Com 5/4 e 2 grandes suítes, 3 vagas na garagem e com um belo armário', 5);

--
-- Insercao em apartamento
--
INSERT INTO `apartamento` (`qntd_quarto`, `qntd_suite`, `qntd_sala_estar`, `qntd_sala_jantar`, `nmro_vagas`, `has_armario_embutido`,
                          `andar`, `valor_condominio`, `has_portaria`, `id_apartamento`,`descricao`) VALUES (2,1,2,1,1,2, 5, 4500, 1, 2,'Apartamento grande com 2/4 e armário embutido');
INSERT INTO `apartamento` (`qntd_quarto`, `qntd_suite`, `qntd_sala_estar`, `qntd_sala_jantar`, `nmro_vagas`, `has_armario_embutido`,
                          `andar`, `valor_condominio`, `has_portaria`, `id_apartamento`,`descricao`) VALUES (3,2,1,2,2,1, 8, 3000, 1, 6,'Apartamento magnífico com 3/4 e 2 garagens');

--
-- Insercao em sala_comercial
--
INSERT INTO `sala_comercial` (`qntd_banheiro`, `qntd_comodo`, `id_sala_comercial`) VALUES (2, 3, 4);
INSERT INTO `sala_comercial` (`qntd_banheiro`, `qntd_comodo`, `id_sala_comercial`) VALUES (3, 5, 8);

--
-- Insercao em terreno
--
INSERT INTO `terreno` (`largura`, `comprimento`, `tipo_inclinacao`, `id_terreno`) VALUES (19, 20, 'Aclive', 3);
INSERT INTO `terreno` (`largura`, `comprimento`, `tipo_inclinacao`, `id_terreno`) VALUES (71, 5, 'Sem Inclinação', 7);
INSERT INTO `terreno` (`largura`, `comprimento`, `tipo_inclinacao`, `id_terreno`) VALUES (40, 20, 'Declive', 9);

--
-- Insercao em cliente_usuario
--
INSERT INTO `cliente_usuario` (`fiador1`, `indicacao1`, `indicacao2`, `indicacao3`, `id_pessoa`) VALUES ('Ruan Portos', 'Flávio Augusto', 'José Kepler', 'Armando Cerqueira', 4);
INSERT INTO `cliente_usuario` (`fiador1`, `indicacao1`, `indicacao2`, `indicacao3`, `id_pessoa`) VALUES ('Jonathan Joestar', 'César Zeppeli', 'Tiago Von Stronheim', 'Elen Silva', 5);
INSERT INTO `cliente_usuario` (`fiador1`, `indicacao1`, `indicacao2`, `indicacao3`, `id_pessoa`) VALUES ('Erina Pendrosa', 'Manuel Marques', 'José Santana Dias', 'Silvan Queiroz', 6);

--
-- Insercao em funcionario
--
INSERT INTO `funcionario` (`id_cargo`, `usuario`, `senha`, `data_ingresso`, `id_pessoa`) VALUES (1, 'funcionario', 'funcionariosenha', '2020-03-01', 7);
INSERT INTO `funcionario` (`id_cargo`, `usuario`, `senha`, `data_ingresso`, `id_pessoa`) VALUES (2, 'gerente', 'gerentesenha', '2013-07-04', 8);
INSERT INTO `funcionario` (`id_cargo`, `usuario`, `senha`, `data_ingresso`, `id_pessoa`) VALUES (3, 'subgerente', 'subgerentesenha', '2016-02-11', 9);

--
-- Insercao em relacao_cliente_usuario_imovel
--
INSERT INTO `relacao_cliente_usuario_imovel` (`ID`, `id_imovel_usuario`, `id_cliente_usuario`) VALUES (1, 1, 5);
INSERT INTO `relacao_cliente_usuario_imovel` (`ID`, `id_imovel_usuario`, `id_cliente_usuario`) VALUES (2, 2, 4);
INSERT INTO `relacao_cliente_usuario_imovel` (`ID`, `id_imovel_usuario`, `id_cliente_usuario`) VALUES (3, 3, 6);

--
-- Insercao em relacao_proprietario_imovel
--
INSERT INTO `relacao_proprietario_imovel` (`ID`, `id_imovel`, `id_proprietario`) VALUES (1, 1, 1);
INSERT INTO `relacao_proprietario_imovel` (`ID`, `id_imovel`, `id_proprietario`) VALUES (2, 2, 2);
INSERT INTO `relacao_proprietario_imovel` (`ID`, `id_imovel`, `id_proprietario`) VALUES (3, 3, 2);

--
-- Insercao em pagamento
--
INSERT INTO `pagamento` (`ID`, `valor`, `forma_pagamento`) VALUES (1, 100, 'Boleto');
INSERT INTO `pagamento` (`ID`, `valor`, `forma_pagamento`) VALUES (2, 150, 'Cartão');

--
-- Insercao em transacao
--
INSERT INTO `transacao` (`ID`, `id_rel_clienteUsuario_imovel`, `id_func_responsavel`, `data_transacao`, `comissao_func`, `id_pagamento`) VALUES
(1, 1, 7, '2020-02-26', 23, 2),
(2, 2, 9, '2020-01-09', 17, 1),
(3, 3, 8, '2020-01-16', 19, 1);

--
-- Insercao em contrato
--
INSERT INTO `contrato` (`ID`, `comissao_imobiliaria`, `id_transacao`) VALUES (1, 37, 1);
INSERT INTO `contrato` (`ID`, `comissao_imobiliaria`, `id_transacao`) VALUES (2, 26, 2);
INSERT INTO `contrato` (`ID`, `comissao_imobiliaria`, `id_transacao`) VALUES (3, 20, 3);

--
-- Insercao em tel_email
--
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (1, 1, '557552366587', '557511254785', 'francis@macio.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (2, 2, '557588596584', '557511245698', 'medina@life.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (3, 3, '557599984572', '557566635289', 'fbernardes@something.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (4, 4, '557588845724', '557599986523', 'ruan@algo.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (5, 5, '75988060006', '75900068806', 'jojo@bouken.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (6, 6, '71981234587', '75992346978', 'pendleton@erina.com.br');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (7, 7, '7599992345', '7198712398', 'KONODIO@DA.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (8, 8, '75899874123', '71988087854', 'jotaro@kujo.com');
INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES (9, 9, '75987656660', '7132305478', 'lisalisa@jojo.com');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
