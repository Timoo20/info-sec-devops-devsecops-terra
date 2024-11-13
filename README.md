# info-sec-devsecops-terra
---
This repository demonstrates and showcases the solutions for a series of exercises for Info-Sec/DevSecOps/DevOps. It includes hands-on assessments that demonstrate containerization technologies (Docker- to be specific), setting up health checks, and troubleshooting issues that are related to web servers and Nginx Ingress configurations. It outlines my problem-solving approach and technical expertise in both Information Security, DevSecOps, DevOps, and the best practice, hence strengthening the security of the application delivery and infrastructure management. The scope of this task is focused on - **Information Security (Info-Sec)**, **DevSecOps**, and **DevOps**.
---
## Table of Contents
1. [PART 1](#PART-1)
    - [Step-by-Step Setup](#step-by-step-setup)
    - [Health Check Configuration](#health-check)
    - [Troubleshooting Docker Health Checks](#troubleshooting-docker-health-checks)
2. [PART 2](#PART-2)
    - [Scenario 1: Failing Health Checks in Docker](#scenario-1-failing-health-checks-in-docker)
    - [Scenario 2: Nginx Ingress Not Accessible](#scenario-2-nginx-ingress-not-accessible)
3. [Tech Stack](#tech-stack)
4. [Requirements](#requirements)
5. [About Me & Contact](#about-me--contact)

---

## PART 1

### Step-by-Step Setup

The main goal of this exercise was to set up a simple web server inside a Docker container, running on port `8002`. I chose **Nginx** as the web server for this project due to its lightweight and efficient nature.

#### The steps I followed were:
1. **Creating the Dockerfile**: I started by creating a `Dockerfile` to configure the web server. The Dockerfile uses the official **Nginx** image, and it exposes the application on port `8002`.
   
    ```Dockerfile
    # Nginx image in the Docker Hub
    FROM nginx:latest
        # Nginx configuration
    COPY nginx/nginx.conf /etc/nginx/nginx.conf
        # Exposing the port 8002
    EXPOSE 8002
        # Health Check
    HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
      CMD curl -f http://localhost:8002/ || exit 1
        # default command to run Nginx
    CMD ["nginx", "-g", "daemon off;"]
        ```
2. **Building and Running the Container**:
   After writing the Dockerfile, I built the Docker image using the following command:
   ```bash
   docker build -t terra-simple-nginx-server .
   ```
   And ran the container:
   ```bash
   docker run -d -p 8002:80 terra-simple-nginx-server
   ```
The web server was live and accessible at `http://localhost:8002`. As shown in the Screenshort [https://github.com/Timoo20/info-sec-devops-devsecops-terra/blob/main/images-screenshots/Validating%20in%20localhost.png]

---
### Health Check

A health check is important as it ensures that the container is up and running perfectly; as expected. To achieve this, I configured a health check in the Dockerfile that pings the root path of the web server every 30 seconds to ensure it is alive.

```Dockerfile
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl --silent --fail http://localhost:8002/ || exit 1
```
[As shown in the screenshort](https://github.com/Timoo20/info-sec-devops-devsecops-terra/blob/main/images-screenshots/Health-Container-Status.png) 
Incase the web server does not respond successfully within the configured param, then Docker will consider the container "UNHEALTHY."

---

### Troubleshooting Docker Health Checks

If I encounter issues with Docker health checks, I would take to troubleshoot the problem by:

1. **Checking the Logs**:  
   First, I would check the container logs to gather any clues about errors or misconfigurations that might be affecting the health check. For example, I ran the following command for my container:
   ```bash
   docker logs 350df94ecfdc
---
The logs showed the server returning the expected **"Hey! This is hello from Terra Software Company. Welcome to your Nginx server" **message, which confirmed the web server was functioning correctly.

2. **Examine the Health Check Status:**

   ```bash
   docker inspect --format='{{json .State.Health}}' 350df94ecfdc
    ---

When I executed the command, it showed that it is in healthy [As shown in the screenshort](https://github.com/Timoo20/info-sec-devops-devsecops-terra/blob/main/images-screenshots/Health-Container-Status.png) ; hence confirming the container was in good health. 


3. **Teting in web server directly:**

   I access the container directly and test the web server inside using curl. This helps in fixing network issues.
  

4. **Increasing the Timeout & Retry Configuration::**

   I would change the health params to fix the issue. For example; instead of 5 seconds in the timeout onfiguration, I would consider extending it to about 10 Seconds. 
  


## PART 2

### Scenario 1: Failing Health Checks in Docker

Health checks can fail because of misconfigurations or maybe because of network issues. In my case, the Docker health check was successful. Incase Docker fails, i would have considered:

1. **Inspecting the Health Checks**: I would utilize `docker inspect` to get finer details about the health status. 
   
2. **Checking the Web Server Logs**: I would keenly check the server logs.

3. **Fine tuning the the Health Check Params**: I would fine tune the health params to fix the issue. For example; instead of 5 seconds in the timeout onfiguration, I would consider extending it to about 10 Seconds. 
  
4. **Rebuilding the Container**: I will rebuilt the  container and ran it again.

---

### Scenario 2: Nginx Ingress Not Accessible

In this scenario, this is how I would approach the troubleshooting:

1. **Checking the Ingress Controller**: I would first assess the Ingress Controller to ensure that it is up and running.

2. **Inspecting the Ingress Resource**: I would keenly verify the ingress Resource; to ensure that it is properly correctly with the correct **service** and **host** details.

3. **DNS checking**: I would check the DNS settings to ensure that they are correctly pointing to the exact Ingress controller - IP address.

4. **Firewall Rules**: I would check if the ports Port 80/443 were open in the cloud provider’s security group or firewall.

5. **Nginx Logs**: Finally, I would look at the logs to check for any issues in routing or configuration.

---

## Tech Stack

- **Docker**: To build and run the terra-simple-nginx-server application.
- **Nginx**: Utilized as the web server to serve the content.
- **Curl**: For testing service health and availability.
- **Yaml & Dockerfiles**: For configuration management.

---

## Requirements

To get started with this project, you'll need:

- **Docker** installed on your local machine or VM.
- Access to a terminal to run the commands and build the containers.

---
## About Me & Contact

I'm a **Developer/Cybersecurity/DevSecOps/DevOps professional** passionate about building secure, scalable, and efficient applications. I focus on bridging the gap between development and security to create seamless solutions that are both effective and safe.

If you want to connect or have any questions about this repository or the exercises, feel free to reach out!

- **Email**: [timothymurkomen@gmail.com](mailto:timothymurkomen@gmail.com)
- **LinkedIn**: [Tim Murkomen](https://www.linkedin.com/in/timoo20/)
---
## LICENCE
**License**: This project is Licensed under a Tim Murkomen Custom License by Tim Murkomen - Here is the Link  [Custom Licence](https://github.com/Timoo20/info-sec-devops-devsecops-terra/blob/main/LICENSE)

---
Contributor: [Tim Murkomen](https://github.com/Timoo20) 
---
