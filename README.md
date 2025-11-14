# aks-microservices

# Platform Architecture & DevOps – README

## 📖 Overview
This repository and associated work represent hands‑on projects and architectural patterns designed by **Anuj**, a Senior DevOps/SRE Engineer and Platform Architect. The focus is on building **production‑grade, maintainable, and secure cloud platforms** with strategic impact, while benchmarking leadership‑level compensation and equity structures.

---

## ⚙️ Setup Steps
1. **Infrastructure as Code (Terraform)**  
   - Modular design for Azure resources (AKS, ACR, Key Vault, Networking).  
   - CI/CD pipelines with isolated states per environment.  
   - Governance baked into module structure.  

2. **Microservices Demo (FastAPI)**  
   - Minimal, production‑ready FastAPI app deployed to AKS.  
   - Automated build/deploy pipeline with monitoring hooks.  
   - Benchmarked against Django for architectural tradeoffs.  

3. **Monitoring & Reliability**  
   - Integrated observability stack (logs, metrics, alerts).  
   - Scenario‑driven troubleshooting workflows.  
   - Automated validation of CIDR allocations, subnet isolation, and secrets management.  

---

## 📐 Assumptions
- Azure is the primary cloud provider.  
- Enterprise‑grade hub‑and‑spoke networking model.  
- CI/CD pipelines enforce reproducibility and security checks (Checkov, policy scans).  
- Future‑proofing is prioritized over short‑term hacks.  

---

## 🧭 Design Decisions
- **Reproducibility:** Pin module sources to commits/tags.  
- **Security:** Private endpoints, NSGs, restricted IP ranges, disabled public access.  
- **Resilience:** Zone redundancy, geo‑replication, SLA‑backed SKUs.  
- **Governance:** Azure Policy add‑ons, secrets isolation, compliance scans.  
- **Maintainability:** Modular Terraform, clear separation of environments, automation‑first workflows.  

---

## 🎯 Goals
- **Short‑term:**  
  - Deliver AKS/Terraform/CI/CD/monitoring assignment with FastAPI demo.  
  - Benchmark FastAPI vs Django for microservice deployments.  
  - Validate compensation/equity structures for senior leadership roles.  

- **Long‑term:**  
  - Secure a senior platform architect role with strategic influence.  
  - Balance technical excellence with business outcomes.  

---

## 🚀 Skills Highlighted
- Azure networking, AKS architecture, Terraform module design.  
- CI/CD pipeline design, secrets management, multi‑environment isolation.  
- Workflow automation, scenario‑driven debugging, reproducible solutions.  
- Strategic platform design with business impact.  

---
