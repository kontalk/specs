-- new column: attachments.timestamp
ALTER TABLE `attachments` ADD `timestamp` DATETIME NULL DEFAULT NULL COMMENT 'Upload/last download time' AFTER `md5sum`;
