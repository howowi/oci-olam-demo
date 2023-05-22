# Oracle Linux Automation Manager (OLAM) HOL

### **Introduction**
Oracle Linux Automation Manager (OLAM) is a task engine and Web interface based on AWX project for scheduling and running Ansible playbook tasks on the inventories the playbooks interact with. The Oracle Linux Automation Engine (Ansible Engine) is an automation tool for deploying software, configuring systems, and orchestrating tasks such as upgrades and updates, in the form of playbooks.

This lab covers the core functionalities of Oracle Linux Automation Manager.

### **Lab instructions**

### (a) Create a Gitlab project for OLAM

1. Login to Gitlab http://129.150.61.205/users/sign_in with your allocated credentials.
2. Reset the password.
3. After logging in, press `New Project` and select `Create blank project`. 

    ![image](img/create-project.png)

4. Input Project name `<user>-olam` eg. user10-olam and press `Create project`. Uncheck the box for `Initialize repository with a README`.
5. Go back to OCI Console. Access Code Editor.

    ![image](img/code-editor.png)

6. Open a new Terminal session.

    ![image](img/terminal.png)

7. Configure git. Change the values accordingly.
    ```
    git config --global user.name "user10"
    git config --global user.name "user10@oracle.com"
    git config --global credential.helper store
    ```
8. Clone the files for OLAM project
    ```
    git clone http://129.150.61.205/user10/olam-hol.git
    ```
9. Push the files to your Gitlab project created previously.
    ```
    cd olam-hol/
    git remote rename origin old-origin
    git remote add origin <your repo url>
    git push -u origin --all
    ```
10. Modify the `compartment_name` in the `inventory.oci.yml` file. Save it.

    ![image](img/compartment-inventory.png)

11. Commit the change and push it to your repo.

    ![image](img/code-editor-commit.png)

### (b) Provision a VM

1. Type `instances` on the search bar of OCI Console and click on `instances`.
2. Make sure you're in your own compartment. Eg. user10
3. Press `Create instance` and apply the following config.

    - Name: `webserver`
    - Shape: `VM.Standard.E4.Flex`, `1 OCPU`, `4GB RAM`
    - Networking:
        
        - Virtual cloud network: Change the compartment to `common_services` and select `common_svc_vcn`
        - Subnet: Change the compartment to `common_services` and select `public subnet-common_svc_vcn`
    
    - SSH Key: `Generate a key pair for me`. Save private and public key.
    - Tagging:

        - Press `Show advanced option` 
        - Tag key: `app`
        - Tag value: `webserver`

4. Press `Create`.


### (c) Set up OLAM Credentials

1. Login to OLAM https://168.138.184.36/#/login with your allocated credentials.

    ![image](img/olem-login.png)

2. On the left pane, press `Credentials` and press `Add`.
3. We'll need to create 3 credentials for Source Control, Oracle Cloud Infrastructure and Machine.
    
    a. Source Control
    
    - Name: `gitlab`
    - Credential Type: `Source Control`
    - Username: `<your gitlab username>`
    - Password: `<your gitlab password>`
    
    b. Oracle Cloud Infrastructure
    
    - Name: `OCI`
    - Credential Type: `Oracle Cloud Infrastructure`
    - User OCID: `ocid1.user.oc1..aaaaaaaa3lwy5xxkl3qtgkbbcnly3bdwaszrsasnn26akgdnh7d7mxh3va4q`
    - Fingerprint: `90:6a:95:26:8a:a6:05:8d:9e:96:b7:26:a7:d2:93:e9`
    - Tenant OCID: `ocid1.tenancy.oc1..aaaaaaaaaekoeezags6xaw66xa7x7xqzqxisxk3m5yxlkthrw5fjhm6rx6sq`
    - Region: `ap-singapore-1`
    - Private User Key:
        ```
        -----BEGIN PRIVATE KEY-----
        MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDSIbO+MG76VROl
        O8jzZF/vMgu8Ux1fnfTDKK4kdRycKhNxl0bh/GNNYJMVAEZYJBLRYzRTmTCNrqdL
        UPPXC5FGDO54xFfAeaWWg8RWY0onyENCHe3oPIP2MzOx9Ttq54U3YEfgrgGwL3Xh
        rvbijk7l5bqmbVjzwa1yiy8qTnQDufP7m71RBP1TWeK8tfcBwG5yDZPiTDUDkqn+
        mVpMEqEVscnkVrfhPPCumMScYnx8pgmNCKljUe1RO7vXpjPFJIhuEcse1YybbrIO
        5YaszKTPSCdB8XLF5UmxDA0NokdLRYeb88Nkl1TfbmMlcbiH0QxYfgk+//6tFnCG
        XE7/0R2RAgMBAAECggEAN33U9MXfmNY80Obf436/YvCJbttYJ3cUOzGUA2a1/nuS
        FO5JNsarBrUZQnOHICGuooMbP3R2AQR9g4NGUaTpYWFq3JOlRNwbIYt8nv+rhqP5
        Nw2mVS0eADd3UGidn1aytHQFp0zsfzWZYNcOtbe1GDs5tlesJPshrd0ZwIdlVdIc
        AhL39LSsmmLRwxrBSz0FTEdPrMv11Kjw8aWdMl02Kocp+iG6QJjYUQPKzdICfFZ/
        5DdZPrnPgM0R9kSxOojMSu045MfYAP12qSlBTaV2oi0P5YSLiMzWz9JLCG9xa18v
        cQodeEFRCk3bWRmJB+6KIs1iYgEnjjZtHGlr4fXaDQKBgQDeIDG/AURlZmBcoWcD
        ZxEL6IWg1UO7JhX1lxWOFLlMc9+97V2+ihcIgmxEsYlxDBsEgW7+3CEG5Yf/TUO9
        P5Mxoj98rgNDUqhOU87NIsUl7Yc40vhvvmwZsccm++Tg8aJDK1ktjs1XpiuwGbLv
        8L8FKenUI29/4DZpMl5JLtEHlwKBgQDyLUHCcIV7MwWfC+6jDHkXZ970dFvJ1bH9
        gtOs263A+GvIwvvtOKGgQeLtrXNCKe18FA68Uke/99C/G/wF6L7mabNV0lyfF+k6
        rLKbjs95rjWEvPpEswHakLbivsQh1nS8Q50yJfpeUnAC84hv2QhxKNE4ceGATbnU
        59PVGgfpFwKBgE9WUG5YlYViO6jaPWEJvxzxwEjh439E6zL888X7wPN9r7y2u3UC
        /Zccfm9KujyWhk/lqy98kI9WDG0zu64stvZTbTmrLZ8uNs9DP+olMSWK4XF6aSIA
        cbv7s5ZJAkcWB07WfNO43b8gqxoLE85/vrqpbctHnNufyc9pHiQlhKOhAoGBANED
        9HSPzvTE1X4uuzjoQ/7KfGg5oRrzH9qwNmdDdpRNFCHC/9H/BageFXCTOh4Jt9lW
        Kl2pGhn6FaVLztl+xnxxEAHrPFtnNLmaYdDWkgTwMWqt+8adROVR7zaF9RtLT5dJ
        N/wXQR51Qg2aCNCX3axk0SZJS5oD+3Zg27hZ7ifjAoGBANBu5B4hMQRQbSDb3n/f
        LrJ7rir7rorffSImYytZIu/CaKJyRLF9IiqxawOnclrAN1rlT0sCmBsyZQQkNCYn
        pgvDwUypOU59RAyUd2nY3TP30+peOJwaIbSRBTlcHZ/OWjaawDyN3SnqIAeg+PN+
        HI00QZ1S0AO1uf/b0xEwu4M/
        -----END PRIVATE KEY-----
        ```
    c. Machine
    
    - Name: `SSH_Key`
    - Username: `opc`
    - SSH Private Key: Drag the private key saved in section (b).
    - Privilege Escalation Method: `sudo`
    - Privilege Escalation Username: `root`

### (d) Set up OLAM Project

1. On the left pane, press `Projects` and press `Add`.
2. Apply the following config and press `Save`.

    - Name: `Webserver Config`
    - Source Control Credential Type: `Git`
    - Source Control URL: `<your gitlab repo URL>`
    - Source Control Branch/Tag/Commit: `main`
    - Source Control Credential: `gitlab`

### (e) Set up Inventories

1. On the left pane, press `Inventories` and press `Add`, `Add inventory`.
2. Apply the following config and press `Save`.

    - Name: `OCI Instances`

3. On the details page, press `Sources` and press `Add`.
4. Apply the following config and press `Save`.

    - Name: `OCI`
    - Source: `Sourced from a Project`
    - Credential: `OCI`
    - Inventory file: `inventories/inventory.oci.yml`
    - Update options: check `Update on project update`

5. The inventory will be auto-synced. Press `Hosts` and you will see the webserver.

### (f) Set up Template and run config tasks

1. We will be creating 2 job template and a workflow template.
2. On the left pane, press `Templates` and press `Add`, `Add job template`.
3. Apply the following config and press `Save`.

    a. Check Linux Distribution
    
    - Name: `Check Linux Distribution`
    - Inventory: `OCI Instances`
    - Playbook: `playbooks/check_distribution.yml`
    - Credentials: `SSH_Key`
    - Options: check `Privilege Escalation`

    b. Install Packages

    - Name: Install Packages
    - Inventory: `OCI Instances`
    - Playbook: `playbooks/main.yml`
    - Credentials: `SSH_Key`
    - Variables: 
    ```yml
    ---
    services:
      - httpd
    
    utilities:
      - telnet
      - curl

    ports:
    - '80/tcp'
    - '8080/tcp'
    ```
    - Options: check `Privilege Escalation`

2. On the `Templates` page, press `Add`, `Add workflow template`.
3. Apply the following config and press `Save`.

    c. Config Webserver

    - Name: `Config Webserver`

4. On the worklow template page, press `Start`, apply the following config and press `Save`.

    - Node Type: `Job Template`
    - Select `Check Linux Distribution`

5. Hover to the `Check Linux Distribution` box, press the `"plus"` button to add another stage.

    ![image](img/add-stage.png)

6. Select `On Success` and press `Next`.
7. Apply the following config and press `Save`.

    - Node Type: `Job Template`
    - Select `Check Linux Distribution`

8. Press `Save` on the top right corner.

9. On the details page, press `Launch` to run the config tasks.
10. When the jobs are completed, key in the public IP address of the webserver to verify the config.

    ![image](img/webserver.png)
