'use strict';

var oki = oki || {};

oki.Page = function(p) {
	this.userName = p ? p.userName : '';
	this.name = p ? p.name : '';
	this.creationDate = p ? p.creationDate : '';
	this.lastModificationDate = p ? p.lastModificationDate : '';
	this.title = p ? p.title : '';
	this.contentLicense = p ? p.contentLicense : '';
	this.policy = p ? p.policy : '';
	this.templateID = p ? p.templateID : '';
	this.tags = p ? p.tags : '';
}

oki.Page.prototype.Key = function() {
	return oki.NewPageKey(this.userName,this.name);
}

oki.Item = function(i) {
	this.id = i ? i.id : undefined;
	this.creationDate = i ? i.creationDate : undefined;
	this.lastModificationDate = i ? i.lastModificationDate : undefined;
	this.kind = i ? i.kind : undefined;
	this.title = i ? i.title : undefined;
	this.content = i ? i.content : undefined;
	this.htmlContent = i ? i.htmlContent : undefined;
	this.source = i ? i.source : undefined;
	this.url = i ? i.url : undefined;
	this.tags = i ? i.tags : undefined;
}
oki.Item.prototype.Set = function(i) {
	this.id = i ? i.id : undefined;
	this.creationDate = i ? i.creationDate : undefined;
	this.lastModificationDate = i ? i.lastModificationDate : undefined;
	this.kind = i ? i.kind : undefined;
	this.title = i ? i.title : undefined;
	this.content = i ? i.content : undefined;
	this.htmlContent = i ? i.htmlContent : undefined;
	this.source = i ? i.source : undefined;
	this.url = i ? i.url : undefined;
	this.tags = i ? i.tags : undefined;
}

oki.LocalStorage = function(){
			
	var pageKey = function(userName, pageName) {
		return 'oki:page:' + userName + ':' + pageName;
	};
	var pageItemsKey = function(userName, pageName) {
		return pageKey(userName, pageName) + ':items';
	};
	var itemKey = function(userName, pageName, itemId) {
		return pageItemsKey(userName, pageName) + ':' + itemId;
	};
	
	var setPage = function(page) {
		var k = pageKey(page.userName, page.name);
		return localforage.setItem(k, page);
	};
	
	var getPage = function(userName, pageName) {		
		var k = pageKey(userName, pageName);
		return localforage.getItem(k);
	};
	var setItemIds = function(userName, pageName, itemIds) {
		var k = pageItemsKey(userName, pageName);
		return localforage.setItem(k, itemIds);
	};
	var getItemIds = function(userName, pageName) {
		var k = pageItemsKey(userName, pageName);
		return localforage.getItem(k);
	};
	
	var setItems = function(userName, pageName, items) {		
		var itemIds = items.map(function(i) { return i.id; })
		
		var promises = [
			setItemIds(userName, pageName, itemIds)
		];
		
		items.forEach(function(i) {
			promises.push(localforage.setItem(itemKey(userName, pageName, i.id), i));
		});
		
		return Promise.all(promises)
	};
	
	var getItems = function(userName, pageName) {
		return getItemIds(userName, pageName)
			.then(function(itemIds) {
				var itemPromises = itemIds.map(function(id) {
					return localforage.getItem(itemKey(userName, pageName, id));
				});
				
				return Promise.all(itemPromises)
			});
	};
	
	var addItem = function(userName, pageName, item) {
		//Generate random id
		if(!item.id || item.id.length == 0) {
			var tempId = "temp" + Math.random();
			item.id = tempId;
		}
		
		//Store item
		var k = itemKey(userName, pageName, item.id);
		var setItemPromise = localforage.setItem(k, item);
		
		// Add id at end of page
		var addAtEndPromise =
			getItemIds(userName, pageName)
			.then(function(itemIds){
				itemIds.push(item.id);
				
				return setItemIds(userName,pageName,itemIds)
			});
		
		return Promise.all([setItemPromise, addAtEndPromise])
			.then(function(){
				return Promise.resolve(item.id);
			});
	};
	
	var editItem = function(userName, pageName, newItem) {
		
		//Delete old item
		var k = itemKey(userName, pageName, newItem.id);
		
		return localforage.removeItem(k)
			.then(function(){
				//Store new item
				return localforage.setItem(k, newItem);
			});
	};
	
	var replaceItem = function(userName, pageName, oldId, newItem) {
		
		//Delete old item
		var oldKey = itemKey(userName, pageName, oldId);
		//Store new item
		var k = itemKey(userName, pageName, newItem.id);
		
		return Promise.all([
			localforage.removeItem(oldKey),
			localforage.setItem(k, JSON.stringify(newItem)),
			getItemIds(userName, pageName)
				.then(function(itemIds){
					itemIds = itemIds.map(function(id) { return  (id == oldId) ? newItem.id : id; });
					
					return setItemIds(userName,pageName,itemIds)
				})
			]);
	};
	
	var removeItem = function(userName, pageName, item) {
		
		//Remove from storage
		var k = itemKey(userName, pageName, item.id);
			
		return Promise.all([
				localforage.removeItem(k),
				getItemIds(userName, pageName)
					.then(function(itemIds){
						var idx = -1;
						itemIds.forEach(function(e, i) { if(e == item.id) { idx = i; } });
						if (idx>=0){
							itemIds.splice(idx,1);
						}
						//Remove from page
						return setItemIds(userName,pageName,itemIds);
					})
			]);
	};
	
	return {
		getPage : getPage,
		setPage : setPage,
		setItems : setItems,
		getItems : getItems,
		addItem : addItem,
		editItem : editItem,
		replaceItem : replaceItem,
		removeItem : removeItem
	};
}();

/**
 * @ngdoc function
 * @name okiApp:okiService
 * @description
 * # okiService
 * Service allowing data access via API
 */
angular.module('okiApp')
	.service('okiService', function($http, $q, ENDPOINT_URI) {
		
		//Initialise online/offline mode
		var isOnLine = navigator.onLine;
		window.addEventListener("online", function() {
			isOnLine = true;
			alert('Now online');
		}, true);
		 
		window.addEventListener("offline", function() {
			isOnLine = false;
			alert('Now offline');
		}, true);
				
		this.getVersion = function() {
			var request = $q.defer();
			
			$http.get(ENDPOINT_URI + '/version').then(
				function(result) {
					request.resolve(result.data.version);
				}, function(err) {
					request.reject(err);
				}
			);
			
			return request.promise;
		};
		
		this.getPage = function(userName, pageName, onPageUpdate) {
			console.log('okiService.getPage started');
			var httpReceived = false;
			
			oki.LocalStorage.getPage(userName, pageName)
				.then(function(page){
					console.log('okiService.getPage LocalStorage received');
					if(!httpReceived)
					{
						console.log('okiService.getPage LocalStorage: onPageUpdate');
						console.log(page);
						onPageUpdate(page);
					}
				}, function(reason){
					//Not a problem: local cache is just not available
					console.error(reason)
				});
			
			$http.get(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName)
				.then(function(result) {
					console.log('okiService.getPage HTTP received');
					httpReceived = true;
					var p = new oki.Page(result.data)
					
					oki.LocalStorage.setPage(p).then(function() {
						console.log('okiService.getPage LocalStorage.setPage done: onPageUpdate');
						console.log(p);
					}, function(reason){
						//Not a problem: local cache is just not available
						console.error(reason)
					});
						
					onPageUpdate(p);
				}, function(reason){
					//Not a problem: local cache is just not available
					console.error(reason)
				});
		};
		
		this.getItems = function(userName, pageName, onPageItemsUpdate) {
			
			var httpReceived = false;
			
			oki.LocalStorage.getItems(userName, pageName).then(function(items){
				if(!httpReceived)	
					onPageItemsUpdate(items);
			});
			
			$http.get(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName + '/items')
				.then(function(result) {
					httpReceived = true;
					
					var items = [];
					
					result.data.forEach(function(element) {
						items.push(new oki.Item(element));
					});
					
					oki.LocalStorage.setItems(userName, pageName, items)
					
					onPageItemsUpdate(items);
					
				});
		};

		this.addItem = function(userName, pageName, item) {
			var request = $q.defer();
			
			var tempId = oki.LocalStorage.addItem(userName, pageName, item);
			
			$http.post(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName + '/items', item).then(
				function(result) {
					var newItem = new oki.Item(result.data);
					oki.LocalStorage.replaceItem(userName, pageName, tempId, newItem);
					newItem.previousId = tempId;
					request.resolve(newItem);
				}, function(err) {
					request.reject(err);
				}
			);
			
			return request.promise;
		};
		
		this.editItem = function(userName, pageName, item) {
			var request = $q.defer();
			
			oki.LocalStorage.editItem(userName, pageName, item);
			
			$http.post(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName + '/items/' + item.id, item).then(
				function(result) {
					var newItem = new oki.Item(result.data);
					oki.LocalStorage.replaceItem(userName, pageName, item.id, newItem);
					request.resolve(newItem);
				}, function(err) {
					request.reject(err);
				}
			);
			
			return request.promise;
		};
		
		this.removeItem = function(userName, pageName, item) {
			var request = $q.defer();
			
			var tempId = oki.LocalStorage.removeItem(userName, pageName, item);
			
			$http.delete(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName + '/items/' + item.id).then(
				function(result) {
					request.resolve();
				}, function(err) {
					request.reject(err);
				}
			);
			
			return request.promise;
		}
		
		this.restoreItem = function(userName, pageName, item) {
			var request = $q.defer();
			
			oki.LocalStorage.addItem(userName, pageName, item);
			
			$http.put(ENDPOINT_URI + '/users/' + userName + '/pages/' + pageName + '/items/' + item.id, item).then(
				function(result) {
					var newItem = new oki.Item(result.data);
					request.resolve(newItem);
				}, function(err) {
					request.reject(err);
				}
			);
			
			return request.promise;
		}
		
	});