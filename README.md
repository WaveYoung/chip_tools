# chip_tools
chip design and verification tools

# host environment set
## install python3
install python
ubuntu/debian:
```
sudo apt update
sudo apt install python3
python3 --version
```
centos/rhel:
```
sudo yum install python3
python3 --version
```
fedora:
```
sudo dnf install python3
python3 --version
```
## change access mode
```
chmod 755 chip_tools/*.py
```
## set chip_tools to env path
edit ~/.bashrc, add chip_tools path to $PATH 
```
export PATH="chip_tools_install_path/chip_tools:$PATH"
```

# USEAGE
## creat project
```
creat_project proj_name proj_path
```
## config environment
`vim sourceme`
```
export SYNOPSYS_HOME=synopsys-install-path eg:/usr/synopsys    
export SYNOPSYS_VERSION=synopsys-version   eg:2018.09    
export VCS_VERSION=vcs-version             eg:O-2018.09-SP2    
export VCS_MX_VERSION=vcs-mx-version       eg:O-2018.09-SP2   
export DVE_VERSION=dve-version             eg:O-2018.09-SP2   
export VERDI_VERSION=verdi-version         eg:Verdi_O-2018.09-SP2   
export SCL_VERSION=scl-version             eg:2018.06  
export CHIP_TOOLS=chip_tools-dir           eg:~/chip_tools              
```
## set project environment
```
cd proj_path
source sourceme
```
## edit header for code file
edit file_header.txt
```
//filename: {file_name}
//author  : your_name
//mailbox : e-mail@xx.xx
//created : {date_time}
//modified: 
//version : v1.0.0
//company : your_comp(ltd.)
//license : GNU
```
text in { } please do not fix it, others you can fix it as you like.
## create reg model from csv file
  use reg command + options as below to build regmodel from csv file.  
   ```
   usage:
    regmodel -i <regmodel_input_csv_file> -o <regmodle_output_sv_file>
  options:
    -h,--h   help information.
    -i,--i   which regmodel csv file you want use. eg:-i <regmodel_input_csv_file> or --i=<regmodel_input_csv_file>
    -o,--o   ouput system_verilog regmodle file name. eg:-o <regmodle_output_sv_file> or --o=<regmodle_output_sv_file>
   ```     
   eg:     
   `regmodel -i reg.csv -o example_reg.sv`    
## create test bench
use build_testbench command + options as below to build project, envrionment and agent   
```
build_testbench -p <ut/it/st> -n <testbench_name> [-e <environment_name>] [-a <agent_name>] [-m <regmodel_file_path>]
options:
 -h,--h   help information.
 -p,--p   where you want to create. eg:-p ut/it/st or --p=ut/it/st
 -n,--n   testbench name set. eg:-n testbench_name --p=testbench_name
 -e,--e   environment name you want to create. eg:-e environment_name or --e=environment_name
 -a,--a   agent name you want to create. eg:-a agent_name or --a=agent_name
 -m,--m   create reg model in env. eg:-m regmodel_file_path or --m=regmodel_file_path
```     
eg:     
`build_testbench -p ut -n testbench_name -m path_to_reg_model/reg_model.sv -e env_name -a agent_name`    
notice: if set agent_name, env_name must be set first.