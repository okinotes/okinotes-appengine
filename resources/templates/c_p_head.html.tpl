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
	#content h1 {
		color:{{.Page.Tags.Tag `title.color`}};
		text-align:center;
	}
	</style>