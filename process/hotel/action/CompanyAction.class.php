<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class CompanyAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'hotelSetting';
        $objResponse -> setTplValue('navigation', 'hotelSetting');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'register':
                $this->employee_register($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        //赋值
        //设置类别

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/company");
    }

    protected function excuteModule($objRequest, $objResponse) {
        $module = $objRequest->module;
        $module = '\hotel\\' . ucwords($module) . 'Action';
        $action = $objRequest->action;;
        //if(isset($_REQUEST['action']))
        //    $action = $_REQUEST['action'];
        $objAction = new $module();
        $objAction->execute($action);
    }
}