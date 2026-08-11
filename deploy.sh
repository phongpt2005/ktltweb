#!/bin/bash
echo "==============================================="
echo "   KTLTWEB AUTOMATED VPS DEPLOYMENT SCRIPT     "
echo "==============================================="

# 1. Update latest code from Git
echo "[1/3] Pulling latest code from repository..."
git pull origin master || git pull origin main

# 2. Start services with Docker Compose
echo "[2/3] Starting Docker containers (Frontend, Backend, MySQL)..."
docker-compose up -d

# 3. Wait for MySQL to be ready and import seed data
echo "[3/3] Waiting for MySQL database to initialize..."
sleep 15

echo "Importing seed products into MySQL..."
docker exec -i ktltweb-db-1 mysql -u root -padmin123 apps -e "SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE product; SET FOREIGN_KEY_CHECKS=1;" 2>/dev/null
docker exec -i ktltweb-db-1 mysql -u root -padmin123 apps --default-character-set=utf8mb4 < seed/product.sql

echo "==============================================="
echo "   DEPLOYMENT COMPLETED SUCCESSFULLY!          "
echo "   Frontend Web: http://$(hostname -I | awk '{print $1}'):8880"
echo "==============================================="
