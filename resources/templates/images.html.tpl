<!DOCTYPE html>
<html lang="en">
  {{template "c_head.html.tpl"}}
  <body>

    <div class="container">
	
	{{template "c_navbar.html.tpl" .}}

	<div class="panel panel-default"> 
		<div class="panel-body">
			<div class="col-xs-12">
				<h3>Upload an image</h3>
				<form action="{{.UploadURL}}" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<label for="file" class="col-sm-2 control-label">File selection: </label>
						<div class="col-sm-10">
							<input type="file" class="form-control" id="file" name="file" placeholder="File to uplaod" />
							<p class="help-block">Supported formats are jpg and png.</p>
						</div>
					</div>
				  <div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
					  <button type="submit" class="btn btn-default"name="upload" >Upload</button>
					</div>
				  </div>
					
				</form>
			</div>
			<div class="col-xs-12">
				<h3>Your images</h3>
			{{range .Images}}
			  <div class="col-xs-6 col-md-3 thumbnail">
				<a href="{{.URL}}">
				   <img src="{{.URL128}}" alt="{{.Name}}" />
					<div class="caption">
						<p>{{.Name}}</p>
					</div>
				</a>
				<div class="btn-group pull-right">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-pencil"></span></button>
						<div class="dropdown-menu" style="padding: 10px">
							<form method="post" action="/user/images/rename.html?imgId={{.ID}}">
								<input type="text" name="imageName" required="required" style="margin-bottom: 10px" value="{{.Name}}" />
								<input class="btn btn-primary" type="submit" value="Rename" />
							</form>
						</div>
					</div>
					<button type="button" class="btn btn-default" data-toggle="modal" data-target="#deleteImage" data-imgId="{{.ID}}" data-imgName="{{.Name}}"><span class="glyphicon glyphicon-trash"></span></button>
				</div>
			  </div>
			{{end}}
			</div>
		</div>
    </div>
	
	{{template "c_footer.html.tpl" .}}
	
	{{/*<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		<pre>{{.}}</pre>
	</div>*/}}
	
    </div> <!-- /container -->
	
	<div class="modal fade" id="deleteImage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" role="form" method="post" action="/user/images/delete.html">
				<input type="hidden" id="deleteImageId" name="imgId" value="" />
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Delete image confirmation</h4>
				</div>
				<div class="modal-body">
					<p>Please confirm the deletion of the image "<span id="deleteImageName"></span>". Be careful. This operation can't be reverted.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<input type="submit" class="btn btn-primary" id="btnDeletePage" value="Confirm" />
				</div>
				</form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		
    {{template "c_js.html.tpl" .}}
	<script type="text/javascript"> 
		$(function() {
		  $('a[data-toggle=modal], button[data-toggle=modal]').click(function () {

			var data_id = '';
			if (typeof $(this).data('imgid') !== 'undefined') {
			  data_id = $(this).data('imgid');
			}
			$('#deleteImageId').val(data_id);
			
			var data_name = '';
			if (typeof $(this).data('imgname') !== 'undefined') {
			  data_name = $(this).data('imgname');
			}
			$('#deleteImageName').text(data_name);
			
		  });
		});
	</script>
  </body>
</html>