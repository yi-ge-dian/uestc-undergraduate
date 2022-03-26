<?php

require_once '/ThinkPHP/Extend/Vendor/oss-php/autoload.php';
use OSS\OssClient;
use OSS\Core\OssException;

class IndexAction extends Action {
    public function index(){
        $this->display();
    }
    //展示文件
    public function getlist(){
    	$accessKeyId = C("KEY_ID");
		$accessKeySecret = C("KEY_SECRET");
		$endpoint = C("END_POINT");
		$bucket= C("END_BUCKET");
	    $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
		    try {
		        $options = array(
		            'delimiter' => '',
		            'marker' => '',
		        );
		        $listObjectInfo = $ossClient->listObjects($bucket, $options);
		    } catch (OssException $e) {
		        printf(__FUNCTION__ . ": FAILED\n");
		        printf($e->getMessage() . "\n");
		        return;
		    }
		    // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表。
		    $list = [];
		    $nextMarker = $listObjectInfo->getNextMarker();
		    $listObject = $listObjectInfo->getObjectList();
		    $listPrefix = $listObjectInfo->getPrefixList();
		    if (!empty($listObject)) {
            foreach ($listObject as $objectInfo) {
                $list[] = ["name"=>$objectInfo->getKey()];
            }
        }
        $res=array("code"=>0,"msg"=>"","count"=>count($list),"data"=>$list);
        return $this->ajaxReturn($res,'JSON');
    }
    //上传文件
    public function add(){
    	if(IS_POST){
    		$accessKeyId = C("KEY_ID");
            $accessKeySecret = C("KEY_SECRET");
            $endpoint = C("END_POINT");
            $bucket = C("END_BUCKET");

 			$object = $_POST["name"];//上传文件名
            $filePath = "./".$_POST["url"];//本地文件地址
            try{
			    $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);

			    $ossClient->uploadFile($bucket, $object, $filePath);
			    $this->success("操作成功");
			} catch(OssException $e) {
			    printf(__FUNCTION__ . ": FAILED\n");
			    printf($e->getMessage() . "\n");
			    $this->error('操作失败');
			    return;
			}

    	}else{
            $this->display();
        }
    }
    //下载文件
     public function xiazai(){
            $accessKeyId = C("KEY_ID");
            $accessKeySecret = C("KEY_SECRET");
            $endpoint = C("END_POINT");
            $bucket = C("END_BUCKET");
            //下载OSS文件时需要指定的文件路径
            $object = $_GET["name"];
            //本地指定的文件路径加文件名包括后缀组成
            $localfile = C("END_WINDOS").$_GET["name"];
            $options = array(
                OssClient::OSS_FILE_DOWNLOAD => $localfile
            );
            try{
                $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
                $ossClient->getObject($bucket, $object, $options);
            } catch(OssException $e) {
                printf(__FUNCTION__ . ": FAILED\n");
                printf($e->getMessage() . "\n");
                return;
            }
            // 使用try catch捕获异常，如果捕获到异常，则说明下载失败；如果没有捕获到异常，则说明下载成功。
            print(__FUNCTION__ . ": OK, The file has been downloaded to the desktop！！！" . "\n");

    }
    //删除文件
    public function del(){
        $accessKeyId = C("KEY_ID");
        $accessKeySecret = C("KEY_SECRET");
        $endpoint = C("END_POINT");
        $bucket = C("END_BUCKET");

        $object = $_GET["name"];
        try{
            $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
            $ossClient->deleteObject($bucket, $object);
            $this->success('删除成功');
        } catch(OssException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            $this->error('删除失败');
            return;
        }
    }
    //重命名文件
     public function edit(){
        if (IS_POST) {
            $accessKeyId = C("KEY_ID");
            $accessKeySecret = C("KEY_SECRET");
            $endpoint = C("END_POINT");
            $bucket = C("END_BUCKET");
            $url = './Uploads/'.date("ymd",time())."/".time().rand(0000,9999);
            $options = array(
                OssClient::OSS_FILE_DOWNLOAD => $url
            );
            try{
                $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);

                $ossClient->getObject($bucket, $_POST["sname"], $options);
                $ossClient->deleteObject($bucket, $_POST["sname"]);
                $ossClient->uploadFile($bucket, $_POST["name"], $url);
                $this->success("操作成功");
            } catch(OssException $e) {
                printf(__FUNCTION__ . ": FAILED\n");
                printf($e->getMessage() . "\n");
                $this->error('操作失败');
                return;
            }
        }else{
            $this->name = $_GET["name"];
            $this->display();
        }
    }	

    
}
