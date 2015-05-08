<form class="form-horizontal" role="form" id="newItemContent">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Add item</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="kind" class="col-lg-2 control-label">Kind</label>
			<div class="col-lg-10">
				<div class="radio">
					<label>
						<input type="radio" name="kind" value="QUOTE" data-bind="checked: editedItem().Kind">Quote
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="kind" value="TEXT" data-bind="checked: editedItem().Kind">Text
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="kind" value="URL" data-bind="checked: editedItem().Kind">URL
					</label>
				</div>
			</div>
		</div>
		<div class="form-group" data-bind="visible: editedItem().TitleEnabled">
			<label for="inputTitle" class="col-lg-2 control-label">Title</label>
			<div class="col-lg-10">
				<input type="text" class="form-control" id="inputTitle" name="title" placeholder="Title" data-bind="value: editedItem().Title">
			</div>
		</div>
		<div class="form-group" data-bind="visible: editedItem().ContentEnabled">
			<label for="inputContent" class="col-lg-2 control-label">Content</label>
			<div class="col-lg-10">
				<textarea class="form-control" rows="3" name="content" placeholder="Content" data-bind="value: editedItem().Content"></textarea>
			</div>
		</div>
		<div class="form-group" data-bind="visible: editedItem().SourceEnabled">
			<label for="inputSource" class="col-lg-2 control-label">Source</label>
			<div class="col-lg-10">
				<input type="text" class="form-control" id="inputSource" name="source" placeholder="Source" data-bind="value: editedItem().Source">
			</div>
		</div>
		<div class="form-group" data-bind="visible: editedItem().URLEnabled">
			<label for="inputURL" class="col-lg-2 control-label">URL</label>
			<div class="col-lg-10">
				<input type="url" class="form-control" id="inputURL" name="URL" placeholder="URL" data-bind="value: editedItem().URL">
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<button type="button" class="btn btn-primary" id="btnSaveEditedItem">Save</button>
	</div>
</form>
<script src="/static/js/knockout-3.1.0.js"></script>
<script src="/static/js/okinotes.js"></script>
<script type="text/javascript"> 
	$(function() {
		root = document.getElementById('newItemContent');
	
		oki.pageName = '{{.Page.Name}}';
		oki.pageUserName = '{{.Page.UserName}}';
		oki.app.init('btnSaveEditedItem', root);
	});
</script>