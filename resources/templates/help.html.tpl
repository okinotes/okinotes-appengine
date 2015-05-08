<!DOCTYPE html>
<html lang="en">
  {{template "c_head.html.tpl"}}
  <body>

    <div class="container">
	
	{{template "c_navbar.html.tpl" .}}

	<div class="panel panel-default"> 
		<div class="panel-body">
			<div class="col-xs-12">
				<h1>How to use <span class="brand">Okinotes</span>?</h1>
				<p>Create a page, add items, done.</p>
				
				<h2>How to create a page?</h2>
				<p>In the home page, click on the navigation item "Create a page" and fill the required parameters. Validate by clicking on "Create".<p>
				<p>Page creation is limited to regsitered users.</p>
				
				<h2>How to add content on a page?</h2>
				<p>Depending on the template, you have a form available at the top of the page. Fill-it click and you are done.<p>
				<p>In all other case, use the keyboard shortcut "n" or the menu "Add item" to open the item creation dialog.<p>
				
				<h2>How to share a page?</h2>
				<p>Using the "Administrate" menu item in the page (shortcut "a"), change the visibility to <strong>public</strong>.
				Copy and share the page URL (similar to <span style="white-space: nowrap;">http://okinotes.appspot.com/p/<em>yourname</em>/<em>yourpage</em>.html</span>)<p>
				
				<h2>Which are the available templates?</h2>
				<p>4 templates are available:</p>
				<ul>
				<li>Micro-blog: a multicolumned list of articles. Usefull for sharing recipes, inspirational quotes, ...</li>
				<li>Micro-blog with offline mode: a revised version of the template "Micro-blog" allowing to view and edit items while being offline.</li>
				<li>TODO list: list tasks and track them when they are done.</li>
				<li>URL list: list URLs to a articles to be read, ressources on a special topic, ...</li>
				</ul>
				
				<h2 id="shortcuts">What are the available keyboard shortcuts?</h2>
				<dl>
				<dt>?</dt><dd>Open the help page (this page)</dd>
				<dt>a</dt><dd>Administrate the page settings (title, provacy, ...)</dd>
				<dt>d</dt><dd>Delete the page</dd>
				<dt>h</dt><dd>Open the <a href="/index.html">home page</a></dd>
				<dt>m</dt><dd>Toggle the menu</dd>
				<dt>n</dt><dd>Create a new item</dd>
				<dt>s</dt><dd>Sign-in or sign-out</dd>
				<dt>t</dt><dd>Change the page template</dd>
				
				<h2>How to backup/restore the content of a page?</h2>
				<p>The page history is not (yet) available. But you can proceed to manual backup &amp; restore :
				<ul>
					<li>Download the file content using the "Export" menu item.</li>
					<li>Save the file on your device.</li>
					<li>When needed, upload the fileusing the "Import" menu item.</li>
				</ul>
				</p>
				</dl>
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