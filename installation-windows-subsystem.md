
# Steps to install TracerX on Ubuntu-18.04 using Windows Subsytem for Linux (WSL): #

## 1. Install WSL ##
* For reference: visit https://learn.microsoft.com/en-us/windows/wsl/install
* Click on the **Start** menu and open **PowerShell** as an administrator
* Execute the below command:
  * <kbd> wsl.exe --install -d Ubuntu-18.04 <kbd>
  * Note: The first time you run your WSL distribution, you will be asked to create a user account.
  * After the WSL installation is successful, the bash prompt gets enabled. Execute the following command:
     * <kbd> sudo apt update && sudo apt upgrade <kbd>

## 2. Install TracerX ##
* Create a 'TracerX' folder at any location in your file system. 
* Click on the Start menu and open WSL as an administrator. Next, change directory to the TracerX folder path. 
* Visit https://www.comp.nus.edu.sg/~tracerx/getingstarted.html and execute all the commands.
* Note: encountered errors and its solutions are as follows.
  * while building LLVM:
    * Download Clang from [Clang Source Code](https://releases.llvm.org/3.4.2/cfe-3.4.2.src.tar.gz) and rerun the llvm commands.
  * while building tracerx:
    * Set the CURRENT_FOLDER to the TracerX folder path and then rerun the tracerx commands.
  * while executing make command of tracerx (error: conflicting types for 'gnu_dev_major'):
    * Open the error causing file and rename the highlighted functions (gnu_dev_major)  by adding some suffix (gnu_dev_major_1). Next, save the file and rerun the make command
