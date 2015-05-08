<form class="form-horizontal" role="form" method="post" action="/delete.html">
	<input type="hidden" name="userName" value="{{.Page.UserName}}" />
	<input type="hidden" name="pageName" value="{{.Page.Name}}" />
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Delete page confirmation</h4>
	</div>
	<div class="modal-body">
		<p>Please confirm the deletion of the current page: '{{.Page.Title}}'. Be careful. This operation can't be reverted.</p>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<input type="submit" class="btn btn-primary" id="btnDeletePage" value="Confirm" />
	</div>
</form>