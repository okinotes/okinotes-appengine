<nav class="navbar navbar-default">
	<div class="container-fluid">
	  <div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		  <span class="sr-only">Toggle navigation</span>
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/"><span><img src="/static/img/okinotes.png" /> <strong>Okinotes</strong></span></a>
	  </div>
	  <div class="navbar-collapse collapse">
		<ul class="nav navbar-nav">
		  <li {{if eq .Nav "home"}}class="active"{{end}}><a href="/"><span class="glyphicon glyphicon-home"></span> Home</a></li>
		  {{if .User.Name}}<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-edit"></span> Create a page <b class="caret"></b></a>
			<div class="dropdown-menu" style="padding: 10px">
				<form method="post" action="/create.html">
					<label for="pageName">Name</label><input id="pageName" type="text" name="pageName" required="required" pattern="[a-z0-9_\-]+"/><br \>
					<label for="template">Template</label><select id="template" name="template" style="margin-bottom: 10px" >{{range .Templates}}
						<option value="{{.ID}}">{{.Name}}</option>{{end}}
					</select>
					<input class="btn btn-primary" type="submit" value="Create" />
				</form>
			</div>
		  </li>
		  {{/*}}<li class="dropdown{{if eq .Nav "media.images"}} active{{end}}">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-th-large"></span> Media <b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <li {{if eq .Nav "media.images"}}class="active"{{end}}><a href="/user/images.html"><span class="glyphicon glyphicon-picture"></span> Images</a></li>
			</ul>
		  </li>{{*/}}{{end}}
		</ul>
		<ul class="nav navbar-nav navbar-right">
		{{if .User.Name}} 
			<li><p class="navbar-text">Logged in as <em>{{.User.FullName}}</em></p></li>
			<li><a href="{{.LogoutURL}}"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
		{{else}}
			<li><a href="{{.LoginURL}}"><span class="glyphicon glyphicon-log-in"></span> Log in</a></li>
		{{end}}
			<li><a href="/help.html"><span class="glyphicon glyphicon-question-sign"></span></a></li>
		</ul>	
	  </div><!--/.nav-collapse -->
	</div><!--/.container-fluid -->
</nav>
