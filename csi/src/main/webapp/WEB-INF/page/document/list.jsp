<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>文档信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="${ctx}/public/logo.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${ctx}/public/css/font.css">
    <link rel="stylesheet" href="${ctx}/public/css/xadmin.css">
      <link rel="stylesheet" href="${ctx}/public/lib/layui/css/layui.css">
      <link rel="stylesheet" href="${ctx}/public/css/bootstrap.min.css">
    <script type="text/javascript" src="${ctx}/public/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/public/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/public/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="${ctx}/welcome">首页</a>
        <a>
          <cite>文档信息</cite></a>
      </span>
      
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="${ctx }/document/list" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row" style="" align="center">
        <form class="layui-form layui-col-md12 x-so" method="get" action="${ctx }/document/list">
          <!-- <input class="layui-input" placeholder="开始日" name="start" id="start">
          <input class="layui-input" placeholder="截止日" name="end" id="end"> -->
          <input type="text" name="content" style="width:50%;"  placeholder="请输入查找内容" autocomplete="off" class="layui-input">
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
      </div>
      
      <table class="layui-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>标题</th>
            <th>文件名</th>
            <th>描述</th>
            <th>发布日期</th>
            <th>发布用户</th>
            <th>操作</th>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.list}" var="dept" varStatus="stat">
     <tr>
            <td>${dept.id}</td>
            <td>${dept.title }</td>
            <td>${dept.filename}</td>
            <td>${dept.remark }</td>
            <td>${dept.create_date }</td>
            <td>${dept.user.username }</td>
            
           <!--  <td class="td-status">
              <span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span></td> -->
            <td class="td-manage">
             <!--  <a onclick="member_stop(this,'10001')" href="javascript:;"  title="启用">
                <i class="layui-icon">&#xe601;</i>
              </a> -->
              <%-- <a title="编辑"  onclick="x_admin_show('编辑','${ctx}/job/add?id=${dept.id }');" href="javascript:;"> --%>
                <c:choose>
                    <c:when test="${sessionScope.tip  == 1}">
                        <a title="编辑" onclick="x_admin_show('编辑','${ctx}/document/add?id=${dept.id }');" href="javascript:;" >
                            <i class="layui-icon">&#xe642;</i>
                        </a>
                        <a title="删除" onclick="member_del(this,'${dept.id }')" href="javascript:;">
                            <i class="layui-icon">&#xe640;</i>
                        </a>
                    </c:when>
                </c:choose>
                <a title="下载"  href="${ctx}/document/download?filename=${dept.filename}">
                    <i class="layui-icon">&#xe601;</i>
                </a>
            </td>
          </tr>
			</c:forEach>
        </tbody>
      </table>
    </div>
    <div class="container" style="background-color: transparent">
        <div class="row">
            <!-- 分页文字信息，其中分页信息都封装在pageInfo中 -->           
            <div class="col-md-6">
                当前第：${pageInfo.pageNum}页，总共：${pageInfo.pages}页，总共：${pageInfo.total}条记录
            </div>
            <div class="col-md-6 col-md-offset-9">               
                <nav aria-label="Page navigation">                 
                    <ul class="pagination pagination-sm">                   
                        <li><a href="${ctx}/document/list?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <li><a href="${ctx}/document/list?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span></a>                      
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum }">
                                <li class="active"><a href="#">${ page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum }">
                                <li>
                                    <a href="${ctx}/document/list?pn=${ page_Num}">${ page_Num}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage }">
                            <li><a href="${ctx}/document/list?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span></a>
                            </li>
                        </c:if>
                        <li>
                            <a href="${ctx}/document/list?pn=${pageInfo.pages}">末页</a>
                        </li>             
                    </ul>               
                </nav>       
            </div>
        </div>
           
    </div>
    <script>
      layui.use('laydate', function(){
        var laydate = layui.laydate;
        
        //执行一个laydate实例
        laydate.render({
          elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
          elem: '#end' //指定元素
        });
      });

      /*用户-删除*/
      function member_del(obj,id){
          layer.confirm('确认要删除吗？',function(index){
              //发异步删除数据
              //等以后再使用异步，这里先使用
              $.get("${ctx}/document/delete?id="+id);
              $(obj).parents("tr").remove();
              layer.msg('已删除!',{icon:1,time:1000});
          });
      }


      function delAll (argument) {

        var data = tableCheck.getData();
  
        layer.confirm('确认要删除吗？'+data,function(index){
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
      }
    </script>

  </body>

</html>