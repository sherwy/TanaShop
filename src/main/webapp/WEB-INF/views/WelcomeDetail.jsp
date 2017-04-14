
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
	<script language="JavaScript" type="text/javascript"
	src="/Tools/cbrte/html2xhtml.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="/Tools/cbrte/richtext.js"></script>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="form-group">

	<script language="JavaScript">
		function validateWelcomeDetail(frm){
			updateRTEs();
			if(frm.welcomeDetailText.value == ""){
				alert("กรุณาระบุข้อความต้อนรับ");
				return false;
			}
		}
		initRTE("/Tools/cbrte/images/", "/Tools/cbrte/", "", true);
	</script>
	<form:form action="/welcomeDetail" method="POST"
		modelAttribute="welcomeDetail">
		<table class="table table-bordered">
			<tr>
				<td><label>ข้อความต้อนรับ</label></td>
				<td>
					<noscript>
						<p>
							<b>Javascript must be enabled to use this form.</b>
						</p>
					</noscript> <script language="JavaScript" type="text/javascript">
						//build new richTextEditor
						var rte1 = new richTextEditor('welcomeDetailText');
						rte1.html = '';

						//enable all commands for demo
						rte1.cmdFormatBlock = true;
						rte1.cmdFontName = true;
						rte1.cmdFontSize = true;
						rte1.cmdIncreaseFontSize = true;
						rte1.cmdDecreaseFontSize = true;

						rte1.cmdBold = true;
						rte1.cmdItalic = true;
						rte1.cmdUnderline = true;
						rte1.cmdStrikethrough = true;
						rte1.cmdSuperscript = true;
						rte1.cmdSubscript = true;	
						/*
						rte1.cmdJustifyLeft = true;
						rte1.cmdJustifyCenter = true;
						rte1.cmdJustifyRight = true;
						rte1.cmdJustifyFull = true;

						rte1.cmdInsertHorizontalRule = true;
						rte1.cmdInsertOrderedList = true;
						rte1.cmdInsertUnorderedList = true;

						rte1.cmdOutdent = true;
						rte1.cmdIndent = true;
						rte1.cmdForeColor = true;
						rte1.cmdHiliteColor = true;
						rte1.cmdInsertLink = true;
						rte1.cmdInsertImage = true;
						rte1.cmdInsertSpecialChars = true;
						rte1.cmdInsertTable = true;
						rte1.cmdSpellcheck = true;

						rte1.cmdCut = true;
						rte1.cmdCopy = true;
						rte1.cmdPaste = true;
						rte1.cmdUndo = true;
						rte1.cmdRedo = true;
						rte1.cmdRemoveFormat = true;
						rte1.cmdUnlink = true;
						*/
						//rte1.toggleSrc = false;

						rte1.build();
					</script></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success"
									onclick="return validateWelcomeDetail(welcomeDetail)" type="submit"
									value="บันทึก" />
							</p>
						</div>
						<div class="col-md-4"></div>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</div>


<jsp:include page="../componant/footer.jsp" flush="true" />