-- ========================================
-- BLESSED PAUL PHARMACY MANAGEMENT SYSTEM
-- Database Schema (PostgreSQL/SQLite Compatible)
-- Version 1.0
-- ========================================

-- ========================================
-- 1. CORE AUTHENTICATION & USER MANAGEMENT
-- ========================================

CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS permissions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    module VARCHAR(50) NOT NULL,
    action VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS role_permissions (
    id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
    UNIQUE(role_id, permission_id)
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    role_id INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_suspended BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    token VARCHAR(500) NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ========================================
-- 2. DRUG & INVENTORY MANAGEMENT
-- ========================================

CREATE TABLE IF NOT EXISTS drug_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS drug_classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS therapeutic_classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS manufacturers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    country VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS drugs (
    id SERIAL PRIMARY KEY,
    generic_name VARCHAR(150) NOT NULL,
    brand_names TEXT,
    category_id INTEGER,
    drug_class_id INTEGER,
    therapeutic_class_id INTEGER,
    manufacturer_id INTEGER,
    description TEXT,
    uses TEXT,
    indications TEXT,
    contraindications TEXT,
    warnings TEXT,
    precautions TEXT,
    side_effects TEXT,
    dosage_info TEXT,
    administration_method VARCHAR(100),
    pregnancy_category VARCHAR(10),
    storage_instructions TEXT,
    drug_interactions TEXT,
    strength VARCHAR(100),
    form VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES drug_categories(id),
    FOREIGN KEY (drug_class_id) REFERENCES drug_classes(id),
    FOREIGN KEY (therapeutic_class_id) REFERENCES therapeutic_classes(id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id)
);

CREATE TABLE IF NOT EXISTS suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    payment_terms VARCHAR(100),
    credit_limit DECIMAL(15, 2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventory_batches (
    id SERIAL PRIMARY KEY,
    drug_id INTEGER NOT NULL,
    supplier_id INTEGER,
    batch_number VARCHAR(100) NOT NULL,
    barcode VARCHAR(100) UNIQUE,
    qr_code VARCHAR(500),
    cost_price DECIMAL(15, 2),
    selling_price DECIMAL(15, 2),
    quantity INTEGER DEFAULT 0,
    reorder_level INTEGER DEFAULT 10,
    manufacturing_date DATE,
    expiry_date DATE,
    storage_conditions TEXT,
    purchase_order_number VARCHAR(100),
    received_date DATE,
    received_by INTEGER,
    is_expired BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (drug_id) REFERENCES drugs(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (received_by) REFERENCES users(id),
    UNIQUE(batch_number)
);

CREATE TABLE IF NOT EXISTS stock_movements (
    id SERIAL PRIMARY KEY,
    batch_id INTEGER NOT NULL,
    movement_type VARCHAR(50) NOT NULL,
    quantity_change INTEGER NOT NULL,
    reason VARCHAR(255),
    reference_number VARCHAR(100),
    notes TEXT,
    created_by INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS purchase_orders (
    id SERIAL PRIMARY KEY,
    po_number VARCHAR(100) UNIQUE NOT NULL,
    supplier_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    expected_delivery_date DATE,
    status VARCHAR(50) DEFAULT 'PENDING',
    total_amount DECIMAL(15, 2),
    notes TEXT,
    created_by INTEGER NOT NULL,
    approved_by INTEGER,
    approved_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (approved_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS purchase_order_items (
    id SERIAL PRIMARY KEY,
    purchase_order_id INTEGER NOT NULL,
    drug_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(15, 2),
    line_total DECIMAL(15, 2),
    received_quantity INTEGER DEFAULT 0,
    FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id) ON DELETE CASCADE,
    FOREIGN KEY (drug_id) REFERENCES drugs(id)
);

-- ========================================
-- 3. CUSTOMERS & PRESCRIPTIONS
-- ========================================

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    customer_type VARCHAR(50) DEFAULT 'RETAIL',
    outstanding_balance DECIMAL(15, 2) DEFAULT 0,
    total_spent DECIMAL(15, 2) DEFAULT 0,
    loyalty_points INTEGER DEFAULT 0,
    allergies TEXT,
    medical_conditions TEXT,
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS prescriptions (
    id SERIAL PRIMARY KEY,
    prescription_number VARCHAR(100) UNIQUE NOT NULL,
    customer_id INTEGER,
    patient_name VARCHAR(150) NOT NULL,
    patient_id VARCHAR(100),
    doctor_name VARCHAR(150),
    diagnosis TEXT,
    prescription_date DATE NOT NULL,
    valid_until DATE,
    status VARCHAR(50) DEFAULT 'PENDING',
    notes TEXT,
    created_by INTEGER NOT NULL,
    dispensed_by INTEGER,
    dispensed_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (dispensed_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS prescription_items (
    id SERIAL PRIMARY KEY,
    prescription_id INTEGER NOT NULL,
    drug_id INTEGER NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration VARCHAR(100),
    quantity INTEGER,
    instructions TEXT,
    is_dispensed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE,
    FOREIGN KEY (drug_id) REFERENCES drugs(id)
);

-- ========================================
-- 4. SALES & BILLING
-- ========================================

CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    transaction_number VARCHAR(100) UNIQUE NOT NULL,
    customer_id INTEGER,
    transaction_type VARCHAR(50) DEFAULT 'SALE',
    transaction_date TIMESTAMP NOT NULL,
    subtotal DECIMAL(15, 2),
    discount_amount DECIMAL(15, 2) DEFAULT 0,
    discount_percent DECIMAL(5, 2) DEFAULT 0,
    tax_amount DECIMAL(15, 2) DEFAULT 0,
    total_amount DECIMAL(15, 2),
    amount_paid DECIMAL(15, 2),
    change_amount DECIMAL(15, 2),
    payment_method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'COMPLETED',
    notes TEXT,
    cashier_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (cashier_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS transaction_items (
    id SERIAL PRIMARY KEY,
    transaction_id INTEGER NOT NULL,
    batch_id INTEGER NOT NULL,
    drug_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(15, 2),
    line_total DECIMAL(15, 2),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(id),
    FOREIGN KEY (drug_id) REFERENCES drugs(id)
);

CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    transaction_id INTEGER,
    customer_id INTEGER,
    amount DECIMAL(15, 2) NOT NULL,
    payment_method VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reference_number VARCHAR(100),
    notes TEXT,
    received_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (received_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS returns (
    id SERIAL PRIMARY KEY,
    return_number VARCHAR(100) UNIQUE NOT NULL,
    transaction_id INTEGER NOT NULL,
    return_date TIMESTAMP NOT NULL,
    reason TEXT,
    total_amount DECIMAL(15, 2),
    refund_method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'PENDING',
    approved_by INTEGER,
    processed_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id),
    FOREIGN KEY (approved_by) REFERENCES users(id),
    FOREIGN KEY (processed_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS return_items (
    id SERIAL PRIMARY KEY,
    return_id INTEGER NOT NULL,
    transaction_item_id INTEGER NOT NULL,
    quantity_returned INTEGER,
    reason VARCHAR(255),
    FOREIGN KEY (return_id) REFERENCES returns(id) ON DELETE CASCADE,
    FOREIGN KEY (transaction_item_id) REFERENCES transaction_items(id)
);

-- ========================================
-- 5. ALERTS & NOTIFICATIONS
-- ========================================

CREATE TABLE IF NOT EXISTS alerts (
    id SERIAL PRIMARY KEY,
    alert_type VARCHAR(50) NOT NULL,
    severity VARCHAR(20) DEFAULT 'INFO',
    title VARCHAR(255),
    message TEXT,
    reference_id INTEGER,
    reference_type VARCHAR(50),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    alert_id INTEGER,
    message TEXT,
    notification_type VARCHAR(50),
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (alert_id) REFERENCES alerts(id) ON DELETE SET NULL
);

-- ========================================
-- 6. AUDIT LOGGING
-- ========================================

CREATE TABLE IF NOT EXISTS audit_logs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    action VARCHAR(100) NOT NULL,
    module VARCHAR(50) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INTEGER,
    old_values TEXT,
    new_values TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    status VARCHAR(50) DEFAULT 'SUCCESS',
    error_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS login_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    logout_time TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    status VARCHAR(50) DEFAULT 'SUCCESS',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ========================================
-- 7. SYSTEM SETTINGS & CONFIGURATION
-- ========================================

CREATE TABLE IF NOT EXISTS system_settings (
    id SERIAL PRIMARY KEY,
    key VARCHAR(100) UNIQUE NOT NULL,
    value TEXT,
    description TEXT,
    data_type VARCHAR(50),
    is_editable BOOLEAN DEFAULT TRUE,
    updated_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS backup_logs (
    id SERIAL PRIMARY KEY,
    backup_type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'PENDING',
    file_path TEXT,
    file_size BIGINT,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    error_message TEXT,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ========================================
-- INDEXES FOR PERFORMANCE
-- ========================================

-- User & Authentication Indexes
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role_id ON users(role_id);
CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_token ON sessions(token);
CREATE INDEX idx_login_history_user_id ON login_history(user_id);
CREATE INDEX idx_login_history_login_time ON login_history(login_time);

-- Drug & Inventory Indexes
CREATE INDEX idx_drugs_generic_name ON drugs(generic_name);
CREATE INDEX idx_drugs_category_id ON drugs(category_id);
CREATE INDEX idx_inventory_batches_drug_id ON inventory_batches(drug_id);
CREATE INDEX idx_inventory_batches_barcode ON inventory_batches(barcode);
CREATE INDEX idx_inventory_batches_expiry_date ON inventory_batches(expiry_date);
CREATE INDEX idx_stock_movements_batch_id ON stock_movements(batch_id);
CREATE INDEX idx_stock_movements_created_at ON stock_movements(created_at);

-- Transaction Indexes
CREATE INDEX idx_transactions_customer_id ON transactions(customer_id);
CREATE INDEX idx_transactions_transaction_date ON transactions(transaction_date);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_transaction_items_transaction_id ON transaction_items(transaction_id);
CREATE INDEX idx_transaction_items_batch_id ON transaction_items(batch_id);

-- Prescription Indexes
CREATE INDEX idx_prescriptions_customer_id ON prescriptions(customer_id);
CREATE INDEX idx_prescriptions_status ON prescriptions(status);
CREATE INDEX idx_prescriptions_prescription_date ON prescriptions(prescription_date);

-- Audit & Logging Indexes
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);

-- ========================================
-- VIEWS FOR COMMON QUERIES
-- ========================================

CREATE VIEW v_low_stock_items AS
SELECT 
    ib.id,
    d.generic_name,
    d.brand_names,
    ib.batch_number,
    ib.quantity,
    ib.reorder_level,
    ib.expiry_date,
    ib.selling_price
FROM inventory_batches ib
JOIN drugs d ON ib.drug_id = d.id
WHERE ib.quantity <= ib.reorder_level
    AND ib.is_active = TRUE
    AND ib.is_expired = FALSE
ORDER BY ib.quantity ASC;

CREATE VIEW v_expired_items AS
SELECT 
    ib.id,
    d.generic_name,
    d.brand_names,
    ib.batch_number,
    ib.quantity,
    ib.expiry_date,
    ib.selling_price
FROM inventory_batches ib
JOIN drugs d ON ib.drug_id = d.id
WHERE ib.expiry_date < CURRENT_DATE
    AND ib.is_active = TRUE
ORDER BY ib.expiry_date ASC;

CREATE VIEW v_near_expiry_items AS
SELECT 
    ib.id,
    d.generic_name,
    d.brand_names,
    ib.batch_number,
    ib.quantity,
    ib.expiry_date,
    ib.selling_price,
    CAST((JULIANDAY(ib.expiry_date) - JULIANDAY('now')) AS INTEGER) as days_to_expiry
FROM inventory_batches ib
JOIN drugs d ON ib.drug_id = d.id
WHERE ib.expiry_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '30 days'
    AND ib.is_active = TRUE
ORDER BY ib.expiry_date ASC;

CREATE VIEW v_daily_sales AS
SELECT 
    DATE(t.transaction_date) as sale_date,
    COUNT(DISTINCT t.id) as transaction_count,
    SUM(t.total_amount) as total_revenue,
    AVG(t.total_amount) as avg_transaction_value,
    SUM(ti.quantity) as total_items_sold
FROM transactions t
LEFT JOIN transaction_items ti ON t.id = ti.transaction_id
WHERE t.status = 'COMPLETED'
GROUP BY DATE(t.transaction_date)
ORDER BY sale_date DESC;

CREATE VIEW v_inventory_value AS
SELECT 
    SUM(ib.quantity * ib.cost_price) as total_cost_value,
    SUM(ib.quantity * ib.selling_price) as total_selling_value,
    SUM(ib.quantity * ib.selling_price) - SUM(ib.quantity * ib.cost_price) as total_potential_profit
FROM inventory_batches ib
WHERE ib.is_active = TRUE
    AND ib.is_expired = FALSE;

CREATE VIEW v_customer_balances AS
SELECT 
    c.id,
    c.name,
    c.phone,
    c.email,
    COUNT(DISTINCT t.id) as total_transactions,
    SUM(t.total_amount) as total_spent,
    c.outstanding_balance,
    c.loyalty_points
FROM customers c
LEFT JOIN transactions t ON c.id = t.customer_id AND t.status = 'COMPLETED'
WHERE c.is_active = TRUE
GROUP BY c.id;

-- ========================================
-- INSERT DEFAULT DATA
-- ========================================

-- Insert default roles
INSERT INTO roles (name, description) VALUES 
    ('Administrator', 'Full system access'),
    ('Pharmacist', 'Manage drugs and prescriptions'),
    ('Cashier', 'Process sales and payments'),
    ('Manager', 'View reports and manage inventory'),
    ('Inventory Staff', 'Manage stock and receiving')
ON CONFLICT (name) DO NOTHING;

-- Insert drug categories
INSERT INTO drug_categories (name, description) VALUES
    ('Antibiotics', 'Antibacterial medications'),
    ('Analgesics', 'Pain relief medications'),
    ('Antihistamines', 'Allergy medications'),
    ('Antacids', 'Stomach acid relief'),
    ('Vitamins', 'Nutritional supplements'),
    ('Cold & Flu', 'Common cold and flu remedies')
ON CONFLICT (name) DO NOTHING;

-- Insert default system settings
INSERT INTO system_settings (key, value, description, data_type) VALUES
    ('system_name', 'Blessed Paul Pharmacy', 'Name of the pharmacy', 'string'),
    ('system_logo', '', 'Path to system logo', 'string'),
    ('currency_symbol', '$', 'Currency symbol for prices', 'string'),
    ('tax_rate', '10', 'Default tax rate percentage', 'number'),
    ('low_stock_threshold', '20', 'Days before low stock alert', 'number'),
    ('backup_frequency', 'daily', 'Backup frequency', 'string'),
    ('session_timeout', '3600', 'Session timeout in seconds', 'number')
ON CONFLICT (key) DO NOTHING;

-- ========================================
-- END OF SCHEMA
-- ========================================
