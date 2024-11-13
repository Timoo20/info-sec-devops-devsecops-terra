# info-sec-devsecops-terra
This repository demonstrates and showcases the solutions for a series of exercises for Info-Sec/DevSecOps/DevOps. It includes hands-on assessments that demonstrate containerization technologies (Docker- to be specific), setting up health checks, and troubleshooting issues that are related to web servers and Nginx Ingress configurations. It outlines my problem-solving approach and technical expertise in both Information Security, DevSecOps, DevOps, and the best practice, hence strengthening the security of the application delivery and infrastructure management. The scope of this task is focused on - **Information Security (Info-Sec)**, **DevSecOps**, and **DevOps**.
---
## Table of Contents
1. [Docker Web Server Setup & Health Checks](#docker-web-server-setup--health-checks)
    - [Step-by-Step Setup](#step-by-step-setup)
    - [Health Check Configuration](#health-check-configuration)
    - [Troubleshooting Docker Health Checks](#troubleshooting-docker-health-checks)
2. [Scenario-Based Troubleshooting](#scenario-based-troubleshooting)
    - [Scenario 1: Failing Health Checks in Docker](#scenario-1-failing-health-checks-in-docker)
    - [Scenario 2: Nginx Ingress Not Accessible](#scenario-2-nginx-ingress-not-accessible)
3. [Tech Stack Used](#tech-stack-used)
4. [Setup & Requirements](#setup--requirements)
5. [About Me & Contact](#about-me--contact)

---

## Docker Web Server Setup & Health Checks

### Step-by-Step Setup

The main goal of this exercise was to set up a simple web server inside a Docker container, running on port `8002`. I chose **Nginx** as the web server for this project due to its lightweight and efficient nature.

#### The steps I followed were:
1. **Creating the Dockerfile**: I started by creating a `Dockerfile` to configure the web server. The Dockerfile uses the official **Nginx** image, and it exposes the application on port `8002`.
   
    ```Dockerfile
    # Use the official Nginx image
    FROM nginx:latest
    
    # Copy custom index.html to the container's web directory
    COPY index.html /usr/share/nginx/html/index.html
    
    # Expose port 8002 for the web server
    EXPOSE 8002
    ```

2. **Building and Running the Container**:
   After writing the Dockerfile, I built the Docker image using the following command:
   ```bash
   docker build -t my-nginx-app .
   ```
   And ran the container:
   ```bash
   docker run -d -p 8002:80 my-nginx-app
   ```

Once this was set up, the web server was live and accessible at `http://localhost:8002`.

---

### Health Check Configuration

A health check is essential to ensure that the container is up and running correctly. To add this, I configured a health check in the Dockerfile, which pings the root path of the web server every 30 seconds to ensure it is alive.

```Dockerfile
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl --silent --fail http://localhost:8002/ || exit 1
```

If the web server does not respond successfully within the set parameters, Docker will consider the container "unhealthy."

---

### Troubleshooting Docker Health Checks

During my setup, I encountered an issue where the health check was consistently failing. Here’s how I tackled the issue:

1. **Check the Logs**: First, I looked at the container logs using `docker logs <container_id>` to see if there were any clues about errors or misconfigurations.
   
2. **Examine the Health Check Status**: Using the command `docker inspect --format='{{json .State.Health}}' <container_id>`, I was able to inspect the health check status and pinpoint the issue.

3. **Test the Web Server Directly**: To rule out potential networking issues, I accessed the container directly using `docker exec` and tested the server internally with `curl`.

4. **Increase Timeout & Retry Settings**: Finally, I tweaked the health check settings, such as increasing the timeout and retry count, which helped the container pass the health check successfully.

---

## Scenario-Based Troubleshooting

### Scenario 1: Failing Health Checks in Docker

Sometimes, health checks can fail due to various reasons, like misconfigurations or network issues. In my case, the Docker health check was failing.

#### Here's how I solved it:
1. **Inspect the Health Check Output**: I started by using `docker inspect` to get more details about the health check status, which pointed out that the issue was a time-out from the health check ping.
   
2. **Check the Web Server Logs**: The logs revealed that Nginx was not fully loading the content due to a missing file.

3. **Adjust the Health Check Parameters**: After resolving the file issue, I adjusted the health check’s timeout and retries to give the container a little more time to respond.

4. **Rebuild the Container**: Once the changes were made, I rebuilt the Docker container and ran it again. This time, the health check passed, confirming the issue was resolved.

---

### Scenario 2: Nginx Ingress Not Accessible

In this scenario, I exposed a service via **Nginx Ingress**, but it wasn’t accessible over the internet. Here’s how I approached the troubleshooting:

1. **Check the Ingress Controller**: I first made sure that the **Nginx Ingress Controller** was properly set up and running in my Kubernetes cluster by using `kubectl get pods -n ingress-nginx`.

2. **Inspect the Ingress Resource**: I verified that the **Ingress Resource** was configured correctly with the correct **host** and **service** details.

3. **DNS and Routing**: Next, I checked if the DNS settings were correctly pointing to the IP address of the Ingress controller.

4. **Firewall Rules**: I made sure that the relevant ports (80/443) were open in the cloud provider’s security group or firewall.

5. **Nginx Logs**: Finally, I looked at the logs of the **Nginx Ingress Controller** to check for any issues in routing or configuration.

---

## Tech Stack Used

- **Docker**: To build and run the containerized web application.
- **Nginx**: Used as the web server to serve the content.
- **Kubernetes & Ingress**: To manage and expose services in a Kubernetes environment.
- **Curl & Wget**: For testing service health and availability.
- **YAML & Dockerfiles**: For configuration management and defining services.

---

## Setup & Requirements

To get started with this project, you'll need:

- **Docker** installed on your local machine or VM.
- **Kubernetes** (optional, for the Nginx Ingress exercise).
- Access to a terminal to run the commands and build the containers.

---
## About Me & Contact

I'm a **Cybersecurity & DevOps professional** passionate about building secure, scalable, and efficient applications. I focus on bridging the gap between development and security to create seamless solutions that are both effective and safe.

If you want to connect or have any questions about this repository or the exercises, feel free to reach out!

- **Email**: [timothymurkomen@gmail.com](mailto:timothymurkomen@gmail.com)
- **LinkedIn**: [Tim Murkomen](https://www.linkedin.com/in/timoo20//)
---
## LICENCE
**License**: This project is Licensed under a Tim Murkomen Custom License by Tim Murkomen - Here is the Link  [Custom Licence](https://github.com/Timoo20/info-sec-devops-devsecops-terra/blob/main/LICENSE)
```
