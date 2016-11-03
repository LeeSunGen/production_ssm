<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/jsp/common_js.jsp"%>
<%@ include file="/WEB-INF/jsp/common_css.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生产管理系统首页</title>
<style type="text/css">
.content {
	padding: 10px 10px 10px 10px;
}
.divNorth{
	background:url('image/TitleBackground.jpg') no-repeat center center;
	background-size:100% 100%;
}
</style>
</head>
<body class="easyui-layout">

	<!-- North Title -->
	<div class="divNorth" style="height:100px;" data-options="region:'north'" >
		<table id="_TableHeader" width="100%" border="0" cellpadding="0"
		cellspacing="0" class="bluebg">
		<tbody>
			<tr>
				<td valign="top">
					<div style="position:relative;">
						<div style="text-align:right;font-size:15px;margin:2px 0 0 0;">
							<span style="display:inline-block;font-size:20px;color:#c1dff7;margin:0 0 8px 0;">华侨大学计算机科学与技术学院</span>
							<br />
							
							</span><span style="color:#c1dff7;">${activeUser.rolename}:</span><span style="color:#c1dff7;">${activeUser.username}</span>
						    &nbsp;<a href="logout" style="text-decoration:none;color:#A9C3D6;"> 退出</a>&nbsp;  &nbsp; 
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<!-- <div data-options="region:'west',title:'功能菜单',split:true"
		style="width:213px;"> -->
	<div id="HomeFuncAccordion" class="easyui-accordion" style="width:213px;"
		data-options="region:'west',title:'功能菜单',split:false">
		<div title="功能搜索"
			data-options="iconCls:'icon-search',collapsed:false,collapsible:false"
			style="padding:10px;">
			<input id="HomeFuncSearch" class="easyui-searchbox" 
				data-options={prompt:'请输入想要搜索的功能'}
				searcher="doSearch" 
				style="width:178px;height:25px;">
			<!---------------------------------------------------->
			<!-- http://www.jeasyui.net/demo/408.html#  ExpandTo-->
			<!---------------------------------------------------->
		</div>

		<div title="计划进度" style="padding:10px;">

			<ul id="scheduleMonitor" class="easyui-tree"
				data-options="animate:true,lines:true">
				<li><span>计划进度</span>
					<ul>
						<li id=11 data-options="attributes:{'url':'order/find'}">订单管理</li>
					</ul>
					<ul>
						<li id=12 data-options="attributes:{'url':'custom/find'}">客户管理</li>
					</ul>
					<ul>
						<li id=13 data-options="attributes:{'url':'product/find'}">产品管理</li>
					</ul>
					<ul>
						<li id=14 data-options="attributes:{'url':'manufacture/find'}">生产计划管理</li>
					</ul>
				</li>
			</ul>

		</div>

		<div title="设备台账" data-options="selected:true" style="padding:10px">

			<ul id="deviceMonitor" class="easyui-tree"
				data-options="animate:true,lines:true">
				<li><span>设备台账</span>
					<ul>
						<li id=21 data-options="attributes:{'url':'device/deviceList'}">设备台账</li>
						<li id=22 data-options="attributes:{'url':'device/deviceType'}">设备种类</li>
						<li id=23 data-options="attributes:{'url':'device/deviceCheck'}">设备例检</li>
						<li id=24 data-options="attributes:{'url':'device/deviceFault'}">设备故障</li>
						<li id=25 data-options="attributes:{'url':'device/deviceMaintain'}">设备维修</li>
					</ul></li>
				<li><span>测试</span>
					<ul>
						<li id=31 data-options="attributes:{'url':'device/test'}">试测</li>
					</ul></li> 
			</ul>

		</div>

		<div title="工艺监控" style="padding:10px">
			<p>~。~</p>
		</div>
		
		<c:if test="${activeUser.rolename == '超级管理员' }">
			<div title="系统管理" style="padding:10px;">
	
				<ul id="sysManager" class="easyui-tree"
					data-options="animate:true,lines:true">
					<li><span>系统管理</span>
						<ul>
							<li data-options="attributes:{'url':'user/find'}">用户管理</li>
						</ul>
						<ul>
							<li data-options="attributes:{'url':'role/find'}">角色管理</li>
						</ul>
					</li>
				</ul>
			</div>
		</c:if>
	</div>

	<!-- </div> -->
	<div data-options="region:'center',title:''">
		<div id="tabs" class="easyui-tabs">
			<div title="首页" style="padding:20px;"></div>

		</div>

	</div>
	
	<script type="text/javascript">

		var allItem = [
						["计划进度", "订单管理","客户管理","产品管理","生产计划管理"], 
						["设备台账", "设备台账","设备种类","设备例检","设备故障","设备维修"],
						["测试","试测"]
					  ];
					  
		/* var allNodeArray = new Array();
		for(var i = 0; i < allItem.length; i++){
			allNodeArray[i]=new Array();
			for(var j = 0;j < allItem[i].length;j++){
				allNodeArray[i][j] = allItem[i][j];
			}
		}  */
			
		function isContains(str, substr) {
		    return new RegExp(substr).test(str);
		}
		
		//HomeFuncSearch
		function doSearch(value){
			var subItem;
			var ifElseContain = false;
			for (var i = 0; i < allItem.length; i++) {
				for (var j = 0; j < allItem[i].length; j++) {
					subItem = allItem[i][j];
					if(isContains(subItem,value) && value!=""){
						ifElseContain=true;
						if(j==0){
							switch(i){
								case 0 : 
									$('#HomeFuncAccordion').accordion('select',allItem[0][0]);
									var node = $('#scheduleMonitor').tree('find',11);
									$('#scheduleMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 1 :
								case 2 :
									var node = $('#deviceMonitor').tree('find',21);
									$('#deviceMonitor').tree('expandTo', node.target).tree('select', node.target);
									$('#HomeFuncAccordion').accordion('select',allItem[1][0]);
									break;
								default:
									break; 
							}
						}else if(j>0){
							var k = (i+1)*10+j;
							switch(i){
								case 0 : 
									$('#HomeFuncAccordion').accordion('select',allItem[0][0]);
									var node = $('#scheduleMonitor').tree('find',k);
									$('#scheduleMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 1 :
								case 2 :
									$('#HomeFuncAccordion').accordion('select',allItem[1][0]);
									var node = $('#deviceMonitor').tree('find',k);
									$('#deviceMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								default:
									break; 
							}
							
						}
						break;
					}
				}
				if(ifElseContain==true){
					break;
				}
			}
		}  
		
		$(function() {
			/* Schedule Manager Tree onClick Event */
			$('#scheduleMonitor').tree({
				onClick : function(node) {
					if ($('#scheduleMonitor').tree("isLeaf", node.target)) {
						var tabs1 = $("#tabs");
						var tab1 = tabs1.tabs("getTab", node.text);
						if (tab1) {
							tabs1.tabs("select", node.text);
						} else {
							tabs1.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
	
			/* Device Manager Tree onClick Event */
			$('#deviceMonitor').tree({
				onClick : function(node) {
					/* debugger; */
					if ($('#deviceMonitor').tree("isLeaf", node.target)) {
						var tabs2 = $("#tabs");
						var tab2 = tabs2.tabs("getTab", node.text);
						if (tab2) {
							tabs2.tabs("select", node.text);
						} else {
							tabs2.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* Sys Manager Tree onClick Event */
			$('#sysManager').tree({
				onClick : function(node) {
					if ($('#sysManager').tree("isLeaf", node.target)) {
						var tabs3 = $("#tabs");
						var tab3 = tabs3.tabs("getTab", node.text);
						if (tab3) {
							tabs3.tabs("select", node.text);
						} else {
							tabs3.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			$('#tabs').tabs({
			  onUnselect: function(title,index){
				switch(title){
					case "设备台账" :
						if(deviceListEditIndex != undefined){
							ENDEDITWHENBLUR_DEVICELIST();
						}
						break;
					case "设备种类" :
						if(deviceTypeEditIndex != undefined){
							ENDEDITWHENBLUR_DEVICETYPE();
						}
						break;
					case "设备例检" :
						if(deviceCheckEditIndex != undefined){
							ENDEDITWHENBLUR_DEVICECHECK();
						}
						break;
					case "设备故障" :
						if(deviceFaultEditIndex != undefined){
							ENDEDITWHENBLUR_DEVICEFAULT();
						}
						break;
					case "设备维修" :
						if(deviceMaintainEditIndex != undefined){
							ENDEDITWHENBLUR_DEVICEMAINTAIN();
						}
						break;
					default:
						break;
				}
			  }
			});
						
	});
		
	function logout(){ 
		console.log("logout");
	}
	</script>

</body>
</html>