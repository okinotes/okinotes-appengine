'use strict';

if (!Array.prototype.find) {
  Array.prototype.find = function(predicate) {
    if (this == null) {
      throw new TypeError('Array.prototype.find called on null or undefined');
    }
    if (typeof predicate !== 'function') {
      throw new TypeError('predicate must be a function');
    }
    var list = Object(this);
    var length = list.length >>> 0;
    var thisArg = arguments[1];
    var value;

    for (var i = 0; i < length; i++) {
      value = list[i];
      if (predicate.call(thisArg, value, i, list)) {
        return value;
      }
    }
    return undefined;
  };
}

/**
 * @ngdoc function
 * @name okiApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the okiApp
 */
angular.module('okiApp')
	.controller('MainCtrl', function ($scope, okiService, $timeout,$log) {
		
	$scope.userName = oki.userName;
	$scope.pageName = oki.pageName;
	$scope.canEdit = oki.canEdit;
	
    
	$scope.version = "offline";
	okiService.getVersion().then(function(data){
		$scope.version = data;
	});
	
	$scope.page = new oki.Page();
	okiService.getPage($scope.userName, $scope.pageName, function(page) {
		$scope.page = page;
	});
	
	$scope.items = [];
	okiService.getItems($scope.userName, $scope.pageName, function(data){
		
		var dict = {}
		data.forEach(function(e,i){
			dict[e.id] = i;
			if(e.previousId)
				dict[e.previousId] = i;
		});
		
		//Remove items from $scope.items that are not in data
		for(var j=0; j<$scope.items.length; j++) {
			if(!dict.hasOwnProperty($scope.items[j].id)) {
				$scope.items.splice(j,1);
				j--;
			}
		}
		
		//Sort $scope.items as in data
		$scope.items.sort(function(a,b){
			if(dict[a.id]<dict[b.id])
				return -1;
			if(dict[a.id]===dict[b.id])
				return 0;
			return 1;
		});
		
		//Add or update items
		var iItemsIndex = 0;
		for(var i=0; i<data.length; i++)
		{
			//Try to find the item in the previous list
			var found=false;
			for(var j=iItemsIndex; j<$scope.items.length && !found; j++) {
				//Same item, updated
				if(data[i].id === $scope.items[j].id) {
					found=true;
					if(data[i].lastModificationDate> $scope.items[j].lastModificationDate) {
						$scope.items[j].Set(data[i]);
					}
				}
				//Same item, id changed
				if(data[i].previousId && data[i].previousId === $scope.items[j].id) {
					found=true;
					$scope.items[j].Set(data[i]);
				}
				
				if(found) {
					iItemsIndex = j+1;
					break;
				}
			}
			if(found)
				continue;
			
			//Not found: search for an other item and insert before
			for(var i2=i+1; i2<data.length && !found; i2++) {
				var id = data[i].previousId ? data[i].previousId : data[i].id;
				for(var j=iItemsIndex; j<$scope.items.length && !found; j++) {
					if(id === $scope.items[j].id) {
						found = true;
						//elements from i up to i2-1 can be insterted before j
						for(var i3=i; i3<i2; i3++) {
							$scope.items.splice(j,0,data[i3]);
							j++;
						}
						//Update array indices
						iItemsIndex = j+1;
						i=i2-1;
						break;
					}
				}
			}
			if(found)
				continue;
			
			//No element from i up to the end found: add them all at the end
			for(var i2=i; i2<data.length; i2++) {
				$scope.items.push(data[i2]);
			}
			break;
		}
	});
	
	$scope.newItem = new oki.Item();
	$scope.newItem.kind = 'TEXT';
	$scope.addItem = function() {
		var newItem = $scope.newItem;
		$scope.newItem = new oki.Item();
		$scope.newItem.kind = newItem.kind;
		
		okiService.addItem($scope.userName, $scope.pageName, newItem).then(function(data){
			$scope.$apply(function(){
				$scope.items.splice(0,0,data); //TODO: do not wait for okiService to add in items list
			});
		});
	};
	
	
	$scope.cancelList = [];
	var addCancel = function(msg,undoFct) {
		$scope.cancelList.push({
				timeHide : Date.now() + 5000,
				msg : msg, 
				undoFct : function() {
			$scope.cancelList.shift();
			undoFct();
			return false;
		}});
	};
	var updateCancelList = function() {
		
		while($scope.cancelList.length>0 && $scope.cancelList[0].timeHide<Date.now()) {
			$scope.cancelList.shift();
		}
				
		if($scope.cancelList.length>0)
			$timeout(updateCancelList, 500);
	}
	
	$scope.deleteItem = function(item) {
		var index = $scope.items.indexOf(item);
		
		//Remove from view
		$scope.items.splice(index,1);
		
		//Add undo method
		addCancel('"' + item.title + '" deleted.', function() {
			$scope.items.push(item);
			okiService.restoreItem($scope.userName, $scope.pageName, item)
		});
		$timeout(updateCancelList, 500);
		
		//Remove from storage
		okiService.removeItem($scope.userName, $scope.pageName, item);
	};
	
	$scope.startEditing = function(item) {
		item.isEdited = true;
		item.backup = new oki.Item(item);
	};
	
	$scope.cancelEditing = function(item) {
		item.isEdited = false;
		item.Set(item.backup);
		delete item.backup;
	};
	
	$scope.saveEditing = function(item) {
		item.isEdited = false;
		delete item.backup;

		//Save
		okiService.editItem($scope.userName, $scope.pageName, item).then(function(data){
			item.Set(data); //TODO: do not wait for okiService to edit item: compute markdown to html
		});
	};
	
  })
  ;