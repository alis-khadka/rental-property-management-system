CREATE TABLE `landlords` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255),
    `date_of_birth` date,
    `phone` varchar(255),
    `email` varchar(255),
    `address` varchar(255)
);

CREATE TABLE `tenants` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255),
    `date_of_birth` date,
    `phone` varchar(255),
    `email` varchar(255),
    `address` varchar(255)
);

CREATE TABLE `properties` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `landlord_id` bigint NOT NULL,
    `address` varchar(255),
    `rental_rate` int,
    `available` tinyint(1),
    INDEX `index_properties_on_landlord_id` (`landlord_id`),
    CONSTRAINT `fk_rails_0d583945c1` FOREIGN KEY (`landlord_id`) REFERENCES `landlords` (`id`)
);

CREATE TABLE `leases` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `property_id` bigint NOT NULL,
    `tenant_id` bigint NOT NULL,
    `start_date` date,
    `end_date` date,
    `status` tinyint(1),
    INDEX `index_leases_on_property_id` (`property_id`),
    INDEX `index_leases_on_tenant_id` (`tenant_id`),
    CONSTRAINT `fk_rails_170c7116c8` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
    CONSTRAINT `fk_rails_40598ae6e6` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`)
);

CREATE TABLE `payments` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `lease_id` bigint NOT NULL,
    `payment_date` datetime(6),
    `amount` float(24),
    INDEX `index_payments_on_lease_id` (`lease_id`),
    CONSTRAINT `fk_rails_b77711b98f` FOREIGN KEY (`lease_id`) REFERENCES `leases` (`id`)
);

CREATE TABLE `maintenance_requests` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `lease_id` bigint NOT NULL,
    `request_date` datetime(6),
    `description` text,
    `status` tinyint(1),
    INDEX `index_maintenance_requests_on_lease_id` (`lease_id`),
    CONSTRAINT `fk_rails_41679b1432` FOREIGN KEY (`lease_id`) REFERENCES `leases` (`id`)
)

CREATE TABLE `violations` (
    `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `lease_id` bigint NOT NULL,
    `incident_date` date,
    `description` text,
    `status` tinyint(1),
    INDEX `index_violations_on_lease_id` (`lease_id`),
    CONSTRAINT `fk_rails_c417e62b1e` FOREIGN KEY (`lease_id`) REFERENCES `leases` (`id`)
);
