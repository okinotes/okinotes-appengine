 <form class="form-horizontal" role="form" method="post" enctype="multipart/form-data" action="/importPage.html">
	<input type="hidden" name="userName" value="{{.UserName}}" />
	<input type="hidden" name="pageName" value="{{.PageName}}" />
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Import page</h4>
	</div>
	<div class="modal-body">
		<p>Please select the file to import. File extension must be <em>.json</em></p>
		<div class="form-group">
			<label for="file" class="col-sm-2 control-label">File selection: </label>
			<div class="col-sm-10">
				<input type="file" class="form-control" id="file" name="file" placeholder="File to uplaod" />
				<p class="help-block">Supported format is json.</p>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<input type="submit" class="btn btn-primary" id="btnImportPage" value="Import" />
	</div>
</form>