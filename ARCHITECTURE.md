# Blessed Paul Pharmacy Management System - Architecture

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Client Layer (Electron)                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │Dashboard │  │Inventory │  │   POS    │  │Reports   │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                      │                                       │
│                      ▼                                       │
│  ┌────────────────────────────────────────────────────┐    │
│  │           React Application Layer                  │    │
│  │  - State Management (Redux Toolkit)                │    │
│  │  - Component Library (Reusable Components)         │    │
│  │  - Local Storage / SQLite Access                   │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                 ┌──────────▼──────────┐
                 │  IPC Bridge Layer   │
                 │  (Electron IPC)     │
                 └──────────┬──────────┘
                            │
┌─────────────────────────────────────────────────────────────┐
│                  Backend API Layer (FastAPI)                │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              API Routes & Endpoints                   │  │
│  │  - Authentication          - Inventory               │  │
│  │  - Sales & Billing         - Prescriptions          │  │
│  │  - Reports & Analytics     - Suppliers              │  │
│  │  - Customers               - Drug Database          │  │
│  │  - Audit Logs              - System Settings        │  │
│  └───────────────────────────────────────────────────────┘  │
│                            │                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │         Business Logic Layer (Services)              │  │
│  │  - Authentication Service      - Inventory Service   │  │
│  │  - Sales Service               - Report Service      │  │
│  │  - Prescription Service        - Drug Service        │  │
│  │  - Audit Service               - Backup Service      │  │
│  └───────────────────────────────────────────────────────┘  │
│                            │                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │      Data Access Layer (SQLAlchemy ORM)              │  │
│  │  - Model Definitions       - Query Builders          │  │
│  │  - Relationships           - Transactions            │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
┌─────────────────────────────────────────────────────────────┐
│                  Data Layer                                  │
│  ┌──────────────────┐         ┌──────────────────┐          │
│  │  SQLite (Local)  │         │ PostgreSQL (Prod)│          │
│  │  - Fast          │         │ - Scalable       │          │
│  │  - Lightweight   │         │ - Multi-user     │          │
│  │  - Offline Ready │         │ - Cloud Ready    │          │
│  └──────────────────┘         └──────────────────┘          │
│                                                              │
│  ┌──────────────────┐         ┌──────────────────┐          │
│  │  Local Storage   │         │ Cloud Storage    │          │
│  │  - Cache         │         │ - Backups        │          │
│  │  - Temp Files    │         │ - Sync           │          │
│  └──────────────────┘         └──────────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## Module Architecture

### 1. **Authentication & Authorization Module**
```
Users Table
├── Roles (Admin, Pharmacist, Cashier)
├── Permissions (CRUD operations)
├── Sessions (Active sessions)
└── Audit Logs (All actions)
```

**Key Features:**
- JWT token-based authentication
- Role-based access control (RBAC)
- Password hashing (bcrypt)
- Session management
- Login/logout tracking

### 2. **Dashboard & Analytics Module**
```
Dashboard Widgets
├── KPI Cards (Sales, Revenue, Inventory)
├── Charts (Revenue trends, Top products)
├── Alerts (Low stock, Expired items)
├── Recent Transactions
└── Quick Stats
```

**Data Sources:**
- Sales transactions
- Inventory levels
- Customer data
- Financial records

### 3. **Inventory Management Module**
```
Drug Catalog
├── Drug Information
│   ├── Generic name, Brand names
│   ├── Classification
│   ├── Manufacturer, Supplier
│   └── Drug interactions/Contraindications
├── Stock Management
│   ├── Batches (Batch #, Expiry, MFG date)
│   ├── Quantity tracking
│   ├── Reorder levels
│   └── Stock movements
├── Alerts
│   ├── Low stock
│   ├── Out of stock
│   ├── Expired items
│   └── Near expiry (30 days)
└── Operations
    ├── Add/Edit/Delete drugs
    ├── Stock adjustments
    ├── Transfers between locations
    └── Purchase orders
```

### 4. **Point of Sale (POS) Module**
```
Sales Transaction
├── Cart Management
│   ├── Add/Remove items
│   ├── Quantity adjustment
│   └── Real-time total calculation
├── Payment Processing
│   ├── Cash
│   ├── Card (POS terminal)
│   ├── Bank transfer
│   ├── Credit
│   └── Mobile payment
├── Checkout
│   ├── Discounts
│   ├── Taxes calculation
│   ├── Receipt generation
│   └── Refunds/Returns
└── Barcode/QR Scanning
    ├── USB barcode scanner support
    ├── Webcam QR code scanning
    └── Auto product lookup
```

### 5. **Prescription Management Module**
```
Prescription
├── Patient Information
│   ├── Name, ID, Contact
│   └── Medical history
├── Prescription Details
│   ├── Doctor name, Diagnosis
│   ├── Drug, Dosage, Frequency
│   ├── Duration, Instructions
│   └── Validation checks
├── Operations
│   ├── Create, Save, Search
│   ├── View history
│   ├── Print prescription
│   └── Dispense tracking
└── Drug Interactions Check
    ├── Contraindications
    ├── Side effects
    └── Warnings
```

### 6. **Drug Database Module**
```
Drug Information
├── Basic Info
│   ├── Names (Generic, Brand)
│   ├── Classification
│   └── Manufacturer
├── Clinical Information
│   ├── Indications (Uses)
│   ├── Contraindications
│   ├── Side effects
│   ├── Warnings, Precautions
│   └── Dosage information
├── Interactions
│   ├── Drug-drug interactions
│   ├── Drug-food interactions
│   └── Drug-disease interactions
├── Special Cases
│   ├── Pregnancy category
│   ├── Breastfeeding
│   └── Pediatric dosage
└── Search & Filter
    ├── By drug name
    ├── By generic name
    ├── By disease
    └── By drug class
```

### 7. **Reporting & Analytics Module**
```
Report Types
├── Sales Reports
│   ├── Daily, Weekly, Monthly, Annual
│   ├── By product, Category, Salesperson
│   └── Revenue, Profit analysis
├── Inventory Reports
│   ├── Inventory valuation
│   ├── Stock movement
│   ├── Expired/Near expiry items
│   └── Low stock alerts
├── Financial Reports
│   ├── Profit & Loss
│   ├── Accounts Payable
│   ├── Accounts Receivable
│   └── Cash flow
└── Export Formats
    ├── PDF (Print-friendly)
    ├── Excel (Data analysis)
    └── CSV (Integration)
```

### 8. **Supplier Management Module**
```
Supplier Profile
├── Contact Information
│   ├── Name, Contact person
│   ├── Phone, Email
│   └── Address
├── Tracking
│   ├── Purchase orders
│   ├── Delivery history
│   ├── Outstanding payments
│   └── Payment terms
└── Performance
    ├── On-time delivery rate
    ├── Quality rating
    └── Price comparison
```

### 9. **Customer Management Module**
```
Customer Profile
├── Basic Information
│   ├── Name, Phone, Address
│   └── Email
├── Transaction History
│   ├── Purchase records
│   ├── Total spent
│   └── Loyalty points
├── Outstanding Balances
│   ├── Credit transactions
│   ├── Payment tracking
│   └── Reminders
└── Preferences
    ├── Preferred items
    ├── Allergies/Warnings
    └── Communication preferences
```

### 10. **Audit & Security Module**
```
Audit Trail
├── User Actions
│   ├── Login/Logout
│   ├── Data modifications
│   └── Access attempts
├── System Events
│   ├── Backups
│   ├── Updates
│   └── Errors
├── Changes Tracking
│   ├── Who (User)
│   ├── What (Action)
│   ├── When (Timestamp)
│   └── Where (Module)
└── Security Logs
    ├── Failed authentications
    ├── Permission violations
    └── Data access
```

## Data Flow

### Example: Sales Transaction Flow

```
1. Cashier scans product barcode
   ↓
2. System looks up product in inventory
   ↓
3. Product added to cart with quantity
   ↓
4. System calculates subtotal + tax
   ↓
5. Cashier selects payment method
   ↓
6. Payment processed
   ↓
7. Transaction saved to database
   ↓
8. Inventory updated (quantity reduced)
   ↓
9. Receipt generated & printed
   ↓
10. Audit log recorded
   ↓
11. Customer receives receipt
```

### Example: Inventory Alert Flow

```
1. System monitors stock levels (scheduled check)
   ↓
2. Detects low stock item (below reorder level)
   ↓
3. Creates alert notification
   ↓
4. Alert displayed on dashboard
   ↓
5. Manager notified (if configured)
   ↓
6. Purchase order can be auto-generated
   ↓
7. Audit log recorded
```

## Design Patterns Used

### 1. **MVC Pattern**
- **Model**: SQLAlchemy ORM models
- **View**: React components
- **Controller**: FastAPI route handlers

### 2. **Service Layer Pattern**
- Business logic separated from routes
- Reusable services
- Easy testing

### 3. **Repository Pattern**
- Data access abstraction
- Database operations centralized
- Easy to switch database engines

### 4. **Dependency Injection**
- FastAPI dependencies
- Loose coupling
- Easy mocking for tests

### 5. **Observer Pattern**
- Event listeners for alerts
- Real-time notifications
- Extensible architecture

## Security Architecture

```
┌─────────────────────────────────────────┐
│         Request Coming In               │
└──────────────────┬──────────────────────┘
                   │
        ┌──────────▼──────────┐
        │  1. Authentication  │
        │  (JWT Token Check)  │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  2. Authorization   │
        │  (Role/Permission)  │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  3. Validation      │
        │  (Input Sanitize)   │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  4. Business Logic  │
        │  (Services)         │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  5. Audit Logging   │
        │  (Record Action)    │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │  6. Response        │
        │  (Encrypted if SSL) │
        └─────────────────────┘
```

## Scalability Considerations

1. **Horizontal Scaling**
   - Multiple backend instances behind load balancer
   - Stateless API design
   - Shared database

2. **Vertical Scaling**
   - Database indexing
   - Query optimization
   - Caching strategies

3. **Database Optimization**
   - Connection pooling
   - Query caching
   - Partitioning for large tables

4. **Frontend Optimization**
   - Code splitting
   - Lazy loading
   - Image optimization
   - Service workers for offline

## Backup & Disaster Recovery

```
Automated Backup Schedule
├── Hourly backups (keep 24 hours)
├── Daily backups (keep 30 days)
├── Weekly backups (keep 12 weeks)
└── Monthly backups (keep 12 months)

Backup Locations
├── Local storage (quick restore)
├── Network storage (redundancy)
└── Cloud storage (disaster recovery)

Restore Procedures
├── Point-in-time recovery
├── Full database restore
├── Incremental restore
└── Verification process
```

## Future Architecture Enhancements

1. **Multi-branch Support**
   - Master-slave replication
   - Branch inventory sync
   - Centralized reporting

2. **Mobile Integration**
   - REST API for mobile apps
   - Real-time sync
   - Offline capability

3. **AI/ML Features**
   - Demand forecasting
   - Drug recommendation
   - Anomaly detection

4. **Integration Points**
   - Insurance systems
   - Accounting software
   - Hospital management systems

---

**Last Updated**: June 2026
