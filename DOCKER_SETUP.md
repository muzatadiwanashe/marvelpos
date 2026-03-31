# MarvelPOS Docker Setup Guide

## Overview
This Docker Compose configuration sets up a complete MarvelPOS development and production environment with all necessary services.

## Services Included

1. **MariaDB** (Database)
   - Container: marvelpos-mariadb
   - Port: 3306
   - User: marvelpos / Password: marvelpos123

2. **Redis** (Cache & Queue)
   - Container: marvelpos-redis
   - Port: 6379

3. **Frappe/ERPNext Worker**
   - Container: marvelpos-frappe
   - Image: frappe/frappe-worker:v15.latest

4. **Nginx Web Server**
   - Container: marvelpos-web
   - Ports: 80 (HTTP), 443 (HTTPS)

5. **Socket.io Server**
   - Container: marvelpos-socketio
   - Real-time communication

6. **Celery Workers**
   - Default Queue: marvelpos-worker-default
   - Long Queue: marvelpos-worker-long
   - Background tasks

7. **Celery Scheduler**
   - Container: marvelpos-scheduler
   - Scheduled tasks

## Prerequisites

- Docker Desktop (or Docker + Docker Compose)
- Minimum 4GB RAM
- 10GB free disk space
- Windows 10/11, macOS, or Linux

## Installation Steps

### 1. Install Docker

**Windows:**
- Download Docker Desktop from https://www.docker.com/products/docker-desktop
- Install and follow the setup wizard
- Restart your computer

**Mac:**
- Download Docker Desktop for Mac
- Install DMG file

**Linux:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

### 2. Verify Docker Installation

```bash
docker --version
docker-compose --version
```

### 3. Navigate to Project Directory

```powershell
cd C:\Users\Muza\source\repos\erpnext
```

### 4. Start Services

#### Option A: Start All Services
```bash
docker-compose up -d
```

#### Option B: Start with Logs
```bash
docker-compose up
```

### 5. Initialize the Site (First Time Only)

```bash
# Access Frappe container
docker-compose exec frappe bash

# Create new site
bench new-site marvelpos.local --db-type mysql --db-host mariadb --db-user marvelpos --db-password marvelpos123

# Install MarvelPOS app
bench --site marvelpos.local install-app erpnext

# Exit container
exit
```

### 6. Access MarvelPOS

- **URL:** http://localhost
- **Username:** Administrator
- **Password:** admin123 (or the password you set)

## Common Commands

### View Logs
```bash
docker-compose logs -f web
docker-compose logs -f mariadb
docker-compose logs -f redis
```

### Stop Services
```bash
docker-compose down
```

### Stop and Remove All Data
```bash
docker-compose down -v
```

### Restart Services
```bash
docker-compose restart
```

### Execute Commands in Container
```bash
# Run bench commands
docker-compose exec frappe bench --site marvelpos.local migrate

# Access bash shell
docker-compose exec frappe bash

# Access database
docker-compose exec mariadb mysql -u marvelpos -pmarvelpos123 -D marvelpos
```

### View Running Containers
```bash
docker-compose ps
```

### Check Container Health
```bash
docker-compose ps --format "table {{.Names}}\t{{.Status}}"
```

## Configuration

Edit `.env` file to customize:
- Database credentials
- Site name and title
- Admin user password
- Email settings
- Redis configuration

## Database Backup & Restore

### Backup Database
```bash
docker-compose exec mariadb mysqldump -u marvelpos -pmarvelpos123 marvelpos > backup.sql
```

### Restore Database
```bash
docker-compose exec -T mariadb mysql -u marvelpos -pmarvelpos123 marvelpos < backup.sql
```

## Performance Optimization

1. Increase Docker Resources (Windows/Mac)
   - Docker Desktop → Settings → Resources
   - CPU: 4+ cores
   - Memory: 4GB+

2. Database Optimization
   - Set innodb_buffer_pool_size in MariaDB config

3. Redis Optimization
   - Monitor Redis memory usage
   - Set appropriate maxmemory policy

## Troubleshooting

### Issue: "Address already in use"
```bash
# Check what's using the port
netstat -ano | findstr :80  # Windows
lsof -i :80                 # Mac/Linux

# Change port in docker-compose.yml
ports:
  - "8080:80"  # Use 8080 instead of 80
```

### Issue: "Permission denied"
```bash
# On Linux/Mac
sudo chmod 666 /var/run/docker.sock
```

### Issue: Database connection error
```bash
# Check if MariaDB is healthy
docker-compose ps mariadb

# Rebuild image
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Issue: Out of disk space
```bash
# Clean up unused images and volumes
docker image prune -a
docker volume prune
```

## Production Deployment

For production, consider:

1. Use managed database service (AWS RDS, Google Cloud SQL)
2. Enable SSL/TLS certificates
3. Set up proper backup strategy
4. Configure CI/CD pipeline
5. Use Docker Swarm or Kubernetes for orchestration
6. Set up monitoring and logging (Prometheus, ELK Stack)
7. Configure rate limiting and security headers

## Security Best Practices

1. Change default passwords in `.env`
2. Enable HTTPS/SSL
3. Use strong database passwords
4. Implement firewall rules
5. Regular security updates
6. Monitor logs for suspicious activity
7. Set up automated backups
8. Use environment variables for secrets

## Resource Limits

To prevent resource exhaustion, add to docker-compose.yml:

```yaml
services:
  frappe:
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 2G
        reservations:
          cpus: '0.5'
          memory: 512M
```

## Monitoring

### CPU and Memory Usage
```bash
docker stats
```

### Container Logs
```bash
docker-compose logs --tail 100 web
```

### Database Status
```bash
docker-compose exec mariadb mysql -u marvelpos -pmarvelpos123 -e "SHOW STATUS;"
```

## Further Customization

For advanced customization, see:
- `docker-compose.yml` - Service configuration
- `.env` - Environment variables
- `.dockerignore` - Files to exclude from context
- Official Frappe Docker documentation

## Support & Documentation

- Frappe Docker: https://github.com/frappe/frappe_docker
- ERPNext Docs: https://docs.erpnext.com
- Docker Docs: https://docs.docker.com

---

**Last Updated:** March 30, 2024
**Status:** Ready for Development & Production
