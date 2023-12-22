INSERT INTO local_lib.genres (title)
VALUES ('Science fiction'),
       ('Satire'),
       ('Drama'),
       ('Action and Adventure'),
       ('Romance'),
       ('Mystery'),
       ('Horror'),
       ('Health'),
       ('Guide'),
       ('Diaries'),
       ('Comics'),
       ('Diaries'),
       ('Journals'),
       ('Biographies'),
       ('Fantasy'),
       ('History'),
       ('Science'),
       ('Art'),
       ('Other');



INSERT INTO local_lib.publishers (title)
VALUES ('Harper Collins'),
       ('Simon & Schuster'),
       ('Macmillan'),
       ('Hachette'),
       ('Penguin Random House');


INSERT INTO local_lib.authors (first_name, last_name)
VALUES ('William', 'Howells'),
       ('Frederic', 'Brown'),
       ('Jack', 'London'),
       ('Albert', 'Blaisdell'),
       ('Ellis', 'Butler'),
       ('Arthur', 'Machen'),
       ('Titus', 'Lucretius'),
       ('Rabindranath', 'Tagore'),
       ('Isaac', 'Asimov'),
       ('Charles', 'Dickens'),
       ('Ralph', 'Emerson'),
       ('Dorothy', 'Canfield'),
       ('Givoanni', 'Boccaccio'),
       ('George', 'Orwell'),
       ('Publius', 'Ovid'),
       ('Robert', 'Stevenson'),
       ('Virginia', 'Woolf'),
       ('George', 'Eliot'),
       ('Amelia', 'Edwards'),
       ('Fyodor', 'Dostoevsky'),
       ('Emily', 'Dickinson'),
       ('Edna', 'Ferber'),
       ('Joseph', 'LeFanu'),
       ('John', 'DosPassos'),
       ('Ruth', 'Stuart'),
       ('Vladimir', 'Nabokov'),
       ('Johanna', 'Spyri'),
       ('Ernest', 'Dowson'),
       ('Mary', 'Foote'),
       ('Zane', 'Grey'),
       ('H. P.', 'Lovecraft'),
       ('Samuel', 'Pepys'),
       ('Kate', 'Sweetser'),
       ('William', 'Lampton'),
       ('Mother', 'Goose'),
       ('Eleanor', 'Abbott'),
       ('Kate', 'Quinn'),
       ('Dray', 'Stephanie'),
       ('Laura', 'Kamoie');


SET datestyle = 'ISO, DMY';

INSERT INTO local_lib.books (title, pages, genre_id, publication_date, publisher_id, author_id, copies)
VALUES ('A Daughter of the Snows', 199, 9, '03.04.2018', 5, 3, 2),
       ('The Near East: 10,000 Years of History', 298, 13, '08.10.2018', 3, 9, 9),
       ('The Cocoon: A Rest-Cure Comedy', 90, 12, '09.02.2015', 2, 25, 5),
       ('The Freakshow Murders', 321, 3, '18.09.2020', 2, 2, 9),
       ('Pharaohs,  Fellahs and Explorers', 367, 9, '05.01.2015', 3, 19, 2),
       ('Hard Times', 293, 1, '01.01.2021', 2, 10, 6),
       ('A Modern Instance', 222, 12, '07.06.2018', 4, 1, 10),
       ('The Real Mother Goose', 88, 1, '04.11.2015', 1, 35, 10),
       ('A Thousand Miles Up the Nile', 110, 18, '07.04.2018', 1, 19, 9),
       ('Children of Blood and Bone', 137, 13, '02.10.2021', 1, 7, 4),
       ('A pushcart at the curb', 95, 1, '14.07.2022', 1, 24, 2),
       ('The Desert and the Sown', 126, 10, '07.02.2018', 3, 29, 1),
       ('Three Soldiers', 223, 16, '14.08.2015', 4, 24, 2),
       ('The End of Eternity', 168, 1, '05.02.2017', 5, 9, 8),
       ('Annie Kilburn', 291, 12, '19.09.2022', 2, 1, 9),
       ('A Touch of Sun and Other Stories', 141, 9, '10.10.2015', 3, 29, 5),
       ('Show Boat', 151, 18, '01.10.2015', 2, 22, 2),
       ('The Call of the Wild', 362, 18, '18.03.2018', 2, 3, 2),
       ('My Mark Twain', 339, 9, '07.08.2018', 5, 1, 2),
       ('Broken Ties', 134, 5, '13.03.2019', 2, 8, 10),
       ('Short Stories From American History', 305, 8, '14.06.2018', 1, 4, 7),
       ('Mrs Rosie and the Priest', 104, 14, '20.01.2015', 3, 13, 1),
       ('So Big', 209, 3, '01.10.2020', 3, 22, 6),
       ('Monsieur Maurice ', 92, 8, '09.11.2019', 2, 19, 9),
       ('The Master of Ballantrae', 236, 13, '03.11.2016', 1, 16, 2),
       ('The Unlived Life of Little Mary Ellen', 99, 6, '01.11.2018', 4, 25, 8),
       ('Mouse - The Last Train', 184, 14, '09.06.2017', 4, 2, 8),
       ('Edith Bonham', 122, 7, '04.07.2015', 3, 29, 5),
       ('Maybe Mother Goose', 161, 14, '07.03.2020', 1, 35, 2),
       ('The Noble Gases', 321, 5, '02.04.2020', 3, 9, 7),
       ('Rainy Week', 98, 7, '10.11.2020', 4, 36, 9),
       ('A Hazard of New Fortunes', 144, 4, '08.03.2017', 2, 1, 9),
       ('A Plot for Murder', 108, 13, '02.03.2022', 5, 2, 8),
       ('Nature', 357, 8, '10.10.2017', 3, 11, 3),
       ('Hickory Dickory Dock', 326, 6, '12.02.2021', 4, 35, 2),
       ('Big Fat Hen', 232, 12, '11.09.2018', 3, 35, 9),
       ('The Lone Star Ranger', 328, 9, '16.11.2021', 4, 30, 1),
       ('The Great Fire of London', 252, 9, '06.06.2021', 1, 32, 10),
       ('White Nights', 265, 14, '20.03.2015', 3, 20, 9),
       ('In a Glass Darkly', 173, 9, '11.05.2022', 1, 23, 8),
       ('Fanny herself', 248, 10, '10.09.2020', 2, 22, 1),
       ('Loaded', 273, 4, '16.06.2019', 2, 2, 1),
       ('A Foregone Conclusion', 121, 15, '03.11.2022', 3, 1, 4),
       ('The Hill of Dreams', 175, 6, '01.04.2021', 4, 6, 5),
       ('Adventure', 217, 8, '16.02.2021', 5, 3, 9),
       ('A Tagore Reader', 285, 4, '20.03.2018', 2, 8, 2),
       ('A Tale of Two Cities', 331, 13, '03.11.2017', 2, 10, 8),
       ('Dombey and Son', 344, 14, '02.09.2016', 3, 10, 10),
       ('Famous Women', 273, 1, '05.08.2016', 3, 13, 9),
       ('Rejection,  The Ruling Spirit', 358, 2, '12.02.2015', 3, 5, 3),
       ('Little Dorrit', 314, 13, '14.09.2015', 3, 10, 8),
       ('The Four-Fifteen Express', 201, 2, '01.09.2016', 2, 19, 10),
       ('Fairy Prince and Other Stories', 306, 15, '12.10.2016', 3, 36, 2),
       ('Ten Tales from the Decameron', 183, 5, '10.03.2018', 3, 13, 3),
       ('The Double', 372, 17, '03.01.2019', 1, 20, 2),
       ('A Flight Of Swans', 115, 8, '17.09.2017', 1, 8, 2),
       ('The Phantom Coach', 243, 17, '09.10.2020', 4, 19, 6),
       ('The Game', 209, 10, '20.07.2017', 3, 3, 10),
       ('Rico and Wiseli', 309, 8, '13.09.2015', 4, 27, 10),
       ('The Shorter Pepys', 276, 5, '17.11.2017', 3, 32, 8),
       ('My Life Had Stood a Loaded Gun ', 278, 12, '01.06.2016', 1, 21, 4),
       ('A Tagore Testament', 268, 15, '15.11.2021', 3, 8, 3),
       ('The Cruise of the Dazzler', 140, 10, '09.09.2021', 5, 3, 9),
       ('To the Lighthouse', 90, 2, '16.03.2021', 3, 17, 7),
       ('The Terror', 293, 18, '08.08.2019', 3, 6, 3),
       ('The Sick-a-Bed Lady', 369, 9, '04.07.2021', 1, 36, 9),
       ('Christmas Every Day', 98, 13, '16.07.2017', 4, 1, 4),
       ('The home-maker', 316, 14, '17.02.2018', 1, 12, 10),
       ('The Ground-Swell', 193, 10, '09.03.2017', 4, 29, 6),
       ('A Sleep and a Forgetting', 360, 2, '05.07.2020', 1, 1, 4),
       ('Nicholas Nickleby', 219, 1, '06.08.2017', 1, 10, 5),
       ('The Whole Family: A Novel by Twelve Authors', 149, 6, '06.04.2016', 3, 1, 9),
       ('Middlemarch', 288, 11, '09.10.2018', 5, 18, 9),
       ('Life of Dante', 156, 14, '01.09.2021', 1, 13, 3),
       ('Short Stories From English History', 189, 2, '19.06.2019', 5, 4, 6),
       ('Little Eve Edgarton', 306, 5, '19.10.2020', 3, 36, 3),
       ('The Kingdom of the Sun', 189, 9, '11.11.2016', 3, 9, 1),
       ('Indian Summer', 107, 14, '18.03.2019', 5, 1, 9),
       ('Mrs Dalloway', 321, 5, '04.11.2020', 3, 17, 1),
       ('Demons', 232, 15, '02.07.2017', 2, 20, 5),
       ('The Last Trail', 116, 14, '18.01.2018', 2, 30, 3),
       ('The Fredric Brown Megapack', 324, 16, '17.02.2020', 4, 2, 8),
       ('The Decameron: Selected Tales', 337, 17, '17.04.2019', 1, 13, 2),
       ('Th bent twig', 367, 3, '20.07.2015', 4, 12, 5),
       ('Things near and far', 199, 6, '05.02.2018', 2, 6, 8),
       ('The Story of Salome', 316, 11, '11.10.2021', 1, 19, 8),
       ('The Destruction of Our Children', 104, 9, '19.07.2015', 5, 5, 1),
       ('Collected Stories', 295, 4, '11.01.2019', 5, 8, 2),
       ('The House of the Dead', 209, 2, '01.05.2017', 5, 20, 9),
       ('Sonny: A Christmas Guest', 186, 6, '07.06.2020', 5, 25, 5),
       ('Amores', 297, 10, '20.09.2018', 4, 15, 3),
       ('Chaturanga', 218, 10, '06.06.2021', 5, 8, 5),
       ('Little Eve Edgarton', 247, 14, '06.06.2018', 5, 36, 2),
       ('Chitra', 122, 9, '01.05.2015', 1, 8, 1),
       ('The Iron Heel', 81, 15, '04.11.2021', 1, 3, 4),
       ('Self Reliance', 137, 18, '13.04.2022', 2, 11, 8),
       ('The Great God Pan And The Hill Of Dreams', 158, 5, '09.09.2017', 1, 6, 8),
       ('The White People and Other Weird Stories', 100, 15, '13.02.2015', 1, 6, 3),
       ('The Diary of Samuel Pepys: A Selection', 271, 3, '09.09.2015', 4, 32, 8);


INSERT INTO user_data.Roles
    (title)
VALUES ('ROLE_USER'),
       ('ROLE_LIBRARIAN'),
       ('ROLE_ADMIN');


INSERT INTO user_data.Users
(id, username, password, role_id, email, phone_number, first_name, last_name)
VALUES (10000, 'user',
        '$argon2id$v=19$m=16384,t=2,p=1$kgBZffntnhd8w753UCymjQ$rbqNvmqwKLf1mtRQcZnfkLe/o2IrjrnJwbLQfysprVk',
        1, 'usermail@gmail.com', '3802222222', 'alex', 'jhones');


INSERT INTO user_data.Users
(id, username, password, role_id, is_banned, email, phone_number, first_name, last_name)
VALUES (10001, 'is_banned_user',
        '$argon2id$v=19$m=16384,t=2,p=1$kgBZffntnhd8w753UCymjQ$rbqNvmqwKLf1mtRQcZnfkLe/o2IrjrnJwbLQfysprVk',
        1, true, 'is_banned@gmail.com', '3804444444', 'top', 'gun');


--password: qwerty123

INSERT INTO user_data.Users
(id, username, password, role_id, email, phone_number, first_name, last_name)
VALUES (10002, 'librarian',
        '$argon2id$v=19$m=16384,t=2,p=1$kgBZffntnhd8w753UCymjQ$rbqNvmqwKLf1mtRQcZnfkLe/o2IrjrnJwbLQfysprVk',
        2, 'librarian@gmail.com', '3803333333', 'mike', 'tayson');

--password: qwerty123

INSERT INTO user_data.Users
(id, username, password, role_id, email, phone_number, first_name, last_name)
VALUES (10003, 'admin',
        '$argon2id$v=19$m=16384,t=2,p=1$kgBZffntnhd8w753UCymjQ$rbqNvmqwKLf1mtRQcZnfkLe/o2IrjrnJwbLQfysprVk',
        3, 'admin@gmail.com', '3801111111', 'max', 'payne');


--password: admin123


INSERT INTO local_lib.Orders
    (user_id, book_id, start_date, end_date, return_date)
VALUES (10000, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', NULL),
       (10000, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', NULL),
       (10000, 3, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', NULL),
       (10000, 42, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', NULL),
       (10000, 50, CURRENT_DATE, CURRENT_DATE - INTERVAL '1 month', NULL),
       (10000, 50, CURRENT_DATE - INTERVAL '1 month', CURRENT_DATE + INTERVAL '1 month', CURRENT_DATE);
