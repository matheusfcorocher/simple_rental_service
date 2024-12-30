CREATE TABLE renters (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telephone TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
