<form class="form-horizontal" role="form" method="post" action="/change_template.html">
	<input type="hidden" name="userName" value="{{.UserName}}" />
	<input type="hidden" name="pageName" value="{{.PageName}}" />
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Change page template</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="policy" class="col-lg-3 control-label">Template</label>
			<div class="col-lg-9">
				{{range .AllTemplates}}
				<div class="radio">
					<label>
						<input type="radio" name="templateID" value="{{.ID}}" {{if .Selected}}checked="checked"{{end}}>{{.Name}}</input>
					</label>
				</div>
				{{end}}
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<input type="submit" class="btn btn-primary" id="btnAdminPage" value="Save" />
	</div>
</form>