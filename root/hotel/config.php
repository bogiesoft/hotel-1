<?php
if( !defined('CONFIG_PHP') ){
define('CONFIG_PHP','YES');
///close web
define('__CLOSE_WEB', false);
//web  
define('__WEB_KEY','localhost');
define('__KEY','xyzABcdeee12345');
define('__WEB','http://dev.hotel.cn/');
define('__RESOURCE','http://dev.hotel.cn/resource/');

define('__WWW_PATH',dirname(__FILE__) . '/');
define('__WWW_PATH_CONFIG',__WWW_PATH.'config/');
define('__HTML', __WWW_PATH.'static/');
define('__HTML_WEB', 'http://dev.hotel.cn/static/');

//images
define('__DEFAULT_PATH',__WWW_PATH);
define('__DEFAULT_IMG',__WWW_PATH.'data/images/');
define('__IMGWEB','http://dev.hotel.cn/data/images/');

define('__XML_PATH',__WWW_PATH);
define('__XML',__XML_PATH.'data/xml/');
define('__XMLWEB','http://dev.hotel.cn/data/xml/');

define('__USER_DATA_PATH',__WWW_PATH);
define('__USER_DATA',__USER_DATA_PATH.'data/userdata/');
define('__USER_IMG',__USER_DATA_PATH.'data/userimg/');
define('__USER_IMGWEB','http://dev.hotel.cn/data/userimg/');//

/// cache physical path ///
define('__CACHE',__WWW_PATH.'cache/');
define('__CACHE_FILE',__CACHE.'filecache/');
define('__USER_CACHE',__CACHE.'user/');
define('__WWW_LOGS_PATH',__CACHE.'logs/');
define('__CRAWL',__CACHE . 'crawl/');
define('__ETAG', false);

//data path, web url 
define('__DATA_PATH', __WWW_PATH);
define('__DATA', __DATA_PATH.'data/');
define('__SQLITE_DATA', __DATA_PATH.'data/sqlite/');
define('__IMG_DATA', __DATA.'images/');

// style
define('__COMPILE', true);

/// db connection ///
define('__DEFAULT_DSN','mysqli://root:@127.0.0.1:3306/hotel');

//debug
define('__Debug',true);
require_once ("../../etc/define.php");
}
?>