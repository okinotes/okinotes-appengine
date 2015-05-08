<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="/static/js/jquery-2.1.0.min.js">\x3C/script>')</script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/mousetrap.min.js"></script>
<script type="text/javascript"> 
	$(function() {
	
		Mousetrap.bind('h', function() { window.location = '/index.html'; });
		Mousetrap.bind('s', function() { window.location = '{{if .User.Name}}{{.LogoutURL}}{{else}}{{.LoginURL}}{{end}}'; });
		Mousetrap.bind('?', function() { window.location = '/help.html'; });
		
	});
</script>
<link href='http://fonts.googleapis.com/css?family=Gloria+Hallelujah' rel='stylesheet' type='text/css'>
<link href="/static/css/bootstrap.min.css" rel="stylesheet">
<link href="/static/css/wizy.css" rel="stylesheet">