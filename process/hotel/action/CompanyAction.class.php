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
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
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
        $pn = empty($objRequest->pn) ? 1 : $objRequest->pn;
        $pn_rows = $objRequest->pn_rows;

        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $parameters['module'] = encode(decode($objRequest->module));
        $arrayPageCompanyId = EmployeeService::pageEmployeeCompany($conditions, $pn, $pn_rows, $parameters);

        $arrayCompany = null;
        if(!empty($arrayPageCompanyId['list_data'])) {
            $stringCompanyId = '';
            foreach($arrayPageCompanyId['list_data'] as $k => $v) {
                $stringCompanyId .= $v['company_id'] . ',';
            }
            $stringCompanyId = trim($stringCompanyId, ',');
            $conditions['where'] = array('IN'=>array('company_id'=>$stringCompanyId));
            $arrayCompany = CompanyService::getCompany($conditions);
            foreach ($arrayCompany as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayCompany[$k]['edit_url'] = \BaseUrlUtil::Url(array('module'=>encode(\ModulesConfig::$modulesCompany['edit']), 'company_id'=>encode($arrayCompany[$k]['company_id'])));
                $arrayCompany[$k]['delete_url'] = \BaseUrlUtil::Url(array('module'=>encode(\ModulesConfig::$modulesCompany['delete']), 'company_id'=>encode($arrayCompany[$k]['company_id'])));;
            }
        }

        //设置类别

        //赋值
        $objResponse -> setTplValue("arrayCompany", $arrayCompany);
        $objResponse -> setTplValue("page", $arrayPageCompanyId['page']);
        $objResponse -> setTplValue("pn", $pn);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doEdit($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        $company_id = decode($objRequest->company_id);

        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('company_id'=>$company_id);
        $arrayCompany = CompanyService::getCompany($conditions);
        //赋值
        $objResponse -> setTplValue("arrayCompany", $arrayCompany[0]);
        $objResponse -> setTplValue("company_update_url", \BaseUrlUtil::Url(array('module'=>encode(22), 'company_id'=>encode($company_id))));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }
}