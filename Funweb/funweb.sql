CREATE TABLE member (
	id VARCHAR(16) PRIMARY KEY,
	pass VARCHAR(16) NOT NULL,
	name VARCHAR(20) NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	address VARCHAR(50) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	mobile VARCHAR(20) NOT NULL,
	date DATE NOT NULL
);

SHOW TABLES;

SELECT * FROM member;

SELECT * FROM member WHERE id='admin' AND pass='123';

SELECT id FROM member WHERE id='hong';

SELECT * FROM member WHERE id='admin';

CREATE TABLE board (
	idx INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	pass VARCHAR(16) NOT NULL,
	subject VARCHAR(50) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	date DATE NOT NULL,
	readcount INT NOT NULL
);

DESC board;



















