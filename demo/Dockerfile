#INTEGRATE YOUR TOOL'S CONTAINER
FROM ubuntu:22.04
RUN echo "#!/bin/bash \n echo \"Hello. This is demo process reading the commandline argument '\$1' and writing this line in a new outfile.\" > my_demo_outfile.txt \n" >> /home/my_demo_pipeline.sh 
#this is a dummy tool for demonstration purposes

#---------- DO NOT EDIT BELOW HERE ------------------------------------------------------------# 
#INSTALL openVRE DEPENDENCIES
#Entrypoint requirements
RUN apt update -y && apt install -y  bindfs sudo
RUN apt-get update -qq ; apt-get install -y git vim python3-pip python3-venv
ARG DEBIAN_FRONTEND=noninteractive
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#OpenVRE runner installation
WORKDIR /home
RUN git clone --single-branch --branch dockerized https://github.com/inab/vre_template_tool.git
WORKDIR /home/vre_template_tool

RUN pip3 install --upgrade wheel
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade pip

#Adding your test files
COPY ./vre_template_tool/tests /home/vre_template_tool/tests
COPY ./vre_template_tool/VRE_Tool.py /home/vre_template_tool/tool
RUN chmod -R 777 /home/vre_template_tool
RUN  chmod -R a+rwx /home/vre_template_tool

#Execute entrypoint 
ENTRYPOINT ["/entrypoint.sh"]

