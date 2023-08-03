
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Anomalous frontend request rate for HAProxy
---

This incident type refers to an anomaly in the amount of frontend requests handled by HAProxy on a particular host. It indicates that the frontend request rate has deviated significantly from the predicted values, triggering a query alert monitor. This incident typically requires immediate attention from the software engineer to investigate and resolve the issue.

### Parameters
```shell
# Environment Variables

export HOST="PLACEHOLDER"

export PATH_TO_HAPROXY_CFG="PLACEHOLDER"

export BUFFER_SIZE="PLACEHOLDER"

export TIMEOUT="PLACEHOLDER"

export NUMBER_OF_CONNECTIONS="PLACEHOLDER"

export BACKEND_SERVER_IP="PLACEHOLDER"

export BACKEND_SERVER_URL="PLACEHOLDER"

export BACKEND_SERVER_USERNAME="PLACEHOLDER"

export HAPROXY_URL="PLACEHOLDER"
```

## Debug

### Check CPU/Memory usage
```shell
top
```

### Check disk usage
```shell
df -h
```

### Check network traffic
```shell
iftop
```

### Check HAProxy status
```shell
systemctl status haproxy
```

### Check HAProxy configuration file
```shell
cat /etc/haproxy/haproxy.cfg
```

### Check HAProxy log file for any errors
```shell
tail -f /var/log/haproxy.log
```

### Check the number of frontend requests handled by HAProxy
```shell
watch "echo 'show info' | socat unix-connect:/var/run/haproxy.sock stdio | grep 'frontend.total'"
```

### Check if there is any network issue
```shell
ping ${HOST}
```

### Check if there is any firewall blocking the traffic
```shell
iptables -L
```

### Check if HAProxy is running on the designated port
```shell
netstat -tulpen | grep haproxy
```

### Check HAProxy statistics
```shell
echo 'show stat' | socat unix-connect:/var/run/haproxy.sock stdio | cut -d',' -f1,2,5,18
```

### Check HAProxy configuration for any syntax errors
```shell
haproxy -f ${PATH_TO_HAPROXY_CFG} -c
```

## Repair

### Update HAProxy configuration file to adjust max number of connections, timeout, and buffer size.

```shell
sed -i "s/^maxconn.*/maxconn $NUMBER_OF_CONNECTIONS/" /etc/haproxy/haproxy.cfg

sed -i "s/^timeout.*/timeout $TIMEOUT/" /etc/haproxy/haproxy.cfg

sed -i "s/^buffer-size.*/buffer-size $BUFFER_SIZE/" /etc/haproxy/haproxy.cfg
```

### Restart HAProxy service
```shell
systemctl restart haproxy.service
```

### Next Step
```shell
echo "HAProxy configuration updated successfully."
```