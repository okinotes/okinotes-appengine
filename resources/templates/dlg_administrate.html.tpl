<form class="form-horizontal" role="form" method="post" action="/administrate.html">
	<input type="hidden" name="userName" value="{{.Page.UserName}}" />
	<input type="hidden" name="pageName" value="{{.Page.Name}}" />
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Administrate page</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="title" class="col-lg-3 control-label">Page title</label>
			<div class="col-lg-9">
				<input type="text" class="form-control" name="title" placeholder="Title" value="{{.Page.Title}}">
			</div>
		</div>
		<div class="form-group">
			<label for="policy" class="col-lg-3 control-label">Access policy</label>
			<div class="col-lg-9">
				<div class="radio">
					<label>
						<input type="radio" name="policy" value="PRIVATE" {{if eq .Page.Policy "PRIVATE"}}checked="checked"{{end}}><span class="glyphicon glyphicon-lock"></span> Private
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="policy" value="PUBLIC" {{if eq .Page.Policy "PUBLIC"}}checked="checked"{{end}}><span class="glyphicon glyphicon-eye-open"></span> Public
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="title" class="col-lg-3 control-label">Content license</label>
			<div class="col-lg-9">
				<input type="text" class="form-control" name="contentLicense" placeholder="Content license" value="{{.Page.ContentLicense}}">
			</div>
		</div>
		{{range .Template.PageTags}}
		<div class="form-group">
			<label for="tag-{{.Key}}" class="col-lg-3 control-label">{{.Name}}</label>
			<div class="col-lg-9">
				{{if eq .Kind "imageId"}}
				<img src="/images/{{$.Page.Tags.Tag .Key}}" style="width:128px" />
				<input type="hidden" name="tag-{{.Key}}" value="{{$.Page.Tags.Tag .Key}}" />
				{{else if eq .Kind "imageUrl"}}
				<img src="{{$.Page.Tags.Tag .Key}}" style="width:128px" />
				<input type="hidden" name="tag-{{.Key}}" value="{{$.Page.Tags.Tag .Key}}" />
				<button type="button" class="btn btn-default">Change image</button>
				{{else if eq .Kind "color"}}
				<input type="color" class="form-control" name="tag-{{.Key}}" placeholder="{{.Description}}" value="{{$.Page.Tags.Tag .Key}}">
				{{end}}
			</div>
		</div>
		{{end}}
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<input type="submit" class="btn btn-primary" id="btnAdminPage" value="Save" />
	</div>
</form>