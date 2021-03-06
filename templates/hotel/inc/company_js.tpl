<!--<script src="<%$__RESOURCE%>js/jquery.ui.custom.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap.min.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-colorpicker.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-datepicker.js"></script>
<script src="<%$__RESOURCE%>js/jquery.uniform.js"></script>
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<script src="<%$__RESOURCE%>js/maruti.js"></script>
<script src="<%$__RESOURCE%>js/maruti.form_common.js"></script>-->
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<%include file="hotel/inc/location_js.tpl"%>
<script type="text/javascript">
	var longitude = "<%$arrayCompany['company_longitude']%>";
	var latitude = "<%$arrayCompany['company_latitude']%>";
	var map = new BMap.Map("allmap");
	
	longitude = longitude == '' ? 121.480174 : longitude;
	latitude = latitude == '' ? 31.236428 : latitude;
	var point = new BMap.Point(longitude, latitude);
	map.centerAndZoom(point,18);
	
	var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	
	function myLocation(result){
		var cityName = result.name;
		map.setCenter(cityName);
		//alert("当前定位城市:"+cityName);
	}
	if(longitude == '121.480174' || latitude == '31.236428') {
		var myCity = new BMap.LocalCity();
		myCity.get(myLocation);
	}
	
	function theLocation(){
		var city = document.getElementById("company_address").value;
		if(city != ""){
			map.centerAndZoom(city,18);      // 用城市名设置地图中心点
		}
	}
	
	function G(id) {
		return document.getElementById(id);
	}
	
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "company_address"
		,"location" : map
	});
	
	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});
	
	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		setPlace();
	});

	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function mySetMap(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			marker = new BMap.Marker(pp);
			marker.enableDragging();
			map.addOverlay(marker);    //添加标注
			//alert(pp.lng lat);
			$('#company_longitude').val(pp.lng);
			$('#company_latitude').val(pp.lat);
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: mySetMap
		});
		local.search(myValue);
		$('#company_address').val(myValue);
	}	

</script>
<script language="javascript">
$(document).ready(function(){
	// Form Validation
    $("#company_form").validate({
		rules:{
			company_name:{
				required:true
			},
			company_province:{
				required:true
			},
			company_mobile:{
				required:true,
				number:true,
				isMobile:true
			},
			company_address:{
				required:true,
				minlength:5,
			}
		},
		messages: {
			company_name:"请输入公司名称",
			company_town:"请选择所在位置",
			company_mobile:"请输入正确移动电话号码",
			company_address:"请输入公司地址"
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
	});
	$('#company_address').val('<%$arrayCompany['company_address']%>');

	
});
</script>