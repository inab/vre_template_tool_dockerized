## How to bring in a new tool?
Essentially, VRE will need thre elements, (1) a docker image for your tool (2) your application or workflow wrapped within a **VRE RUNNER**, and (2) **metadata** annotating it (*i.e.* input files requirements, descriptions). The following steps describe how to achieve it.

- [Step 1](#step-1-pre-define-your-tool-to-build-a-test-set-of-VRE-job-execution-files) &nbsp; &nbsp; &nbsp; Define your tool's input and output files. Build job execution files for testing the RUNNER.
- [Step 2](#step-2-prepare-a-VRE-RUNNER-wrapping-your-application) &nbsp; &nbsp; &nbsp; Prepare a VRE RUNNER script for your application
- [Step 3](#step-3-annotate-and-submit-the-new-VRE-tool) &nbsp; &nbsp; &nbsp; Annotate and submit the new VRE tool
- [Step 4](#step-4-test-and-debug-the-new-tool-from-the-VRE) &nbsp; &nbsp; &nbsp; Test and debug the new tool from the VRE user interface
- [Step 5](#step-5-prepare-a-web-page-to-display-a-summary-report-on-each-execution) &nbsp; &nbsp; &nbsp; (optional) Prepare a web page to display a summary report on each execution
- [Step 6](#step-6-provide-documentation-for-the-new-tool) &nbsp; &nbsp; &nbsp; Provide documentation for the new tool
<br/>



#### STEP 2: Prepare a VRE RUNNER script for your application

VRE RUNNERs are pieces of code that work as adapters between the VRE server and each of the integrated applications or pipelines. Eventually, the RUNNER should: 
1. Consume the VRE job execution files that will be generated when a user submits a new job from the web interface,
2. Run locally the wrapped application or pipeline (the command that would be the CMD for the docker image of the tool), and  
3. Generate a list of output files, information that the VRE server will use to register and display the files at users' workspace.

For preparing the RUNNER, the easiest option is to **take as reference a `RUNNER template `** and use it as skeleton to wrap your own application. The template includes a couple of python classes that parse and load VRE job execution files into python dictionaries. The template includes a method that you can customize at your convenience to call the application, module or pipeline to be integrated.  

**Step-by-step**

1. **Fork or clone** the repository of the RUNNER template in your local development environment.
    | RUNNER template repository |  |
    | ------------- | ------------- |
    | https://github.com/inab/vre_template_tool_dockerized | [documentation](https://vre-template-tool.readthedocs.io/en/latest/reference/classes.html) |

2. (optional) Run the `demo` example. The RUNNER template is initially configured to "wrap" an application called `demo`. It demonstrates the overall flow of a VRE RUNNER.
    - How to: https://github.com/inab/vre_template_tool#run-the-wrapper
3. **Include your own job execution files** in the repository. You can copy the JSON files generated in *STEP 1* into the `test/` folder of the repository to replace the basic `demo` example. They should contain the input files and arguments for a test execution of your tool. You can try again to run the RUNNER as above, but now it's going to fail, as the RUNNER is still expecting the arguments and the input files  of the `demo` example.

    Make sure that the absolute path of the working directory and the input files defined in these JSON files are accessible.

4. **Implement the `run` method of the `VRE_Tool`** so that the function executes the application, module or pipeline to be integrated. The input file locations and argument values as defined in the job execution files are going to be the content of parameters received  in the  `run` method.

5. The RUNNER will be ready when the  wrapped application is properly executed and the output files are generated at the location specified in `output_files[].file.path`. These paths are usually defined in `config.json` file.
    Alternatively, if the name and number of the output files cannot be known before the execution, you should extend the `VRE_Tool.run` method to **define the `file.path` attribute** into the `output_files` dictionary. The RUNNER will write down it into the out-files metadata file (*i.e.* `out_metadata.json`).

    Make sure your output files are generated in the root of the working directory

6. **Save your RUNNER** in a GIT repository publicly available. In the same way than the template RUNNER, document the installation and include some test datasets, considering also the installation of the wrapped application itself: extra modules, dependencies, libraries, etc. VRE administrators will eventually install this repository in the VRE cloud.

<br/>

#### STEP 3: Annotate and submit the new VRE tool

Once the RUNNER is successfully executing the application in your local development environment, it is time to ask for **registering the new tool** to the corresponding VRE server. To do so, some descriptive metadata on the new application is required, *i.e.*, tool descriptions and titles, ownership, references, keywords, etc.

Again, two approaches are supported: 

- **Manual approach**:
   
    Generate the `tool specification file` taking as reference some examples to fully annotate the new tool
    - JSON schemes:
        - [tool schema minimal](https://github.com/euCanSHare/vre/tree/master/tool_schemas/tool_specification)
    - Examples:
        - dpfrep RUNNER (example of a R-based tool):  [tool_specification.json](https://github.com/inab/vre_dpfrep_executor/tree/master/tool_specification)
    
    Save your tool specification file in your repository and send it all together to VRE administrators. They will validate the data and register the tool the the VRE.

- **VRE web interface approach**:
    
    Go to the tools' developer administration panel and fill in the missing information for the tool entry generated in *STEP 1* when preparing the job execution files.  
    - Where:
        1. in the left navigation menu, Admin &#8594; My Tools &#8594; Development &#8594;. Find the row corresponding to your tool in preparation.
        2. Fill in the two last columns:
            - `bring us your code`: URL of the your RUNNER's repository created in *STEP 2*
            - `Define Tool`: edit online the template JSON document. Find a title for your tool, a description, etc. All this information will be displayed to the user on the web application.
        3. Send the `Submit` button. It will send an email to VRE administrators, who will validate the data and register the tool to the VRE.

After approval, the tool will be accessible on the web application in *test mode*, *i.e.*, only tool developers and administrators will be able to find and run the tool at the VRE.

<br/>

#### STEP 4: Test and debug the new tool from the VRE

<br/>

#### STEP 5: Prepare a custom report viewer for each execution

<br/>

#### STEP 6: Provide documentation for the new tool

- Tool logo: minimal resolution of 400px x 400px
- Sample datasets
- Help pages


