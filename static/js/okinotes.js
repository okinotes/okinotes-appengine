var oki = oki || { };

oki.Item = function(id, kind, title, content, source, url) {
	this.Id = id;
	
	this.Kind = ko.observable(kind);
	
	this.Title = ko.observable(title);
	this.TitleEnabled = ko.computed(function() { return this.Kind() === 'URL' || this.Kind() === 'TEXT'},this);
	
	this.Content = ko.observable(content),
	this.ContentEnabled = ko.computed(function() { return this.Kind() === 'QUOTE' || this.Kind() === 'URL' || this.Kind() === 'TEXT'},this);
	
	this.Source = ko.observable(source),
	this.SourceEnabled = ko.computed(function() { return this.Kind() === 'QUOTE'},this);
	
	this.URL = ko.observable(url),
	this.URLEnabled = ko.computed(function() { return this.Kind() === 'QUOTE' || this.Kind() === 'URL'},this);
	
};

oki.ViewModel = function() {
	var self = this;
		
	this.editedItem = ko.observable(new oki.Item('','TEXT','','','',''));
};

oki.app = (function() {

	var start={},
	
	init = function(btnSaveEditedItemId, root) {
		$('.loadingIndicator').fadeIn();
		
		viewmodel = new oki.ViewModel();
		ko.applyBindings(viewmodel, root);
		
		$('.loadingIndicator').fadeOut();
		
		btnSaveEditedItem = $(document.getElementById(btnSaveEditedItemId));
		btnSaveEditedItem.click(function () {
			saveEditedItem();
		});
	},
	
	saveEditedItem = function() {
	
		$('.loadingIndicator').fadeIn();
		
		var targeturl = '/api/users/' + oki.pageUserName + '/pages/' + oki.pageName + '/items';
		if(viewmodel.editedItem().Id != undefined && viewmodel.editedItem().Id != '') {
			targeturl = '/api/users/' + oki.pageUserName + '/pages/' + oki.pageName + '/items/' + viewmodel.editedItem().Id;
		}
		
		$.ajax({
			url: targeturl,
			async : false,
			type: 'POST',
			data: {
				id : viewmodel.editedItem().Id, 
				kind : viewmodel.editedItem().Kind, 
				title : viewmodel.editedItem().Title, 
				content : viewmodel.editedItem().Content, 
				source : viewmodel.editedItem().Source, 
				URL : viewmodel.editedItem().URL
			},
			dataType: 'json',
			success: function(d) {
				window.location.reload();
			},
			complete: function () {
				$('.loadingIndicator').fadeOut();
				editdlg.modal('hide');
				viewmodel.editedItem(new oki.Item('','TEXT','','','',''));
			}
		});
	},
	
	setItem = function(id, kind, title, content, source, url) {
		viewmodel.editedItem(new oki.Item(id, kind, title, content, source, url));
	},
	
	end={};
		
	return {
		init : init,
		setItem : setItem
    };

})();
		