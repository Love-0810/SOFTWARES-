-- ========================================
-- SAMPLE DRUG DATABASE
-- Blessed Paul Pharmacy Management System
-- ========================================

-- Insert common drugs (sample data)
INSERT INTO drugs (
    generic_name, brand_names, category_id, drug_class_id, 
    therapeutic_class_id, description, uses, indications, 
    contraindications, side_effects, dosage_info, 
    administration_method, storage_instructions
) VALUES
-- Antibiotics
('Amoxicillin', 'Amoxil, Alphamox', 1, 1, 1, 
 'Beta-lactam antibiotic', 'Bacterial infections', 
 'Respiratory, ear, nose, throat infections',
 'Penicillin allergy', 'Rash, nausea, diarrhea',
 '250-500mg 3 times daily', 'Oral',
 'Store at room temperature, away from moisture'),

('Metronidazole', 'Flagyl', 1, 1, 1,
 'Antimicrobial antibiotic', 'Protozoal and anaerobic infections',
 'Bacterial vaginosis, trichomoniasis',
 'Pregnancy (first trimester)', 'Metallic taste, nausea',
 '250-500mg 3 times daily', 'Oral',
 'Store at room temperature'),

('Ciprofloxacin', 'Cipro', 1, 1, 1,
 'Fluoroquinolone antibiotic', 'Broad spectrum antibiotic',
 'UTI, respiratory, skin infections',
 'Tendon disorders history', 'Nausea, diarrhea, headache',
 '250-750mg twice daily', 'Oral',
 'Store at room temperature'),

-- Analgesics & Anti-inflammatory
('Paracetamol', 'Acetaminophen, Tylenol', 2, 2, 2,
 'Acetaminophen analgesic', 'Pain relief and fever reduction',
 'Headache, bodyache, fever',
 'Liver disease, alcohol dependence', 'Rash, nausea',
 '500-1000mg 4-6 hourly max 4000mg/day', 'Oral',
 'Store below 25°C'),

('Ibuprofen', 'Brufen, Advil', 2, 2, 2,
 'NSAID pain reliever', 'Anti-inflammatory pain relief',
 'Headache, muscle pain, fever',
 'GI ulcers, severe kidney disease', 'Stomach upset, nausea',
 '200-400mg 4-6 hourly', 'Oral',
 'Store at room temperature'),

('Aspirin', 'Bayer Aspirin', 2, 2, 2,
 'Salicylate analgesic', 'Pain, fever, anti-thrombotic',
 'Headache, fever, cardiovascular protection',
 'Asthma, GI ulcers, bleeding disorders', 'Stomach irritation',
 '325-500mg 4-6 hourly', 'Oral',
 'Store in cool, dry place'),

-- Antihistamines
('Cetirizine', 'Zyrtec, Alleroff', 3, 3, 3,
 'Antihistamine', 'Allergy relief',
 'Allergic rhinitis, urticaria',
 'Severe renal impairment', 'Drowsiness, headache',
 '10mg once daily', 'Oral',
 'Store at room temperature'),

('Loratadine', 'Claritin', 3, 3, 3,
 'Non-sedating antihistamine', 'Seasonal allergies',
 'Allergic rhinitis, urticaria',
 'None significant', 'Headache',
 '10mg once daily', 'Oral',
 'Store at room temperature'),

-- Antacids
('Omeprazole', 'Prilosec, Omez', 4, 4, 4,
 'Proton pump inhibitor', 'Reduce stomach acid',
 'GERD, peptic ulcer disease',
 'Severe liver disease', 'Headache, nausea',
 '20-40mg once daily', 'Oral',
 'Store below 25°C'),

('Ranitidine', 'Zantac', 4, 4, 4,
 'H2-receptor antagonist', 'Reduce stomach acid',
 'GERD, peptic ulcers, heartburn',
 'Severe kidney disease', 'Headache, diarrhea',
 '150mg twice daily', 'Oral',
 'Store at room temperature'),

-- Vitamins & Supplements
('Vitamin C', 'Ascorbic Acid', 5, 5, 5,
 'Vitamin supplement', 'Immune support, antioxidant',
 'Vitamin C deficiency, immune support',
 'Severe hemochromatosis', 'Mild nausea',
 '500-1000mg daily', 'Oral',
 'Store in cool, dry place'),

('Vitamin D3', 'Cholecalciferol', 5, 5, 5,
 'Vitamin D supplement', 'Calcium absorption, bone health',
 'Vitamin D deficiency, osteoporosis',
 'Hypercalcemia', 'None',
 '1000-4000 IU daily', 'Oral',
 'Store at room temperature'),

('Multivitamin', 'Daily Vital', 5, 5, 5,
 'Vitamin combination', 'General nutritional supplement',
 'Nutritional deficiency',
 'Hemochromatosis', 'Mild upset stomach',
 '1 tablet daily', 'Oral',
 'Store in cool, dry place'),

-- Cold & Flu
('Cough Syrup', 'Robitussin', 6, 6, 6,
 'Cough suppressant', 'Suppress cough',
 'Dry cough, cold symptoms',
 'MAOI use', 'Drowsiness',
 '10-20ml every 4 hours', 'Oral',
 'Store at room temperature'),

('Pseudoephedrine', 'Sudafed', 6, 6, 6,
 'Decongestant', 'Nasal congestion relief',
 'Nasal congestion from cold/flu',
 'Severe hypertension', 'Nervousness, insomnia',
 '30-60mg 4-6 hourly max 240mg/day', 'Oral',
 'Store at room temperature');

-- Insert sample manufacturers
INSERT INTO manufacturers (name, country) VALUES
('GlaxoSmithKline', 'United Kingdom'),
('Pfizer', 'United States'),
('Novartis', 'Switzerland'),
('Johnson & Johnson', 'United States'),
('Merck', 'United States'),
('AbbVie', 'United States'),
('Local Generic Company', 'Local Country');

-- Insert sample suppliers
INSERT INTO suppliers (name, contact_person, phone, email, city, country, payment_terms) VALUES
('MedSupply Distributors', 'John Smith', '555-1234', 'john@medsupply.com', 'City A', 'Country', 'Net 30'),
('PharmaCorp International', 'Sarah Johnson', '555-5678', 'sarah@pharmacorp.com', 'City B', 'Country', 'Net 45'),
('Generic Meds Inc', 'Mike Davis', '555-9012', 'mike@genericmeds.com', 'City C', 'Country', 'COD'),
('Wholesale Pharmacy Plus', 'Emma Wilson', '555-3456', 'emma@wpplus.com', 'City D', 'Country', 'Net 60');

-- ========================================
-- END OF SEED DATA
-- ========================================
