CREATE TABLE patients (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  type_name VARCHAR(255) NOT NULL
);

CREATE TABLE invoice_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  unit_price DECIMAL(10, 2) NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE invoices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  total_amount DECIMAL(10, 2) NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP,
  medical_history_id INT NOT NULL UNIQUE,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE medical_histories_treatments (
  medical_history_id INT NOT NULL,
  treatment_id INT NOT NULL,
  PRIMARY KEY (medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

-- Add indexes to foreign keys

ALTER TABLE medical_histories
ADD INDEX (patient_id);
ALTER TABLE invoice_items
ADD INDEX (invoice_id),
ADD INDEX (treatment_id);
ALTER TABLE invoices
ADD INDEX (medical_history_id);
ALTER TABLE medical_histories_treatments
ADD INDEX (medical_history_id),
ADD INDEX (treatment_id);