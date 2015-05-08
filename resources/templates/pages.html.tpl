<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--<meta name="description" content="">
    <meta name="author" content="">-->
    <link rel="shortcut icon" href="/favicon.ico">

    <title>{{.Page.Title}}</title>
	
	<link href='http://fonts.googleapis.com/css?family=Gloria+Hallelujah' rel='stylesheet' type='text/css'>
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/snap.css" rel="stylesheet">
    <link href="/static/css/wizy.css" rel="stylesheet">
	<style type="text/css">
	
	.snap-drawers {
		background: #323949;
		color: #ccc;
	}

	.snap-content{
		background: url("/images/{{.Page.Tags.Tag `background`}}") no-repeat center center fixed;
		-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;
	}
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
	#content h1 {
		color:{{.Page.Tags.Tag `title.color`}};
		text-align:center;
	}
	</style>
</head>
<body>
	<div id="drawers" class="snap-drawers">
		<nav id="nav-main">
			<ul class="menu nav nav-stacked">
				<li><a href="/"><span class="glyphicon glyphicon-home"></span> Home</a></li>
				{{if .User.ID}}
				<li><a href="{{.LogoutURL}}"><span class="glyphicon glyphicon-log-out"></span> Sign out</a></li>
				{{else}}
				<li><a href="{{.LoginURL}}"><span class="glyphicon glyphicon-log-in"></span> Sign in</a></li>
				{{end}}
				<li>&nbsp;</li>
				{{if .CanUpdate}}
				<li><a href="/newItem.html?pageId={{.Page.ID}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-plus"></span> Add item</a></li>
				<li>&nbsp;</li>
				{{end}}
				{{if .CanDelete}}
				<li><a href="/administrate.html?pageId={{.Page.ID}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Administrate</a></li>
				<li><a href="/change_template.html?userName={{.User.Name}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Change template</a></li>
				<li><a href="/delete.html?pageId={{.Page.ID}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-trash"></span> Delete page</a></li>
				<li>&nbsp;</li>
				{{end}}
				<li><a href="/help.html"><span class="glyphicon glyphicon-question-sign"></span> Help</a></li>
				<li><a href="/about.html"><span class="glyphicon glyphicon-info-sign"></span> About</a></li>
			</ul>
		</nav>
	</div>

	<div id="content" class="snap-content container">
		<div class="pull-left btn-group" style="margin:1em">
			<button class="btn btn-default" type="button" id="toggle"><span class="glyphicon glyphicon-list"></span></button>
		</div>
		<div class="pull-right loadingIndicator" style="margin:1em"><img src="/static/img/ajax-loader.gif" width="32" height="32" /></div>
		<div class="container">
			<h1>{{.Page.Title}}</h1>

			<div id="notes-layout">
			{{range .Items}}
				<div class="note quote col-xs-12 col-md-6" id="{{.ID}}">
					<article class="content">
						<header class="clearfix">
							<div class="note-date pull-left"><time datetime="{{.LastModificationDate}}">{{timeago .LastModificationDate}}</time></div>
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
		</div>
		
		{{if eq (.Page.Tags.Tag "template.debug") "true"}}<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<pre>{{.}}</pre>{{end}}
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="remoteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<p>Please wait. Loading content</p>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="/static/js/jquery-2.1.0.min.js">\x3C/script>')</script>
    <script src="/static/js/bootstrap.min.js"></script>
	<script src="/static/js/snap.min.js"></script>
	<script type="text/javascript"> 
		$(function() {
			snapper = new Snap({
				element: document.getElementById('content'),
				disable: 'right'
			});
			toggle = document.getElementById('toggle');
		
			toggle.addEventListener('click', function(){

				if( snapper.state().state=="left" ){
					snapper.close();
				} else {
					snapper.open('left');
				}

			});
			
			editdlg = $(document.getElementById('newItemModal'));
			editdlg.on('show.bs.modal', function () {
				if( snapper.state().state=="left" ){
					snapper.close();
				}
			});
			
			remoteModal = $(document.getElementById('remoteModal'));
			remoteModal.on('show.bs.modal', function () {
				if( snapper.state().state=="left" ){
					snapper.close();
				}
			});
			remoteModal.on('hidden.bs.modal', function () {
				remoteModal.removeData('bs.modal');
				remoteModal.find( ".modal-content" ).html("<p>Please wait. Loading content</p>")
			});
			
			{{if .CanDelete}}
			var hash = location.hash.slice(1);
			if(hash === 'administrate') {
				remoteModal.modal({remote: '/administrate.html?pageId={{.Page.ID}}', show: true});
			}
			{{end}}
			
			$(".loadingIndicator").fadeOut();
		});
	</script>
</body>
</html>
