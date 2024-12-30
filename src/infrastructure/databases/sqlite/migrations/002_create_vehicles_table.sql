CREATE TABLE vehicles (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    licensePlate TEXT NOT NULL,
    value INTEGER NOT NULL,
    status TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
