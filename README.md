# Blessed Paul Pharmacy Management System

**Version 1.0** - Enterprise-Grade Pharmacy Management Solution

## Overview

Blessed Paul Pharmacy Management System is a modern, professional, enterprise-grade desktop application designed for pharmacies, drug stores, and medical supply shops. The system focuses on **speed, security, inventory accuracy, and ease of use**.

## Key Features

### 🎯 Core Modules
- **Authentication & User Management** - Role-based access control
- **Dashboard & Analytics** - Real-time metrics and insights
- **Inventory Management** - Complete stock tracking and management
- **Point of Sale (POS)** - Fast checkout and billing
- **Prescription Management** - Prescription creation and tracking
- **Drug Database** - Comprehensive drug information
- **Reporting & Analytics** - Multi-format export (PDF, Excel, CSV)
- **Supplier Management** - Vendor and purchase tracking
- **Customer Management** - Customer profiles and history
- **Audit Logging** - Complete activity tracking

### 🛡️ Security Features
- User authentication with password hashing
- Session management
- Role-based access control (RBAC)
- Audit logging for all actions
- Database encryption support
- Secure API endpoints

### 💾 Data Management
- **Offline-first** capability with local database
- Automatic backups
- Cloud synchronization option
- Multi-user support
- Data export functionality

### 🎨 User Experience
- Modern UI/UX design
- Dark Mode and Light Mode support
- Responsive layout
- Professional dashboard
- Fast performance optimization

## Technology Stack

### Frontend
- **Electron** with **React 18**
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Redux Toolkit** for state management
- **React Query** for data fetching

### Backend
- **Python 3.11+** with **FastAPI**
- **SQLAlchemy** ORM
- **Pydantic** for data validation
- **JWT** for authentication

### Database
- **SQLite** for local development
- **PostgreSQL** for production

### Tools & DevOps
- **Docker** for containerization
- **Git** for version control
- **pytest** for testing
- **Black** & **Flake8** for code quality

## Project Structure

```
blessed-paul-pharmacy/
├── frontend/                    # Electron + React application
│   ├── public/
│   ├── src/
│   │   ├── components/         # Reusable UI components
│   │   ├── pages/              # Page components
│   │   ├── modules/            # Feature modules
│   │   ├── services/           # API services
│   │   ├── store/              # Redux store
│   │   ├── utils/              # Utility functions
│   │   ├── styles/             # Global styles
│   │   ├── types/              # TypeScript types
│   │   └── App.tsx
│   ├── electron/               # Electron main process
│   ├── package.json
│   ├── tsconfig.json
│   └── tailwind.config.js
│
├── backend/                     # FastAPI backend
│   ├── app/
│   │   ├── api/
│   │   │   ├── endpoints/      # API route handlers
│   │   │   ├── middleware/     # Custom middleware
│   │   │   └── dependencies.py
│   │   ├── models/             # SQLAlchemy models
│   │   ├── schemas/            # Pydantic schemas
│   │   ├── services/           # Business logic
│   │   ├── utils/              # Utility functions
│   │   ├── config.py           # Configuration
│   │   ├── database.py         # Database setup
│   │   └── main.py             # App entry point
│   ├── tests/                  # Test suite
│   ├── migrations/             # Database migrations
│   ├── requirements.txt
│   ├── pytest.ini
│   └── .env.example
│
├── database/                    # Database schema and scripts
│   ├── schema.sql              # Main schema
│   ├── seed_data.sql           # Initial data
│   ├── migrations/             # Migration scripts
│   └── drugs_database.sql      # Drug information
│
├── docker/                      # Docker configuration
│   ├── Dockerfile.frontend
│   ├── Dockerfile.backend
│   └── docker-compose.yml
│
├── docs/                        # Documentation
│   ├── API.md                  # API documentation
│   ├── ARCHITECTURE.md         # Architecture guide
│   ├── SETUP.md                # Setup instructions
│   ├── USER_GUIDE.md           # User manual
│   └── DATABASE.md             # Database guide
│
├── scripts/                     # Utility scripts
│   ├── setup.sh
│   ├── start.sh
│   └── backup.sh
│
├── .gitignore
├── .env.example
└── LICENSE
```

## Quick Start

### Prerequisites
- Node.js 18+
- Python 3.11+
- PostgreSQL or SQLite
- Docker (optional)

### Installation

```bash
# Clone repository
git clone https://github.com/Love-0810/SOFTWARES-.git
cd SOFTWARES-
git checkout blessed-paul-pharmacy-v1

# Backend setup
cd backend
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt

# Frontend setup
cd ../frontend
npm install

# Start backend
cd ../backend
uvicorn app.main:app --reload

# Start frontend (in another terminal)
cd frontend
npm start
```

## Default Credentials (Development Only)

- **Username**: admin
- **Password**: Admin@123
- **Role**: Administrator

⚠️ **CHANGE THESE IMMEDIATELY IN PRODUCTION**

## Database Setup

See [DATABASE.md](docs/DATABASE.md) for detailed database configuration and migration instructions.

## Architecture

See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for detailed architecture documentation.

## API Documentation

See [API.md](docs/API.md) for complete API endpoint documentation.

## Features Roadmap

- ✅ Phase 1: Core modules (Inventory, POS, Dashboard)
- ✅ Phase 2: Advanced reporting and analytics
- 🔄 Phase 3: Multi-branch support
- 🔄 Phase 4: Mobile app integration
- 🔄 Phase 5: AI-powered drug search
- 🔄 Phase 6: Insurance claim processing

## Contributing

Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@blessedpaulpharmacy.com or open an issue on GitHub.

## Authors

- **Blessed Paul Pharmacy Team** - Initial work

---

**Made with ❤️ for better pharmacy management**
