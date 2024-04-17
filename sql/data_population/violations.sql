INSERT INTO
    `violations` (
        `id`,
        `lease_id`,
        `incident_date`,
        `description`,
        `status`
    )
VALUES
    (
        1,
        53,
        "2023-09-10",
        "Loud noise after 10pm.",
        TRUE
    ),
    (2, 90, "2024-08-25", "Littering.", TRUE),
    (3, 40, "2024-07-07", "Loud noise.", FALSE),
    (4, 68, "2023-07-12", "Loud noise.", TRUE),
    (
        5,
        97,
        "2024-05-09",
        "Broke other tenant\'s window.",
        TRUE
    ),
    (6, 98, "2023-10-26", "Littering.", FALSE),
    (7, 93, "2023-10-04", "Littering.", TRUE),
    (8, 70, "2024-07-06", "Loud noise.", TRUE),
    (
        9,
        85,
        "2023-07-24",
        "Loud noise after 10pm.",
        FALSE
    ),
    (10, 96, "2023-06-14", "Loud noise.", TRUE),
    (11, 34, "2024-07-12", "Littering.", TRUE),
    (
        12,
        17,
        "2023-07-05",
        "Broke other tenant\'s window.",
        FALSE
    ),
    (
        13,
        100,
        "2024-02-18",
        "Loud noise after 10pm.",
        TRUE
    ),
    (14, 43, "2023-07-18", "Littering.", FALSE),
    (
        15,
        12,
        "2024-05-14",
        "Broke other tenant\'s window.",
        FALSE
    ),
    (16, 87, "2023-06-26", "Loud noise.", FALSE),
    (17, 16, "2024-02-13", "Littering.", TRUE),
    (
        18,
        37,
        "2024-05-23",
        "Broke other tenant\'s window.",
        FALSE
    ),
    (
        19,
        57,
        "2024-03-24",
        "Loud noise after 10pm.",
        FALSE
    ),
    (
        20,
        18,
        "2023-04-23",
        "Loud noise after 10pm.",
        FALSE
    ) ON DUPLICATE KEY
UPDATE
    `id` = `id`;