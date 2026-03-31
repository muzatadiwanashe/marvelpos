# MarvelPOS - Modern Point of Sale System

[![GitHub](https://img.shields.io/badge/GitHub-muzatadiwanashe/marvelpos-blue?logo=github)](https://github.com/muzatadiwanashe/marvelpos)
[![License](https://img.shields.io/badge/License-GNU%20General%20Public%20License%20(v3)-red)](#license)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue?logo=docker)](./docker-compose.yml)

A modern, customized Point of Sale system built on ERPNext with Frappe Framework. Featuring a contemporary cornflower blue theme, responsive design, and optimized dashboard for retail operations.

## 🌟 Features

### Core Features
- ✅ Modern Point of Sale Interface
- ✅ Real-time Sales Tracking
- ✅ Inventory Management
- ✅ Customer Management
- ✅ Multi-user Support
- ✅ Secure Transactions
- ✅ Responsive Design

### Customizations
- 🎨 **Modern Theme**: Cornflower blue color scheme (#6495ED)
- 📱 **Responsive Welcome Page**: Beautiful landing page with feature highlights
- 📊 **Custom Dashboard**: POS-focused workspace with quick shortcuts
- ⚡ **Optimized Widgets**: Real-time sales, customer, and order metrics
- 🎯 **Shopping Cart Icon**: Professional branding throughout

## 🚀 Quick Start

### Prerequisites
- Docker Desktop 4.0+
- 4GB RAM minimum
- 10GB free disk space

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/muzatadiwanashe/marvelpos.git
cd marvelpos
```

**2. Start services with Docker**
```bash
docker-compose up -d
```

**3. Wait for database to be ready (30-60 seconds)**
```bash
docker-compose logs -f mariadb
```

**4. Initialize the site**
```bash
docker-compose exec frappe bash

# Inside container:
bench new-site marvelpos.local --db-type mysql --db-host mariadb --db-user marvelpos --db-password marvelpos123
bench --site marvelpos.local install-app erpnext
exit
```

**5. Access MarvelPOS**
```
URL: http://localhost
Username: Administrator
Password: (set during setup)
```

## 📁 Project Structure

```
marvelpos/
├── docker-compose.yml              # Docker services configuration
├── .env                            # Environment variables
├── .dockerignore                   # Docker context exclusions
├── docker-init.sh                  # Docker initialization script
│
├── erpnext/
│   ├── hooks.py                    # App configuration (customized)
│   ├── www/
│   │   └── marvelpos_welcome.html # Custom welcome page
│   ├── setup/workspace/home/
│   │   └── home.json              # Dashboard configuration
│   └── ...                         # ERPNext application files
│
├── DOCKER_SETUP.md                # Docker setup guide
├── MarvelPOS_CUSTOMIZATION_GUIDE.md # Customization documentation
└── README.md                       # This file
```

## 🐳 Docker Services

The `docker-compose.yml` includes:

| Service | Container | Port | Purpose |
|---------|-----------|------|---------|
| MariaDB | marvelpos-mariadb | 3306 | Database |
| Redis | marvelpos-redis | 6379 | Cache & Queue |
| Frappe | marvelpos-frappe | - | Application |
| Nginx | marvelpos-web | 80, 443 | Web Server |
| Socket.io | marvelpos-socketio | 9000 | Real-time |
| Workers | marvelpos-worker-* | - | Background Tasks |
| Scheduler | marvelpos-scheduler | - | Scheduled Tasks |

## 🎨 Customizations

### Color Scheme
- **Primary Color**: Cornflower Blue (#6495ED)
- **Icon**: Shopping Cart (fa-shopping-cart)
- **Description**: "Modern Point of Sale System"

### Welcome Page
- File: `erpnext/www/marvelpos_welcome.html`
- Features: Gradient background, feature cards, call-to-action buttons
- Fully responsive design

### Dashboard
- File: `erpnext/setup/workspace/home/home.json`
- Sections: POS Dashboard, Inventory, Accounting & Finance
- Widgets: Total Sales, Customers, Pending Orders
- Shortcuts: Quick access to common actions

## 📚 Documentation

- [DOCKER_SETUP.md](./DOCKER_SETUP.md) - Comprehensive Docker setup guide
- [MarvelPOS_CUSTOMIZATION_GUIDE.md](./MarvelPOS_CUSTOMIZATION_GUIDE.md) - Customization details
- [ERPNext Docs](https://docs.erpnext.com) - Official ERPNext documentation

## 🔧 Configuration

Edit `.env` to customize:
```env
DB_ROOT_PASSWORD=root
DB_NAME=marvelpos
DB_USER=marvelpos
DB_PASSWORD=marvelpos123
ADMIN_PASSWORD=admin123
SITE_NAME=marvelpos.local
```

## 📋 Common Commands

### Docker Operations
```bash
# Start all services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Execute commands
docker-compose exec frappe bash

# Check status
docker-compose ps

# Clean up
docker-compose down -v
```

### Frappe/Bench Commands
```bash
# Create site
bench new-site marvelpos.local

# Install app
bench --site marvelpos.local install-app erpnext

# Migrate database
bench --site marvelpos.local migrate

# Console
bench --site marvelpos.local console

# Backup
bench --site marvelpos.local backup
```

## 💾 Backup & Restore

### Backup Database
```bash
docker-compose exec mariadb mysqldump -u marvelpos -pmarvelpos123 marvelpos > backup.sql
```

### Restore Database
```bash
docker-compose exec -T mariadb mysql -u marvelpos -pmarvelpos123 marvelpos < backup.sql
```

## 🐛 Troubleshooting

### Port Already in Use
Change ports in `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Use 8080 instead of 80
```

### Database Connection Error
```bash
docker-compose logs mariadb
docker-compose restart mariadb
```

### Out of Disk Space
```bash
docker image prune -a
docker volume prune
```

For more troubleshooting, see [DOCKER_SETUP.md](./DOCKER_SETUP.md)

## 🔐 Security

- Change default passwords in `.env`
- Enable SSL/HTTPS for production
- Use strong database credentials
- Regular backups
- Monitor logs for suspicious activity

## 📈 Performance

### Recommended Resources
- **CPU**: 4+ cores
- **RAM**: 8GB minimum
- **Disk**: 20GB SSD recommended

### Optimization Tips
1. Increase Docker resources (Docker Desktop Settings)
2. Use SSD for database storage
3. Monitor Redis memory usage
4. Configure proper MySQL buffer pool

## 🚢 Deployment

### Local Development
```bash
docker-compose up -d
# Access at http://localhost
```

### Production Deployment
Consider:
- Use managed database service (AWS RDS)
- Configure reverse proxy (Nginx)
- Enable SSL/TLS certificates
- Set up automated backups
- Use container orchestration (Kubernetes)

## 📝 License

This project is licensed under the GNU General Public License (v3). See LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## 📞 Support

For issues and support:
- GitHub Issues: https://github.com/muzatadiwanashe/marvelpos/issues
- ERPNext Community: https://discuss.erpnext.com
- Documentation: See [DOCKER_SETUP.md](./DOCKER_SETUP.md)

## 🙏 Acknowledgments

- Built on [ERPNext](https://erpnext.com) - Open Source ERP System
- Powered by [Frappe Framework](https://frappeframework.com)
- Docker configuration based on [frappe/frappe_docker](https://github.com/frappe/frappe_docker)

## 📊 Project Stats

- **Customizations**: 5 files modified/created
- **Docker Services**: 7 services
- **Features**: Modern POS system
- **Theme**: Cornflower Blue
- **Status**: ✅ Production Ready

---

**Last Updated**: March 30, 2024  
**Version**: 1.0  
**Author**: Muza Tadiwanashe

For more information, visit: https://github.com/muzatadiwanashe/marvelpos
