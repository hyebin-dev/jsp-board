-- =========================================================
-- jsp-board schema.sql
-- - Tables: board, comment, user
-- - Tested target: MySQL 8.x
-- =========================================================

-- 1) Create DB (optional - you can also do this manually)
CREATE DATABASE IF NOT EXISTS jspdb
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE jspdb;

-- 2) board table
CREATE TABLE IF NOT EXISTS board (
  bno       INT NOT NULL AUTO_INCREMENT,
  title     VARCHAR(100) NOT NULL,
  writer    VARCHAR(100) NOT NULL,
  content   TEXT,
  regdate   DATETIME DEFAULT NOW(),
  moddate   DATETIME DEFAULT NOW(),
  imagefile VARCHAR(500),
  PRIMARY KEY (bno)
) ENGINE=InnoDB;

-- 3) comment table
CREATE TABLE IF NOT EXISTS comment (
  cno     INT NOT NULL AUTO_INCREMENT,
  bno     INT NOT NULL,
  writer  VARCHAR(100) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  regdate DATETIME DEFAULT NOW(),
  PRIMARY KEY (cno),
  INDEX idx_comment_bno (bno),
  CONSTRAINT fk_comment_board
    FOREIGN KEY (bno) REFERENCES board(bno)
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4) user table
-- NOTE: `user` is a reserved word in some contexts. Use backticks for safety.
CREATE TABLE IF NOT EXISTS `user` (
  id        VARCHAR(100) NOT NULL,
  pwd       VARCHAR(100) NOT NULL,
  email     VARCHAR(100) NOT NULL,
  phone     VARCHAR(50),
  regdate   DATETIME DEFAULT NOW(),
  lastlogin DATETIME DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE KEY uk_user_email (email)
) ENGINE=InnoDB;
