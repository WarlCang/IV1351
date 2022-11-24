CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(500) NOT NULL,
 person_number UNIQUE VARCHAR(12) NOT NULL,
 can_teach_ensembles BOOLEAN NOT NULL,
 zip VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 mobilenumber VARCHAR(20) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument_can_teach (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(50) NOT NULL
);

ALTER TABLE instrument_can_teach ADD CONSTRAINT PK_instrument_can_teach PRIMARY KEY (id);


CREATE TABLE instruments (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(30) NOT NULL,
 quantity INT NOT NULL,
 type VARCHAR(30) NOT NULL,
 price FLOAT(10) NOT NULL
);

ALTER TABLE instruments ADD CONSTRAINT PK_instruments PRIMARY KEY (id);


CREATE TABLE intrument_instructor_can_teach (
 intrument_can_teach_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT PK_intrument_instructor_can_teach PRIMARY KEY (intrument_can_teach_id,instructor_id);


CREATE TABLE is_avaliable_time (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time TIMESTAMP(10) NOT NULL
);

ALTER TABLE is_avaliable_time ADD CONSTRAINT PK_is_avaliable_time PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 beginner_price FLOAT(10) NOT NULL,
 intermediate_price  FLOAT(10) NOT NULL,
 Individual_lesoon_price  FLOAT(10) NOT NULL,
 advanced_price  FLOAT(10) NOT NULL,
 group_lesson_price FLOAT(10) NOT NULL,
 sibling_discount DECIMAL(10)
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name  VARCHAR(500) NOT NULL,
 person_number UNIQUE VARCHAR(12) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 type_of_skill VARCHAR(500) NOT NULL,
 level_of_skill VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 mobilenumber VARCHAR(20) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE contact_person (
 student_id INT NOT NULL,
 relationWithStudent VARCHAR(500) NOT NULL,
 mobilenumber VARCHAR(20) NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (student_id);


CREATE TABLE instructor_is_avaliable_time (
 instructor_id INT NOT NULL,
 is_avaliable_time_id INT NOT NULL
);

ALTER TABLE instructor_is_avaliable_time ADD CONSTRAINT PK_instructor_is_avaliable_time PRIMARY KEY (instructor_id,is_avaliable_time_id);


CREATE TABLE intrument_renting (
 student_id INT NOT NULL,
 intrument_id INT NOT NULL,
 rentTime TIMESTAMP(10) NOT NULL
);

ALTER TABLE intrument_renting ADD CONSTRAINT PK_intrument_renting PRIMARY KEY (student_id,intrument_id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 level VARCHAR(20) NOT NULL,
 instructor_id INT NOT NULL,
 price_scheme_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE siblings (
 name VARCHAR(500) NOT NULL,
 personNumber UNIQUE VARCHAR(12) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (name,personNumber UNIQUE,student_id);


CREATE TABLE student_lesson (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (student_id,lesson_id);


CREATE TABLE ensembles (
 lesson_id INT NOT NULL,
 minNumberOfStudents INT NOT NULL,
 maxNumberOfStudents INT NOT NULL,
 genre VARCHAR(50) NOT NULL,
 time TIMESTAMP(10) NOT NULL
);

ALTER TABLE ensembles ADD CONSTRAINT PK_ensembles PRIMARY KEY (lesson_id);


CREATE TABLE group_lessons (
 lesson_id INT NOT NULL,
 max_number_of_students INT NOT NULL,
 min_number_of_students INT NOT NULL,
 intrument_type VARCHAR(50) NOT NULL,
 time TIMESTAMP(10) NOT NULL
);

ALTER TABLE group_lessons ADD CONSTRAINT PK_group_lessons PRIMARY KEY (lesson_id);


CREATE TABLE individual_lessons (
 lesson_id INT NOT NULL,
 intrument_type VARCHAR(50) NOT NULL,
 booked_time TIMESTAMP(10) NOT NULL
);

ALTER TABLE individual_lessons ADD CONSTRAINT PK_individual_lessons PRIMARY KEY (lesson_id);


ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT FK_intrument_instructor_can_teach_0 FOREIGN KEY (intrument_can_teach_id) REFERENCES instrument_can_teach (id) ON DELETE CASCADE;
ALTER TABLE intrument_instructor_can_teach ADD CONSTRAINT FK_intrument_instructor_can_teach_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE instructor_is_avaliable_time ADD CONSTRAINT FK_instructor_is_avaliable_time_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;
ALTER TABLE instructor_is_avaliable_time ADD CONSTRAINT FK_instructor_is_avaliable_time_1 FOREIGN KEY (is_avaliable_time_id) REFERENCES is_avaliable_time (id) ON DELETE CASCADE;


ALTER TABLE intrument_renting ADD CONSTRAINT FK_intrument_renting_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE intrument_renting ADD CONSTRAINT FK_intrument_renting_1 FOREIGN KEY (intrument_id) REFERENCES instruments (id) ON DELETE CASCADE;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE SET NULL;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_scheme_id) REFERENCES pricing_scheme (id) ON DELETE SET NULL;


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE ensembles ADD CONSTRAINT FK_ensembles_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE group_lessons ADD CONSTRAINT FK_group_lessons_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE individual_lessons ADD CONSTRAINT FK_individual_lessons_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


