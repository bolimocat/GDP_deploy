//
package local

import (
	 "fmt"
    "os/exec"
)



//删除现有host上的版本目录，重新创建
func DropCurrentBuildFolder(host string,folder string){
	command := "./script/mkDir.sh "+host+" "+folder
	cmd := exec.Command("/bin/bash", "-c", command)

    _, err := cmd.Output()
    if err != nil {
        fmt.Printf("DropCurrentBuildFolder:%s failed with error:%s", command, err.Error())
        return
    }
}

//发送文件
func SendBuildToHost(host string,folder string,architecture string,file string){
	command := "./script/sendFile.sh "+host+" "+folder+" "+architecture+" "+file 
	cmd := exec.Command("/bin/bash", "-c", command)

    _, err := cmd.Output()
    if err != nil {
        fmt.Printf("SendBuildToHost:%s failed with error:%s", command, err.Error())
        return
    }
	
}

//发送自动化测试工具到admin节点
func SendTestToolToAdmin(host string){
	command := "./script/sendTool.sh "+host 
	cmd := exec.Command("/bin/bash", "-c", command)

    _, err := cmd.Output()
    if err != nil {
        fmt.Printf("SendTestToolToAdmin:%s failed with error:%s", command, err.Error())
        return
    }
}

//远程执行自动化测试
func ExecuteAutoTest(host string){
	command := "./script/executeAutoTest.sh "+host 
	cmd := exec.Command("/bin/bash", "-c", command)

    _, err := cmd.Output()
    if err != nil {
        fmt.Printf("SendTestToolToAdmin:%s failed with error:%s", command, err.Error())
        return
    }
}

//在远程主机上安装代理
func InstallOnHost(role string,host string,path string,file string,aio string){
	command := "./script/install-agent.sh "+role+" "+host+" "+path+" "+file+" "+aio
	fmt.Printf("== InstallOnHost == : "+command+" !\n")
	cmd := exec.Command("/bin/bash", "-c", command)

    _, err := cmd.Output()
    if err != nil {
        fmt.Printf("InstallOnHost_error:%s failed with error:%s", command, err.Error())
        return
    }
	
}

