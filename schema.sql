-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 14 ago, 2012 at 07:43 PM
-- Versione MySQL: 5.5.25
-- Versione PHP: 5.3.15-1~dotdeb.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kontalk`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `attachments`
--

CREATE TABLE `attachments` (
  `userid` char(40) NOT NULL COMMENT 'User ID',
  `filename` varchar(255) NOT NULL COMMENT 'Filename relative to the server local storage',
  `mime` varchar(50) NOT NULL COMMENT 'Mime type',
  `md5sum` varchar(32) NOT NULL COMMENT 'File MD5 sum',
  `timestamp` datetime DEFAULT NULL COMMENT 'Upload/last download time',
  PRIMARY KEY (`userid`,`filename`),
  KEY `md5sum` (`md5sum`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Attachments catalog';

-- --------------------------------------------------------

--
-- Struttura della tabella `messages`
--

CREATE TABLE `messages` (
  `id` char(64) NOT NULL COMMENT 'Message ID',
  `orig_id` char(64) DEFAULT NULL COMMENT 'Originating message ID',
  `timestamp` datetime NOT NULL COMMENT 'Message timestamp',
  `sender` char(48) NOT NULL COMMENT 'Sender (user id + resource)',
  `recipient` char(48) NOT NULL COMMENT 'Recipient (user id + resource)',
  `group` char(10) DEFAULT NULL COMMENT 'Group ID',
  `mime` varchar(50) NOT NULL COMMENT 'Message mime type',
  `content` mediumblob NOT NULL COMMENT 'Message content',
  `encrypted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Encrypted message flag',
  `filename` varchar(255) DEFAULT NULL COMMENT 'Message content filename (if any)',
  `ttl` smallint(3) DEFAULT NULL COMMENT 'Message time-to-live',
  `need_ack` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'Need ack flag',
  PRIMARY KEY (`id`),
  KEY `recipient` (`recipient`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Transiting messages';

-- --------------------------------------------------------

--
-- Struttura della tabella `servers`
--

CREATE TABLE `servers` (
  `fingerprint` char(40) NOT NULL COMMENT 'Server key fingerprint',
  `host` varchar(100) NOT NULL COMMENT 'Server host',
  `port` smallint(6) DEFAULT NULL COMMENT 'Client port',
  `http_port` smallint(6) DEFAULT NULL COMMENT 'Client HTTP port',
  `serverlink_port` smallint(6) DEFAULT NULL COMMENT 'Serverlink port',
  PRIMARY KEY (`fingerprint`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Servers';

-- --------------------------------------------------------

--
-- Struttura della tabella `usercache`
--

CREATE TABLE `usercache` (
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

CREATE TABLE `validations` (
  `userid` char(48) NOT NULL COMMENT 'User ID',
  `code` char(6) NOT NULL COMMENT 'Verification code',
  `timestamp` datetime DEFAULT NULL COMMENT 'Validation code timestamp',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COMMENT='Verification codes';
