BEGIN TRANSACTION;

CREATE TABLE owner
(
        owner_id SERIAL NOT NULL,
        last_name VARCHAR (15) NOT NULL,
        first_name VARCHAR (15) NOT NULL,
        address VARCHAR (30),
        city VARCHAR (30),
        province VARCHAR (2),
        postal_code VARCHAR (7)
);


CREATE TABLE pet
(
        pet_id SERIAL NOT NULL,
        owner_id INTEGER,
        name VARCHAR (15) NOT NULL,
        type VARCHAR (10) NOT NULL,
        age INTEGER NOT NULL
);

CREATE TABLE invoice
(
        invoice_id SERIAL NOT NULL,
        owner_id INTEGER,
        invoice_date TIMESTAMP NOT NULL,
        tax numeric (15, 2) NOT NULL,
        invoice_total numeric (15,2) NOT NULL
 );

CREATE TABLE procedure
(
        procedure_id SERIAL NOT NULL,
        pet_id INTEGER,
        invoice_id INTEGER,
        name VARCHAR (30) NOT NULL,
        procedure_price NUMERIC (15,2) NOT NULL,
        procedure_date TIMESTAMP NOT NULL
);


ALTER TABLE owner ADD CONSTRAINT pk_owner PRIMARY KEY (owner_id);

ALTER TABLE pet ADD CONSTRAINT pk_pet PRIMARY KEY (pet_id);
ALTER TABLE pet ADD CONSTRAINT fk_pet_owner FOREIGN KEY (owner_id) REFERENCES owner (owner_id);

ALTER TABLE invoice ADD CONSTRAINT pk_invoice PRIMARY KEY (invoice_id);
ALTER TABLE invoice ADD CONSTRAINT fk_invoice_owner FOREIGN KEY (owner_id) REFERENCES owner (owner_id);

ALTER TABLE procedure ADD CONSTRAINT pk_procedure PRIMARY KEY (procedure_id);
ALTER TABLE procedure ADD CONSTRAINT fk_pet_procedure FOREIGN KEY (pet_id) REFERENCES pet (pet_id);
ALTER TABLE procedure ADD CONSTRAINT fk_procedure_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (invoice_id);

COMMIT transaction;