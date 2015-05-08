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

	.note h2 {
		margin-top: 5px;
	}
	
	</style>
</head>
<body>
	{{template "c_p_bodystart.html.tpl" .}}
			{{$root := .}}			
			<table id="todolist" class="table table-condensed table-bordered content">
				<tbody data-bind="foreach: items">
					<tr  class="note">
						<td style="text-align:center; width:50px">
						<button type="button" class="btn" data-bind="css : btnClass(), click: toggle">
							<span class="glyphicon glyphicon-ok" data-bind="style : { color: isNew() ? 'lightgrey' : '' }">
						</button></td>
						
						<td>
							<div data-bind="if: IsText, visible: IsText">
								<h2 data-bind="text: Title"></h2>
								<p data-bind="html: htmlContent"></p>
							</div>
							<blockquote data-bind="if: IsQuote, visible: IsQuote">
								<p data-bind="html: htmlContent"></p>
								<small data-bind="if: Source"><cite data-bind="text: Source"></cite></small>
							</blockquote>
							<div data-bind="if: IsURL, visible: IsURL">
								<h2 data-bind="text: Title, visible: Title"></h2>
								<p><a target="_blank" data-bind="attr: {href: URL}, text: URL"></a></p>
								<p data-bind="html: htmlContent"></p>
							</div>
						</td>
						<td>
							<div class="pull-right btn-group">
								<a data-bind="attr: {href: '/editItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID=' + ID}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-pencil"></span></a>
								<a data-bind="attr: {href: '/deleteItem.html?userName={{$root.User.Name}}&pageName={{$root.Page.Name}}&itemID=' + ID}" data-toggle="modal" data-target="#remoteModal" class="btn btn-default btn-xs" role="button"><span class="glyphicon glyphicon-trash"></span></a>
							</div>
							<span class="label label-default"><time data-bind="attr: { datetime:LastModificationDate}, text:LastModificationDateText"></time></span>
							<span class="label label-info" data-bind="visible: Deadline">Due date: <span data-bind="text: Deadline"></span></span>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<form  data-bind="submit: addItem">
					<tr>
						<td />
						<td>
							<div class="col-md-12"><input type="text" class="form-control" id="newTitle" name="title" placeholder="Task"  data-bind="value: itemToAdd().Title"/></div>
							<div class="col-md-12"><textarea class="form-control" rows="3" name="content" placeholder="Description" required="required"  data-bind="value: itemToAdd().Content"></textarea></div>
						</td>
						<td>
							<button type="submit" class="btn btn-primary">Add</button>
						</td>
					</tr>
					</form>
				</tfoot>
			</table>
	{{template "c_p_bodyend.html.tpl" .}}	
	
<script src="/static/js/knockout-3.1.0.js"></script>
<script src="/static/js/Markdown.Converter.js"></script>
<script src="/static/js/Markdown.Sanitizer.js"></script>
<script src="/static/js/jquery.timeago.js"></script>
<script type="text/javascript"> 
	$(function() {
		var converter = Markdown.getSanitizingConverter();
		//var t = converter.makeHtml("* a\r\n* b");
	
		var Note = function(id, kind, title, content, source, url, lastModificationDate, status, deadline) {
			this.ID = id;
	
			this.Kind = ko.observable(kind);
			this.IsText = ko.computed(function() { return this.Kind() == "TEXT"; },this);
			this.IsURL = ko.computed(function() { return this.Kind() == "URL"; },this);
			this.IsQuote = ko.computed(function() { return this.Kind() == "QUOTE"; },this);
			
			this.Title = ko.observable(title);
			this.Content = ko.observable(content);
			this.Source = ko.observable(source);
			this.URL = ko.observable(url);
			this.LastModificationDate = ko.observable(lastModificationDate);
			this.Deadline = ko.observable(deadline);
			
			this.isNew = ko.observable(status == 'new');
			
			this.LastModificationDateText = ko.computed(function() {
				return $.timeago(this.LastModificationDate());
			}, this);
			this.htmlContent = ko.computed(function() {
				return converter.makeHtml(this.Content());
			}, this);
			this.btnClass = ko.computed(function() {
				return this.isNew() ? "btn-default" : "btn-ok";
			}, this);
			
			this.toggle = function() {
				var self = this;
				self.isNew(!self.isNew());
					
				$(".loadingIndicator").fadeIn();
				
				var targeturl = "/api/users/{{.Page.UserName}}/pages/{{.Page.Name}}/items/" + self.ID;
					
				$.ajax({
					url: targeturl,
					async : false,
					type: 'POST',
					data: {
						'mode': 'updateTag',
						'tag-status': (self.isNew() ? 'new' : 'done')
					},
					dataType: 'json',
					success: function(d) {
					},
					complete: function () {
						$(".loadingIndicator").fadeOut();
					}
				});
			};
		};
		var NoteModel = function(userName, items) {
			this.userName = ko.observable(userName);
			this.items = ko.observableArray(items);
			this.itemToAdd = ko.observable(new Note('','TEXT','','','','','','new',''));
			this.itemToAddReady = ko.computed(function() {
				return this.itemToAdd().Title != "" || this.itemToAdd().Content != "" || this.itemToAdd().URL != "";
			}, this);
			this.addItem = function() {
				var self = this;
				if(this.itemToAddReady()) {
					$(".loadingIndicator").fadeIn();
		
					var targeturl = "/api/users/{{.Page.UserName}}/pages/{{.Page.Name}}/items";
					
					$.ajax({
						url: targeturl,
						async : false,
						type: 'POST',
						data: {
							kind : this.itemToAdd().Kind, 
							title : this.itemToAdd().Title, 
							content : this.itemToAdd().Content, 
							source : this.itemToAdd().Source, 
							URL : this.itemToAdd().URL
						},
						dataType: 'json',
						success: function(d) {
							self.itemToAdd().ID = d.id;
							self.itemToAdd().LastModificationDate(d.lastModificationDate);
							self.items.push(self.itemToAdd()); // Adds the item. Writing to the "items" observableArray causes any associated UI to update.
							self.items.sort(function(left, right) { return left.LastModificationDate() == right.LastModificationDate() ? 0 : (left.LastModificationDate() > right.LastModificationDate() ? -1 : 1) })
						},
						complete: function () {
							$(".loadingIndicator").fadeOut();
							editdlg.modal('hide');
							self.itemToAdd(new Note('','TEXT','','','','','','new','')); // Clears the text box, because it's bound to the "itemToAdd" observable
						}
					});
				}
			}.bind(this);  // Ensure that "this" is always this view model
		};
		
		ko.applyBindings(new NoteModel('{{.Page.UserName}}', [
			{{range .Items}}
			new Note('{{.ID}}','{{.Kind}}','{{.Title}}', '{{.Content}}', '{{.Source}}', '{{.URL}}', '{{.LastModificationDate.Format "2006-01-02T15:04:05Z07:00"}}', '{{.Tags.Tag "status"}}', '{{.Tags.Tag "deadline"}}'),
			{{end}}
			]), document.getElementById('todolist'));
	});
</script>
</body>
</html>
