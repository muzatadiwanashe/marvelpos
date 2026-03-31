#!/bin/bash
# MarvelPOS Docker Initialization Script

set -e

echo "════════════════════════════════════════════════════════════════"
echo "   MarvelPOS Docker Initialization"
echo "════════════════════════════════════════════════════════════════"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Check Docker
echo -e "\n${BLUE}[1/5] Checking Docker installation...${NC}"
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker Desktop."
    exit 1
fi
echo -e "${GREEN}✓ Docker is installed${NC}"

# Step 2: Check Docker Compose
echo -e "\n${BLUE}[2/5] Checking Docker Compose...${NC}"
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed."
    exit 1
fi
echo -e "${GREEN}✓ Docker Compose is installed${NC}"

# Step 3: Start services
echo -e "\n${BLUE}[3/5] Starting MarvelPOS services...${NC}"
docker-compose up -d
echo -e "${GREEN}✓ Services started${NC}"

# Step 4: Wait for database
echo -e "\n${BLUE}[4/5] Waiting for database to be ready...${NC}"
for i in {1..30}; do
    if docker-compose exec -T mariadb mysqladmin ping -h localhost &> /dev/null; then
        echo -e "${GREEN}✓ Database is ready${NC}"
        break
    fi
    echo "Waiting for database... ($i/30)"
    sleep 2
done

# Step 5: Create site (optional - commented out for manual execution)
echo -e "\n${BLUE}[5/5] Setup completed!${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. Wait 30 seconds for all services to start"
echo "2. Create a site:"
echo "   docker-compose exec frappe bash"
echo "   bench new-site marvelpos.local --db-type mysql --db-host mariadb --db-user marvelpos --db-password marvelpos123"
echo "3. Install MarvelPOS:"
echo "   bench --site marvelpos.local install-app erpnext"
echo "4. Access at: http://localhost"
echo ""
echo -e "${GREEN}MarvelPOS is starting! This may take a few minutes...${NC}"
