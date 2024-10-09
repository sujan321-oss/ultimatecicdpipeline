resource "aws_instance" "example" {
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.large"
  associate_public_ip_address = true
  key_name               = "virginiajenkins"
  subnet_id              = "subnet-06c200db60b5b55ac"
  
  user_data = <<-EOF
              #!/bin/bash
              # Update the package index
              sudo apt-get update -y
              
              # Install Java (Jenkins requires Java)
              sudo apt-get install -y openjdk-11-jdk

              # Install Docker
              sudo apt-get install -y \
                  apt-transport-https \
                  ca-certificates \
                  curl \
                  software-properties-common

              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

              sudo apt-get update -y
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io

              # Start Docker and enable it to start on boot
              sudo systemctl start docker
              sudo systemctl enable docker

              # Add the current user to the docker group to avoid using sudo with Docker
              sudo usermod -aG docker ubuntu

              # Install Jenkins
              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
                  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                  https://pkg.jenkins.io/debian binary/ | sudo tee \
                  /etc/apt/sources.list.d/jenkins.list > /dev/null

              sudo apt-get update -y
              sudo apt-get install -y jenkins

              # Start Jenkins and enable it to start on boot
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
         EOF
}
