-- Landlord
INSERT INTO
    `landlords` (
        `id`,
        `name`,
        `date_of_birth`,
        `phone`,
        `email`,
        `address`
    )
VALUES
    (
        1,
        'Brad Kunze',
        '1961-01-01',
        '+1 701-347-8516 x4988',
        'lino@parker-schowalter.example',
        '497 Tremblay Prairie, East Felton, NE 77194'
    ),
    (
        2,
        'Lakiesha Heathcote',
        '1962-09-25',
        '+1 803-815-7778 x1751',
        'sixta_harber@jast.test',
        'Suite 723 64335 Emmerich Forge, Felipestad, WV 18201'
    ),
    (
        3,
        'Msgr. Eldon Jacobs',
        '1986-02-23',
        '+1 (859) 276-8305 x4322',
        'stacy.abbott@kovacek.example',
        '735 Crist Corner, East Mortonbury, AL 35772-6832'
    ),
    (
        4,
        'Vanetta Gutkowski',
        '1976-06-25',
        '+1 619-903-2431',
        'darrin.wintheiser@oconnell-bashirian.test',
        'Suite 266 85391 Ondricka Turnpike, Kilbackchester, MO 15965-2693'
    ),
    (
        5,
        'Cesar Toy',
        '1962-02-01',
        '+1 276.631.7129',
        'reynalda@okon.example',
        '405 Ruecker Squares, Port Ignacio, IA 99622-9972'
    ) ON DUPLICATE KEY
UPDATE
    `id` = `id`;