# AAACoder Services Dashboard

A modern, responsive landing page for AAACoder's online utility services. This project features a beautiful "Coming Soon" design with animated elements and is fully containerized for easy deployment.

## 🚀 Features

- **Modern Design**: Clean, professional landing page with gradient backgrounds and glassmorphism effects
- **Responsive**: Fully responsive design that works on all devices
- **Animated Elements**: Subtle animations and floating shapes for visual appeal
- **Utility Services**: Showcases 6 core online utility tools
- **Analytics Integration**: Built-in Plausible Analytics and conversion tracking
- **Dockerized**: Easy deployment with Docker containerization
- **CI/CD Ready**: GitHub Actions workflow for automated builds and deployments

## 🛠️ Tech Stack

- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Web Server**: Nginx (Alpine Linux)
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Analytics**: Plausible Analytics
- **Conversion Tracking**: AClib
- **Styling**: External CSS file for better organization

## 📋 Prerequisites

- Docker
- Git
- GitHub account (for CI/CD)

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd services-dashboard
   ```

2. **Build and run with Docker**
   ```bash
   # Build the Docker image
   docker build -t aaacoder-dashboard .
   
   # Run the container
   docker run -p 8080:80 aaacoder-dashboard
   ```

3. **Access the application**
   Open your browser and navigate to `http://localhost:8080`

### Alternative: Run without Docker

If you prefer to run the application directly:

1. **Serve with a local web server**
   ```bash
   # Using Python 3
   python3 -m http.server 8080
   
   # Using Node.js (if you have npx)
   npx serve -s . -l 8080
   
   # Using PHP
   php -S localhost:8080
   ```

2. **Access the application**
   Open your browser and navigate to `http://localhost:8080`

## 🐳 Docker Deployment

### Build Image
```bash
docker build -t aaacoder-dashboard .
```

### Run Container
```bash
docker run -d -p 80:80 --name aaacoder-dashboard aaacoder-dashboard
```

### Docker Compose (Optional)
Create a `docker-compose.yml` file:
```yaml
version: '3.8'
services:
  dashboard:
    build: .
    ports:
      - "80:80"
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "wget -qO- http://localhost/health || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3
```

Then run:
```bash
docker-compose up -d
```

## 🔄 CI/CD with GitHub Actions

The project includes a GitHub Actions workflow that automatically:

1. **Builds** the Docker image on every push to main/master branch
2. **Pushes** the image to GitHub Container Registry
3. **Tags** the image with branch name, commit SHA, and semantic version tags
4. **Caches** build layers for faster subsequent builds

### Workflow Triggers
- Push to `main` or `master` branch
- Push with version tags (e.g., `v1.0.0`)
- Pull requests to `main` or `master` branch

### Image Tags
The workflow automatically creates the following tags:
- `latest` (for main/master branch)
- `{branch-name}` (e.g., `main`, `feature-branch`)
- `{branch-name}-{commit-sha}` (e.g., `main-a1b2c3d`)
- `{version}` (for semantic version tags)
- `{major}.{minor}` (for semantic version tags)

## 📊 Analytics & Tracking

The dashboard includes the following tracking scripts:

### Plausible Analytics
- **Domain**: `dash.aaacoder.xyz`
- **Script**: `https://plausible.aaacoder.xyz/js/script.js`
- **Privacy-focused** analytics without cookies

### Conversion Tracking
- **Provider**: AClib
- **Zone ID**: `g39t819m8o`
- **Script**: `//acscdn.com/script/aclib.js`

## 🏗️ Project Structure

```
services-dashboard/
├── index.html              # Main HTML file
├── styles.css              # External CSS styles
├── nginx.conf              # Nginx configuration
├── Dockerfile              # Docker configuration
├── .github/
│   └── workflows/
│       └── docker-build.yml # GitHub Actions workflow
├── .gitignore              # Git ignore rules
├── .dockerignore           # Docker ignore rules
├── .cursorignore           # Cursor IDE ignore rules
├── README.md               # Project documentation
└── LICENSE                 # Project license
```

## 🔧 Configuration

### Nginx Configuration
The `nginx.conf` file includes:
- **Gzip compression** for better performance
- **Security headers** for enhanced security
- **Caching rules** for static assets
- **Health check endpoint** at `/health`

### Customization
To customize the dashboard:

1. **Update content**: Modify `index.html`
2. **Change styling**: Update `styles.css` for all visual modifications
3. **Add scripts**: Include additional scripts before the closing `</body>` tag
4. **Modify nginx config**: Update `nginx.conf` for server-specific settings

## 🚀 Deployment with Dokploy

This project is designed to work seamlessly with Dokploy:

1. **Push to GitHub**: The repository includes the necessary Docker configuration
2. **Automatic Build**: GitHub Actions builds and pushes the Docker image
3. **Deploy with Dokploy**: Use the generated Docker image in your Dokploy configuration

### Dokploy Configuration Example
```yaml
services:
  dashboard:
    image: ghcr.io/your-username/services-dashboard:latest
    ports:
      - "80:80"
    healthcheck:
      path: /health
      interval: 30s
      timeout: 10s
      retries: 3
```

## 🔍 Health Check

The application includes a health check endpoint:
- **URL**: `/health`
- **Response**: `healthy` with 200 status code
- **Use case**: Load balancer health checks, container orchestration

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Contact

- **Email**: contact@aaacoder.xyz
- **Website**: [dash.aaacoder.xyz](https://dash.aaacoder.xyz)

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page for existing problems
2. Create a new issue with detailed information
3. Contact us at contact@aaacoder.xyz

---

**Built with ❤️ by AAACoder** 