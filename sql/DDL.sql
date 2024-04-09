CREATE TABLE landlords (
	id SERIAL primary key,
	name varchar(255),
	date_of_birth date,
	phone varchar(20),
	email varchar(255),
	address varchar(255)
);

CREATE TABLE tenants (
	id SERIAL primary key,
	name varchar(255),
	date_of_birth date,
	phone varchar(20),
	email varchar(255),
	address varchar(255)
);

CREATE TABLE properties (
	id SERIAL primary key,
	landlord_id int REFERENCES landlords(id),
    address varchar(255),
    rental_rate int,
    available boolean
);

CREATE TABLE leases (
	id SERIAL primary key,
	property_id int REFERENCES properties(id),
	tenant_id int REFERENCES tenants(id),
    start_date date,
    end_date date,
    status boolean
);

CREATE TABLE payments (
    id SERIAL primary key,
    lease_id int REFERENCES leases(id),
    payment_date date,
    amount DOUBLE PRECISION
);

CREATE TABLE maintenance_requests (
    id SERIAL primary key,
    lease_id int REFERENCES leases(id),
    request_date date,
    description text,
    status boolean
);

CREATE TABLE violations (
    id SERIAL primary key,
    lease_id int REFERENCES leases(id),
    tenant_id int REFERENCES tenants(id),
    description text,
    status boolean
);
