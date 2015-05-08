<form class="form-horizontal" role="form" method="post" action="/deleteItem.html">
	<input type="hidden" name="userName" value="{{.Page.UserName}}" />
	<input type="hidden" name="pageName" value="{{.Page.Name}}" />
	<input type="hidden" name="itemID" value="{{.Item.ID}}" />
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Delete item confirmation</h4>
	</div>
	<div class="modal-body">
		<p>Please confirm the deletion of the following item:</p>
		{{with .Item}}
		<div class="note" id="{{.ID}}">
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
		<p>Be careful. This operation can't be reverted.</p>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<input type="submit" class="btn btn-primary" id="btnDeletePage" value="Confirm" />
	</div>
</form>