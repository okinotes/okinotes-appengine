<!DOCTYPE html>
<html lang="en">
  {{template "c_head.html.tpl"}}
  <body>

    <div class="container">
	
	{{template "c_navbar.html.tpl" .}}

	<div class="panel panel-default"> 
		<div class="panel-body">
			<div class="col-xs-12">
				<h1><span class="brand">Okinotes: note and share in seconds</span></h1>
				<h3>Account creation</h2>
				<p>Welcome to Okinotes. We have just one question before you can start using the service. Pleas provide an user name who will be used to prefix
				your pages in url. For example http://okinotes.appspot.com/p/<em>yourname</em>/yourpage.html.</p>
				<form method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">Name: </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="name" name="name" placeholder="User name" required="required" pattern="[a-z0-9_\-]{3,}" />
							<p class="help-block">Only lower case characters, digits, dash and underscore accepted. At least 3 characters.</p>
						</div>
					</div>
					{{/*TODO: privacy & usage conditions approval */}}
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary"name="create" >Create</button>
							<a class="btn btn-default" href="{{.LogoutURL}}">Cancel</a>
						</div>
					</div>
					
				</form>
			</div>
		</div>
    </div>
	
	{{template "c_footer.html.tpl" .}}
	
	{{/*<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		<pre>{{.}}</pre>
	</div>*/}}
	
    </div> <!-- /container -->
	
	
    {{template "c_js.html.tpl" .}}
  </body>
</html>