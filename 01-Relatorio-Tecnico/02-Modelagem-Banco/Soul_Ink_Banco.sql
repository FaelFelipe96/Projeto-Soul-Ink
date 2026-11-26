-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema soul_ink
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema soul_ink
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `soul_ink` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `soul_ink` ;

-- -----------------------------------------------------
-- Table `soul_ink`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `instagram` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`compra` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `data_compra` DATE NULL DEFAULT NULL,
  `fornecedor` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`id_compra`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`tatuador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`tatuador` (
  `id_tatuador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `instagram` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tatuador`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`despesa` (
  `id_despesa` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NULL DEFAULT NULL,
  `categoria` VARCHAR(100) NULL DEFAULT NULL,
  `data_despesa` DATE NULL DEFAULT NULL,
  `valor_despesa` DECIMAL(10,2) NULL DEFAULT NULL,
  `forma_pagamento` VARCHAR(50) NULL DEFAULT NULL,
  `id_tatuador` INT NOT NULL,
  `id_compra` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_despesa`),
  UNIQUE INDEX `uk_despesa_compra` (`id_compra` ASC) VISIBLE,
  INDEX `fk_despesa_tatuador` (`id_tatuador` ASC) VISIBLE,
  CONSTRAINT `fk_despesa_compra`
    FOREIGN KEY (`id_compra`)
    REFERENCES `soul_ink`.`compra` (`id_compra`),
  CONSTRAINT `fk_despesa_tatuador`
    FOREIGN KEY (`id_tatuador`)
    REFERENCES `soul_ink`.`tatuador` (`id_tatuador`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`material` (
  `id_material` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `categoria` VARCHAR(100) NULL DEFAULT NULL,
  `unidade_medida` VARCHAR(30) NULL DEFAULT NULL,
  `quantidade_estoque` DECIMAL(10,2) NULL DEFAULT NULL,
  `estoque_minimo` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_material`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`item_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`item_compra` (
  `id_item_compra` INT NOT NULL AUTO_INCREMENT,
  `quantidade` DECIMAL(10,2) NULL DEFAULT NULL,
  `valor_unitario` DECIMAL(10,2) NULL DEFAULT NULL,
  `subtotal` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_compra` INT NOT NULL,
  `id_material` INT NOT NULL,
  PRIMARY KEY (`id_item_compra`),
  INDEX `fk_item_compra_compra` (`id_compra` ASC) VISIBLE,
  INDEX `fk_item_compra_material` (`id_material` ASC) VISIBLE,
  CONSTRAINT `fk_item_compra_compra`
    FOREIGN KEY (`id_compra`)
    REFERENCES `soul_ink`.`compra` (`id_compra`),
  CONSTRAINT `fk_item_compra_material`
    FOREIGN KEY (`id_material`)
    REFERENCES `soul_ink`.`material` (`id_material`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `descricao` TEXT NULL DEFAULT NULL,
  `estilo` VARCHAR(100) NULL DEFAULT NULL,
  `local_corpo` VARCHAR(100) NULL DEFAULT NULL,
  `tamanho` VARCHAR(50) NULL DEFAULT NULL,
  `data_contratacao` DATE NULL DEFAULT NULL,
  `status` VARCHAR(30) NULL DEFAULT NULL,
  `valor_total` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_cliente` INT NOT NULL,
  `id_tatuador` INT NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_servico_cliente` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_servico_tatuador` (`id_tatuador` ASC) VISIBLE,
  CONSTRAINT `fk_servico_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `soul_ink`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_servico_tatuador`
    FOREIGN KEY (`id_tatuador`)
    REFERENCES `soul_ink`.`tatuador` (`id_tatuador`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`sessao` (
  `id_sessao` INT NOT NULL AUTO_INCREMENT,
  `data_sessao` DATE NULL DEFAULT NULL,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `hora_fim` TIME NULL DEFAULT NULL,
  `valor_sessao` DECIMAL(10,2) NULL DEFAULT NULL,
  `status` VARCHAR(30) NULL DEFAULT NULL,
  `id_servico` INT NOT NULL,
  PRIMARY KEY (`id_sessao`),
  INDEX `fk_sessao_servico` (`id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_sessao_servico`
    FOREIGN KEY (`id_servico`)
    REFERENCES `soul_ink`.`servico` (`id_servico`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`movimentacao_estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`movimentacao_estoque` (
  `id_movimentacao` INT NOT NULL AUTO_INCREMENT,
  `data_movimentacao` DATE NULL DEFAULT NULL,
  `tipo_movimentacao` VARCHAR(20) NULL DEFAULT NULL,
  `quantidade` DECIMAL(10,2) NULL DEFAULT NULL,
  `observacao` VARCHAR(200) NULL DEFAULT NULL,
  `id_material` INT NOT NULL,
  `id_sessao` INT NULL DEFAULT NULL,
  `id_item_compra` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_movimentacao`),
  UNIQUE INDEX `uk_movimentacao_item_compra` (`id_item_compra` ASC) VISIBLE,
  INDEX `fk_movimentacao_material` (`id_material` ASC) VISIBLE,
  INDEX `fk_movimentacao_sessao` (`id_sessao` ASC) VISIBLE,
  CONSTRAINT `fk_movimentacao_item_compra`
    FOREIGN KEY (`id_item_compra`)
    REFERENCES `soul_ink`.`item_compra` (`id_item_compra`),
  CONSTRAINT `fk_movimentacao_material`
    FOREIGN KEY (`id_material`)
    REFERENCES `soul_ink`.`material` (`id_material`),
  CONSTRAINT `fk_movimentacao_sessao`
    FOREIGN KEY (`id_sessao`)
    REFERENCES `soul_ink`.`sessao` (`id_sessao`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`orcamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`orcamento` (
  `id_orcamento` INT NOT NULL AUTO_INCREMENT,
  `data_orcamento` DATE NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `valor_estimado` DECIMAL(10,2) NULL DEFAULT NULL,
  `status` VARCHAR(30) NULL DEFAULT NULL,
  `id_cliente` INT NOT NULL,
  `id_tatuador` INT NOT NULL,
  PRIMARY KEY (`id_orcamento`),
  INDEX `fk_orcamento_cliente` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_orcamento_tatuador` (`id_tatuador` ASC) VISIBLE,
  CONSTRAINT `fk_orcamento_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `soul_ink`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_orcamento_tatuador`
    FOREIGN KEY (`id_tatuador`)
    REFERENCES `soul_ink`.`tatuador` (`id_tatuador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `soul_ink`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soul_ink`.`pagamento` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `data_pagamento` DATE NULL DEFAULT NULL,
  `valor_pago` DECIMAL(10,2) NULL DEFAULT NULL,
  `forma_pagamento` VARCHAR(50) NULL DEFAULT NULL,
  `parcelas` INT NULL DEFAULT NULL,
  `status` VARCHAR(30) NULL DEFAULT NULL,
  `id_sessao` INT NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `fk_pagamento_sessao` (`id_sessao` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_sessao`
    FOREIGN KEY (`id_sessao`)
    REFERENCES `soul_ink`.`sessao` (`id_sessao`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
