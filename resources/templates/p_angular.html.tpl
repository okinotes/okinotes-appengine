<!doctype html>
<html lang="en" {{if .Offline}}manifest="cache.manifest"{{end}}>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--<meta name="description" content="">
	<meta name="author" content="">-->
	<link rel="shortcut icon" href="/favicon.ico">

	<title>{{.Page.Title}}{{if .Offline}} - offline version{{end}}</title>
	
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
	#content h1 {
		color:{{.Page.Tags.Tag `title.color`}};
		text-align:center;
	}
	</style>

	<style type="text/css">
	.snap-content{
		background: url("/static/img/bg-pehoe.jpg") no-repeat center center fixed;
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
	
	.license {
		border:1px solid black;
		padding:0.5em;
		font-size:small;
		text-align: center;
		margin-bottom: 1em;
		background-color: rgba(255, 255, 255, 0.9);
	}
	.license p {
		margin-bottom: 0;
	}

	div.note {
		padding:1em;
	}

	div.note header {
		font-size:small;
		padding: 0.5em 0;
	}
	div.note h2{
		margin-top:0;
	}
	div.note footer {
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
<body ng-app="okiApp">
	<!--[if lt IE 7]>
		<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
	<![endif]-->
	<div id="drawers" class="snap-drawers">
		<nav id="nav-main">
			<ul class="menu nav nav-stacked">
				<li><a href="/"><span class="glyphicon glyphicon-home"></span> Home</a></li>
			{{if not .Offline}}
				{{if .User.Name}}
				<li><a href="{{.LogoutURL}}"><span class="glyphicon glyphicon-log-out"></span> Sign out</a></li>
				{{else}}
				<li><a href="{{.LoginURL}}"><span class="glyphicon glyphicon-log-in"></span> Sign in</a></li>
				{{end}}
				<li>&nbsp;</li>
				{{if .CanEdit}}
				<li><a href="/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Administrate</a></li>
				<li><a href="/change_template.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Change template</a></li>
				<li><a href="/delete.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-trash"></span> Delete page</a></li>
				<li>&nbsp;</li>
				<li><a href="/importPage.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-upload"></span> Import</a></li>
				{{end}}
				<li><a href="/p/{{.Page.UserName}}/{{.Page.Name}}/{{.Page.UserName}}_{{.Page.Name}}.json"><span class="glyphicon glyphicon-download"></span> Export</a></li>
				<li>&nbsp;</li>
				<li><a href="/p/{{.Page.UserName}}/{{.Page.Name}}/offline.html"><span class="glyphicon glyphicon-link"></span> Offline version</a></li>
			{{else}}
				<li>&nbsp;</li>
				<li><a href="/p/{{.Page.UserName}}/{{.Page.Name}}.html"><span class="glyphicon glyphicon-link"></span> Online version</a></li>
			{{end}}
				<li>&nbsp;</li>
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
		<div class="container" ng-view=""></div>
		{{if eq (.Page.Tags.Tag "template.debug") "true"}}<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<pre>{{.}}</pre>
		</div>{{end}}
	</div>
	{{if not .Offline}}
	<!-- Modal -->
	<div class="modal fade" id="remoteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<p>Please wait. Loading content</p>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	{{end}}

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="/static/js/jquery-2.1.0.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
	<script src="/static/js/snap.min.js"></script>
	<script src="/static/js/mousetrap.min.js"></script>
	<script type="text/javascript"> 
		$(function() {
			
			snapper = new Snap({
				element: document.getElementById('content'),
			});
			snapper.disable();
			toggle = document.getElementById('toggle');
		
			toggle.addEventListener('click', function(){

				if( snapper.state().state=="left" ){
					snapper.close();
				} else {
					snapper.open('left');
				}

			});
			{{if not .Offline}}
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
			
			{{if .CanEdit}}
			var hash = location.hash.slice(1);
			if(hash === 'administrate') {
				remoteModal.modal({remote: '/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			}
			{{end}}
			{{end}}
			
			Mousetrap.bind('m', function(){

				if( snapper.state().state=="left" ){
					snapper.close();
				} else {
					snapper.open('left');
				}

			});
			Mousetrap.bind('h', function() { window.location = '/index.html'; });
			{{if not .Offline}}
			Mousetrap.bind('s', function() { window.location = '{{if .User.Name}}{{.LogoutURL}}{{else}}{{.LoginURL}}{{end}}'; });
			{{if .CanEdit}}
			Mousetrap.bind('t', function() {
				remoteModal.modal({remote: '/change_template.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('a', function() {
				remoteModal.modal({remote: '/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('d', function() {
				remoteModal.modal({remote: '/delete.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			{{end}}
			{{end}}
			Mousetrap.bind('?', function() { window.location = '/help.html'; });
			
			$(".loadingIndicator").fadeOut();
		});
	</script>
	
	<script src="/static/js/masonry.pkgd.min.js"></script>
	<script src="/static/js/imagesloaded.pkgd.min.js"></script>
	<script src="/static/js/moment.min.js"></script>
	
    <script src="/static/js/angular-1.3.0/angular.js"></script>
    <script src="/static/js/angular-1.3.0/angular-route.js"></script>
    <script src="/static/js/angular-1.3.0/angular-sanitize.js"></script>
	
    <script src="/static/js/angular-masonry.js"></script>
    <script src="/static/js/angular-moment.min.js"></script>

	<script src="/static/js/localforage.min.js"></script>
	
	<script src="/static/js/oki/app.js"></script>
	<script src="/static/js/oki/okiService.js"></script>
	<script src="/static/js/oki/controllers/main.js"></script>
	
	<script type="text/javascript"> 
	var oki = oki || {};
	oki.userName = '{{.Page.UserName}}';
	oki.pageName = '{{.Page.Name}}';
	oki.canEdit = {{.CanEdit}};
	
	{{if .Offline}}
	
	// Check if a new cache is available on page load.
	window.addEventListener('load', function(e) {
	window.applicationCache.addEventListener('updateready', function(e) {
			if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
				// Browser downloaded a new app cache.
				window.applicationCache.swapCache();
				console.log('swap cache has been called');
				if (confirm('A new version of this site is available. Load it?')) {
					window.location.reload();
				}
			} else {
			  // Manifest didn't changed. Nothing new to server.
			}
		}, false);
	}, false);
	window.applicationCache.update();
	{{end}}
	</script>

	<link href='http://fonts.googleapis.com/css?family=Gloria+Hallelujah' rel='stylesheet' type='text/css'>
	<link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/snap.css" rel="stylesheet">
	<link href="/static/css/wizy.css" rel="stylesheet">
</body>
</html>