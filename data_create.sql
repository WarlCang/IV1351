CREATE TABLE contact_person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (id);


CREATE TABLE genre (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 genre VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE genre ADD CONSTRAINT PK_genre PRIMARY KEY (id);


CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(500) NOT NULL,
 person_number VARCHAR(12) UNIQUE NOT NULL,
 email VARCHAR(500) UNIQUE NOT NULL,
 phone VARCHAR(500) NOT NULL,
 can_teach_ensemble BOOLEAN NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE intrument_can_teach (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE intrument_can_teach ADD CONSTRAINT PK_intrument_can_teach PRIMARY KEY (id);


CREATE TABLE instrument_brand (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE instrument_brand ADD CONSTRAINT PK_instrument_brand PRIMARY KEY (id);


CREATE TABLE instrument_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (id);


CREATE TABLE lesson_skill_level (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 level VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE lesson_skill_level ADD CONSTRAINT PK_lesson_skill_level PRIMARY KEY (id);


CREATE TABLE lesson_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE lesson_type ADD CONSTRAINT PK_lesson_type PRIMARY KEY (id);


CREATE TABLE intrument_instructor_can_teach (
 instructor_id INT NOT NULL,
 intrument_can_teach_id INT NOT NULL
);

ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT PK_intrument_instructor_can_teach PRIMARY KEY (instructor_id,intrument_can_teach_id);


CREATE TABLE price_skill_level (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE price_skill_level ADD CONSTRAINT PK_price_skill_level PRIMARY KEY (id);


CREATE TABLE price_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE price_type ADD CONSTRAINT PK_price_type PRIMARY KEY (id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(500) NOT NULL,
 person_number VARCHAR(12) UNIQUE NOT NULL,
 email VARCHAR(500) UNIQUE,
 phone VARCHAR(500),
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 contact_person_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(500) UNIQUE NOT NULL
);

ALTER TABLE student_instrument ADD CONSTRAINT PK_student_instrument PRIMARY KEY (id);


CREATE TABLE booking (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 date DATE NOT NULL,
 time TIME(6) NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (id);


CREATE TABLE lesson_price (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 price INT NOT NULL,
 sibling_discount INT,
 price_type_id INT NOT NULL,
 price_skill_level_id INT
);

ALTER TABLE lesson_price ADD CONSTRAINT PK_lesson_price PRIMARY KEY (id);


CREATE TABLE sibling (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id,sibling_id);


CREATE TABLE booked_students (
 student_id INT NOT NULL,
 booking_id INT NOT NULL
);

ALTER TABLE booked_students ADD CONSTRAINT PK_booked_students PRIMARY KEY (student_id,booking_id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_brand_id INT NOT NULL,
 instrument_type_id INT NOT NULL,
 instrument_id VARCHAR(500) UNIQUE NOT NULL,
 cost INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);

CREATE TABLE instrument_renting (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 student_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instrument_renting ADD CONSTRAINT PK_instrument_renting PRIMARY KEY (id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 booking_id INT NOT NULL,
 lesson_type_id INT NOT NULL,
 min_number_of_students INT,
 max_number_of_students INT,
 genre_id INT
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT FK_intrument_instructor_can_teach_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;
ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT FK_intrument_instructor_can_teach_1 FOREIGN KEY (intrument_can_teach_id) REFERENCES intrument_can_teach (id) ON DELETE CASCADE;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (contact_person_id) REFERENCES contact_person (id) ON DELETE SET NULL;


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE NO ACTION;


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id) ON DELETE NO ACTION;
ALTER TABLE instrument ADD CONSTRAINT FK_instrument_1 FOREIGN KEY (instrument_brand_id) REFERENCES instrument_brand (id) ON DELETE NO ACTION;


ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_0 FOREIGN KEY (price_type_id) REFERENCES price_type (id) ON DELETE NO ACTION;
ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_1 FOREIGN KEY (price_skill_level_id) REFERENCES price_skill_level (id) ON DELETE NO ACTION;


ALTER TABLE instrument_renting ADD CONSTRAINT FK_instrument_renting_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE NO ACTION;
ALTER TABLE instrument_renting ADD CONSTRAINT FK_instrument_renting_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id) ON DELETE NO ACTION;


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE booked_students ADD CONSTRAINT FK_booked_students_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE booked_students ADD CONSTRAINT FK_booked_students_1 FOREIGN KEY (booking_id) REFERENCES booking (id) ON DELETE CASCADE;


--ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (genre_id) REFERENCES genre (id) ON DELETE SET NULL;
--ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (lesson_skill_level_id) REFERENCES lesson_skill_level (id) ON DELETE NO ACTION;
--ALTER TABLE lesson ADD CONSTRAINT FK_lesson_2 FOREIGN KEY (instrument_id) REFERENCES instrument (id) ON DELETE SET NULL;
--ALTER TABLE lesson ADD CONSTRAINT FK_lesson_3 FOREIGN KEY (lesson_type_id) REFERENCES lesson_type (id) ON DELETE NO ACTION;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (booking_id) REFERENCES booking (id) ON DELETE NO ACTION;
--ALTER TABLE lesson ADD CONSTRAINT FK_lesson_5 FOREIGN KEY (lesson_price_id) REFERENCES lesson_price (id) ON DELETE NO ACTION;
