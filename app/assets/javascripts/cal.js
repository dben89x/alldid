// $(document).ready(function() {
// 	var now = new Date();
// 	var year = now.getFullYear();
// 	var month = now.getMonth() + 1;
// 	var date = now.getDate();
//
// 	var data = [{
// 		date: year + '-' + month + '-' + (date - 1),
// 		value: 'hello'
// 	}, {
// 		date: year + '-' + month + '-' + date,
// 		value: 'foo'
// 	}, {
// 		date: new Date(year, month - 1, date + 1),
// 		value: 'bar'
// 	}];
//
// 	// inline
// 	var $ca = $('#one').calendar({
// 		// view: 'month',
// 		width: 320,
// 		height: 320,
// 		// startWeek: 0,
// 		// selectedRang: [new Date(), null],
// 		data: data,
// 		monthArray: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
// 		date: new Date(2016, 9, 31),
// 		onSelected: function (view, date, data) {
// 			console.log('view:' + view)
// 			console.log('date:' + date)
// 			console.log('data:' + (data || '无'));
// 		},
// 		viewChange: function (view, y, m) {
// 			console.log(view, y, m)
//
// 		}
// 	});
//
// 	// picker
// 	$('#two').calendar({
// 		trigger: '#dt',
// 		// offset: [0, 1],
// 		zIndex: 999,
// 		data: data,
// 		onSelected: function (view, date, data) {
// 			console.log('event: onSelected')
// 		},
// 		onClose: function (view, date, data) {
// 			console.log('event: onClose')
// 			console.log('view:' + view)
// 			console.log('date:' + date)
// 			console.log('data:' + (data || '无'));
// 		}
// 	});
//
// 	// Dynamic elements
// 	var $demo = $('#demo');
// 	var UID = 1;
// 	$('#add').click(function () {
// 		$demo.append('<input id="input-' + UID + '"><div id="ca-' + UID + '"></div>');
// 		$('#ca-' + UID).calendar({
// 			trigger: '#input-' + UID++
// 		})
// 	})
// });
