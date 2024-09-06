package load

import (
	"os"
    "log"
    "bufio"
    "strings"	
    "fmt"
)

func Loadhost(profile string) []string{
	fmt.Println("读取host列表")
	var sliceinfo []string
	sliceinfo,err := HandleTextHost(profile)
    if err != nil {
        panic(err)
    }else{
    	//没有错误时，直接把切片返回个main函数
		return sliceinfo
	}
}

func HandleTextHost(textfile string) ([]string,error) {	//返回切片和error信息
//	 fmt.Println("properties : "+textfile )
    file, err := os.Open(textfile)
    	var infoSlice []string =make([]string,6)
    if err != nil {
        log.Printf("Cannot open text file: %s, err: [%v]", textfile, err)
        return infoSlice,err
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
    
        line := scanner.Text() 
	     
	    if !strings.Contains(line, "#"){
	    	
	    	if strings.Contains(line,"admin"){
			infoSlice[0] = line
			}
	    	if strings.Contains(line,"storage"){
			infoSlice[1] = line
			}
	    	if strings.Contains(line,"client1"){
			infoSlice[2] = line
			}
	    	if strings.Contains(line,"client2"){
			infoSlice[3] = line
			}
	    	if strings.Contains(line,"client3"){
			infoSlice[4] = line
			}
	    	if strings.Contains(line,"client4"){
			infoSlice[5] = line
			}
	    }
	 }

    if err := scanner.Err(); err != nil {
        log.Printf("Cannot scanner text file: %s, err: [%v]", textfile, err)
        return infoSlice,err
    }

	return infoSlice,nil
}