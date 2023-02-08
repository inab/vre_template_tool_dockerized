## How to bring in a new tool?
Essentially, VRE will need thre elements, (1) a docker image for your tool (2) your application or workflow wrapped within a **VRE RUNNER**, and (2) **metadata** annotating it (*i.e.* input files requirements, descriptions). The following steps describe how to achieve it.

1. Clone https://github.com/inab/vre_template_tool_dockerized/​
2. Change in the Dockerfile the FROM image with the one for your tool, the rest leave it as it is​
3. Adjust the VRE_Tool.py of the vre_template_tool_dockerized repo and the tests folder​
4. Build the image with the modified Dockerfile​
5. Test with new image​

