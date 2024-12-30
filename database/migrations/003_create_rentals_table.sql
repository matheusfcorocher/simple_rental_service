CREATE TABLE rentals (
    id TEXT PRIMARY KEY,
    renter_id TEXT NOT NULL UNIQUE,
    vehicle_id TEXT NOT NULL UNIQUE,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(renter_id) REFERENCES renters(id)
    FOREIGN KEY(vehicle_id) REFERENCES vehicles(id)
);
