# QR Payment Application Management Script
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start", "stop", "restart", "build", "logs", "status")]
    [string]$Action
)

function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    } else {
        $input | Write-Output
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-ColorOutput Green "=== QR Payment Application Manager ==="
Write-Host ""

switch ($Action.ToLower()) {
    "start" {
        Write-ColorOutput Yellow "Starting QR Payment Application..."
        docker-compose up -d
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput Green "✅ Application started successfully!"
            Write-ColorOutput Cyan "🌐 Access the app at: http://localhost:3000"
        } else {
            Write-ColorOutput Red "❌ Failed to start application"
        }
    }
    
    "stop" {
        Write-ColorOutput Yellow "Stopping QR Payment Application..."
        docker-compose down
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput Green "✅ Application stopped successfully!"
        } else {
            Write-ColorOutput Red "❌ Failed to stop application"
        }
    }
    
    "restart" {
        Write-ColorOutput Yellow "Restarting QR Payment Application..."
        docker-compose down
        docker-compose up -d
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput Green "✅ Application restarted successfully!"
            Write-ColorOutput Cyan "🌐 Access the app at: http://localhost:3000"
        } else {
            Write-ColorOutput Red "❌ Failed to restart application"
        }
    }
    
    "build" {
        Write-ColorOutput Yellow "Building QR Payment Application..."
        docker-compose down
        docker-compose build --no-cache
        docker-compose up -d
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput Green "✅ Application built and started successfully!"
            Write-ColorOutput Cyan "🌐 Access the app at: http://localhost:3000"
        } else {
            Write-ColorOutput Red "❌ Failed to build application"
        }
    }
    
    "logs" {
        Write-ColorOutput Yellow "Showing application logs (Press Ctrl+C to exit)..."
        docker-compose logs -f
    }
    
    "status" {
        Write-ColorOutput Yellow "Checking application status..."
        docker-compose ps
        Write-Host ""
        $container = docker-compose ps -q qr-payment-app
        if ($container) {
            $health = docker inspect --format='{{.State.Health.Status}}' $container 2>$null
            if ($health -eq "healthy") {
                Write-ColorOutput Green "✅ Application is healthy"
            } elseif ($health -eq "unhealthy") {
                Write-ColorOutput Red "❌ Application is unhealthy"
            } else {
                Write-ColorOutput Yellow "⏳ Health check in progress or not configured"
            }
        } else {
            Write-ColorOutput Red "❌ Application container not found"
        }
    }
}

Write-Host ""
Write-ColorOutput Gray "Available actions: start, stop, restart, build, logs, status"
Write-ColorOutput Gray "Usage: .\manage.ps1 -Action <action>"
