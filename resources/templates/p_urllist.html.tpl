<!doctype html>
<html lang="en">
<head>
{{template "c_p_head.html.tpl" .}}
	
	<style type="text/css">
	.content {
		border:1px solid black;
		padding:0 1em;
		background-color: rgba(255, 255, 255, 0.9);
	}

	div.note {
		padding:1em;
	}

	div.note header {
		font-size:small;
		padding: 0.5em 0;
	}
	</style>
</head>
<body>
	{{template "c_p_bodystart.html.tpl" .}}
			{{$root := .}}
			<table class="table table-condensed table-bordered content">
				{{if .CanEdit}}<tr>
					<form method="post">
						<td>
						<input type="hidden" name="kind" value="URL" />
						<input type="hidden" name="content" value="" />
						<input type="hidden" name="source" value="" />
						<div class="col-md-4"><input type="text" class="form-control" id="newTitle" name="title" placeholder="Title" /></div>
							<div class="col-md-8"><input type="url" class="form-control" id="newURL" name="URL" placeholder="URL"  required="required" /></div></td>
						<td><input type="submit" class="btn btn-primary" id="btnSaveNewItem" value="Save" /></td>
					</form>
				</tr>{{end}}
			{{range .Items}}
				<tr id="{{.ID}}">
					<td>
						{{if eq .Kind "TEXT"}}
						<div>
							<h2>{{.Title}}</h2>
							<p>{{.HTMLContent}}</p>
						</div>
						{{else if eq .Kind "QUOTE"}}
						<blockquote>
							<p>{{.HTMLContent}}</p>
							{{if .Source}}<small><cite>{{.Source}}</cite></small>{{end}}
						</blockquote>
						{{else if eq .Kind "URL"}}
						<div>
							<p><a target="_blank" href="{{.URL}}">{{if .Title}}{{.Title}}{{else}}{{.URL}}{{end}}</a></p>
							{{if .HTMLContent}}<p>{{.HTMLContent}}</p>{{end}}
						</div>
						{{end}}
					</td>
					<td>{{if $root.CanEdit}}<div class="pull-right btn-group">
								<a href="/editItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID={{.ID}}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-pencil"></span></a>
								<a href="/deleteItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID={{.ID}}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-trash"></span></a></div>{{end}}<span class="label label-default"><time datetime="{{.LastModificationDate}}">{{timeago .LastModificationDate}}</time></span></td>
				</tr>
			{{end}}
			</table>
	{{template "c_p_bodyend.html.tpl" .}}	
</body>
</html>
