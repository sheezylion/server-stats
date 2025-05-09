# Step-by-Step Guide: Deploy a Node.js App to Kubernetes (Minikube/Docker Desktop)
## Task Objective
Learn how to run a basic web application on a Kubernetes cluster using essential components like Pods, Deployments, and Services.

## Prerequisites
- Install Docker: Docker Desktop (includes Kubernetes) or Minikube.

- Install kubectl: kubectl CLI.

- Node.js: Node.js LTS.

### Step 1: We would create a simple Node.js App
We’ll build a basic farming business landing page.

1. Initialize the Project

```
mkdir farming-app && cd farming-app  
npm init -y  
npm install express
```

2. Create app.js

```
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send(`
    <h1>Green Acres Farming</h1>
    <p>Welcome to our organic farm! Fresh produce delivered daily.</p>
  `);
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```
<img width="766" alt="Screenshot 2025-05-09 at 21 39 50" src="https://github.com/user-attachments/assets/4db19046-0751-44a4-9911-7190bbad9ede" />

3. Test Locally

```
node app.js
```
Visit http://localhost:3000 to verify the app works.

<img width="1084" alt="Screenshot 2025-05-09 at 18 12 47" src="https://github.com/user-attachments/assets/5872b6cf-adb0-473e-838c-939078dd688e" />

### Step 2: Dockerize the App
1. Create Dockerfile

```
# ---- Build Stage ----
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# (Optional: Run tests or build steps here)

# ---- Production Stage ----
FROM node:16-alpine
WORKDIR /app
# Copy only production dependencies from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js .
COPY --from=builder /app/package.json .

EXPOSE 3000
CMD ["node", "app.js"]
```

<img width="728" alt="Screenshot 2025-05-09 at 21 42 57" src="https://github.com/user-attachments/assets/4b4dfa5d-3685-416f-9dfe-8a7d52153055" />

2. Build and Test the Docker Image

```
docker build -t farming-app .
docker run -p 3000:3000 farming-app
```

Verify at http://localhost:3000

### Step 3: Set Up Kubernetes
1. Start Minikube/Docker Desktop Kubernetes

```
minikube start --driver=hyperkit
```
<img width="1074" alt="Screenshot 2025-05-09 at 21 07 51" src="https://github.com/user-attachments/assets/61645a9c-92e8-4612-ba89-e88e6e6d4d00" />

2. Verify Cluster is Running

```
kubectl cluster-info
```

<img width="941" alt="Screenshot 2025-05-09 at 21 11 04" src="https://github.com/user-attachments/assets/418e762f-0fe8-4f5e-bcd1-f621a0df4d84" />

### Step 4: Create Kubernetes Deployment & Service

1. Create deployment.yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: farming-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: farming-app
  template:
    metadata:
      labels:
        app: farming-app
    spec:
      containers:
      - name: farming-app
        image: farming-app
        imagepullpolicy: never
        ports:
        - containerPort: 3000
```

2. Create service.yaml (NodePort)

```
apiVersion: v1
kind: Service
metadata:
  name: farming-app-service
spec:
  type: NodePort
  selector:
    app: farming-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
      nodePort: 30001  # Accessible on port 30001
```

### Step 5: Deploy to Kubernetes
1. Apply the Configs

```
kubectl apply -f deployment.yml
kubectl apply -f service.yaml
```

2. Verify Deployment

```
kubectl get pods
kubectl get deployment
kubectl get service
```

<img width="1021" alt="Screenshot 2025-05-09 at 21 54 09" src="https://github.com/user-attachments/assets/14749b72-6cb0-4f3e-a1f1-4048deaa14f6" />

3. Access the App

- Minikube:

```
minikube service farming-app-service
```
In your local browser visit: http://192.168.67.3:30001/

<img width="1138" alt="Screenshot 2025-05-09 at 21 32 42" src="https://github.com/user-attachments/assets/51e41bc5-6e1f-4fe8-88a8-922d488441bd" />



