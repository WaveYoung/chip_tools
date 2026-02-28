# chip_tools
chip design and verification tools

# 1 host environment set
## 1.1 install python3
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
## 1.2 change access mode
```
chmod 755 chip_tools/creat_project
chmod 755 chip_tools/build_testbench
chmod 755 chip_tools/prun
chmod 755 chip_tools/regression
chmod 755 chip_tools/regmodel
```
## 1.3 set chip_tools to env path
edit( ~/.bashrc), add chip_tools path to $PATH 
```
export PATH="chip_tools_install_path/chip_tools:$PATH"
```

# 2 creat project
use follow command to creat project:
```
creat_project proj_name proj_path
```
if you want to creat project in current dir use command as follow:
```
creat_project proj_name
```
## 2.1 config environment
```
cd proj_path
vim sourceme
```
update the follow macro :
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
## 2.2 set project environment
```
cd proj_path
source sourceme
```
## 2.3 edit header for code file
edit file_header.txt in chip_tools dir:
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

# 3 build test bench
use build_testbench command + options as below to build project, envrionment and agent   
```
usage: build_testbench [-h] -p {ut,it,st} -n NAME [-e ENV] [-a AGT] [-m MDL]

this script for build testbench environment

optional arguments:
  -h, --help            show this help message and exit
  -p {ut,it,st}, --pos {ut,it,st}
                        where you want to create. eg:-p ut/it/st or
                        --pos=ut/it/st.
  -n NAME, --name NAME  testbench name set. eg:-n <testbench_name> or
                        --name=<testbench_name>.
  -e ENV, --env ENV     environment name you want to create. eg:-e
                        <environment_name> or --env=<environment_name>.
  -a AGT, --agt AGT     agent name you want to create. eg:-a <agent_name> or
                        --agt=<agent_name>.
  -m MDL, --mdl MDL     create reg model in env. eg:-m <regmodel_file_path> or
                        --m=<regmodel_file_path>.

the end
```     
eg:     
`build_testbench -p ut -n testbench_name -m path_to_reg_model/reg_model.sv -e env_name -a agent_name`    
notice: if set agent_name or reg_model, env_name must be set first.

# 4  create reg model from csv file
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

# 5 run case or caselist
   use prun command + options as below to run case or caselist    
   ```
  usage: prun [-h] [--comp COMP] [--sim SIM] [-d | -da] [-c] [-s SEED]
            [-rt RUNTIMES]
            case_name

   this script for run verifaction case

   positional arguments:
   case_name             the case name you want to run.

   optional arguments:
   -h, --help            show this help message and exit
   --comp COMP           compile arguments.eg:--comp 'comp_opt' or
                           --comp='comp_opt'
   --sim SIM             simulation arguments.eg:--sim 'sim_opt' or
                           --sim='sim_opt'
   -d, --dump            dump wave without array.eg: -d or --dump
   -da, --dumpall        dump wave with array data.eg:--da or --dumpall
   -c, --cov             open coverage collection.eg: -c or --cov
   -s SEED, --seed SEED  sim seed value.eg: -s seed_value or --seed=seed_value
   -rt RUNTIMES, --runtimes RUNTIMES
                           case run times.eg: -rt run_times or
                           --runtimes=run_times

   the end
   ```     
   eg:     
   `prun example_case`    