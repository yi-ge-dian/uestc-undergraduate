 <?php
import("ORG.Net.UploadFile");//引入thinkphp框架的文件上传类
class UpyunAction extends Action {
	
	// 文件上传

	public function OSSupload(){
		$upload = new UploadFile();// 实例化上传类
        $upload->maxSize=52428800;// 设置附件上传大小
        $upload->savePath= 'Uploads/'.date("ymd",time())."/"; // 设置附件上传目录
        $saveName = time().rand(0000,9999);
        $upload->saveName = $saveName;
            
        // 上传文件 
        if($upload->upload()){
            $info = $upload->getUploadFileInfo();
            $extension = $info[0]['extension'];
            $savename = $info[0]['savename'];
            $savepath = $info[0]['savepath'];
            $filename = $savepath.$savename;
			$this->success(["houzhui"=>$extension,'savename'=>$savename,"url"=>$filename]);
        }else{
			$this->error($upload->getError());
        }
	}


}