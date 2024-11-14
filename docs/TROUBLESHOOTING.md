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

1. **Inspecting the Health Checks**: The first thing I would do is utilize the docker inspect command to check the status and configuration of the container. This command provides detailed information about the container, including its health check status. This will give me insights into why the health check is failing, such as whether the server isn’t responding in time, or if it’s returning an error code. This gives me room to confirm whether the issue lies in the web server configuration, networking, or health check parameters themselves.
I would utilize `docker inspect` to get finer details about the health status. 
   
3. **Checking the Web Server Logs**: Once I have an idea of what might be going wrong, I would proceed to inspect the logs of the web server. Logs are very important because they contain error messages or warnings that can highlight what’s failing; and where specifically. If I’m using Nginx, I would use commands like docker logs and or access the container’s file system to navigate to log directories. For instance, with Nginx, I would check the error logs typically found in /var/log/nginx/error.log to identify issues such as misconfigurations, missing files, or other problems that might prevent the server from responding properly to the health check request.

4. **Fine tuning the the Health Check Params**: Health checks can sometimes fail if they are configured with too strict or too short parameters. For instance, if the --timeout param is set too low (e.g., 1 second), the health check may fail if the server needs a bit more time to respond, especially under load. In such cases, I would adjust these params. I might increase the --timeout value to 10 seconds, giving the server more time to respond. Additionally, I would adjust the --interval (the time between checks) and --retries (how many times Docker tries before marking the container as unhealthy) to more appropriate values. For example, increasing the --interval to 15 seconds might give the server enough breathing room between health checks, reducing false positives.
  
5. **Rebuilding the Container**: After fine-tuning the params or fixing any issues with the server logs, I would rebuild the Docker container to apply the changes. Rebuilding the container ensures that all the changes I made, whether to the Dockerfile, server configuration, or health check parameters, are properly implemented. I would use the docker build command to rebuild the image and then rerun the container with docker run. Once the container is running, I would retest the health checks to ensure that they pass. If the container’s health checks are now successful, I would know that the issue has been resolved.

---

### Scenario 2: Nginx Ingress Not Accessible

In this scenario, this is how I would approach the troubleshooting:

1. **Checking the Ingress Controller**: First, I would verify that the Ingress Controller itself is operational, as it manages routing to the exposed service. Using kubectl get pods -n, I would check that the controller is up and running without errors. If there are issues here, I’d restart the controller and examine its logs to understand any potential setup issues.

2. **Inspecting the Ingress Resource**: Next, I’d review the Ingress resource configuration to ensure that it’s correctly linked to the intended service and has the correct hostname or IP address. Using kubectl describe ingress, I would confirm that all paths and host details are set up as expected, as any misalignment here could lead to accessibility issues. I would keenly verify the ingress Resource; to ensure that it is properly correctly with the correct **service** and **host** details.

3. **DNS checking**: I would then check DNS settings to confirm that they accurately point to the Ingress Controller’s IP. I’d validate DNS by performing commands such as dig or nslookup to ensure that the domain resolves to the correct IP since any misconfigured DNS records limits external access.

4. **Firewall Rules**: Next, I would inspect firewall rules or cloud security groups to ensure that ports 80 (HTTP) and 443 (HTTPS) are open and directed to the Ingress Controller. Many cloud providers have security settings that can unintentionally block external traffic, so I would confirm these ports are allowed.

5. **Nginx Logs**: Finally, I would review the Nginx logs (kubectl logs  -n command) to identify any routing or configuration errors that may be affecting access. Logs often reveal issues like misrouted traffic or configuration warnings, which can guide any final adjustments.

---
