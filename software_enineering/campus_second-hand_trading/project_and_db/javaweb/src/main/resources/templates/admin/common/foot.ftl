<!--对话框-->
<script type="text/javascript" src="/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="/admin/js/bootstrap.min.js"></script>
<#--<script src="/home/js/jquery-3.5.1.min.js"></script>-->
<script src="/admin/js/jconfirm/jquery-confirm.min.js"></script>
<script src="/admin/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var currentUrl = window.location.pathname;
	var curs = currentUrl.split("/");
	currentUrl = curs[2];
	$(".second-menu").each(function(i,e){
		if($(e).children("a").attr('href').indexOf(currentUrl) > 0){
			$(e).addClass('active');
			$(e).parent("ul").parent("li").addClass("active open")
		}
	});
});
</script>
