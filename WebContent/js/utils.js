/**
 * 
 */
$(document).ready(function() {
			$("#search").autocomplete({
				source : function (request, response) {
					$.ajax({
						url:"ProductoAction",
						type:"POST",
						data:{
							term : request.productos
						},
						dataType: "json",
						success : function (data) {
							response(data);
						}
					});
				}
			});
});

function subtractMonthsDate(date, numMonths) {
	date.setMonth(date.getMonth() - numMonths);
	return date;
}