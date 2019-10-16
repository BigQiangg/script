#!/bin/sh

user=$LOGNAME

workname="app-iv3"
basepath=`pwd`
path="$basepath/$workname"
path_log="$basepath/gitlog"
time=`date "+%Y-%m-%d"`
file_log=$path_log/$time.log
commitText="$basepath/commit.txt"

#提交代码的文字描述
if [ -z "$1" ]; then
    echo 代码优化 > $commitText
else
    echo $1 > $commitText
    echo "参数测试："$1
fi

#创建文件夹
mkdir $path_log
cd $path 


#测试用的一句话
#git add . 


echo "**************************"`date "+%Y-%m-%d %H:%M:%S"`"*************************" >>  $file_log
echo $gitstatus  >> $file_log

branch=`git branch` 
# #获Git取版本号
branch=${branch##*\* }
branch=${branch%% *}
echo $branch >> $file_log


function upload(){
	echo "正在提交本地缓存"

		addinfo=`git add .`
		echo "add "$addinfo >> $file_log

		text=$(cat $commitText)
		commitinfo=`git commit -m \"$text\"`
		echo "commit "$commitinfo >> $file_log

		pullinfo=`git pull origin $branch`
		echo "pull "$pullinfo >> $file_log

		pushinfo=`git push origin $branch`
		echo "push "$pushinfo >> $file_log
}

gitstatus=`git status`
#判断是否有改动
if [[ $gitstatus == *nothing* ]];then 

echo "没有改动,不用提交" >> $file_log
# 拉取最新代码
pullinfo=`git pull origin $branch`
echo "pull "$pullinfo >> $file_log

#log_content=$(cat $file_log);
#echo $log_content;
#echo "没有改动,未提交"$log_content | mail -s "关机前自动提交" 571848788@qq.com
else
echo "正在上传" >> $file_log
upload;
#log_content=$(cat $file_log);
#echo $log_content;
#echo "提交成功"$log_content | mail -s "关机前自动提交" 571848788@qq.com
fi


