PRAGMA foreign_keys = ON;
PRAGMA encoding="UTF-8";

CREATE TABLE users (
       id               INTEGER PRIMARY KEY,
       name_lc          TEXT,
       display_name     TEXT
);

CREATE TABLE meals (
       id         INTEGER PRIMARY KEY,
       date       TEXT,
       comment    TEXT,
       user_id    INTEGER REFERENCES users(id)
);

INSERT INTO users
(id, name_lc, display_name) VALUES
( 1,  'mose',       'Mose'),
( 2, 'timon',      'Timon');

INSERT INTO meals
(id,         date,   comment, user_id) VALUES
( 1, '2020-02-20', 'Februar',       1),
( 2, '2020-04-20',    'März',       2),
( 3, '2020-06-15',    'Juni',	 NULL),
( 4, '2020-06-20',  'Juni 2',	 NULL);

