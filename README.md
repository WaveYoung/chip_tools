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
```
## set project environment
```
cd proj_path
source sourceme
```