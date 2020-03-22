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
  `complemento` VARCHAR(80) NOT NULL,
  `id_bairro` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `id_bairro_UNIQUE` (`id_bairro` ASC),
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
  `email` VARCHAR(45) NOT NULL,
  `estado_civil` VARCHAR(15) NOT NULL,
  `sexo` ENUM('F', 'M') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) ,
  INDEX `id_endereco_idx` (`id_endereco` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `id_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `bdImobiliaria`.`endereco` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdImobiliaria`.`cliente_propietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdImobiliaria`.`cliente_propietario` (
  `profissao` VARCHAR(30) NOT NULL,
  `id_pessoa` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_cliente_propietario_pessoa1`
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
  `foto1` TINYBLOB NOT NULL,
  `foto2` TINYBLOB NOT NULL,
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
  `data_alugado_vendido` DATE NOT NULL,
  `data_postagem` DATE NOT NULL,
  `id_fotos` INT UNSIGNED NOT NULL,
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
  `qndtd_suite` INT UNSIGNED NOT NULL,
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
  PRIMARY KEY (`id_apartamento`),
  CONSTRAINT `fk_apartamento_casa1`
    FOREIGN KEY (`id_apartamento`)
    REFERENCES `bdImobiliaria`.`casa` (`id_casa`)
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
    REFERENCES `bdImobiliaria`.`cliente_propietario` (`id_pessoa`)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
