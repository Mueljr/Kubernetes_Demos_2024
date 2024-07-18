**DEPLOY CLOUD-BASED MONITORING APP ON KUBERNETES**

![cloud-based monitoring app on K8S_flow](https://github.com/user-attachments/assets/1d3be313-275c-49fd-bd20-0e6e4ed86f54)

In this project, a cloud-based monitoring application as created on Python is going to be deployed on K8S. The purpose of the app is to notify a user or a group of users, if the CPU and/or memory utlization has equalled or has gone past 80%. This will enable the appropriate quarters take the necessary actions in scaling up the infrastructure in use, to avoid failure or latency on the end of the customers or end users.

Following the workflow above, 

**(A) BUILD APP:** the 'psutil' library is installed and used for retrieving information on running processes and system utilization. e.g. CPU, memory, disks, etc. The entire app is also created on 'Flask' framework. All the dependencies as used in this app are added in the "requirements.txt" file, and it is executed after. To make the app interface friendly and colorful, some design templates are added based on the "index.html" file. Post-executing this code, at this stage, the app will be running only on local host.

**(B) DOCKER:** A Dockerfile is written with baseImage and tag as Python:3.9-buster. All dependencies to be used in the app are copied as in the requirements.txt file, and no caching during installation is set for. Port 5000 is exposed for access, and Dockerfile is built into an image (**docker build -t 'imagename' .**)

A Docker container is created by using the Docker run command, which the port number is defined to run on the local host as well (**docker run -p 5000:5000 'imageID'**)

**(C) AMAZON ECR:** the Docker container is then pushed into the ECR hub. Python Boto3 is used to create the container repository. After the repository is created, 'push commands' provided by AWS, are used to push the Docker image into the repository from the terminal.

**(D) AMAZON EKS:** A cluster is created, as it is ensured port 5000 is open in the security group configurations. A node group is created as well, which creates two nodes.

**(E) DEPLOY ON KUBERNETES:** For this final stage, deployment.yaml and service.yaml files could've been written to be executed, but Python was once again used to create the deployment and service on K8S. After this is executed, port-forwarding is done for the service created.

Finally, the app is deployed on K8S, and can be access by anyone with the local host port address (http://localhost:5000)

