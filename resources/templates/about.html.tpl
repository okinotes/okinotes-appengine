<!DOCTYPE html>
<html lang="en">
  {{template "c_head.html.tpl"}}
  <body>

    <div class="container">
	
	{{template "c_navbar.html.tpl" .}}

	<div class="panel panel-default"> 
		<div class="panel-body">
			<div class="col-xs-12">
				<h1>About <span class="brand">Okinotes</span></h1>
				<p>Okinotes is a collaborative content sharing platform.</p>
				<p>Okinotes is developed in <a href="http://golang.org" target="_blank">Go</a> and is powered by Google App Engine.</p>
				<p>Contact us at <a href="mailto:simonhege@gmail.com">simonhege@gmail.com</a>.</p>
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