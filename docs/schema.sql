-- =========================================================
--  jsp-board schema.sql  (Portfolio-friendly, code-compatible)
--  - DB: jspdb / User: jspuser / Password: mysql
--  - MySQL 8.x 기준
--  - 주의: 이 스키마는 "기존 코드 변경 없이 동작"을 최우선으로 유지합니다.
-- =========================================================

-- 2025-11-26 DB/USER 생성

CREATE DATABASE IF NOT EXISTS jspdb
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

-- root 계정으로 실행 (MySQL 시스템 DB 선택)
USE mysql;

CREATE USER IF NOT EXISTS 'jspuser'@'localhost' IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON jspdb.* TO 'jspuser'@'localhost';
FLUSH PRIVILEGES;

-- 이후부터는 jspuser로 접속해서 실행
USE jspdb;

-- 2025-11-26 board 테이블

CREATE TABLE IF NOT EXISTS board (
  bno       INT NOT NULL AUTO_INCREMENT,
  title     VARCHAR(100) NOT NULL,
  writer    VARCHAR(100) NOT NULL,
  content   TEXT,
  regdate   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  moddate   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  imagefile VARCHAR(500) NULL,
  PRIMARY KEY (bno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--  2025-11-27 comment 테이블

CREATE TABLE IF NOT EXISTS comment (
  cno     INT NOT NULL AUTO_INCREMENT,
  bno     INT NOT NULL,
  writer  VARCHAR(100) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  regdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (cno),
  INDEX idx_comment_bno (bno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- (게시글 삭제 시 댓글 자동 삭제)
ALTER TABLE comment
  ADD CONSTRAINT fk_comment_board
  FOREIGN KEY (bno) REFERENCES board(bno)
  ON DELETE CASCADE;

-- 2025-12-02 user 테이블
-- 코드 호환성을 위해 컬럼명(id, pwd, email, phone, regdate, lastlogin)을 유지

CREATE TABLE IF NOT EXISTS `user` (
  id        VARCHAR(100) NOT NULL,
  pwd       VARCHAR(100) NOT NULL,
  email     VARCHAR(100) NOT NULL,
  phone     VARCHAR(50) NULL,
  regdate   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastlogin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
