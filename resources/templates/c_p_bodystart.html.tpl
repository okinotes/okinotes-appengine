	<div id="drawers" class="snap-drawers">
		<nav id="nav-main">
			<ul class="menu nav nav-stacked">
				<li><a href="/"><span class="glyphicon glyphicon-home"></span> Home</a></li>
				{{if .User.Name}}
				<li><a href="{{.LogoutURL}}"><span class="glyphicon glyphicon-log-out"></span> Sign out</a></li>
				{{else}}
				<li><a href="{{.LoginURL}}"><span class="glyphicon glyphicon-log-in"></span> Sign in</a></li>
				{{end}}
				<li>&nbsp;</li>
				{{if .CanEdit}}
				<li><a href="/newItem.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-plus"></span> Add item</a></li>
				<li>&nbsp;</li>
				<li><a href="/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Administrate</a></li>
				<li><a href="/change_template.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-cog"></span> Change template</a></li>
				<li><a href="/delete.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-trash"></span> Delete page</a></li>
				<li>&nbsp;</li>
				<li><a href="/importPage.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}" data-toggle="modal" data-target="#remoteModal"><span class="glyphicon glyphicon-upload"></span> Import</a></li>
				{{end}}
				<li><a href="/p/{{.Page.UserName}}/{{.Page.Name}}/{{.Page.UserName}}_{{.Page.Name}}.json"><span class="glyphicon glyphicon-download"></span> Export</a></li>
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
		<div class="container">
			<h1>{{.Page.Title}}</h1>
