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
