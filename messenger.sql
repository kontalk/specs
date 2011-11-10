-- phpMyAdmin SQL Dump
-- version 3.3.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 08 nov, 2011 at 02:48 PM
-- Versione MySQL: 5.1.54
-- Versione PHP: 5.3.5-1ubuntu7.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `messenger1`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `userid` char(40) NOT NULL COMMENT 'User ID',
  `filename` varchar(255) NOT NULL COMMENT 'Filename relative to the server local storage',
  `mime` varchar(50) NOT NULL COMMENT 'Mime type',
  PRIMARY KEY (`userid`,`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Attachments catalog';

-- --------------------------------------------------------

--
-- Struttura della tabella `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` char(64) NOT NULL COMMENT 'Message ID',
  `orig_id` char(64) DEFAULT NULL COMMENT 'Originating message ID',
  `sender` char(48) NOT NULL COMMENT 'Sender (user id + resource)',
  `recipient` char(48) NOT NULL COMMENT 'Recipient (user id + resource)',
  `group` char(10) DEFAULT NULL COMMENT 'Group ID',
  `mime` varchar(50) NOT NULL COMMENT 'Message mime type',
  `content` mediumblob NOT NULL COMMENT 'Message content',
  `encrypted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Encrypted message flag',
  `filename` varchar(255) DEFAULT NULL COMMENT 'Message content filename (if any)',
  `ttl` smallint(3) DEFAULT NULL COMMENT 'Message time-to-live',
  `local_lock` datetime DEFAULT NULL COMMENT 'Last lock time by polling server',
  `remote_lock` datetime DEFAULT NULL COMMENT 'Last lock time by daemon',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Transiting messages';

-- --------------------------------------------------------

--
-- Struttura della tabella `servers`
--

DROP TABLE IF EXISTS `servers`;
CREATE TABLE IF NOT EXISTS `servers` (
  `fingerprint` char(40) NOT NULL COMMENT 'Server key fingerprint',
  `address` varchar(255) NOT NULL COMMENT 'Server address',
  `serverlink` varchar(100) DEFAULT NULL COMMENT 'Serverlink address',
  PRIMARY KEY (`fingerprint`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Servers';

-- --------------------------------------------------------

--
-- Struttura della tabella `usercache`
--

DROP TABLE IF EXISTS `usercache`;
CREATE TABLE IF NOT EXISTS `usercache` (
  `userid` char(48) NOT NULL COMMENT 'User ID',
  `timestamp` datetime NOT NULL COMMENT 'Cache entry timestamp',
  `status` varchar(140) CHARACTER SET utf8 DEFAULT NULL COMMENT 'User status message',
  `google_registrationid` varchar(255) DEFAULT NULL COMMENT 'Google C2DM device registration ID',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Users location cache';

-- --------------------------------------------------------

--
-- Struttura della tabella `validations`
--

DROP TABLE IF EXISTS `validations`;
CREATE TABLE IF NOT EXISTS `validations` (
  `userid` char(40) NOT NULL COMMENT 'User ID',
  `code` char(20) NOT NULL COMMENT 'Verification code',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Verification codes';
