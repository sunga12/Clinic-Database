CREATE TABLE patients(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR(50),
	date_of_birth DATE
);

CREATE TABLE treatments(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	type VARCHAR(50),
	name VARCHAR(50)
);

CREATE TABLE medical_histories(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	admitted_at TIMESTAMP,
	patient_id INT REFERENCES patients(id),
	status VARCHAR(25)
);

CREATE TABLE invoices(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
	invoice_id INT REFERENCES invoices(id),
	treatment_id INT REFERENCES treatments(id)
);

ALTER TABLE medical_histories ADD CONSTRAINT fk_patients FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE invoices ADD CONSTRAINT fk_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices(id);

CREATE INDEX idx_patient_id ON medical_histories(patient_id);
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);
