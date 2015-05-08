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
	@media screen and (max-width: 768px){
		#notes-layout[data-columns]::before {
			content: '1 .column.size-1of1';
		}
	}
	@media screen and (min-width: 769px) {
		#notes-layout[data-columns]::before {
			content: '2 .column.size-1of2';
		}
	}

	/* These are the classes that are going to be applied: */
	.column { float: left; }
	.size-1of1 { width: 100%; }
	.size-1of2 { width: 50%; }
	.size-1of3 { width: 33.333%; }
	.size-1of4 { width: 25%; }
	</style>
</head>
<body>
	{{template "c_p_bodystart.html.tpl" .}}
			<div id="notes-layout" data-columns>
			{{$root := .}}
			{{range .Items}}
				<div class="note" id="{{.ID}}">
					<article class="content">
						<header class="clearfix">
							<div class="note-date pull-left"><time datetime="{{.LastModificationDate}}">{{timeago .LastModificationDate}}</time></div>
							{{if $root.CanEdit}}<div class="pull-right btn-group">
								<a href="/editItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID={{.ID}}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-pencil"></span></a>
								<a href="/deleteItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID={{.ID}}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-trash"></span></a></div>{{end}}
						</header>
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
							{{if .Title}}<h2>{{.Title}}</h2>{{end}}
							<p><a target="_blank" href="{{.URL}}">{{.URL}}</a></p>
							{{if .HTMLContent}}<p>{{.HTMLContent}}</p>{{end}}
						</div>
						{{end}}
					</article>
				</div>
			{{end}}
			</div>
	{{template "c_p_bodyend.html.tpl" .}}	
	<script src="/static/js/salvattore.min.js"></script>
</body>
</html>
