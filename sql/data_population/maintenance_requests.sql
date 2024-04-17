INSERT INTO
    `maintenance_requests` (
        `id`,
        `lease_id`,
        `request_date`,
        `description`,
        `status`
    )
VALUES
    (
        1,
        74,
        '2023-08-30',
        'Laundry unit not working.',
        FALSE
    ),
    (
        2,
        40,
        '2024-01-15',
        'Water leakage in kitchen sink.',
        FALSE
    ),
    (
        3,
        19,
        '2023-07-27',
        'AC not working properly.',
        FALSE
    ),
    (
        4,
        7,
        '2023-12-06',
        'Need to change door locks.',
        FALSE
    ),
    (
        5,
        75,
        '2023-07-28',
        'Water leakage in bathroom sink.',
        TRUE
    ),
    (
        6,
        34,
        '2024-03-09',
        'AC not working properly.',
        TRUE
    ),
    (
        7,
        96,
        '2023-06-29',
        'Laundry unit not working.',
        TRUE
    ),
    (
        8,
        72,
        '2023-10-22',
        'Water leakage in bathroom sink.',
        TRUE
    ),
    (
        9,
        56,
        '2024-04-23',
        'Need to change door locks.',
        FALSE
    ),
    (
        10,
        87,
        '2023-08-09',
        'Water leakage in bathroom sink.',
        TRUE
    ),
    (
        11,
        32,
        '2023-12-05',
        'Need to change door locks.',
        FALSE
    ),
    (
        12,
        70,
        '2024-01-18',
        'Bedroom lights broken.',
        FALSE
    ),
    (
        13,
        5,
        '2023-08-17',
        'Need to change door locks.',
        TRUE
    ),
    (
        14,
        66,
        '2023-07-07',
        'Bedroom lights broken.',
        FALSE
    ),
    (
        15,
        38,
        '2023-09-21',
        'Need to change door locks.',
        FALSE
    ),
    (
        16,
        59,
        '2024-03-21',
        'Water leakage in bathroom sink.',
        TRUE
    ),
    (
        17,
        55,
        '2023-09-16',
        'Laundry unit not working.',
        FALSE
    ),
    (
        18,
        69,
        '2023-12-06',
        'Water leakage in kitchen sink.',
        FALSE
    ),
    (
        19,
        10,
        '2024-02-29',
        'Water leakage in bathroom sink.',
        TRUE
    ),
    (
        20,
        95,
        '2024-04-17',
        'Bedroom lights broken.',
        FALSE
    ) ON DUPLICATE KEY
UPDATE
    `id` = `id`;