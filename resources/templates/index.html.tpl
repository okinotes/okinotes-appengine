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
				<p>Create a page, add content, share publicly or with colleagues and friends. Your page may be a micro-blog, a todo-list or whatever: we have a template for each use case. 
				Add content from your desktop browser, mobile browser, or using one of our mobile apps.</p>
				<p>This application is open-source. Deploy your own instance or contribute to make it even better.</p>
{{if not .User.Name}} 
				<p><a href="{{.LoginURL}}">Log in</a> to create and share pages.</p>
{{end}}
			</div>
			<div class="col-xs-12 col-md-6">
<h2>Why you'll love Okinotes.</h2>
<ul>
	<li><strong>User friendly</strong>: multiple templates, advanced customisation</li>
	<li><strong>Efficient</strong>: no ads, keyboard shortcuts</li>
	<li><strong>Social</strong>: share your creation</li>
</ul>
			</div>
{{if .User.Name}} 
			<div class="col-xs-12 col-md-6">
<h2>My pages</h2>
{{if .MyPages}}<table class="col-xs-12"><tr><th>Title</th><th>Policy</th><th>Last modification</th></tr>
{{range .MyPages}}
<tr>
	<td><a href="/p/{{.UserName}}/{{.Name}}.html">{{.Title}}</a></td>
	<td><span class="glyphicon glyphicon-{{if eq .Policy "PRIVATE"}}lock{{else}}eye-open{{end}}" title="{{.Policy}}"></span></td>
	<td><time datetime="{{.LastModificationDate}}">{{timeago .LastModificationDate}}</time></td>
</tr>
{{end}}
</table>{{else}}<p><em>No pages created yet.</em></p>{{end}}
			</div>
{{end}}
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