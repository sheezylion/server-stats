# Building a Robust CI/CD Pipeline on AWS with Jenkins and Docker Agents: A Step-by-Step Guide (Part 1)
## Introduction: Why Jenkins for CI/CD?

- Jenkins is one of the first CI/CD tools widely used for Continuous Integration & Deployment.

- It’s ideal for hybrid environments and has tons of plugins compared to tools like GitHub Actions.

- Even though newer tools exist, Jenkins remains popular for enterprise CI/CD pipelines.

## Understanding Jenkins Architecture
Before we install Jenkins, let’s understand how it works:

- Master Node (Controller Node): Manages the jobs and schedules tasks.

- Worker Node (Agent Node): Executes the actual build process.

- Typically, multiple worker nodes are used to handle traffic efficiently.

## Why Use Docker for Jenkins Agents?
Traditionally, worker nodes require separate VMs, but this increases cost and resource usage.

Instead, we use Docker agents, which:
- Spin up a container for the build.
- Auto-delete once done (no extra cost).
- Are lightweight and fast compared to full VMs.

## Setting Up Jenkins on AWS (EC2 Instance)
We will set up Jenkins on Ubuntu AMI with Docker integration.

### Step 1️: Launch an EC2 Instance

- Use Ubuntu 22.04 AMI.

- Instance type: t2.medium (at least 4GB RAM for Jenkins).

- Open ports: 22 (SSH), 8080 (Jenkins), 2375 (Docker Daemon if needed).


<img width="1107" alt="Screenshot 2025-03-25 at 15 33 56" src="https://github.com/user-attachments/assets/866373f7-1734-4991-9a4f-ac9e021bc969" />

### Step 2️: ssh into the EC2 instance through your terminal

```
ssh -i <path to key-pair> ubuntu@<ip-address>
```

<img width="983" alt="Screenshot 2025-03-25 at 15 48 05" src="https://github.com/user-attachments/assets/bc105f4f-65b9-43b4-8ba8-bfd61d5c771c" />

### Step 3: Install Jenkins on EC2

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-17-jdk wget
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable --now jenkins
```

<img width="1658" alt="Screenshot 2025-03-25 at 16 01 07" src="https://github.com/user-attachments/assets/73534461-cfb8-458c-89ec-d248dbff5788" />

### Jenkins should now be running on port 8080.

<img width="1611" alt="Screenshot 2025-03-25 at 16 03 30" src="https://github.com/user-attachments/assets/3f94b864-1920-4c5a-af7f-7b7e0b7a4d89" />

### Step 4: Go back to your terminal and Install Docker on EC2

```
sudo apt install -y docker.io
sudo systemctl enable --now docker
```

### Step 5: Add Jenkins & Ubuntu User to Docker Group

```
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart jenkins
```

✅ This ensures Jenkins can run Docker containers.

### Step 6: Install Docker Plugin in Jenkins

- Go to Manage Jenkins > Plugin Manager.

- Install "Docker Pipeline Plugin".

- Restart Jenkins.

## First Jenkins Job: Running a Pipeline with Docker Agent
Now that Jenkins and Docker are set up, let’s run a simple pipeline:

### Step 1️: Create a New Pipeline Job

- Go to Jenkins Dashboard → New Item → Pipeline.

- Name it "Docker Test Pipeline".

- Scroll down to Pipeline Script and add the following:

```
pipeline {
    agent {
        docker { image 'node:latest' }  // Runs inside a Node.js container
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'  // Check if Node.js is installed
            }
        }
    }
}
```

### Step 2️: Save & Run
Click Build Now and check the logs.

You should see the Node.js version printed, meaning the pipeline ran successfully inside a Docker container! 

### Conclusion

In this first part of our series on building a robust CI/CD pipeline on AWS with Jenkins and Docker agents, we've successfully set up Jenkins on an EC2 instance and integrated Docker to streamline our build processes. By leveraging Docker agents, we have optimized resource usage and reduced costs, setting a strong foundation for efficient CI/CD operations. We also created a simple pipeline to demonstrate the seamless execution of tasks within Docker containers. 

In the upcoming parts, we will enhance our pipeline by integrating GitHub for code management, deploying a real-world application, and implementing webhooks for automated builds, further solidifying our CI/CD strategy. Stay tuned for more advanced configurations and practical applications!





