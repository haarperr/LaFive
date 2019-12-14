-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Versão:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essentialmode
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `essentialmode`;

-- Dumping structure for table essentialmode.licensas
CREATE TABLE IF NOT EXISTS `licensas` (
  `owner` varchar(255) DEFAULT NULL,
  `mota` varchar(255) DEFAULT 'nao',
  `carro` varchar(255) DEFAULT 'nao',
  `camiao` varchar(255) DEFAULT 'nao',
  `armas` varchar(255) DEFAULT 'nao'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table essentialmode.licensas: ~3 rows (approximately)
/*!40000 ALTER TABLE `licensas` DISABLE KEYS */;
/*!40000 ALTER TABLE `licensas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
