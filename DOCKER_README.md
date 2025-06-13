# QR Payment Application Docker Setup

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- PowerShell (Windows) or bash (Linux/Mac)

### Running the Application

1. **Start the application:**
   ```powershell
   docker-compose up -d
   ```

2. **View logs:**
   ```powershell
   docker-compose logs -f
   ```

3. **Stop the application:**
   ```powershell
   docker-compose down
   ```

4. **Rebuild and restart:**
   ```powershell
   docker-compose down
   docker-compose build --no-cache
   docker-compose up -d
   ```

### Access the Application
- Open your browser and go to: http://localhost:3000

### Features
- ✅ Optimized image loading
- ✅ QR code cache prevention (using timestamp parameters)
- ✅ Docker containerization with Nginx
- ✅ Gzip compression enabled
- ✅ Security headers configured
- ✅ Health checks implemented

### Docker Compose Services
- **qr-payment-app**: Main web application served by Nginx
  - Port: 3000 (external) → 80 (internal)
  - Health check: Checks if the app is responding
  - Auto-restart: unless stopped manually

### Development
To modify the application:
1. Edit the HTML/CSS/JS files
2. Rebuild the container: `docker-compose build`
3. Restart: `docker-compose up -d`

### Troubleshooting
- Check container status: `docker-compose ps`
- View logs: `docker-compose logs qr-payment-app`
- Access container: `docker-compose exec qr-payment-app sh`
