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