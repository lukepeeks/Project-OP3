
USE EurocapsLP;

CREATE TABLE IF NOT EXISTS `SoortPartner` (
  `SoortPartnerID` INT PRIMARY KEY,
  `Omschrijving` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Partner` (
  `PartnerID` INT PRIMARY KEY,
  `Bedrijfsnaam` VARCHAR(255),
  `Straatnaam` VARCHAR(255),
  `Huisnummer` VARCHAR(10),
  `Postcode` VARCHAR(10),
  `Plaats` VARCHAR(100),
  `Land` VARCHAR(100),
  `Email` VARCHAR(255),
  `TelNr` VARCHAR(20),
  `SoortPartnerID` INT
);

CREATE TABLE IF NOT EXISTS `PartnerContact` (
  `PartnerContactID` INT PRIMARY KEY,
  `Voornaam` VARCHAR(100),
  `Achternaam` VARCHAR(100),
  `Functie` VARCHAR(100),
  `Email` VARCHAR(255),
  `TelNr` VARCHAR(20),
  `PartnerID` INT
);

CREATE TABLE IF NOT EXISTS `SoortProduct` (
  `SoortProductID` INT PRIMARY KEY,
  `Omschrijving` VARCHAR(255),
  `Gewicht` FLOAT,
  `Afmeting` VARCHAR(100),
  `Materiaal` VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS `Product` (
  `ProductID` INT PRIMARY KEY,
  `ProductTHTDatum` DATE,
  `CStatusProduct` VARCHAR(100),
  `FStatusProduct` VARCHAR(100),
  `PStatusProduct` VARCHAR(100),
  `SoortProductID` INT
);

CREATE TABLE IF NOT EXISTS `Levering` (
  `LeveringID` INT PRIMARY KEY,
  `LeveringDatum` DATE,
  `VerwachteLeverdatum` DATE
);

CREATE TABLE IF NOT EXISTS `LeveringRegel` (
  `LeveringID` INT,
  `ProductID` INT,
  `Aantal` INT,
  PRIMARY KEY (`LeveringID`, `ProductID`)
);

CREATE TABLE IF NOT EXISTS `ProductieBatch` (
  `BatchID` INT PRIMARY KEY,
  `ProductID` INT,
  `BatchDatumStart` DATE,
  `BatchDatumEind` DATE,
  `Aantalgeproduceerd` INT
);

CREATE TABLE IF NOT EXISTS `Grinding` (
  `GrindingID` INT PRIMARY KEY,
  `G_DatumTijdStart` DATETIME,
  `G_DatumTijdEind` DATETIME,
  `G_Machine` VARCHAR(100),
  `BatchID` INT
);

CREATE TABLE IF NOT EXISTS `Filling` (
  `FillingID` INT PRIMARY KEY,
  `F_DatumTijdStart` DATETIME,
  `F_DatumTijdEind` DATETIME,
  `F_Machine` VARCHAR(100),
  `BatchID` INT
);

CREATE TABLE IF NOT EXISTS `Packaging` (
  `PackagingID` INT PRIMARY KEY,
  `P_DatumTijdStart` DATETIME,
  `P_DatumTijdEind` DATETIME,
  `P_Machine` VARCHAR(100),
  `AantalStuksPerDoos` INT,
  `BatchID` INT
);

CREATE TABLE IF NOT EXISTS `Grinding_Product` (
  `GrindingID` INT,
  `ProductID` INT,
  `Aantal` INT,
  PRIMARY KEY (`GrindingID`, `ProductID`)
);

CREATE TABLE IF NOT EXISTS `Filling_Product` (
  `FillingID` INT,
  `ProductID` INT,
  `Aantal` INT,
  PRIMARY KEY (`FillingID`, `ProductID`)
);

CREATE TABLE IF NOT EXISTS `Packaging_Product` (
  `PackagingID` INT,
  `ProductID` INT,
  `Aantal` INT,
  PRIMARY KEY (`PackagingID`, `ProductID`)
);

ALTER TABLE `Partner` ADD FOREIGN KEY (`SoortPartnerID`) REFERENCES `SoortPartner`(`SoortPartnerID`);
ALTER TABLE `PartnerContact` ADD FOREIGN KEY (`PartnerID`) REFERENCES `Partner`(`PartnerID`);
ALTER TABLE `Product` ADD FOREIGN KEY (`SoortProductID`) REFERENCES `SoortProduct`(`SoortProductID`);
ALTER TABLE `LeveringRegel` ADD FOREIGN KEY (`LeveringID`) REFERENCES `Levering`(`LeveringID`);
ALTER TABLE `LeveringRegel` ADD FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`);
ALTER TABLE `ProductieBatch` ADD FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`);
ALTER TABLE `Grinding` ADD FOREIGN KEY (`BatchID`) REFERENCES `ProductieBatch`(`BatchID`);
ALTER TABLE `Filling` ADD FOREIGN KEY (`BatchID`) REFERENCES `ProductieBatch`(`BatchID`);
ALTER TABLE `Packaging` ADD FOREIGN KEY (`BatchID`) REFERENCES `ProductieBatch`(`BatchID`);
ALTER TABLE `Grinding_Product` ADD FOREIGN KEY (`GrindingID`) REFERENCES `Grinding`(`GrindingID`);
ALTER TABLE `Grinding_Product` ADD FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`);
ALTER TABLE `Filling_Product` ADD FOREIGN KEY (`FillingID`) REFERENCES `Filling`(`FillingID`);
ALTER TABLE `Filling_Product` ADD FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`);
ALTER TABLE `Packaging_Product` ADD FOREIGN KEY (`PackagingID`) REFERENCES `Packaging`(`PackagingID`);
ALTER TABLE `Packaging_Product` ADD FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`);
