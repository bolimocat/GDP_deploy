package main

import (
	"fmt"
	"strings"
	load "GDPdeploy/load"
	local "GDPdeploy/local"
)

func main(){
	fmt.Println("GDP Agent auto deployed on Host")
	
	var architecture string
	var admin_file string
	var backend_file string
	var client_file string
	var admin_path string
	var backend_path string
	var client_path string
	var aio string
	var host_list string
	var path_list string
	var file_list string
	
	var properties_info []string = load.Loadproperties("file/properties")
	for i,value := range properties_info{
		if i == 0 {
			architecture = strings.Split(value,":")[1]
			fmt.Println("==== architecture : "+architecture)
		}
		if i == 1 {
			admin_file = strings.Split(value,":")[1]
			fmt.Println("==== admin_file : "+admin_file)
		}
		if i == 2 {
			backend_file = strings.Split(value,":")[1]
			fmt.Println("==== backend_file : "+backend_file)
		}
		if i == 3 {
			client_file = strings.Split(value,":")[1]
			fmt.Println("==== client_file : "+client_file)
		}
		if i == 4 {
			admin_path = strings.Split(value,":")[1]
			fmt.Println("==== admin_path : "+admin_path)
		}
		if i == 5 {
			backend_path = strings.Split(value,":")[1]
			fmt.Println("==== backend_path : "+backend_path)
		}
		if i == 6 {
			client_path = strings.Split(value,":")[1]
			fmt.Println("==== client_path : "+client_path)
		}
		if i == 7 {
			aio = strings.Split(value,":")[1]
			if aio == "0" {
				fmt.Println("deploy not AIO ")
			}
			if aio == "1" {
				fmt.Println("deploy AIO ")
			}
			
		}
		
	}
	
	var admin_host string
	var storage_host string
	var client1_host string
	var client2_host string
	var client3_host string
	var client4_host string
	
	var host_info []string = load.Loadhost("file/host_list")
	for i,value := range host_info{
		if i == 0 {
			admin_host = strings.Split(value,":")[1]
			fmt.Println("==== admin_host : "+admin_host)
			host_list = admin_host
		}
		if i == 1 {
			if aio == "1" {
				storage_host = admin_host
				fmt.Println("==AIO== storage_host : "+storage_host)
				host_list = admin_host+":"+admin_host
			}else{
				storage_host = strings.Split(value,":")[1]
				fmt.Println("==NORMAL== storage_host : "+storage_host)
				host_list = admin_host+":"+storage_host
			}
			
		}
		if i == 2 {
			client1_host = strings.Split(value,":")[1]
			fmt.Println("==== client1_host : "+client1_host)
		}
		if i == 3 {
			client2_host = strings.Split(value,":")[1]
			fmt.Println("==== client2_host : "+client2_host)
		}
		if i == 4 {
			client3_host = strings.Split(value,":")[1]
			fmt.Println("==== client3_host : "+client3_host)
		}
		if i == 5 {
			client4_host = strings.Split(value,":")[1]
			fmt.Println("==== client4_host : "+client4_host)
		}
		
	}
	
	//删除现有目标host上的版本文件
	if admin_host == "null" {
		fmt.Println("current do not update GDP Server")
	}else{
		fmt.Println("remove the old admin path")
		local.DropCurrentBuildFolder(admin_host,admin_path);
		fmt.Println("send file to the new admin path")
		local.SendBuildToHost(admin_host,admin_path,architecture,admin_file)
		if strings.Contains(architecture,"arm"){
			local.SendBuildToHost(admin_host,admin_path,architecture,"arm64-docker-images-gdp-20240229.tar.bz2")
		}
		if strings.Contains(architecture,"x86"){
			local.SendBuildToHost(admin_host,admin_path,architecture,"docker-images-gdp-20240426.tar.bz2")
		}
	}
	if aio == "1" {
			fmt.Println("AIO that do not need send the backend")
	}else{
		fmt.Println("remove the old backend path")
		local.DropCurrentBuildFolder(storage_host,backend_path);
		fmt.Println("send file to the new backend path")
		local.SendBuildToHost(storage_host,backend_path,architecture,backend_file)
	}
	
	if client1_host == "null" { 
		fmt.Println(" == do not need client1")
	}else{
		local.DropCurrentBuildFolder(client1_host,client_path);
		fmt.Println("send client1 file")
		local.SendBuildToHost(client1_host,client_path,architecture,client_file)
		host_list = admin_host+":"+storage_host+":"+client1_host
	}
	
	if client2_host == "null" { 
		fmt.Println(" == do not need client2")
	}else{
		local.DropCurrentBuildFolder(client2_host,client_path);
		fmt.Println("send client2 file")
		local.SendBuildToHost(client2_host,client_path,architecture,client_file)
		host_list = admin_host+":"+storage_host+":"+client1_host+":"+client2_host
	}
	if client3_host == "null" { 
		fmt.Println(" == do not need client3")
	}else{
		local.DropCurrentBuildFolder(client3_host,client_path);
		fmt.Println("send client3 file")
		local.SendBuildToHost(client3_host,client_path,architecture,client_file)
		host_list = admin_host+":"+storage_host+":"+client1_host+":"+client2_host+":"+client3_host
	}
	if client4_host == "null" { 
		fmt.Println(" == do not need client4")
	}else{
		local.DropCurrentBuildFolder(client4_host,client_path);
		fmt.Println("send client4 file")
		local.SendBuildToHost(client4_host,client_path,architecture,client_file)
		host_list = admin_host+":"+storage_host+":"+client1_host+":"+client2_host+":"+client3_host+":"+client4_host
	}
	

	path_list = admin_path+":"+backend_path+":"+client_path
	file_list = admin_file+":"+backend_file+":"+client_file
	
//	//在远程主机上安装所有代理
	fmt.Println("Install agent ... ...")
	local.InstallOnHost(architecture,host_list,path_list,file_list,aio)

	fmt.Println("\n Deploy over")
	

}
