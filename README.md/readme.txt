# Jenkins on EKS with Docker & Flask App Deployment

This project sets up a CI/CD pipeline using Jenkins running on an EC2 instance, with a Flask app deployed to an EKS cluster. The pipeline integrates with GitHub, DockerHub, and AWS.

---

## 🔧 Stack Used
- **AWS EKS (Elastic Kubernetes Service)**
- **EC2 (for Jenkins)**
- **Docker & DockerHub**
- **Jenkins (CI/CD)**
- **Flask App**
- **kubectl / eksctl / awscli**

---

## 📁 Project Structure

EKSJ/├── cluster.yaml # EKS cluster + node group definition 
    ├── setup-jenkins.sh # Jenkins installation script
    ├── requirements.txt # Flask app dependencies
    ├── Dockerfile # (Optional) Flask app Docker build file 
    ├── Jenkinsfile # (Optional) Jenkins pipeline definition 
    ├── README.md # This file

    
---

## 🚀 Getting Started

### 1. Create EKS Cluster
```bash
eksctl create cluster -f cluster.yaml


bash setup-jenkins.sh

Open Jenkins at http://<public-ip>:8080

Unlock using /var/lib/jenkins/secrets/initialAdminPassword

🔐 Jenkins Credentials

DockerHub
Go to DockerHub → Account Settings → Security → Create Access Token
In Jenkins → Manage Credentials → Add:
Username = DockerHub username
Password = Token value
AWS CLI
Use aws configure to set credentials for Jenkins user
Or add IAM role to EC2 with necessary permissions

✅ Required Jenkins Plugins

GitHub Integration
Docker Pipeline
AWS Credentials
Kubernetes CLI Plugin
Blue Ocean (optional UI)
Pipeline Utility Steps

🧪 Test the Setup

Push code to GitHub
Jenkins picks up changes via webhook
Jenkins builds Docker image
Jenkins pushes image to DockerHub
Jenkins deploys to EKS via kubectl

⚠️ Notes
Make sure inbound rules (ports 22, 80, 443, 8080) are set correctly in EC2 Security Group
Use kubectl get nodes and kubectl get pods to verify EKS health

Built and maintained by Devansh Pandey — driven by curiosity and caffeine.
