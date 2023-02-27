-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: storage, user, wisecost
-- Source Schemata: storage, user, wisecost
-- Created: Thu Feb  2 19:28:13 2023
-- Workbench Version: 8.0.31
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema storage
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `storage` ;
CREATE SCHEMA IF NOT EXISTS `storage` ;

-- ----------------------------------------------------------------------------
-- Table storage.namespace
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`namespace` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_ns_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table storage.node
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_node_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table storage.pod
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`pod` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_pod_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table storage.pv
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`pv` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_pv_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table storage.pvc
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`pvc` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_pvc_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table storage.service
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_service_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- ----------------------------------------------------------------------------
-- Table storage.storageclass
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `storage`.`storageclass` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cluster` VARCHAR(64) NOT NULL,
  `mode` INT NOT NULL,
  `resourceVersion` VARCHAR(64) NOT NULL,
  `node` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_sc_name` (`cluster` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- ----------------------------------------------------------------------------
-- Schema wisecost
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `wisecost` ;
CREATE SCHEMA IF NOT EXISTS `wisecost` ;

-- ----------------------------------------------------------------------------
-- Table wisecost.cloud_provider
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wisecost`.`cloud_provider` (
  `name` VARCHAR(64) NOT NULL,
  `accessKey` VARCHAR(64) NOT NULL,
  `accessKeySecret` VARCHAR(64) NOT NULL,
  `cloud_type` CHAR(4) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table wisecost.cloud_provider_params
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wisecost`.`cloud_provider_params` (
  `id` INT NOT NULL,
  `cloud_provider_id` INT NOT NULL,
  `param_name` VARCHAR(64) NOT NULL,
  `param_value` VARCHAR(512) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `IDX_CPID_PARAM_NAME` (`cloud_provider_id` ASC, `param_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table wisecost.cluster
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wisecost`.`cluster` (
  `cluster_id` VARCHAR(64) NOT NULL,
  `cluster_name` VARCHAR(64) NOT NULL,
  `description` VARCHAR(512) NULL DEFAULT NULL,
  `region_id` VARCHAR(64) NULL DEFAULT NULL,
  `cloudprovider_name` VARCHAR(64) NOT NULL,
  `kube_config` MEDIUMTEXT NOT NULL,
  `prometheus_addr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cluster_id`),
  INDEX `IDX_NAME` (`cluster_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table wisecost.optimize_item
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wisecost`.`optimize_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rule` VARCHAR(64) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `objects` TEXT NULL DEFAULT NULL,
  `template` VARCHAR(64) NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saving` FLOAT NOT NULL DEFAULT '0',
  `actions` VARCHAR(32) NULL DEFAULT NULL,
  `ignore` TINYINT(1) NULL DEFAULT '0',
  `delete` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
