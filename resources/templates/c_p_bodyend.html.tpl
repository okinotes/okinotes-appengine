
		</div>
		
		{{if eq (.Page.Tags.Tag "template.debug") "true"}}<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<pre>{{.}}</pre></div>{{end}}
		
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
	<script src="/static/js/mousetrap.min.js"></script>
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
			
			{{if .CanEdit}}
			var hash = location.hash.slice(1);
			if(hash === 'administrate') {
				remoteModal.modal({remote: '/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			}
			{{end}}
			
			Mousetrap.bind('m', function(){

				if( snapper.state().state=="left" ){
					snapper.close();
				} else {
					snapper.open('left');
				}

			});
			Mousetrap.bind('h', function() { window.location = '/index.html'; });
			Mousetrap.bind('s', function() { window.location = '{{if .User.Name}}{{.LogoutURL}}{{else}}{{.LoginURL}}{{end}}'; });
			{{if .CanEdit}}
			Mousetrap.bind('n', function() {
				remoteModal.modal({remote: '/newItem.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('t', function() {
				remoteModal.modal({remote: '/change_template.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('a', function() {
				remoteModal.modal({remote: '/administrate.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('d', function() {
				remoteModal.modal({remote: '/delete.html?userName={{.Page.UserName}}&pageName={{.Page.Name}}', show: true});
			});
			Mousetrap.bind('?', function() { window.location = '/help.html#shortcuts'; });
			{{end}}
			
			$(".loadingIndicator").fadeOut();
		});
	</script>