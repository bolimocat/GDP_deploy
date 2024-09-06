package load

import (
	"os"
    "log"
    "bufio"
    "strings"	
    "fmt"
)

func Loadproperties(profile string) []string{
	fmt.Println("读取配置文件")
	var sliceinfo []string
	sliceinfo,err := HandleTextProperties(profile)
    if err != nil {
        panic(err)
    }else{
    	//没有错误时，直接把切片返回个main函数
		return sliceinfo
	}
}

func HandleTextProperties(textfile string) ([]string,error) {	//返回切片和error信息
//	 fmt.Println("properties : "+textfile )
    file, err := os.Open(textfile)
    	var infoSlice []string =make([]string,8)
    if err != nil {
        log.Printf("Cannot open text file: %s, err: [%v]", textfile, err)
        return infoSlice,err
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
    
        line := scanner.Text() 
	     
	    if !strings.Contains(line, "#"){
	    	
	    	if strings.Contains(line,"architecture"){
			infoSlice[0] = line
			}
	    	if strings.Contains(line,"admin_file"){
			infoSlice[1] = line
			}
	    	if strings.Contains(line,"backend_file"){
			infoSlice[2] = line
			}
	    	if strings.Contains(line,"client_file"){
			infoSlice[3] = line
			}
	    	if strings.Contains(line,"admin_path"){
			infoSlice[4] = line
			}
	    	if strings.Contains(line,"backend_path"){
			infoSlice[5] = line
			}
	    	if strings.Contains(line,"client_path"){
			infoSlice[6] = line
			}
			if strings.Contains(line,"aio"){
			infoSlice[7] = line
			}
	    }
	 }

    if err := scanner.Err(); err != nil {
        log.Printf("Cannot scanner text file: %s, err: [%v]", textfile, err)
        return infoSlice,err
    }

	return infoSlice,nil
}