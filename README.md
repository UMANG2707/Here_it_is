# SimpleTimeService

## Overview

- SimpleTimeService is a minimalist microservice that returns the current timestamp and the IP address of the visitor in JSON format. The service is built using Python and Flask, containerized using Docker, and automated with GitHub Actions for continuous integration and deployment.

## Features

- Responds with a JSON object containing the current timestamp and the IP address of the requester.
- Runs inside a Docker container as a non-root user.
- Automated Docker image builds and deployments using GitHub Actions.
- Image is pushed to DockerHub with branch-based tagging.
- Runs on port 5000.
- Response Format
- When accessed via http://localhost:5000/, the application returns a response in the following format:
  ```
  {
    "timestamp": "<current date and time>",
    "ip": "<the IP address of the visitor>"
  }
  ```
  
## Repository Structure

```
├── app
│   ├── app.py                 # Flask application
│   ├── Dockerfile             # Docker configuration
│   ├── requirements.txt       # Python dependencies
├── .github/workflows
│   ├── docker-publish.yml     # GitHub Actions workflow for CI/CD
├── README.md                  # Project documentation
```

## Running the Service Locally

- Docker installed on your machine.
- Pull the Docker image:
  ```
  docker pull uamng/simpletimeservice:main
  ```
- Run the container:
  ```
  docker run -d -p 5000:5000 --name simpletimeservice uamng/simpletimeservice:main
  ```
- Test the service
- Open a browser or use curl:
  ```
  curl http://localhost:5000/
  ```
- Expected output:
  ```
  {
    "timestamp": "2025-03-28T14:30:00Z",
    "ip": "127.0.0.1"
  }
  ```

## GitHub Actions & CI/CD Pipeline

### Automation Workflow

- Docker credentials are stored as GitHub repository secrets.
- On any change in the app/ directory, the GitHub Actions workflow (.github/workflows/docker-publish.yml) is triggered.
- If a new branch is created, the Docker image is pushed to DockerHub with the branch name as the tag.
- If changes are merged into main, the image is tagged as main.

### Best Practices Followed

- Security: The application runs as a non-root user inside the container.
- Efficiency: The Docker image is optimized to be as small as possible.
- CI/CD: Automated builds and deployments ensure smooth integration.
- Branch-Based Tagging: Feature branches generate images with their branch name as a tag for better tracking.

