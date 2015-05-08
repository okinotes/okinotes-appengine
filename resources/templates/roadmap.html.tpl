<!DOCTYPE html>
<html lang="en">
  {{template "c_head.html.tpl"}}
  <body>

    <div class="container">
	
	{{template "c_navbar.html.tpl" .}}

	<div class="panel panel-default"> 
		<div class="panel-body">
			<div class="col-xs-12">
				<h1><span class="brand">Okinotes</span> roadmap</h1>
				<p>Improve, improve, improve.</p>
				<p>For a more detailed roadmap, see the <a href="https://github.com/okinotes/okinotes-appengine/issues">issues list in GitHub</a>.</p>
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