<?php
return array(
	//'配置项'=>'配置值'
		// 添加数据库配置信息
		'DB_TYPE'   => 'mysql', // 数据库类型
		'DB_HOST'   => 'localhost', // 服务器地址
		'DB_NAME'   => 'dc_oss', // 数据库名
		'DB_USER'   => 'root', // 用户名
		'DB_PWD'    => '', // 密码
		'DB_PORT'   => 3306, // 端口
		'DB_PREFIX' => 'dc_', // 数据库表前缀

		'KEY_ID'    => '*********',  // 阿里云oss key_id
		'KEY_SECRET'  => '**********',  // 阿里云oss key_secret
		//上面的内容设计隐私，所以要隐藏掉
		'END_POINT'   => 'http://oss-cn-beijing.aliyuncs.com',  // 阿里云oss endpoint
		'END_BUCKET'  => 'aliyunapi',//bucket 名字
		'END_WINDOS'  => 'C:/Users/C:/Users/10852/Desktop/',
		//终端窗口

);
?>