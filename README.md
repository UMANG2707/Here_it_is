# SimpleTimeService

---
### TASK 1
---

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
- Docker image URL
  https://hub.docker.com/r/uamng/simpletimeservice/tags
  
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

---
### TASK 2
---

## Overview

- This Terraform project provisions the necessary AWS infrastructure to host and run a containerized application using ECS, ALB, and supporting resources. The infrastructure follows best practices, using Terraform modules for networking and compute resources while storing the Terraform state in an S3 backend.

## Infrastructure Components

### Network

- Creates a VPC with:
  - 2 Public Subnets (for the load balancer)
  - 2 Private Subnets (for the ECS tasks)
- Internet Gateway and Route Tables configured accordingly.

### Compute

- ECS Cluster: Hosts the containerized application.
- ECS Task Definition: Defines how the container should run.
- ECS Service: Ensures the application is always running on private subnets.

### Load Balancing

- Application Load Balancer (ALB) deployed in public subnets.
- Target Group (TG) with health checks configured.
- ALB Listener to route traffic to ECS tasks.

### Other Resources

- Security Groups: Restrict access to necessary ports.
- IAM Roles & Policies: Grant required permissions for ECS tasks and ALB.
- S3 Backend: Stores Terraform state securely with locking enabled.

## Repository Structure

```
.
├── app                 # Application files (Dockerfile, source code, etc.)
└── terraform           # Infrastructure as Code (Terraform configurations)
    ├── main.tf         # Defines all infrastructure resources
    ├── providers.tf    # Specifies Terraform provider and S3 backend
    ├── s3-backend.conf # Configuration for Terraform remote state
    ├── terraform.tfvars# Stores variable values
    ├── variables.tf    # Declares Terraform variables

```

## Deployment Steps

- AWS CLI installed and configured.
- Terraform installed.
- AWS IAM permissions to create resources.

### Steps to Deploy

- Clone the Repository
  ```
  git clone <repo-url>
  cd terraform
  ```
- Configure AWS Profile
- Set up AWS credentials and update providers.tf with the correct profile name.
- Create an S3 Bucket for Terraform State
- Update s3-backend.conf with the correct values.
- Initialize Terraform
  ```
  terraform init -backend-config=s3-backend.conf
  ```
- Plan and Apply Terraform Changes
  ```
  terraform plan
  terraform apply -auto-approve
  ```
- Verify Deployment:
- Use the ALB DNS name to check the application:
- This points to the ECS service, which routes requests via the target group to the running task on port 5000.
  
## Automating Deployment

- Updating the ECS Task Definition with a new image tag.
- Forcing ECS Service Deployment to roll out the updated application.
- Creating a CI/CD Pipeline to handle image updates and infrastructure changes.

## Future Enhancements

- Implement a CI/CD pipeline for infrastructure provisioning.
- Parameterize image tags and automate deployments via GitHub Actions.
- Enhance security with fine-grained IAM policies.

## Recommended Deployment Process

- Create a v2 branch.
- Build and push a new image tagged v2.
- Update ECS task definition with the new image tag.
- Force deploy the ECS service.
- Test the deployment using the ALB DNS.
- Merge changes into the main branch and apply the Terraform changes.

----

# conclusion 

This project sets up a scalable, secure, and modular AWS infrastructure for hosting containerized applications. The setup is designed for easy updates and future automation. A CI pipeline has already been implemented, allowing for manual deployments while also enabling automated deployment. Additionally, an infrastructure integration pipeline can be added by configuring AWS credentials in repository secrets to make the process fully automated.

----
